Return-Path: <srs0=f9ru=5n=linux.vnet.ibm.com=aneesh.kumar@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjxBl1FrMzDqFH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 17:00:15 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wjxBl0Nk7z90MN
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 17:00:15 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wjxBk1yX5z9s81
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2017 17:00:14 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v586x56G046199
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Jun 2017 03:00:12 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2axxkkqvhj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 08 Jun 2017 03:00:11 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 8 Jun 2017 17:00:08 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v58707N16029612
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Jun 2017 17:00:07 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v58706ai026809
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Jun 2017 17:00:07 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/mm/radix: Only add X for pages overlapping kernel
 text
In-Reply-To: <1496728137-19655-1-git-send-email-mpe@ellerman.id.au>
References: <1496728137-19655-1-git-send-email-mpe@ellerman.id.au>
Date: Thu, 08 Jun 2017 12:30:04 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8760g72ccr.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Currently we map the whole linear mapping with PAGE_KERNEL_X. Instead we
> should check if the page overlaps the kernel text and only then add
> PAGE_KERNEL_X.
>
> Note that we still use 1G pages if they're available, so this will
> typically still result in a 1G executable page at KERNELBASE. So this fix is
> primarily useful for catching stray branches to high linear mapping addresses.
>
> Without this patch, we can execute at 1G in xmon using:
>
>   0:mon> m c000000040000000
>   c000000040000000  00 l
>   c000000040000000  00000000 01006038
>   c000000040000004  00000000 2000804e
>   c000000040000008  00000000 x
>   0:mon> di c000000040000000
>   c000000040000000  38600001      li      r3,1
>   c000000040000004  4e800020      blr
>   0:mon> p c000000040000000
>   return value is 0x1
>
> After we get a 400 as expected:
>
>   0:mon> p c000000040000000
>   *** 400 exception occurred
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>


> Fixes: 2bfd65e45e87 ("powerpc/mm/radix: Add radix callbacks for early init routines")
> Cc: stable@vger.kernel.org # v4.7+
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/mm/pgtable-radix.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index c28165d8970b..6c062f92b9e4 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -19,6 +19,7 @@
>  #include <asm/mmu.h>
>  #include <asm/firmware.h>
>  #include <asm/powernv.h>
> +#include <asm/sections.h>
>
>  #include <trace/events/thp.h>
>
> @@ -121,7 +122,8 @@ static inline void __meminit print_mapping(unsigned long start,
>  static int __meminit create_physical_mapping(unsigned long start,
>  					     unsigned long end)
>  {
> -	unsigned long addr, mapping_size = 0;
> +	unsigned long vaddr, addr, mapping_size = 0;
> +	pgprot_t prot;
>
>  	start = _ALIGN_UP(start, PAGE_SIZE);
>  	for (addr = start; addr < end; addr += mapping_size) {
> @@ -145,8 +147,14 @@ static int __meminit create_physical_mapping(unsigned long start,
>  			start = addr;
>  		}
>
> -		rc = radix__map_kernel_page((unsigned long)__va(addr), addr,
> -					    PAGE_KERNEL_X, mapping_size);
> +		vaddr = (unsigned long)__va(addr);
> +
> +		if (overlaps_kernel_text(vaddr, vaddr + mapping_size))
> +			prot = PAGE_KERNEL_X;
> +		else
> +			prot = PAGE_KERNEL;
> +
> +		rc = radix__map_kernel_page(vaddr, addr, prot, mapping_size);
>  		if (rc)
>  			return rc;
>  	}
> -- 
> 2.7.4
