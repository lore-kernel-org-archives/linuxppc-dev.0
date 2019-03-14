Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D80C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 13:23:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D478B204FD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 13:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D478B204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KqCw3pP5zDqP6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 00:23:40 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Kq9133K0zDqGY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 00:21:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44Kq8z5KYfz8sxp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 00:21:07 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44Kq8z4CNwz9s70; Fri, 15 Mar 2019 00:21:07 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44Kq8y6v3bz9s5c
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Mar 2019 00:21:06 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2EDAHGE145904
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Mar 2019 09:21:05 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2r7pc8n0bs-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Mar 2019 09:21:04 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Thu, 14 Mar 2019 13:21:02 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 14 Mar 2019 13:20:59 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2EDKwlQ33423492
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Mar 2019 13:20:58 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29E0AA405C;
 Thu, 14 Mar 2019 13:20:58 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 93D8FA4054;
 Thu, 14 Mar 2019 13:20:56 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.102.2.45])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 14 Mar 2019 13:20:56 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/mm/64: Document the sizes of/sizes mapped by
 Pxx_INDEX_SIZE
In-Reply-To: <20190314125453.4956-1-mpe@ellerman.id.au>
References: <20190314125453.4956-1-mpe@ellerman.id.au>
Date: Thu, 14 Mar 2019 18:50:55 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19031413-0020-0000-0000-000003234795
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031413-0021-0000-0000-000021754BFE
Message-Id: <87sgvppp6w.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-14_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903140092
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
Cc: aneesh.kumar@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Add comments describing the size in bytes of the various levels of the
> page table tree, and the size of the virtual address space mapped by
> each level, to make it clear what the sizes are without having to also
> look up other definitions.
>
> The code that calculates the sizes actually uses sizeof(pgd_t) etc.,
> so in theory these comments could skew vs the code, but the size of
> pgd_t etc. is unlikely to change very often.
>

This makes it soo much easier to follow the page table mapping w.r.t hugepages.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/book3s/64/hash-4k.h   | 8 ++++----
>  arch/powerpc/include/asm/book3s/64/hash-64k.h  | 9 +++++----
>  arch/powerpc/include/asm/book3s/64/radix-4k.h  | 9 +++++----
>  arch/powerpc/include/asm/book3s/64/radix-64k.h | 8 ++++----
>  4 files changed, 18 insertions(+), 16 deletions(-)
>
> Someone *please* check my math :)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> index cf5ba5254299..54fab723a8c7 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> @@ -2,10 +2,10 @@
>  #ifndef _ASM_POWERPC_BOOK3S_64_HASH_4K_H
>  #define _ASM_POWERPC_BOOK3S_64_HASH_4K_H
>
> -#define H_PTE_INDEX_SIZE  9
> -#define H_PMD_INDEX_SIZE  7
> -#define H_PUD_INDEX_SIZE  9
> -#define H_PGD_INDEX_SIZE  9
> +#define H_PTE_INDEX_SIZE  9  // size: 8B << 9 = 4KB, maps: 2^9 x   4KB =   2MB
> +#define H_PMD_INDEX_SIZE  7  // size: 8B << 7 = 1KB, maps: 2^7 x   2MB = 256MB
> +#define H_PUD_INDEX_SIZE  9  // size: 8B << 9 = 4KB, maps: 2^9 x 256MB = 128GB
> +#define H_PGD_INDEX_SIZE  9  // size: 8B << 9 = 4KB, maps: 2^9 x 128GB =  64TB
>
>  /*
>   * Each context is 512TB. But on 4k we restrict our max TASK size to 64TB
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index f82ee8a3b561..81f4eb6e7da4 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -2,10 +2,11 @@
>  #ifndef _ASM_POWERPC_BOOK3S_64_HASH_64K_H
>  #define _ASM_POWERPC_BOOK3S_64_HASH_64K_H
>
> -#define H_PTE_INDEX_SIZE  8
> -#define H_PMD_INDEX_SIZE  10
> -#define H_PUD_INDEX_SIZE  10
> -#define H_PGD_INDEX_SIZE  8
> +#define H_PTE_INDEX_SIZE   8  // size: 8B <<  8 = 2KB, maps 2^8  x 64KB = 16MB
> +#define H_PMD_INDEX_SIZE  10  // size: 8B << 10 = 8KB, maps 2^10 x 16MB = 16GB
> +#define H_PUD_INDEX_SIZE  10  // size: 8B << 10 = 8KB, maps 2^10 x 16GB = 16TB
> +#define H_PGD_INDEX_SIZE   8  // size: 8B <<  8 = 2KB, maps 2^8  x 16TB =  4PB
> +
>
>  /*
>   * Each context is 512TB size. SLB miss for first context/default context
> diff --git a/arch/powerpc/include/asm/book3s/64/radix-4k.h b/arch/powerpc/include/asm/book3s/64/radix-4k.h
> index 863c3e8286fb..d5f5ab73dc7f 100644
> --- a/arch/powerpc/include/asm/book3s/64/radix-4k.h
> +++ b/arch/powerpc/include/asm/book3s/64/radix-4k.h
> @@ -5,10 +5,11 @@
>  /*
>   * For 4K page size supported index is 13/9/9/9
>   */
> -#define RADIX_PTE_INDEX_SIZE  9  /* 2MB huge page */
> -#define RADIX_PMD_INDEX_SIZE  9  /* 1G huge page */
> -#define RADIX_PUD_INDEX_SIZE	 9
> -#define RADIX_PGD_INDEX_SIZE  13
> +#define RADIX_PTE_INDEX_SIZE   9  // size: 8B <<  9 =  4KB, maps 2^9  x    4K =   2MB
> +#define RADIX_PMD_INDEX_SIZE   9  // size: 8B <<  9 =  4KB, maps 2^9  x   2MB =   1GB
> +#define RADIX_PUD_INDEX_SIZE   9  // size: 8B <<  9 =  4KB, maps 2^9  x   1GB = 512GB
> +#define RADIX_PGD_INDEX_SIZE  13  // size: 8B << 13 = 64KB, maps 2^13 x 512GB =   4PB
> +
>  /*
>   * One fragment per per page
>   */
> diff --git a/arch/powerpc/include/asm/book3s/64/radix-64k.h b/arch/powerpc/include/asm/book3s/64/radix-64k.h
> index ccb78ca9d0c5..54e33828b0fb 100644
> --- a/arch/powerpc/include/asm/book3s/64/radix-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/radix-64k.h
> @@ -5,10 +5,10 @@
>  /*
>   * For 64K page size supported index is 13/9/9/5
>   */
> -#define RADIX_PTE_INDEX_SIZE  5  /* 2MB huge page */
> -#define RADIX_PMD_INDEX_SIZE  9  /* 1G huge page */
> -#define RADIX_PUD_INDEX_SIZE	 9
> -#define RADIX_PGD_INDEX_SIZE  13
> +#define RADIX_PTE_INDEX_SIZE   5  // size: 8B <<  5 = 256B, maps 2^5  x   64K =   2MB
> +#define RADIX_PMD_INDEX_SIZE   9  // size: 8B <<  9 =  4KB, maps 2^9  x   2MB =   1GB
> +#define RADIX_PUD_INDEX_SIZE   9  // size: 8B <<  9 =  4KB, maps 2^9  x   1GB = 512GB
> +#define RADIX_PGD_INDEX_SIZE  13  // size: 8B << 13 = 64KB, maps 2^13 x 512GB =   4PB
>
>  /*
>   * We use a 256 byte PTE page fragment in radix
> -- 
> 2.20.1

