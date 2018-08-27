Return-Path: <konrad.r.wilk@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zgBB4Hc7zDrS7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 04:18:38 +1000 (AEST)
Received: by mail-qk0-x244.google.com with SMTP id 93-v6so11161402qks.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2018 11:18:38 -0700 (PDT)
Sender: Konrad Rzeszutek Wilk <konrad.r.wilk@gmail.com>
Date: Mon, 27 Aug 2018 14:18:31 -0400
From: Konrad Rzeszutek Wilk <konrad@darnok.org>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Anshuman Khandual <anshuman.linux@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christoph Hellwig <hch@lst.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Mike Anderson <andmike@linux.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Ram Pai <linuxram@us.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 11/11] powerpc/svm: Increase SWIOTLB buffer size
Message-ID: <20180827181830.GB3834@0021ccb48c25>
References: <20180824162535.22798-1-bauerman@linux.ibm.com>
 <20180824162535.22798-12-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180824162535.22798-12-bauerman@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 24, 2018 at 01:25:35PM -0300, Thiago Jung Bauermann wrote:
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> 
> SWIOTLB buffer default size (64MB) is not enough for large sequential write
> operations which eventually leads to kernel crash like here.
> 
> virtio-pci 0000:00:05.0: swiotlb buffer is full (sz: 327680 bytes)
> virtio-pci 0000:00:05.0: DMA: Out of SW-IOMMU space for 327680 bytes
> Kernel panic - not syncing: DMA: Random memory could be DMA read
> CPU: 12 PID: 3985 Comm: mkfs.ext4 Not tainted 4.18.0-rc4+ #285
> Call Trace:
> [c0000007d2a27020] [c000000000cfdffc] dump_stack+0xb0/0xf4 (unreliable)
> [c0000007d2a27060] [c000000000112a98] panic+0x140/0x328
> [c0000007d2a270f0] [c0000000001b4f88] swiotlb_full+0x108/0x130
> [c0000007d2a27180] [c0000000001b5f6c] swiotlb_map_page+0x25c/0x2c0
> [c0000007d2a271e0] [c0000000007bfaf8] vring_map_one_sg.isra.0+0x58/0x70
> [c0000007d2a27200] [c0000000007c08dc] virtqueue_add_sgs+0x1bc/0x690
> [c0000007d2a272f0] [d0000000042a1280] virtio_queue_rq+0x358/0x4a0 [virtio_blk]
> [c0000007d2a273d0] [c0000000006b5d68] blk_mq_dispatch_rq_list+0x1f8/0x6d0
> ..................
> 
> Increase the SWIOTLB size to 1GB on Ultravisor based secure guests.

Gosh, that is huge.

What about making the SWIOTLB be more dynamic? That is expand it's size
dynamically if it can?

> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  arch/powerpc/Kconfig | 5 +++++
>  kernel/dma/swiotlb.c | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 1466d1234723..fee7194ce9e4 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -457,6 +457,11 @@ config PPC_SVM
>  
>  	 If unsure, say "N".
>  
> +config SWIOTLB_DEFAULT_SIZE
> +       int "Size of Software I/O TLB buffer (in MiB)"
> +       default "1024"
> +       depends on PPC_SVM
> +
>  config PPC_TRANSACTIONAL_MEM
>         bool "Transactional Memory support for POWERPC"
>         depends on PPC_BOOK3S_64
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 04b68d9dffac..32dc67422d8a 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -146,8 +146,13 @@ void swiotlb_set_max_segment(unsigned int val)
>  		max_segment = rounddown(val, PAGE_SIZE);
>  }
>  
> +#ifdef CONFIG_SWIOTLB_DEFAULT_SIZE
> +#define IO_TLB_DEFAULT_SIZE ((unsigned long) CONFIG_SWIOTLB_DEFAULT_SIZE << 20)
> +#else
>  /* default to 64MB */
>  #define IO_TLB_DEFAULT_SIZE (64UL<<20)
> +#endif
> +
>  unsigned long swiotlb_size_or_default(void)
>  {
>  	unsigned long size;
> 
