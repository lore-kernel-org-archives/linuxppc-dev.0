Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKlqS3Y7VzDrg5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 23:47:48 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7PDkfCm037572
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 09:47:46 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 251w7w55f3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 09:47:46 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 25 Aug 2016 07:47:45 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Rui Teng <rui.teng@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Rui Teng <rui.teng@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Remove suspect CONFIG_PPC_BOOK3E #ifdefs in
 nohash/64/pgtable.h
In-Reply-To: <1472106670-3432-1-git-send-email-rui.teng@linux.vnet.ibm.com>
References: <1472106670-3432-1-git-send-email-rui.teng@linux.vnet.ibm.com>
Date: Thu, 25 Aug 2016 19:17:38 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8760qp55ad.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rui Teng <rui.teng@linux.vnet.ibm.com> writes:

> There are three #ifdef CONFIG_PPC_BOOK3E sections in nohash/64/pgtable.h.
> And there should be no configurations possible which use nohash/64/pgtable.h
> but don't also enable CONFIG_PPC_BOOK3E.
>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Rui Teng <rui.teng@linux.vnet.ibm.com>


Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>  arch/powerpc/include/asm/nohash/64/pgtable.h | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
> index d4d808c..6213fc1 100644
> --- a/arch/powerpc/include/asm/nohash/64/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
> @@ -26,15 +26,11 @@
>  #else
>  #define PMD_CACHE_INDEX	PMD_INDEX_SIZE
>  #endif
> +
>  /*
>   * Define the address range of the kernel non-linear virtual area
>   */
> -
> -#ifdef CONFIG_PPC_BOOK3E
>  #define KERN_VIRT_START ASM_CONST(0x8000000000000000)
> -#else
> -#define KERN_VIRT_START ASM_CONST(0xD000000000000000)
> -#endif
>  #define KERN_VIRT_SIZE	ASM_CONST(0x0000100000000000)
>  
>  /*
> @@ -43,11 +39,7 @@
>   * (we keep a quarter for the virtual memmap)
>   */
>  #define VMALLOC_START	KERN_VIRT_START
> -#ifdef CONFIG_PPC_BOOK3E
>  #define VMALLOC_SIZE	(KERN_VIRT_SIZE >> 2)
> -#else
> -#define VMALLOC_SIZE	(KERN_VIRT_SIZE >> 1)
> -#endif
>  #define VMALLOC_END	(VMALLOC_START + VMALLOC_SIZE)
>  
>  /*
> @@ -85,12 +77,8 @@
>   * Defines the address of the vmemap area, in its own region on
>   * hash table CPUs and after the vmalloc space on Book3E
>   */
> -#ifdef CONFIG_PPC_BOOK3E
>  #define VMEMMAP_BASE		VMALLOC_END
>  #define VMEMMAP_END		KERN_IO_START
> -#else
> -#define VMEMMAP_BASE		(VMEMMAP_REGION_ID << REGION_SHIFT)
> -#endif
>  #define vmemmap			((struct page *)VMEMMAP_BASE)
>  
>  
> -- 
> 2.7.4
