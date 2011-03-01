Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 613D3B70DB
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Mar 2011 06:52:11 +1100 (EST)
Date: Tue, 1 Mar 2011 11:52:08 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Felix Radensky <felix@embedded-sol.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 0/8] fsldma: lockup fixes
Message-ID: <20110301195208.GC23403@ovro.caltech.edu>
References: <4D6BEDCE.3020102@embedded-sol.com>
	<20110228195350.GA31428@ovro.caltech.edu>
	<4D6C0275.6000807@embedded-sol.com>
	<20110228211103.GB31428@ovro.caltech.edu>
	<4D6C134C.4070407@embedded-sol.com>
	<20110301002156.GC31428@ovro.caltech.edu>
	<4D6C89A7.8010803@embedded-sol.com>
	<20110301165515.GA23403@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110301165515.GA23403@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 01, 2011 at 08:55:15AM -0800, Ira W. Snyder wrote:

[ big snip ]

> 
> Thanks, this is exactly what I was going to ask for next. :)
> 
> I really don't understand why the P2020 DMA controller isn't behaving
> nicely after my patches.
> 
> Can you run a git bisect to figure out which patch in the series causes
> the problems. It should take three or four build + test cycles to narrow
> down which patch breaks the driver. When it is finished, send me the
> output of git bisect.
> 
> Like this (assuming you have two branches: master and
> fsldma, where fsldma is master + my patches):
> 
> # setup the bisect
> git bisect start
> git bisect bad fsldma
> git bisect good master
> 
> # build and test the kernel using the same test as before:
> modprobe dmatest max_channels=1 threads_per_chan=1 iterations=4
> 
> # if the test passes:
> git bisect good
> 
> # if the test fails:
> git bisect bad
> 
> # now build + test again, then mark that good or bad. Repeat until
> # finished.
> 
> 
> I really appreciate your help in testing this. You've been great at
> providing everything I've asked for.
> 

I'd still like the bisect if you have a chance. I've re-reviewed the
patch series, and found the places that change register writes to the
controller.

The patch below changes the register operations back to the original
order. It doesn't make any sense why this would be required, but it is
worth a quick try.

I've added an "XXX" mark where you can comment out a single line if this
patch fails. It is highly unlikely to make any difference, but I'm
really having a hard time understanding what is wrong.

Ira


>From 9e479ce27f8c1819694d7082bb4a27772b4baf52 Mon Sep 17 00:00:00 2001
From: Ira W. Snyder <iws@ovro.caltech.edu>
Date: Tue, 1 Mar 2011 11:43:00 -0800
Subject: [PATCH] fsldma: try and fix 85xx DMA controller

This is just a random guess at what might be wrong. The datasheet
doesn't say that a completed transfer must be aborted before starting a
new transfer (nor does it make much sense). However, the old code did it
anyway.

NOT AT ALL Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/dma/fsldma.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index e4d9d17..d8eedbc 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -213,6 +213,7 @@ static void dma_halt(struct fsldma_chan *chan)
 	int i;
 
 	mode = DMA_IN(chan, &chan->regs->mr, 32);
+	dev_dbg(chan->dev, "%s: dma_halt mode=0x%.8x\n", chan->name, mode);
 	mode |= FSL_DMA_MR_CA;
 	DMA_OUT(chan, &chan->regs->mr, mode, 32);
 
@@ -921,10 +922,24 @@ static void fsl_chan_xfer_ld_queue(struct fsldma_chan *chan)
 	list_splice_tail_init(&chan->ld_pending, &chan->ld_running);
 
 	/*
+	 * XXX: Guess at problems
+	 *
+	 * The 85xx requires that you run this routine before you try to start
+	 * the next DMA for an as yet unknown reason. Maybe.
+	 */
+	if ((chan->feature & FSL_DMA_IP_MASK) == FSL_DMA_IP_85XX) {
+		dev_dbg(chan->dev, "%s: 85xx, running workaround\n", name);
+		dma_halt(chan);
+	}
+
+	/*
 	 * Program the descriptor's address into the DMA controller,
 	 * then start the DMA transaction
 	 */
 	set_cdar(chan, desc->async_tx.phys);
+
+
+	/* XXX: if that doesn't work, comment the "get_cdar()" line below */
 	get_cdar(chan);
 
 	dma_start(chan);
-- 
1.7.3.4
