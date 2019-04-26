Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AA4C43218
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 06:50:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D9AD206DD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 06:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9AD206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44r4Sm14kzzDqjZ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:50:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44r4Lq4YG5zDqWF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 16:45:39 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3Q6cipQ017413
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 02:45:37 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2s3u5pw1ec-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 02:45:36 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 26 Apr 2019 07:45:35 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 26 Apr 2019 07:45:32 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3Q6jVxx33423400
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2019 06:45:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0C29A406D;
 Fri, 26 Apr 2019 06:45:31 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAC96A4059;
 Fri, 26 Apr 2019 06:45:29 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.193.89.254])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 26 Apr 2019 06:45:29 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 Q)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 03/11] powerpc/mm: hand a context_t over to
 slice_mask_for_size() instead of mm_struct
In-Reply-To: <633e11daecb440a8233890589a4025ed5003f222.1556202029.git.christophe.leroy@c-s.fr>
References: <cover.1556202028.git.christophe.leroy@c-s.fr>
 <633e11daecb440a8233890589a4025ed5003f222.1556202029.git.christophe.leroy@c-s.fr>
Date: Fri, 26 Apr 2019 12:04:40 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19042606-4275-0000-0000-0000032E6D15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042606-4276-0000-0000-0000383DBC43
Message-Id: <8736m5b7gf.fsf@linux.ibm.com>
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

> slice_mask_for_size() only uses mm->context, so hand directly a
> pointer to the context. This will help moving the function in
> subarch mmu.h in the next patch by avoiding having to include
> the definition of struct mm_struct
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/mm/slice.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 35b278082391..8eb7e8b09c75 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -151,32 +151,32 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret,
>  }
>  
>  #ifdef CONFIG_PPC_BOOK3S_64
> -static struct slice_mask *slice_mask_for_size(struct mm_struct *mm, int psize)
> +static struct slice_mask *slice_mask_for_size(mm_context_t *ctx, int psize)
>  {
>  #ifdef CONFIG_PPC_64K_PAGES
>  	if (psize == MMU_PAGE_64K)
> -		return mm_ctx_slice_mask_64k(&mm->context);
> +		return mm_ctx_slice_mask_64k(&ctx);
>  #endif
>  	if (psize == MMU_PAGE_4K)
> -		return mm_ctx_slice_mask_4k(&mm->context);
> +		return mm_ctx_slice_mask_4k(&ctx);
>  #ifdef CONFIG_HUGETLB_PAGE
>  	if (psize == MMU_PAGE_16M)
> -		return mm_ctx_slice_mask_16m(&mm->context);
> +		return mm_ctx_slice_mask_16m(&ctx);
>  	if (psize == MMU_PAGE_16G)
> -		return mm_ctx_slice_mask_16g(&mm->context);
> +		return mm_ctx_slice_mask_16g(&ctx);
>  #endif
>  	BUG();
>  }
>  #elif defined(CONFIG_PPC_8xx)
> -static struct slice_mask *slice_mask_for_size(struct mm_struct *mm, int psize)
> +static struct slice_mask *slice_mask_for_size(mm_context_t *ctx, int psize)
>  {
>  	if (psize == mmu_virtual_psize)
> -		return &mm->context.mask_base_psize;
> +		return &ctx->mask_base_psize;
>  #ifdef CONFIG_HUGETLB_PAGE
>  	if (psize == MMU_PAGE_512K)
> -		return &mm->context.mask_512k;
> +		return &ctx->mask_512k;
>  	if (psize == MMU_PAGE_8M)
> -		return &mm->context.mask_8m;
> +		return &ctx->mask_8m;
>  #endif
>  	BUG();
>  }
> @@ -246,7 +246,7 @@ static void slice_convert(struct mm_struct *mm,
>  	slice_dbg("slice_convert(mm=%p, psize=%d)\n", mm, psize);
>  	slice_print_mask(" mask", mask);
>  
> -	psize_mask = slice_mask_for_size(mm, psize);
> +	psize_mask = slice_mask_for_size(&mm->context, psize);
>  
>  	/* We need to use a spinlock here to protect against
>  	 * concurrent 64k -> 4k demotion ...
> @@ -263,7 +263,7 @@ static void slice_convert(struct mm_struct *mm,
>  
>  		/* Update the slice_mask */
>  		old_psize = (lpsizes[index] >> (mask_index * 4)) & 0xf;
> -		old_mask = slice_mask_for_size(mm, old_psize);
> +		old_mask = slice_mask_for_size(&mm->context, old_psize);
>  		old_mask->low_slices &= ~(1u << i);
>  		psize_mask->low_slices |= 1u << i;
>  
> @@ -282,7 +282,7 @@ static void slice_convert(struct mm_struct *mm,
>  
>  		/* Update the slice_mask */
>  		old_psize = (hpsizes[index] >> (mask_index * 4)) & 0xf;
> -		old_mask = slice_mask_for_size(mm, old_psize);
> +		old_mask = slice_mask_for_size(&mm->context, old_psize);
>  		__clear_bit(i, old_mask->high_slices);
>  		__set_bit(i, psize_mask->high_slices);
>  
> @@ -538,7 +538,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>  	/* First make up a "good" mask of slices that have the right size
>  	 * already
>  	 */
> -	maskp = slice_mask_for_size(mm, psize);
> +	maskp = slice_mask_for_size(&mm->context, psize);
>  
>  	/*
>  	 * Here "good" means slices that are already the right page size,
> @@ -565,7 +565,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>  	 * a pointer to good mask for the next code to use.
>  	 */
>  	if (IS_ENABLED(CONFIG_PPC_64K_PAGES) && psize == MMU_PAGE_64K) {
> -		compat_maskp = slice_mask_for_size(mm, MMU_PAGE_4K);
> +		compat_maskp = slice_mask_for_size(&mm->context, MMU_PAGE_4K);
>  		if (fixed)
>  			slice_or_mask(&good_mask, maskp, compat_maskp);
>  		else
> @@ -760,7 +760,7 @@ void slice_init_new_context_exec(struct mm_struct *mm)
>  	/*
>  	 * Slice mask cache starts zeroed, fill the default size cache.
>  	 */
> -	mask = slice_mask_for_size(mm, psize);
> +	mask = slice_mask_for_size(&mm->context, psize);
>  	mask->low_slices = ~0UL;
>  	if (SLICE_NUM_HIGH)
>  		bitmap_fill(mask->high_slices, SLICE_NUM_HIGH);
> @@ -819,14 +819,14 @@ int slice_is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
>  
>  	VM_BUG_ON(radix_enabled());
>  
> -	maskp = slice_mask_for_size(mm, psize);
> +	maskp = slice_mask_for_size(&mm->context, psize);
>  #ifdef CONFIG_PPC_64K_PAGES
>  	/* We need to account for 4k slices too */
>  	if (psize == MMU_PAGE_64K) {
>  		const struct slice_mask *compat_maskp;
>  		struct slice_mask available;
>  
> -		compat_maskp = slice_mask_for_size(mm, MMU_PAGE_4K);
> +		compat_maskp = slice_mask_for_size(&mm->context, MMU_PAGE_4K);
>  		slice_or_mask(&available, maskp, compat_maskp);
>  		return !slice_check_range_fits(mm, &available, addr, len);
>  	}
> -- 
> 2.13.3

