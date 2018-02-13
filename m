Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zglq55PN6zF1P3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 01:51:25 +1100 (AEDT)
Date: Tue, 13 Feb 2018 15:51:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Meelis Roos <mroos@linux.ee>
Cc: Christoph Hellwig <hch@lst.de>, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org,
 Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: pata-macio WARNING at dmam_alloc_coherent+0xec/0x110
Message-ID: <20180213145120.GA14657@lst.de>
References: <alpine.LRH.2.21.1802122246230.9153@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.21.1802122246230.9153@math.ut.ee>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Does this fix your warning?

diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index 62f541f968f6..07074820a167 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -375,6 +375,7 @@ static struct macio_dev * macio_add_one_device(struct macio_chip *chip,
 	dev->ofdev.dev.of_node = np;
 	dev->ofdev.archdata.dma_mask = 0xffffffffUL;
 	dev->ofdev.dev.dma_mask = &dev->ofdev.archdata.dma_mask;
+	dev->ofdev.dev.coherent_dma_mask = dev->ofdev.archdata.dma_mask;
 	dev->ofdev.dev.parent = parent;
 	dev->ofdev.dev.bus = &macio_bus_type;
 	dev->ofdev.dev.release = macio_release_dev;
