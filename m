Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAF9C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 11:27:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD972081C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 11:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD972081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 435FcN1msCzDqDh
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 22:27:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 435FYk3S7vzDqcL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 22:25:14 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wATBJN3w084448
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 06:25:12 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p2d1se9j7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 06:25:11 -0500
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Thu, 29 Nov 2018 11:25:10 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 29 Nov 2018 11:25:07 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wATBP6PI11927800
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 29 Nov 2018 11:25:06 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63924AC059;
 Thu, 29 Nov 2018 11:25:06 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5600BAC05E;
 Thu, 29 Nov 2018 11:25:04 +0000 (GMT)
Received: from [9.85.85.107] (unknown [9.85.85.107])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 29 Nov 2018 11:25:03 +0000 (GMT)
Subject: Re: [PATCH] powerpc/mm: add exec protection on powerpc 603
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <c8231561dfd73a18cc0fe7db94405ee71a886136.1542388741.git.christophe.leroy@c-s.fr>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Thu, 29 Nov 2018 16:55:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <c8231561dfd73a18cc0fe7db94405ee71a886136.1542388741.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18112911-0060-0000-0000-000002DB591A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010142; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01124425; UDB=6.00583796; IPR=6.00904552; 
 MB=3.00024380; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-29 11:25:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112911-0061-0000-0000-0000475C5548
Message-Id: <a1e73a85-f5f0-769e-ba17-5b4560ecd9b7@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-29_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811290099
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/16/18 10:50 PM, Christophe Leroy wrote:
> The 603 doesn't have a HASH table, TLB misses are handled by
> software. It is then possible to generate page fault when
> _PAGE_EXEC is not set like in nohash/32.
> 
> In order to support it, set_pte_filter() and
> set_access_flags_filter() are made common, and the handling
> is made dependent on MMU_FTR_HPTE_TABLE
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/include/asm/book3s/32/hash.h    |  1 +
>   arch/powerpc/include/asm/book3s/32/pgtable.h | 18 +++++++++---------
>   arch/powerpc/include/asm/cputable.h          |  8 ++++----
>   arch/powerpc/kernel/head_32.S                |  2 ++
>   arch/powerpc/mm/pgtable.c                    | 20 +++++++++++---------
>   5 files changed, 27 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/32/hash.h b/arch/powerpc/include/asm/book3s/32/hash.h
> index f2892c7ab73e..2a0a467d2985 100644
> --- a/arch/powerpc/include/asm/book3s/32/hash.h
> +++ b/arch/powerpc/include/asm/book3s/32/hash.h
> @@ -26,6 +26,7 @@
>   #define _PAGE_WRITETHRU	0x040	/* W: cache write-through */
>   #define _PAGE_DIRTY	0x080	/* C: page changed */
>   #define _PAGE_ACCESSED	0x100	/* R: page referenced */
> +#define _PAGE_EXEC	0x200	/* software: exec allowed */
>   #define _PAGE_RW	0x400	/* software: user write access allowed */
>   #define _PAGE_SPECIAL	0x800	/* software: Special page */
>   
> diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
> index c21d33704633..cf844fed4527 100644
> --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
> @@ -10,9 +10,9 @@
>   /* And here we include common definitions */
>   
>   #define _PAGE_KERNEL_RO		0
> -#define _PAGE_KERNEL_ROX	0
> +#define _PAGE_KERNEL_ROX	(_PAGE_EXEC)
>   #define _PAGE_KERNEL_RW		(_PAGE_DIRTY | _PAGE_RW)
> -#define _PAGE_KERNEL_RWX	(_PAGE_DIRTY | _PAGE_RW)
> +#define _PAGE_KERNEL_RWX	(_PAGE_DIRTY | _PAGE_RW | _PAGE_EXEC)
>   
>   #define _PAGE_HPTEFLAGS _PAGE_HASHPTE
>   
> @@ -66,11 +66,11 @@ static inline bool pte_user(pte_t pte)
>    */
>   #define PAGE_NONE	__pgprot(_PAGE_BASE)
>   #define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
> -#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
> +#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW | _PAGE_EXEC)
>   #define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER)
> -#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER)
> +#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
>   #define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER)
> -#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER)
> +#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
>   
>   /* Permission masks used for kernel mappings */
>   #define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW)
> @@ -318,7 +318,7 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
>   					   int psize)
>   {
>   	unsigned long set = pte_val(entry) &
> -		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW);
> +		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
>   
>   	pte_update(ptep, 0, set);
>   
> @@ -384,7 +384,7 @@ static inline int pte_dirty(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_DIRTY);
>   static inline int pte_young(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_ACCESSED); }
>   static inline int pte_special(pte_t pte)	{ return !!(pte_val(pte) & _PAGE_SPECIAL); }
>   static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
> -static inline bool pte_exec(pte_t pte)		{ return true; }
> +static inline bool pte_exec(pte_t pte)		{ return pte_val(pte) & _PAGE_EXEC; }
>   
>   static inline int pte_present(pte_t pte)
>   {
> @@ -451,7 +451,7 @@ static inline pte_t pte_wrprotect(pte_t pte)
>   
>   static inline pte_t pte_exprotect(pte_t pte)
>   {
> -	return pte;
> +	return __pte(pte_val(pte) & ~_PAGE_EXEC);
>   }
>   
>   static inline pte_t pte_mkclean(pte_t pte)
> @@ -466,7 +466,7 @@ static inline pte_t pte_mkold(pte_t pte)
>   
>   static inline pte_t pte_mkexec(pte_t pte)
>   {
> -	return pte;
> +	return __pte(pte_val(pte) | _PAGE_EXEC);
>   }
>   
>   static inline pte_t pte_mkpte(pte_t pte)
> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
> index 29f49a35d6ee..a0395ccbbe9e 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -296,7 +296,7 @@ static inline void cpu_feature_keys_init(void) { }
>   #define CPU_FTRS_PPC601	(CPU_FTR_COMMON | CPU_FTR_601 | \
>   	CPU_FTR_COHERENT_ICACHE | CPU_FTR_UNIFIED_ID_CACHE | CPU_FTR_USE_RTC)
>   #define CPU_FTRS_603	(CPU_FTR_COMMON | CPU_FTR_MAYBE_CAN_DOZE | \
> -	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_PPC_LE)
> +	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_PPC_LE | CPU_FTR_NOEXECUTE)
>   #define CPU_FTRS_604	(CPU_FTR_COMMON | CPU_FTR_PPC_LE)
>   #define CPU_FTRS_740_NOTAU	(CPU_FTR_COMMON | \
>   	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_L2CR | \
> @@ -367,15 +367,15 @@ static inline void cpu_feature_keys_init(void) { }
>   	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
>   	    CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR | \
>   	    CPU_FTR_PPC_LE | CPU_FTR_NEED_PAIRED_STWCX)
> -#define CPU_FTRS_82XX	(CPU_FTR_COMMON | CPU_FTR_MAYBE_CAN_DOZE)
> +#define CPU_FTRS_82XX	(CPU_FTR_COMMON | CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_NOEXECUTE)
>   #define CPU_FTRS_G2_LE	(CPU_FTR_COMMON | CPU_FTR_MAYBE_CAN_DOZE | \
>   	    CPU_FTR_MAYBE_CAN_NAP)
>   #define CPU_FTRS_E300	(CPU_FTR_MAYBE_CAN_DOZE | \
>   	    CPU_FTR_MAYBE_CAN_NAP | \
> -	    CPU_FTR_COMMON)
> +	    CPU_FTR_COMMON  | CPU_FTR_NOEXECUTE)
>   #define CPU_FTRS_E300C2	(CPU_FTR_MAYBE_CAN_DOZE | \
>   	    CPU_FTR_MAYBE_CAN_NAP | \
> -	    CPU_FTR_COMMON | CPU_FTR_FPU_UNAVAILABLE)
> +	    CPU_FTR_COMMON | CPU_FTR_FPU_UNAVAILABLE  | CPU_FTR_NOEXECUTE)
>   #define CPU_FTRS_CLASSIC32	(CPU_FTR_COMMON)
>   #define CPU_FTRS_8XX	(CPU_FTR_NOEXECUTE)
>   #define CPU_FTRS_40X	(CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
> diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
> index 61ca27929355..50e892763dbb 100644
> --- a/arch/powerpc/kernel/head_32.S
> +++ b/arch/powerpc/kernel/head_32.S
> @@ -515,6 +515,8 @@ InstructionTLBMiss:
>   	lwz	r0,0(r2)		/* get linux-style pte */
>   	andc.	r1,r1,r0		/* check access & ~permission */
>   	bne-	InstructionAddressInvalid /* return if access not permitted */
> +	andi.	r1,r0,_PAGE_EXEC
> +	beq-	InstructionAddressInvalid /* return if not _PAGE_EXEC */
>   	ori	r0,r0,_PAGE_ACCESSED	/* set _PAGE_ACCESSED in pte */

