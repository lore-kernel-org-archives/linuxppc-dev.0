Return-Path: <SRS0=n4RZ=OS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F40C07E85
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Dec 2018 10:25:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A26D20831
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Dec 2018 10:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A26D20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43CMmH4Q7QzDqst
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Dec 2018 21:25:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43CMk51hJVzDqjh
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Dec 2018 21:23:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43CMk40qChz9s2P;
 Sun,  9 Dec 2018 21:23:40 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christoph Hellwig <hch@lst.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 12/34] powerpc/cell: move dma direct window setup out of
 dma_configure
In-Reply-To: <20181114082314.8965-13-hch@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
 <20181114082314.8965-13-hch@lst.de>
Date: Sun, 09 Dec 2018 21:23:39 +1100
Message-ID: <871s6r3sno.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christoph Hellwig <hch@lst.de> writes:

> Configure the dma settings at device setup time, and stop playing games
> with get_pci_dma_ops.  This prepares for using the common dma_configure
> code later on.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/platforms/cell/iommu.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)

This one's crashing, haven't dug into why yet:

  [    1.347085] Unable to handle kernel paging request for data at address 0x00000040
  [    1.391505] Faulting instruction address: 0xc0000000006b6e6c
  cpu 0x0: Vector: 380 (Data SLB Access) at [c0000007fc9032d0]
  pc: c0000000006b6e6c: .of_n_addr_cells+0x34/0xc0
  lr: c000000000070b30: .cell_iommu_get_fixed_address+0x58/0x2b0
  sp: c0000007fc903560
  msr: 9000000000009032
  dar: 40
  current = 0xc0000007fc8d0000
  paca    = 0xc000000000f60000	 irqmask: 0x03	 irq_happened: 0x01
  pid   = 1, comm = swapper/0
  Linux version 4.20.0-rc2-gcc7x-g1e32f48 (kerkins@p82) (gcc version 7.4.1 20181208 (Custom eb377405ab2d1900)) #1 SMP Sun Dec 9 12:16:48 AEDT 2018
  enter ? for help
  [c0000007fc9035f0] c000000000070b30 .cell_iommu_get_fixed_address+0x58/0x2b0
  [c0000007fc9036c0] c0000000000711ac .cell_dma_dev_setup.part.1+0x24/0x118
  [c0000007fc903740] c000000000071374 .cell_of_bus_notify+0x6c/0xbc
  [c0000007fc9037c0] c0000000000e7ef0 .notifier_call_chain+0x90/0xf8
  [c0000007fc903860] c0000000000e8c2c .blocking_notifier_call_chain+0x84/0xb8
  [c0000007fc9038f0] c000000000597544 .device_add+0x584/0x7b8
  [c0000007fc9039c0] c0000000005a0308 .platform_device_add+0x148/0x2f0
  [c0000007fc903a60] c0000000005a1508 .platform_device_register_full+0x148/0x168
  [c0000007fc903ae0] c000000000a9a8a0 .__machine_initcall_cell_cell_publish_devices+0x1bc/0x210
  [c0000007fc903be0] c00000000000eca4 .do_one_initcall+0x64/0x2d8
  [c0000007fc903cc0] c000000000a844ec .kernel_init_freeable+0x3dc/0x4e4
  [c0000007fc903da0] c00000000000f06c .kernel_init+0x24/0x150
  [c0000007fc903e20] c00000000000a9c0 .ret_from_kernel_thread+0x58/0x78

cheers

> diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
> index 12352a58072a..cce5bf9515e5 100644
> --- a/arch/powerpc/platforms/cell/iommu.c
> +++ b/arch/powerpc/platforms/cell/iommu.c
> @@ -657,14 +657,21 @@ static const struct dma_map_ops dma_iommu_fixed_ops = {
>  	.mapping_error	= dma_iommu_mapping_error,
>  };
>  
> +static u64 cell_iommu_get_fixed_address(struct device *dev);
> +
>  static void cell_dma_dev_setup(struct device *dev)
>  {
> -	if (get_pci_dma_ops() == &dma_iommu_ops)
> +	if (get_pci_dma_ops() == &dma_iommu_ops) {
> +		u64 addr = cell_iommu_get_fixed_address(dev);
> +
> +		if (addr != OF_BAD_ADDR)
> +			set_dma_offset(dev, addr + dma_iommu_fixed_base);
>  		set_iommu_table_base(dev, cell_get_iommu_table(dev));
> -	else if (get_pci_dma_ops() == &dma_nommu_ops)
> +	} else if (get_pci_dma_ops() == &dma_nommu_ops) {
>  		set_dma_offset(dev, cell_dma_nommu_offset);
> -	else
> +	} else {
>  		BUG();
> +	}
>  }
>  
>  static void cell_pci_dma_dev_setup(struct pci_dev *dev)
> @@ -950,19 +957,14 @@ static int dma_suported_and_switch(struct device *dev, u64 dma_mask)
>  {
>  	if (dma_mask == DMA_BIT_MASK(64) &&
>  	    cell_iommu_get_fixed_address(dev) != OF_BAD_ADDR) {
> -		u64 addr = cell_iommu_get_fixed_address(dev) +
> -			dma_iommu_fixed_base;
>  		dev_dbg(dev, "iommu: 64-bit OK, using fixed ops\n");
> -		dev_dbg(dev, "iommu: fixed addr = %llx\n", addr);
>  		set_dma_ops(dev, &dma_iommu_fixed_ops);
> -		set_dma_offset(dev, addr);
>  		return 1;
>  	}
>  
>  	if (dma_iommu_dma_supported(dev, dma_mask)) {
>  		dev_dbg(dev, "iommu: not 64-bit, using default ops\n");
> -		set_dma_ops(dev, get_pci_dma_ops());
> -		cell_dma_dev_setup(dev);
> +		set_dma_ops(dev, &dma_iommu_ops);
>  		return 1;
>  	}
>  
> -- 
> 2.19.1
