Return-Path: <B29237@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 21EEAB6EF2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2012 18:55:12 +1100 (EST)
From: Shi Xuelin-B29237 <B29237@freescale.com>
To: "iws@ovro.caltech.edu" <iws@ovro.caltech.edu>
Subject: RE: [PATCH]     fsldma: fix performance degradation by optimizing
 spinlock use.
Date: Wed, 11 Jan 2012 07:54:55 +0000
Message-ID: <DBB740589CE8814680DECFE34BE197AB1665A3@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1324879263-11845-1-git-send-email-b29237@freescale.com>
In-Reply-To: <1324879263-11845-1-git-send-email-b29237@freescale.com>
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
Cc: "vinod.koul@intel.com" <vinod.koul@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Iris,

As we discussed in the previous patch, I add one smp_mb() in fsl_tx_status.
In my testing with iozone, this smp_mb() could cause 1%~2% performance degr=
adation.
Anyway it is acceptable for me. Do you have any other comments?

Thanks,
Forrest

-----Original Message-----
From: Shi Xuelin-B29237=20
Sent: 2011=1B$BG/=1B(B12=1B$B7n=1B(B26=1B$BF|=1B(B 14:01
To: iws@ovro.caltech.edu; vinod.koul@intel.com; dan.j.williams@intel.com; l=
inuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org
Cc: Shi Xuelin-B29237
Subject: [PATCH] fsldma: fix performance degradation by optimizing spinlock=
 use.

From: Forrest shi <b29237@freescale.com>

    dma status check function fsl_tx_status is heavily called in
    a tight loop and the desc lock in fsl_tx_status contended by
    the dma status update function. this caused the dma performance
    degrades much.

    this patch releases the lock in the fsl_tx_status function, and
    introduce the smp_mb() to avoid possible memory inconsistency.

    Signed-off-by: Forrest Shi <xuelin.shi@freescale.com>
---
 drivers/dma/fsldma.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c index 8a78154..008=
fb5e 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -986,15 +986,11 @@ static enum dma_status fsl_tx_status(struct dma_chan =
*dchan,
 	struct fsldma_chan *chan =3D to_fsl_chan(dchan);
 	dma_cookie_t last_complete;
 	dma_cookie_t last_used;
-	unsigned long flags;
-
-	spin_lock_irqsave(&chan->desc_lock, flags);
=20
	last_complete =3D chan->completed_cookie;
+	smp_mb();
	last_used =3D dchan->cookie;
=20
-	spin_unlock_irqrestore(&chan->desc_lock, flags);
-
 	dma_set_tx_state(txstate, last_complete, last_used, 0);
 	return dma_async_is_complete(cookie, last_complete, last_used); }
--
1.7.0.4