Can we get a DataTLB miss and expect to map that in TLB with Exec 
permission?

>   	/*
>   	 * NOTE! We are assuming this is not an SMP system, otherwise
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index 010e1c616cb2..3d86fe9d2ff4 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -74,7 +74,7 @@ static struct page *maybe_pte_to_page(pte_t pte)
>    * support falls into the same category.
>    */
>   
> -static pte_t set_pte_filter(pte_t pte)
> +static pte_t set_pte_filter_hash(pte_t pte)
>   {
>   	if (radix_enabled())
>   		return pte;
> @@ -93,14 +93,12 @@ static pte_t set_pte_filter(pte_t pte)
>   	return pte;
>   }
>   
> -static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
> -				     int dirty)
> -{
> -	return pte;
> -}
> -
>   #else /* CONFIG_PPC_BOOK3S */
>   
> +static pte_t set_pte_filter_hash(pte_t pte) { return pte; }
> +
> +#endif /* CONFIG_PPC_BOOK3S */
> +
>   /* Embedded type MMU with HW exec support. This is a bit more complicated
>    * as we don't have two bits to spare for _PAGE_EXEC and _PAGE_HWEXEC so
>    * instead we "filter out" the exec permission for non clean pages.
> @@ -109,6 +107,9 @@ static pte_t set_pte_filter(pte_t pte)
>   {
>   	struct page *pg;
>   
> +	if (mmu_has_feature(MMU_FTR_HPTE_TABLE))
> +		return set_pte_filter_hash(pte);

so 603 doesn't have a coherent icache?

> +
>   	/* No exec permission in the first place, move on */
>   	if (!pte_exec(pte) || !pte_looks_normal(pte))
>   		return pte;
> @@ -138,6 +139,9 @@ static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
>   {
>   	struct page *pg;
>   
> +	if (mmu_has_feature(MMU_FTR_HPTE_TABLE))
> +		return pte;
> +
>   	/* So here, we only care about exec faults, as we use them
>   	 * to recover lost _PAGE_EXEC and perform I$/D$ coherency
>   	 * if necessary. Also if _PAGE_EXEC is already set, same deal,
> @@ -172,8 +176,6 @@ static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
>   	return pte_mkexec(pte);
>   }
>   
> -#endif /* CONFIG_PPC_BOOK3S */
> -
>   /*
>    * set_pte stores a linux PTE into the linux page table.
>    */
> 

The code looks good from book3s 64 point. I am not familiar with 603 
hardware.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

-aneesh

