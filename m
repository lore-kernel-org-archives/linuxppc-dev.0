Return-Path: <mason@postdiluvian.org>
Received: from porklips.postdiluvian.org (postdiluvian.org [128.30.54.21])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7056DB70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Dec 2010 14:42:54 +1100 (EST)
Received: from mason by porklips.postdiluvian.org with local (Exim 4.72)
	(envelope-from <mason@postdiluvian.org>) id 1PPo1y-0003Jr-7g
	for linuxppc-dev@lists.ozlabs.org; Mon, 06 Dec 2010 22:15:54 -0500
Date: Mon, 6 Dec 2010 22:15:54 -0500
From: Mark Mason <mason@postdiluvian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: MPC831x (and others?) NAND erase performance improvements
Message-ID: <20101207031554.GA12731@postdiluvian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A few months ago I ran into some performance problems involving
UBI/NAND erases holding other devices off the LBC on an MPC8315.  I
found a solution for this, which worked well, at least with the
hardware I was working with.  I suspect the same problem affects other
PPCs, probably including multicore devices, and maybe other
architectures as well.

I don't have experience with similar NAND controllers on other
devices, so I'd like to explain what I found and see if someone who's
more familiar with the family and/or driver can tell if this is
useful.

The problem cropped up when there was a lot of traffic to the NAND
(Samsung K9WAGU08U1B-PIB0), with the NAND being on the LBC along with
a video chip that needed constant and prompt attention.

What I would see is that, as the writes happened, the erases would
wind up batched and issued all at once, such that frequently 400-700
erases were issued in rapid succession with a 1ms LBC BUSY cycle per
erase.  BUSY was shared with all of the devices on the LBC, so the PPC
could not talk to the video chip as long as BUSY was asserted by the
NAND.  This would give us a window of up to 700ms in which the PPC
could manage very little communication with other devices on the LBC -
in our case the video chip, for which this delay was essentially
fatal.  I suspect that some multicore chips might have one core
effectively halt if that core attempts to access the LBC while the
other core (or itself, for that matter) is executing an erase (if they
have a similar NAND controller).

What I found, though, was that the NAND did not inherently assert BUSY
as part of the erase - BUSY was asserted because the driver polled for
the status (NAND_CMD_STATUS).  If the status poll was delayed for the
duration of the erase then the MPC could talk to the video chip while
the erase was in progress.  At the end of the 1ms delay I would then
poll for status, which would complete effectively immediately.

Here's a code snippet from 2.6.37, with some comments I added.
drivers/mtd/nand/fsl_elbc_nand.c - fsl_elbc_cmdfunc():

  /* ERASE2 uses the block and page address from ERASE1 */
  case NAND_CMD_ERASE2:
    dev_vdbg(priv->dev, "fsl_elbc_cmdfunc: NAND_CMD_ERASE2.\n");

    out_be32(&lbc->fir,
       (FIR_OP_CM0 << FIR_OP0_SHIFT) |  /* Execute CMD0 (ERASE1).           */
       (FIR_OP_PA  << FIR_OP1_SHIFT) |  /* Issue block and page address.    */
       (FIR_OP_CM2 << FIR_OP2_SHIFT) |  /* Execute CMD2 (ERASE2).           */
           /* (delay needed here - this is where the erase happens) */
       (FIR_OP_CW1 << FIR_OP3_SHIFT) |  /* Wait for LFRB (BUSY) to deassert */
                                        /* then issue CW1 (read status).    */
       (FIR_OP_RS  << FIR_OP4_SHIFT));  /* Read one byte.                   */

    out_be32(&lbc->fcr,
       (NAND_CMD_ERASE1 << FCR_CMD0_SHIFT) |  /* 0x60 */
       (NAND_CMD_STATUS << FCR_CMD1_SHIFT) |  /* 0x70 */
       (NAND_CMD_ERASE2 << FCR_CMD2_SHIFT));  /* 0xD0 */

    out_be32(&lbc->fbcr, 0);
    elbc_fcm_ctrl->read_bytes = 0;
    elbc_fcm_ctrl->use_mdr = 1;

    fsl_elbc_run_command(mtd);
    return;

What I did was to issue two commands with fsl_elbc_run_command(), with
a 1ms sleep in between (a tightloop delay worked almost as well, the
important part was having 1ms between the erase and the status poll).
The first command did the FIR_OP_CM0 (NAND_CMD_ERASE1), FIR_OP_PA, and
FIR_OP_CM2 (NAND_CMD_ERASE2).  The second did the FIR_OP_CW1
(NAND_CMD_STATUS) and FIR_OP_RS.

For a bit more detail...  fsl_elbc_run_command() would put the thread
issuing the erase to sleep so other threads could run.  That did work
as planned, except that I was working with a fairly pathalogical case
- there was a very high volume of writes to the NAND, and the video
chip required very frequent and prompt attention.  This meant that the
thread that was most likely to run when the NAND erase was in progress
was the thread that serviced the video chip.

A logic analyzer backed this up.  It would show the erase being
issued, BUSY (R/B# or LFRB) being asserted for 1ms, one or two 16 bit
transactions to the video chip, then another erase, repeating this
process hundreds of times in a row.  The UBI BGT would run long enough
to issue an erase (probably on the order of 20us) then go to sleep.
The video thread would then run, and issue a transaction to the chip.
That transaction would get blocked until BUSY deasserted, at which
point the thread would appear to have run for 1ms, even though it had
only executed a single bus transaction.

I know almost nothing at all about the scheduler, but I'm pretty sure
that this behavior would cause the scheduler to think the video thread
was a CPU hog, since the video thread was running for 1ms for every
20us that the UBI BGT ran, which would cause the scheduler to unfairly
prefer the UBI BGT.  I initially tried to address this problem with
thread priorities, but the unfortunate reality was that either the
NAND writes could fall behind or the video chip could fall behind, and
there wasn't spare bandwidth to allow either.

I tried the same trick for the writes.  It didn't work.

I really hope that someone cares enough after all this typing.
Unfortunately I don't have access to the hardware in question any
more, so I'm a bit limited in what I can offer beyond this without
hardware to run on, but I am willing to do whatever I can.
