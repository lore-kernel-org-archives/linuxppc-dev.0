Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSSpn0bybzDvnP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 13:55:44 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAT2s1b5094177
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 21:55:42 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 270tb0yb7x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 21:55:42 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 28 Nov 2016 21:55:41 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Fix lazy icache flush on pre-POWER5
In-Reply-To: <1480385626.11342.53.camel@kernel.crashing.org>
References: <1480385626.11342.53.camel@kernel.crashing.org>
Date: Tue, 29 Nov 2016 08:25:37 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8737ibm1ue.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On 64-bit CPUs with no-execute support and non-snooping icache, such as
> 970 or POWER4, we have a software mechanism to ensure coherency of the
> cache (using exec faults when needed).
>
> This was broken due to a logic inversion when that code was rewritten
> from assembly to C.

The asm code for reference is

BEGIN_FTR_SECTION
       mr      r4,r30
       mr      r5,r7
       bl      hash_page_do_lazy_icache
END_FTR_SECTION(CPU_FTR_NOEXECUTE|CPU_FTR_COHERENT_ICACHE, CPU_FTR_NOEXECUTE)


Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Fixes: 91f1da99792a1d133df94c4753510305353064a1
> Fixes: 89ff725051d177556b23d80f2a30f880a657a6c1
> Fixes: a43c0eb8364c022725df586e91dd753633374d66
> --
> diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
> index 42c702b..6fa450c 100644
> --- a/arch/powerpc/mm/hash64_4k.c
> +++ b/arch/powerpc/mm/hash64_4k.c
> @@ -55,7 +55,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  	 */
>  	rflags = htab_convert_pte_flags(new_pte);
>
> -	if (!cpu_has_feature(CPU_FTR_NOEXECUTE) &&
> +	if (cpu_has_feature(CPU_FTR_NOEXECUTE) &&
>  	    !cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
>  		rflags = hash_page_do_lazy_icache(rflags, __pte(old_pte), trap);
>
> diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
> index 3bbbea0..1a68cb1 100644
> --- a/arch/powerpc/mm/hash64_64k.c
> +++ b/arch/powerpc/mm/hash64_64k.c
> @@ -87,7 +87,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  	subpg_pte = new_pte & ~subpg_prot;
>  	rflags = htab_convert_pte_flags(subpg_pte);
>
> -	if (!cpu_has_feature(CPU_FTR_NOEXECUTE) &&
> +	if (cpu_has_feature(CPU_FTR_NOEXECUTE) &&
>  	    !cpu_has_feature(CPU_FTR_COHERENT_ICACHE)) {
>
>  		/*
> @@ -258,7 +258,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
>
>  	rflags = htab_convert_pte_flags(new_pte);
>
> -	if (!cpu_has_feature(CPU_FTR_NOEXECUTE) &&
> +	if (cpu_has_feature(CPU_FTR_NOEXECUTE) &&
>  	    !cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
>  		rflags = hash_page_do_lazy_icache(rflags, __pte(old_pte), trap);
