Return-Path: <mason@postdiluvian.org>
Received: from porklips.postdiluvian.org (postdiluvian.org [128.30.54.21])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8B07FB70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Dec 2010 10:24:49 +1100 (EST)
Date: Tue, 7 Dec 2010 18:24:45 -0500
From: Mark Mason <mason@postdiluvian.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: MPC831x (and others?) NAND erase performance improvements
Message-ID: <20101207232445.GB29218@postdiluvian.org>
References: <20101207031554.GA12731@postdiluvian.org>
	<20101207145153.540da45a@udp111988uds.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101207145153.540da45a@udp111988uds.am.freescale.net>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote:

> On Mon, 6 Dec 2010 22:15:54 -0500
> Mark Mason <mason@postdiluvian.org> wrote:
> 
> > A few months ago I ran into some performance problems involving
> > UBI/NAND erases holding other devices off the LBC on an MPC8315.  I
> > found a solution for this, which worked well, at least with the
> > hardware I was working with.  I suspect the same problem affects other
> > PPCs, probably including multicore devices, and maybe other
> > architectures as well.
> > 
> > I don't have experience with similar NAND controllers on other
> > devices, so I'd like to explain what I found and see if someone who's
> > more familiar with the family and/or driver can tell if this is
> > useful.
> > 
> > The problem cropped up when there was a lot of traffic to the NAND
> > (Samsung K9WAGU08U1B-PIB0), with the NAND being on the LBC along with
> > a video chip that needed constant and prompt attention.
> 
> If you attach NAND to the LBC, you should not attach anything else
> to it which is latency-sensitive.

We found that out the hard way.

The 1ms latency wasn't a problem by itself, the real problem was that
the quantity of erases issued in a short time significantly decreased
the bandwidth available, and that the scheduler saw the video thread
use 1ms of CPU time even though it'd only done a couple hundred
nanoseconds worth of work.

> > What I found, though, was that the NAND did not inherently assert BUSY
> > as part of the erase - BUSY was asserted because the driver polled for
> > the status (NAND_CMD_STATUS).  If the status poll was delayed for the
> > duration of the erase then the MPC could talk to the video chip while
> > the erase was in progress.  At the end of the 1ms delay I would then
> > poll for status, which would complete effectively immediately.
> 
> That's what we originially did.  The problem is that during this
> interval the NAND chip will be driving the busy pin, which corrupts
> other LBC transactions.

This is not what we observed with our flash part.  For a page erase,
the NAND did not assert the busy pin until the status read was done.
This was confirmed with a logic analyzer, and taking advantage of this
behavior is the sole purpose of the change.

I don't think that this behavior is what's described in the Samsung
datasheet, but it is what our parts did.

I incorrectly said "polled for status" in my original post.  It did
not poll for status, it monitored the busy line from NAND and did a
single read from the status register.

> Newer chips have this added text in their reference manuals under
> "NAND Flash Block Erase Command Sequence Example":
> 
>   Note that operations specified by OP3 and OP4 (status read) should
>   never be skipped while erasing a NAND Flash device, because, in
>   case that happens, contention may arise on LGPL4.  A possible case
>   is that the next transaction from eLBC may try to use that pin as
>   an output and since the NAND Flash device might already be driving
>   it, contention will occur.  In case OP3 and OP4 operations are
>   skipped, it may also happen that a new command is issued to the
>   NAND Flash device even when the device has not yet finished
>   processing the previous request.  This may also result in
>   unpredictable behavior.

I would expect those operations to be mandatory.

> > Here's a code snippet from 2.6.37, with some comments I added.
> > drivers/mtd/nand/fsl_elbc_nand.c - fsl_elbc_cmdfunc():
> > 
> >   /* ERASE2 uses the block and page address from ERASE1 */
> >   case NAND_CMD_ERASE2:
> >     dev_vdbg(priv->dev, "fsl_elbc_cmdfunc: NAND_CMD_ERASE2.\n");
> > 
> >     out_be32(&lbc->fir,
> >        (FIR_OP_CM0 << FIR_OP0_SHIFT) |  /* Execute CMD0 (ERASE1).           */
> >        (FIR_OP_PA  << FIR_OP1_SHIFT) |  /* Issue block and page address.    */
> >        (FIR_OP_CM2 << FIR_OP2_SHIFT) |  /* Execute CMD2 (ERASE2).           */
> >            /* (delay needed here - this is where the erase happens) */
> >        (FIR_OP_CW1 << FIR_OP3_SHIFT) |  /* Wait for LFRB (BUSY) to deassert */
> >                                         /* then issue CW1 (read status).    */
> >        (FIR_OP_RS  << FIR_OP4_SHIFT));  /* Read one byte.                   */
> > 
> >     out_be32(&lbc->fcr,
> >        (NAND_CMD_ERASE1 << FCR_CMD0_SHIFT) |  /* 0x60 */
> >        (NAND_CMD_STATUS << FCR_CMD1_SHIFT) |  /* 0x70 */
> >        (NAND_CMD_ERASE2 << FCR_CMD2_SHIFT));  /* 0xD0 */
> > 
> >     out_be32(&lbc->fbcr, 0);
> >     elbc_fcm_ctrl->read_bytes = 0;
> >     elbc_fcm_ctrl->use_mdr = 1;
> > 
> >     fsl_elbc_run_command(mtd);
> >     return;
> > 
> > What I did was to issue two commands with fsl_elbc_run_command(), with
> > a 1ms sleep in between (a tightloop delay worked almost as well, the
> > important part was having 1ms between the erase and the status poll).
> > The first command did the FIR_OP_CM0 (NAND_CMD_ERASE1), FIR_OP_PA, and
> > FIR_OP_CM2 (NAND_CMD_ERASE2).  The second did the FIR_OP_CW1
> > (NAND_CMD_STATUS) and FIR_OP_RS.
> 
> So essentially, you reverted commit
> 476459a6cf46d20ec73d9b211f3894ced5f9871e
> 
> :-)
> 
> Except for the 1ms delay.

Well then, the 1ms delay is the value-add!

> > I know almost nothing at all about the scheduler, but I'm pretty
> > sure that this behavior would cause the scheduler to think the
> > video thread was a CPU hog, since the video thread was running for
> > 1ms for every 20us that the UBI BGT ran, which would cause the
> > scheduler to unfairly prefer the UBI BGT.  I initially tried to
> > address this problem with thread priorities, but the unfortunate
> > reality was that either the NAND writes could fall behind or the
> > video chip could fall behind, and there wasn't spare bandwidth to
> > allow either.
> 
> If you set a realtime priority and have preemption enabled, you
> should be able to avoid being delayed by more than one NAND
> transaction, until the realtime thread sleeps.  Be careful to ensure
> that it does sleep enough for other things to run.

I tried that, but if the erases were held off enough to get the other
bus bandwidth we required then the NAND writes fell behind and the
kernel oom'd.

> -Scott

Thanks for reviewing it.  It wouldn't surprise me if this wasn't
useful in a more general case, but it made a big difference for us.
