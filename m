Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPrtV213fzDxLQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 00:49:22 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rPrtT2YmNz9t0t
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Jun 2016 00:49:21 +1000 (AEST)
Received: from pps.filterd (m0075420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u58EmgNQ025789
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jun 2016 10:49:19 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23e9mftjuu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 08 Jun 2016 10:49:19 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 08:49:17 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/nohash: Fix build break with 4K pages
In-Reply-To: <1465392071-18715-1-git-send-email-mpe@ellerman.id.au>
References: <1465392071-18715-1-git-send-email-mpe@ellerman.id.au>
Date: Wed, 08 Jun 2016 20:19:12 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87wplz20t3.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Commit 74701d5947a6 "powerpc/mm: Rename function to indicate we are
> allocating fragments" renamed page_table_free() to pte_fragment_free().
> One occurrence was mistyped as pte_fragment_fre().
>
> This only breaks the nohash 4K page build, which is not the default or
> enabled in any defconfig.

Can you share the .config. I will add it to the build test.

>
> Fixes: 74701d5947a6 ("powerpc/mm: Rename function to indicate we are allocating fragments")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>


Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>  arch/powerpc/include/asm/nohash/64/pgalloc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
> index 0c12a3bfe2ab..069369f6414b 100644
> --- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
> +++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
> @@ -172,7 +172,7 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
>
>  static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>  {
> -	pte_fragment_fre((unsigned long *)pte, 1);
> +	pte_fragment_free((unsigned long *)pte, 1);
>  }
>
>  static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
> -- 
> 2.5.0
