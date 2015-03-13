Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3CE4A1A08ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:55:43 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Fri, 13 Mar 2015 14:25:40 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4DB761258056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 14:27:07 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2D8tbBj33030324
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 14:25:38 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2D8t42Q016781
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 14:25:04 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH slof] helpers: Fix SLOF_alloc_mem_aligned to meet callers
 expectation
In-Reply-To: <1426235812-3749-1-git-send-email-aik@ozlabs.ru>
References: <1426235812-3749-1-git-send-email-aik@ozlabs.ru>
Date: Fri, 13 Mar 2015 14:25:36 +0530
Message-ID: <87bnjxp987.fsf@abhimanyu.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Thomas Huth <thuth@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> Every caller of SLOF_alloc_mem_aligned() assumes the size is the first
> argument while it is not.
>
> This switches align and size and fixes random memory corruptions.
>
> This is grep for SLOF_alloc_mem_aligned with this patch applied:
>
> include/helpers.h|27| extern void *SLOF_alloc_mem_aligned(long size, long align);
> lib/libveth/veth.c|103| buffer_list = SLOF_alloc_mem_aligned(8192, 4096);
> lib/libveth/veth.c|105| rx_queue = SLOF_alloc_mem_aligned(rx_queue_len, 16);
> lib/libvirtio/virtio-net.c|101| vq[i].desc = SLOF_alloc_mem_aligned(virtio_vring_size(vq[i].size), 4096);
> slof/helpers.c|70| void *SLOF_alloc_mem_aligned(long size, long align)
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

> ---
>  include/helpers.h | 2 +-
>  slof/helpers.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/helpers.h b/include/helpers.h
> index f6d4375..fb10534 100644
> --- a/include/helpers.h
> +++ b/include/helpers.h
> @@ -24,7 +24,7 @@ extern void SLOF_usleep(uint32_t time);
>  extern void *SLOF_dma_alloc(long size);
>  extern void SLOF_dma_free(void *virt, long size);
>  extern void *SLOF_alloc_mem(long size);
> -extern void *SLOF_alloc_mem_aligned(long align, long size);
> +extern void *SLOF_alloc_mem_aligned(long size, long align);
>  extern void SLOF_free_mem(void *addr, long size);
>  extern long SLOF_dma_map_in(void *virt, long size, int cacheable);
>  extern void SLOF_dma_map_out(long phys, void *virt, long size);
> diff --git a/slof/helpers.c b/slof/helpers.c
> index c582996..d7c1888 100644
> --- a/slof/helpers.c
> +++ b/slof/helpers.c
> @@ -67,7 +67,7 @@ void *SLOF_alloc_mem(long size)
>  	return (void *)forth_pop();
>  }
>
> -void *SLOF_alloc_mem_aligned(long align, long size)
> +void *SLOF_alloc_mem_aligned(long size, long align)
>  {
>  	unsigned long addr = (unsigned long)SLOF_alloc_mem(size + align - 1);
>  	addr = addr + align - 1;
> -- 
> 2.0.0
