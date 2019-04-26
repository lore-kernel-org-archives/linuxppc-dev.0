Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168E5C43219
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 06:56:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA55206DD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 06:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA55206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44r4bp4bH9zDqgX
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:56:54 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44r4MW598qzDqg1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 16:46:15 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3Q6dN1h121537
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 02:46:13 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2s3vjmh6wf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 02:46:13 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 26 Apr 2019 07:46:11 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 26 Apr 2019 07:46:08 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3Q6k7DQ57933904
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2019 06:46:07 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29A774C040;
 Fri, 26 Apr 2019 06:46:07 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A0984C06E;
 Fri, 26 Apr 2019 06:46:05 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.193.89.254])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 26 Apr 2019 06:46:05 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 Q)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 10/11] powerpc/mm: define subarch SLB_ADDR_LIMIT_DEFAULT
In-Reply-To: <c21aee3bc21b17c7a3491ef07e563ba235aeb101.1556202029.git.christophe.leroy@c-s.fr>
References: <cover.1556202028.git.christophe.leroy@c-s.fr>
 <c21aee3bc21b17c7a3491ef07e563ba235aeb101.1556202029.git.christophe.leroy@c-s.fr>
Date: Fri, 26 Apr 2019 12:13:34 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19042606-4275-0000-0000-0000032E6D1D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042606-4276-0000-0000-0000383DBC4B
Message-Id: <87o94t9sh5.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-26_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
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

> This patch defines a subarch specific SLB_ADDR_LIMIT_DEFAULT
> to remove the #ifdefs around the setup of mm->context.slb_addr_limit
>
> It also generalises the use of mm_ctx_set_slb_addr_limit() helper.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/book3s/64/slice.h | 2 ++
>  arch/powerpc/include/asm/nohash/32/slice.h | 2 ++
>  arch/powerpc/mm/hash_utils_64.c            | 2 +-
>  arch/powerpc/mm/slice.c                    | 6 +-----
>  arch/powerpc/mm/tlb_nohash.c               | 4 +---
>  5 files changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/slice.h b/arch/powerpc/include/asm/book3s/64/slice.h
> index 062e11136e9c..f0d3194ba41b 100644
> --- a/arch/powerpc/include/asm/book3s/64/slice.h
> +++ b/arch/powerpc/include/asm/book3s/64/slice.h
> @@ -11,4 +11,6 @@
>  #define SLICE_NUM_HIGH		(H_PGTABLE_RANGE >> SLICE_HIGH_SHIFT)
>  #define GET_HIGH_SLICE_INDEX(addr)	((addr) >> SLICE_HIGH_SHIFT)
>  
> +#define SLB_ADDR_LIMIT_DEFAULT	DEFAULT_MAP_WINDOW_USER64
> +
>  #endif /* _ASM_POWERPC_BOOK3S_64_SLICE_H */
> diff --git a/arch/powerpc/include/asm/nohash/32/slice.h b/arch/powerpc/include/asm/nohash/32/slice.h
> index 777d62e40ac0..39eb0154ae2d 100644
> --- a/arch/powerpc/include/asm/nohash/32/slice.h
> +++ b/arch/powerpc/include/asm/nohash/32/slice.h
> @@ -13,6 +13,8 @@
>  #define SLICE_NUM_HIGH		0ul
>  #define GET_HIGH_SLICE_INDEX(addr)	(addr & 0)
>  
> +#define SLB_ADDR_LIMIT_DEFAULT	DEFAULT_MAP_WINDOW
> +
>  #endif /* CONFIG_PPC_MM_SLICES */
>  
>  #endif /* _ASM_POWERPC_NOHASH_32_SLICE_H */
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index f727197de713..884246e3bf0b 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -1050,7 +1050,7 @@ void __init hash__early_init_mmu(void)
>  	htab_initialize();
>  
>  	init_mm.context.hash_context = &init_hash_mm_context;
> -	init_mm.context.hash_context->slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;
> +	mm_ctx_set_slb_addr_limit(&init_mm.context, SLB_ADDR_LIMIT_DEFAULT);
>  
>  	pr_info("Initializing hash mmu with SLB\n");
>  	/* Initialize SLB management */
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index ace97d953040..97fbf7b54422 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -704,11 +704,7 @@ void slice_init_new_context_exec(struct mm_struct *mm)
>  	 * case of fork it is just inherited from the mm being
>  	 * duplicated.
>  	 */
> -#ifdef CONFIG_PPC64
> -	mm_ctx_set_slb_addr_limit(&mm->context, DEFAULT_MAP_WINDOW_USER64);
> -#else
> -	mm->context.slb_addr_limit = DEFAULT_MAP_WINDOW;
> -#endif
> +	mm_ctx_set_slb_addr_limit(&mm->context, SLB_ADDR_LIMIT_DEFAULT);
>  	mm_ctx_set_user_psize(&mm->context, psize);
>  
>  	/*
> diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
> index 088e0a6b5ade..ba4bff11191f 100644
> --- a/arch/powerpc/mm/tlb_nohash.c
> +++ b/arch/powerpc/mm/tlb_nohash.c
> @@ -802,9 +802,7 @@ void __init early_init_mmu(void)
>  #endif
>  
>  #ifdef CONFIG_PPC_MM_SLICES
> -#if defined(CONFIG_PPC_8xx)
> -	init_mm.context.slb_addr_limit = DEFAULT_MAP_WINDOW;
> -#endif
> +	mm_ctx_set_slb_addr_limit(&init_mm.context, SLB_ADDR_LIMIT_DEFAULT);
>  #endif
>  }
>  #endif /* CONFIG_PPC64 */
> -- 
> 2.13.3

