Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE009.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E67C5B70A4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Dec 2010 07:52:10 +1100 (EST)
Received: from mail47-tx2 (localhost.localdomain [127.0.0.1])	by
	mail47-tx2-R.bigfish.com (Postfix) with ESMTP id 05B45EB0344	for
	<linuxppc-dev@lists.ozlabs.org>; Tue,  7 Dec 2010 20:52:00 +0000 (UTC)
Received: from TX2EHSMHS045.bigfish.com (unknown [10.9.14.245])	by
	mail47-tx2.bigfish.com (Postfix) with ESMTP id 8B66EE0060	for
	<linuxppc-dev@lists.ozlabs.org>; Tue,  7 Dec 2010 20:51:59 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	oB7Kpukm018222	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 7 Dec 2010 13:51:57 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	oB7L8vL2023199	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 7 Dec 2010 15:08:57 -0600 (CST)
Date: Tue, 7 Dec 2010 14:51:53 -0600
From: Scott Wood <scottwood@freescale.com>
To: Mark Mason <mason@postdiluvian.org>
Subject: Re: MPC831x (and others?) NAND erase performance improvements
Message-ID: <20101207145153.540da45a@udp111988uds.am.freescale.net>
In-Reply-To: <20101207031554.GA12731@postdiluvian.org>
References: <20101207031554.GA12731@postdiluvian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 6 Dec 2010 22:15:54 -0500
Mark Mason <mason@postdiluvian.org> wrote:

> A few months ago I ran into some performance problems involving
> UBI/NAND erases holding other devices off the LBC on an MPC8315.  I
> found a solution for this, which worked well, at least with the
> hardware I was working with.  I suspect the same problem affects other
> PPCs, probably including multicore devices, and maybe other
> architectures as well.
> 
> I don't have experience with similar NAND controllers on other
> devices, so I'd like to explain what I found and see if someone who's
> more familiar with the family and/or driver can tell if this is
> useful.
> 
> The problem cropped up when there was a lot of traffic to the NAND
> (Samsung K9WAGU08U1B-PIB0), with the NAND being on the LBC along with
> a video chip that needed constant and prompt attention.

If you attach NAND to the LBC, you should not attach anything else to
it which is latency-sensitive.

> What I found, though, was that the NAND did not inherently assert BUSY
> as part of the erase - BUSY was asserted because the driver polled for
> the status (NAND_CMD_STATUS).  If the status poll was delayed for the
> duration of the erase then the MPC could talk to the video chip while
> the erase was in progress.  At the end of the 1ms delay I would then
> poll for status, which would complete effectively immediately.

That's what we originially did.  The problem is that during this
interval the NAND chip will be driving the busy pin, which corrupts
other LBC transactions.

Newer chips have this added text in their reference manuals under "NAND
Flash Block Erase Command Sequence Example":

  Note that operations specified by OP3 and OP4 (status read) should
  never be skipped while erasing a NAND Flash device, because, in case
  that happens, contention may arise on LGPL4.  A possible case is that
  the next transaction from eLBC may try to use that pin as an output
  and since the NAND Flash device might already be driving it,
  contention will occur.  In case OP3 and OP4 operations are skipped,
  it may also happen that a new command is issued to the NAND Flash
  device even when the device has not yet finished processing the
  previous request.  This may also result in unpredictable behavior.


> Here's a code snippet from 2.6.37, with some comments I added.
> drivers/mtd/nand/fsl_elbc_nand.c - fsl_elbc_cmdfunc():
> 
>   /* ERASE2 uses the block and page address from ERASE1 */
>   case NAND_CMD_ERASE2:
>     dev_vdbg(priv->dev, "fsl_elbc_cmdfunc: NAND_CMD_ERASE2.\n");
> 
>     out_be32(&lbc->fir,
>        (FIR_OP_CM0 << FIR_OP0_SHIFT) |  /* Execute CMD0 (ERASE1).           */
>        (FIR_OP_PA  << FIR_OP1_SHIFT) |  /* Issue block and page address.    */
>        (FIR_OP_CM2 << FIR_OP2_SHIFT) |  /* Execute CMD2 (ERASE2).           */
>            /* (delay needed here - this is where the erase happens) */
>        (FIR_OP_CW1 << FIR_OP3_SHIFT) |  /* Wait for LFRB (BUSY) to deassert */
>                                         /* then issue CW1 (read status).    */
>        (FIR_OP_RS  << FIR_OP4_SHIFT));  /* Read one byte.                   */
> 
>     out_be32(&lbc->fcr,
>        (NAND_CMD_ERASE1 << FCR_CMD0_SHIFT) |  /* 0x60 */
>        (NAND_CMD_STATUS << FCR_CMD1_SHIFT) |  /* 0x70 */
>        (NAND_CMD_ERASE2 << FCR_CMD2_SHIFT));  /* 0xD0 */
> 
>     out_be32(&lbc->fbcr, 0);
>     elbc_fcm_ctrl->read_bytes = 0;
>     elbc_fcm_ctrl->use_mdr = 1;
> 
>     fsl_elbc_run_command(mtd);
>     return;
> 
> What I did was to issue two commands with fsl_elbc_run_command(), with
> a 1ms sleep in between (a tightloop delay worked almost as well, the
> important part was having 1ms between the erase and the status poll).
> The first command did the FIR_OP_CM0 (NAND_CMD_ERASE1), FIR_OP_PA, and
> FIR_OP_CM2 (NAND_CMD_ERASE2).  The second did the FIR_OP_CW1
> (NAND_CMD_STATUS) and FIR_OP_RS.

So essentially, you reverted commit
476459a6cf46d20ec73d9b211f3894ced5f9871e

:-)

Except for the 1ms delay.

> I know almost nothing at all about the scheduler, but I'm pretty sure
> that this behavior would cause the scheduler to think the video thread
> was a CPU hog, since the video thread was running for 1ms for every
> 20us that the UBI BGT ran, which would cause the scheduler to unfairly
> prefer the UBI BGT.  I initially tried to address this problem with
> thread priorities, but the unfortunate reality was that either the
> NAND writes could fall behind or the video chip could fall behind, and
> there wasn't spare bandwidth to allow either.

If you set a realtime priority and have preemption enabled, you should
be able to avoid being delayed by more than one NAND transaction, until
the realtime thread sleeps.  Be careful to ensure that it does sleep
enough for other things to run.

-Scott
