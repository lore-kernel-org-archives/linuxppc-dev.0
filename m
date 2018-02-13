Return-Path: <mroos@linux.ee>
Received: from smtp1.it.da.ut.ee (mailhost6-1.ut.ee
 [IPv6:2001:bb8:2002:500::46])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zgpMp3QYszF1QP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 03:46:28 +1100 (AEDT)
Date: Tue, 13 Feb 2018 18:46:20 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Christoph Hellwig <hch@lst.de>
cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
 Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: pata-macio WARNING at dmam_alloc_coherent+0xec/0x110
In-Reply-To: <20180213145120.GA14657@lst.de>
Message-ID: <alpine.LRH.2.21.1802131845580.21385@math.ut.ee>
References: <alpine.LRH.2.21.1802122246230.9153@math.ut.ee>
 <20180213145120.GA14657@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Does this fix your warning?
> 
> diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
> index 62f541f968f6..07074820a167 100644
> --- a/drivers/macintosh/macio_asic.c
> +++ b/drivers/macintosh/macio_asic.c
> @@ -375,6 +375,7 @@ static struct macio_dev * macio_add_one_device(struct macio_chip *chip,
>  	dev->ofdev.dev.of_node = np;
>  	dev->ofdev.archdata.dma_mask = 0xffffffffUL;
>  	dev->ofdev.dev.dma_mask = &dev->ofdev.archdata.dma_mask;
> +	dev->ofdev.dev.coherent_dma_mask = dev->ofdev.archdata.dma_mask;
>  	dev->ofdev.dev.parent = parent;
>  	dev->ofdev.dev.bus = &macio_bus_type;
>  	dev->ofdev.dev.release = macio_release_dev;

Yes, it does - thank you!

Tested-by: Meelis Roos <mroos@linux.ee>

-- 
Meelis Roos (mroos@linux.ee)
