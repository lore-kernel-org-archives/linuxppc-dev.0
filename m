Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E36AC43219
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 06:58:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CA4F206E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 06:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA4F206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44r4dP606NzDqP8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:58:17 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44r4Mf00jTzDqg1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 16:46:21 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3Q6ckJW019764
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 02:46:20 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2s3vrw0sce-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 02:46:19 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 26 Apr 2019 07:46:18 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 26 Apr 2019 07:46:15 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3Q6kE0G47775752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2019 06:46:14 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 43D8E11C066;
 Fri, 26 Apr 2019 06:46:14 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 938B411C058;
 Fri, 26 Apr 2019 06:46:12 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.193.89.254])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 26 Apr 2019 06:46:12 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 Q)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 11/11] powerpc/mm: drop slice DEBUG
In-Reply-To: <f263887b4ca31f4bb0fe77823e301c28ba27c796.1556202029.git.christophe.leroy@c-s.fr>
References: <cover.1556202028.git.christophe.leroy@c-s.fr>
 <f263887b4ca31f4bb0fe77823e301c28ba27c796.1556202029.git.christophe.leroy@c-s.fr>
Date: Fri, 26 Apr 2019 12:14:39 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19042606-0020-0000-0000-000003365F07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042606-0021-0000-0000-00002188CE7B
Message-Id: <87lfzx9sfc.fsf@linux.ibm.com>
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

> slice is now an improved functionnality. Drop the DEBUG stuff.
>

I would like to keep that. I helped a lot when moving address ranges and
it should not have any runtime impact.


> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/mm/slice.c | 62 ++++---------------------------------------------
>  1 file changed, 4 insertions(+), 58 deletions(-)
>
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 97fbf7b54422..a9d803738b65 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -41,28 +41,6 @@
>  
>  static DEFINE_SPINLOCK(slice_convert_lock);
>  
> -#ifdef DEBUG
> -int _slice_debug = 1;
> -
> -static void slice_print_mask(const char *label, const struct slice_mask *mask)
> -{
> -	if (!_slice_debug)
> -		return;
> -	pr_devel("%s low_slice: %*pbl\n", label,
> -			(int)SLICE_NUM_LOW, &mask->low_slices);
> -	pr_devel("%s high_slice: %*pbl\n", label,
> -			(int)SLICE_NUM_HIGH, mask->high_slices);
> -}
> -
> -#define slice_dbg(fmt...) do { if (_slice_debug) pr_devel(fmt); } while (0)
> -
> -#else
> -
> -static void slice_print_mask(const char *label, const struct slice_mask *mask) {}
> -#define slice_dbg(fmt...)
> -
> -#endif
> -
>  static inline bool slice_addr_is_low(unsigned long addr)
>  {
>  	u64 tmp = (u64)addr;
> @@ -207,9 +185,6 @@ static void slice_convert(struct mm_struct *mm,
>  	unsigned long i, flags;
>  	int old_psize;
>  
> -	slice_dbg("slice_convert(mm=%p, psize=%d)\n", mm, psize);
> -	slice_print_mask(" mask", mask);
> -
>  	psize_mask = slice_mask_for_size(&mm->context, psize);
>  
>  	/* We need to use a spinlock here to protect against
> @@ -255,10 +230,6 @@ static void slice_convert(struct mm_struct *mm,
>  				(((unsigned long)psize) << (mask_index * 4));
>  	}
>  
> -	slice_dbg(" lsps=%lx, hsps=%lx\n",
> -		  (unsigned long)mm_ctx_low_slices(&mm->context),
> -		  (unsigned long)mm_ctx_high_slices(&mm->context));
> -
>  	spin_unlock_irqrestore(&slice_convert_lock, flags);
>  
>  	copro_flush_all_slbs(mm);
> @@ -485,14 +456,9 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>  	BUG_ON(mm_ctx_slb_addr_limit(&mm->context) == 0);
>  	VM_BUG_ON(radix_enabled());
>  
> -	slice_dbg("slice_get_unmapped_area(mm=%p, psize=%d...\n", mm, psize);
> -	slice_dbg(" addr=%lx, len=%lx, flags=%lx, topdown=%d\n",
> -		  addr, len, flags, topdown);
> -
>  	/* If hint, make sure it matches our alignment restrictions */
>  	if (!fixed && addr) {
>  		addr = _ALIGN_UP(addr, page_size);
> -		slice_dbg(" aligned addr=%lx\n", addr);
>  		/* Ignore hint if it's too large or overlaps a VMA */
>  		if (addr > high_limit - len || addr < mmap_min_addr ||
>  		    !slice_area_is_free(mm, addr, len))
> @@ -538,17 +504,12 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>  		slice_copy_mask(&good_mask, maskp);
>  	}
>  
> -	slice_print_mask(" good_mask", &good_mask);
> -	if (compat_maskp)
> -		slice_print_mask(" compat_mask", compat_maskp);
> -
>  	/* First check hint if it's valid or if we have MAP_FIXED */
>  	if (addr != 0 || fixed) {
>  		/* Check if we fit in the good mask. If we do, we just return,
>  		 * nothing else to do
>  		 */
>  		if (slice_check_range_fits(mm, &good_mask, addr, len)) {
> -			slice_dbg(" fits good !\n");
>  			newaddr = addr;
>  			goto return_addr;
>  		}
> @@ -558,13 +519,10 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>  		 */
>  		newaddr = slice_find_area(mm, len, &good_mask,
>  					  psize, topdown, high_limit);
> -		if (newaddr != -ENOMEM) {
> -			/* Found within the good mask, we don't have to setup,
> -			 * we thus return directly
> -			 */
> -			slice_dbg(" found area at 0x%lx\n", newaddr);
> +
> +		/* Found within good mask, don't have to setup, thus return directly */
> +		if (newaddr != -ENOMEM)
>  			goto return_addr;
> -		}
>  	}
>  	/*
>  	 * We don't fit in the good mask, check what other slices are
> @@ -572,11 +530,9 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>  	 */
>  	slice_mask_for_free(mm, &potential_mask, high_limit);
>  	slice_or_mask(&potential_mask, &potential_mask, &good_mask);
> -	slice_print_mask(" potential", &potential_mask);
>  
>  	if (addr != 0 || fixed) {
>  		if (slice_check_range_fits(mm, &potential_mask, addr, len)) {
> -			slice_dbg(" fits potential !\n");
>  			newaddr = addr;
>  			goto convert;
>  		}
> @@ -586,18 +542,14 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>  	if (fixed)
>  		return -EBUSY;
>  
> -	slice_dbg(" search...\n");
> -
>  	/* If we had a hint that didn't work out, see if we can fit
>  	 * anywhere in the good area.
>  	 */
>  	if (addr) {
>  		newaddr = slice_find_area(mm, len, &good_mask,
>  					  psize, topdown, high_limit);
> -		if (newaddr != -ENOMEM) {
> -			slice_dbg(" found area at 0x%lx\n", newaddr);
> +		if (newaddr != -ENOMEM)
>  			goto return_addr;
> -		}
>  	}
>  
>  	/* Now let's see if we can find something in the existing slices
> @@ -618,8 +570,6 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>  		return -ENOMEM;
>  
>  	slice_range_to_mask(newaddr, len, &potential_mask);
> -	slice_dbg(" found potential area at 0x%lx\n", newaddr);
> -	slice_print_mask(" mask", &potential_mask);
>  
>   convert:
>  	/*
> @@ -697,8 +647,6 @@ void slice_init_new_context_exec(struct mm_struct *mm)
>  	struct slice_mask *mask;
>  	unsigned int psize = mmu_virtual_psize;
>  
> -	slice_dbg("slice_init_new_context_exec(mm=%p)\n", mm);
> -
>  	/*
>  	 * In the case of exec, use the default limit. In the
>  	 * case of fork it is just inherited from the mm being
> @@ -730,8 +678,6 @@ void slice_setup_new_exec(void)
>  {
>  	struct mm_struct *mm = current->mm;
>  
> -	slice_dbg("slice_setup_new_exec(mm=%p)\n", mm);
> -
>  	if (!is_32bit_task())
>  		return;
>  
> -- 
> 2.13.3

