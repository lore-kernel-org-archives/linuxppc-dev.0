Return-Path: <srs0=wwrk=7e=linux.vnet.ibm.com=aneesh.kumar@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMmNN3HPPzDsPm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 18:20:52 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xMmNM31QPz8t9V
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 18:20:51 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xMmNL4FTBz9sxR
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Aug 2017 18:20:50 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v728DhTm069132
 for <linuxppc-dev@ozlabs.org>; Wed, 2 Aug 2017 04:20:48 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c3469khxu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 02 Aug 2017 04:20:47 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 2 Aug 2017 18:20:43 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v728KXqb19988694
 for <linuxppc-dev@ozlabs.org>; Wed, 2 Aug 2017 18:20:41 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v728K9QJ032647
 for <linuxppc-dev@ozlabs.org>; Wed, 2 Aug 2017 18:20:09 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: anton@samba.org
Subject: Re: [PATCH 3/3] powerpc/mm/hash64: Make vmalloc 56T on hash
In-Reply-To: <1501583364-14909-3-git-send-email-mpe@ellerman.id.au>
References: <1501583364-14909-1-git-send-email-mpe@ellerman.id.au>
 <1501583364-14909-3-git-send-email-mpe@ellerman.id.au>
Date: Wed, 02 Aug 2017 13:49:29 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <874ltq1iwe.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> On 64-bit book3s, with the hash MMU, we currently define the kernel
> virtual space (vmalloc, ioremap etc.), to be 16T in size. This is a
> leftover from pre v3.7 when our user VM was also 16T.
>
> Of that 16T we split it 50/50, with half used for PCI IO and ioremap
> and the other 8T for vmalloc.
>
> We never bothered to make it any bigger because 8T of vmalloc ought to
> be enough for anybody. But it turns out that's not true, the per cpu
> allocator wants large amounts of vmalloc space, not to make large
> allocations, but to allow a large stride between allocations, because
> we use pcpu_embed_first_chunk().
>
> With a bit of juggling we can keep 8T for the IO etc. and make the
> vmalloc space 56T. The only complication is the check of the address

What is the significance of 56T number ? Can you add a comment regarding
why 56TB was selected ?


> in the SLB miss handler, see the comment in the code.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/book3s/64/hash.h |  4 ++--
>  arch/powerpc/mm/slb_low.S                 | 18 +++++++++++++++---
>  2 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> index d613653ed5b9..f88452019114 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> @@ -40,7 +40,7 @@
>   * Define the address range of the kernel non-linear virtual area
>   */
>  #define H_KERN_VIRT_START ASM_CONST(0xD000000000000000)
> -#define H_KERN_VIRT_SIZE	ASM_CONST(0x0000100000000000)
> +#define H_KERN_VIRT_SIZE  ASM_CONST(0x0000400000000000) /* 64T */
>
>  /*
>   * The vmalloc space starts at the beginning of that region, and
> @@ -48,7 +48,7 @@
>   * (we keep a quarter for the virtual memmap)
>   */
>  #define H_VMALLOC_START	H_KERN_VIRT_START
> -#define H_VMALLOC_SIZE	(H_KERN_VIRT_SIZE >> 1)
> +#define H_VMALLOC_SIZE	ASM_CONST(0x380000000000) /* 56T */
>  #define H_VMALLOC_END	(H_VMALLOC_START + H_VMALLOC_SIZE)
>
>  #define H_KERN_IO_START	H_VMALLOC_END
> diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
> index 2eb1b92a68ff..906a86fe457b 100644
> --- a/arch/powerpc/mm/slb_low.S
> +++ b/arch/powerpc/mm/slb_low.S
> @@ -121,9 +121,21 @@ slb_miss_kernel_load_vmemmap:
>  1:
>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
>
> -	clrldi	r11,r10,48
> -	cmpldi	r11,(H_VMALLOC_SIZE >> 28) - 1
> -	bgt	5f
> +	/*
> +	 * r10 contains the ESID, which is the original faulting EA shifted
> +	 * right by 28 bits. We need to compare that with (H_VMALLOC_END >> 28)
> +	 * which is 0xd00038000. That can't be used as an immediate, even if we
> +	 * ignored the 0xd, so we have to load it into a register, and we only
> +	 * have one register free. So we must load all of (H_VMALLOC_END >> 28)
> +	 * into a register and compare ESID against that.
> +	 */
> +	lis	r11,(H_VMALLOC_END >> 32)@h	// r11 = 0xffffffffd0000000
> +	ori	r11,r11,(H_VMALLOC_END >> 32)@l	// r11 = 0xffffffffd0003800
> +	// Rotate left 4, then mask with 0xffffffff0
> +	rldic	r11,r11,4,28			// r11 = 0xd00038000
> +	cmpld	r10,r11				// if r10 >= r11
> +	bge	5f				//   goto io_mapping
> +
>  	/*
>  	 * vmalloc mapping gets the encoding from the PACA as the mapping
>  	 * can be demoted from 64K -> 4K dynamically on some machines.
> -- 
> 2.7.4
