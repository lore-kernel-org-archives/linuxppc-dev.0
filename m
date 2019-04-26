Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19006C43219
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 06:52:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 987EC20651
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 06:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987EC20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44r4VT5MCPzDqd1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:52:17 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44r4M02tHYzDqcG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 16:45:48 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3Q6cjVx069797
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 02:45:45 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2s3sa58nhu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 02:45:45 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 26 Apr 2019 07:45:43 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 26 Apr 2019 07:45:40 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3Q6jdGA55705852
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2019 06:45:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79EFD42049;
 Fri, 26 Apr 2019 06:45:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0790542045;
 Fri, 26 Apr 2019 06:45:38 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.193.89.254])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 26 Apr 2019 06:45:37 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 Q)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 04/11] powerpc/mm: move slice_mask_for_size() into mmu.h
In-Reply-To: <f406fa36f3bf7bd8ec5bcf8e3d00f40270050c6a.1556202029.git.christophe.leroy@c-s.fr>
References: <cover.1556202028.git.christophe.leroy@c-s.fr>
 <f406fa36f3bf7bd8ec5bcf8e3d00f40270050c6a.1556202029.git.christophe.leroy@c-s.fr>
Date: Fri, 26 Apr 2019 12:06:55 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19042606-0016-0000-0000-0000027561C0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042606-0017-0000-0000-000032D1DD43
Message-Id: <87zhod9ss8.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-26_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904260048
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

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Move slice_mask_for_size() into subarch mmu.h
>
> At the same time, replace BUG() by VM_BUG_ON() as those BUG() are not
> there to catch runtime errors but to catch errors during development
> cycle only.
>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/book3s/64/mmu.h     | 17 +++++++++++
>  arch/powerpc/include/asm/nohash/32/mmu-8xx.h | 42 +++++++++++++++++++---------
>  arch/powerpc/mm/slice.c                      | 34 ----------------------
>  3 files changed, 46 insertions(+), 47 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
> index 230a9dec7677..ad00355f874f 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
> @@ -203,6 +203,23 @@ static inline struct slice_mask *mm_ctx_slice_mask_16g(mm_context_t *ctx)
>  }
>  #endif
>  
> +static inline struct slice_mask *slice_mask_for_size(mm_context_t *ctx, int psize)
> +{
> +#ifdef CONFIG_PPC_64K_PAGES
> +	if (psize == MMU_PAGE_64K)
> +		return mm_ctx_slice_mask_64k(&ctx);
> +#endif
> +#ifdef CONFIG_HUGETLB_PAGE
> +	if (psize == MMU_PAGE_16M)
> +		return mm_ctx_slice_mask_16m(&ctx);
> +	if (psize == MMU_PAGE_16G)
> +		return mm_ctx_slice_mask_16g(&ctx);
> +#endif
> +	VM_BUG_ON(psize != MMU_PAGE_4K);
> +
> +	return mm_ctx_slice_mask_4k(&ctx);
> +}
> +
>  #ifdef CONFIG_PPC_SUBPAGE_PROT
>  static inline struct subpage_prot_table *mm_ctx_subpage_prot(mm_context_t *ctx)
>  {
> diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
> index c503e2f05e61..a0f6844a1498 100644
> --- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
> +++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
> @@ -184,7 +184,23 @@
>  #define LOW_SLICE_ARRAY_SZ	SLICE_ARRAY_SIZE
>  #endif
>  
> +#if defined(CONFIG_PPC_4K_PAGES)
> +#define mmu_virtual_psize	MMU_PAGE_4K
> +#elif defined(CONFIG_PPC_16K_PAGES)
> +#define mmu_virtual_psize	MMU_PAGE_16K
> +#define PTE_FRAG_NR		4
> +#define PTE_FRAG_SIZE_SHIFT	12
> +#define PTE_FRAG_SIZE		(1UL << 12)
> +#else
> +#error "Unsupported PAGE_SIZE"
> +#endif
> +
> +#define mmu_linear_psize	MMU_PAGE_8M
> +
>  #ifndef __ASSEMBLY__
> +
> +#include <linux/mmdebug.h>
> +
>  struct slice_mask {
>  	u64 low_slices;
>  	DECLARE_BITMAP(high_slices, 0);
> @@ -255,6 +271,19 @@ static inline struct slice_mask *mm_ctx_slice_mask_8m(mm_context_t *ctx)
>  	return &ctx->mask_8m;
>  }
>  #endif
> +
> +static inline struct slice_mask *slice_mask_for_size(mm_context_t *ctx, int psize)
> +{
> +#ifdef CONFIG_HUGETLB_PAGE
> +	if (psize == MMU_PAGE_512K)
> +		return &ctx->mask_512k;
> +	if (psize == MMU_PAGE_8M)
> +		return &ctx->mask_8m;
> +#endif
> +	VM_BUG_ON(psize != mmu_virtual_psize);
> +
> +	return &ctx->mask_base_psize;
> +}
>  #endif /* CONFIG_PPC_MM_SLICE */
>  
>  #define PHYS_IMMR_BASE (mfspr(SPRN_IMMR) & 0xfff80000)
> @@ -306,17 +335,4 @@ extern s32 patch__itlbmiss_perf, patch__dtlbmiss_perf;
>  
>  #endif /* !__ASSEMBLY__ */
>  
> -#if defined(CONFIG_PPC_4K_PAGES)
> -#define mmu_virtual_psize	MMU_PAGE_4K
> -#elif defined(CONFIG_PPC_16K_PAGES)
> -#define mmu_virtual_psize	MMU_PAGE_16K
> -#define PTE_FRAG_NR		4
> -#define PTE_FRAG_SIZE_SHIFT	12
> -#define PTE_FRAG_SIZE		(1UL << 12)
> -#else
> -#error "Unsupported PAGE_SIZE"
> -#endif
> -
> -#define mmu_linear_psize	MMU_PAGE_8M
> -
>  #endif /* _ASM_POWERPC_MMU_8XX_H_ */
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 8eb7e8b09c75..31de91b65a64 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -150,40 +150,6 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret,
>  			__set_bit(i, ret->high_slices);
>  }
>  
> -#ifdef CONFIG_PPC_BOOK3S_64
> -static struct slice_mask *slice_mask_for_size(mm_context_t *ctx, int psize)
> -{
> -#ifdef CONFIG_PPC_64K_PAGES
> -	if (psize == MMU_PAGE_64K)
> -		return mm_ctx_slice_mask_64k(&ctx);
> -#endif
> -	if (psize == MMU_PAGE_4K)
> -		return mm_ctx_slice_mask_4k(&ctx);
> -#ifdef CONFIG_HUGETLB_PAGE
> -	if (psize == MMU_PAGE_16M)
> -		return mm_ctx_slice_mask_16m(&ctx);
> -	if (psize == MMU_PAGE_16G)
> -		return mm_ctx_slice_mask_16g(&ctx);
> -#endif
> -	BUG();
> -}
> -#elif defined(CONFIG_PPC_8xx)
> -static struct slice_mask *slice_mask_for_size(mm_context_t *ctx, int psize)
> -{
> -	if (psize == mmu_virtual_psize)
> -		return &ctx->mask_base_psize;
> -#ifdef CONFIG_HUGETLB_PAGE
> -	if (psize == MMU_PAGE_512K)
> -		return &ctx->mask_512k;
> -	if (psize == MMU_PAGE_8M)
> -		return &ctx->mask_8m;
> -#endif
> -	BUG();
> -}
> -#else
> -#error "Must define the slice masks for page sizes supported by the platform"
> -#endif
> -
>  static bool slice_check_range_fits(struct mm_struct *mm,
>  			   const struct slice_mask *available,
>  			   unsigned long start, unsigned long len)
> -- 
> 2.13.3

