Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skMTq2GGhzDrWh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 12:43:59 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3skMTp6BlTz9rxv
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Sep 2016 12:43:58 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8S2h2kt015608
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Sep 2016 22:43:56 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25qxu26m5c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Sep 2016 22:43:56 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 27 Sep 2016 20:43:56 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Chris Smart <chris@distroguy.com>
Subject: Re: [PATCH] Fix "ibm,processor-radix-AP-encodings"
In-Reply-To: <0612c46e-7e1b-3729-d84f-cefa886abb6d@gmail.com>
References: <0612c46e-7e1b-3729-d84f-cefa886abb6d@gmail.com>
Date: Wed, 28 Sep 2016 08:13:48 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <877f9wbv6j.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> The top 3 bits of the lower order byte should contain the
> AP encoding, we assume the top 3 bits of the MSB.


Are you sure, Power architecture documents always confuse about MSB vs
lowe order bytes. ?

>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>
>  - Detected while reviewing Chris Smart's patch to add radix-AP-encoding
>    to skiboot
>  - Also fixed typo (sift/shift)
>
>  arch/powerpc/mm/pgtable-radix.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index af897d9..d525b0b 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -245,10 +245,10 @@ static int __init radix_dt_scan_page_sizes(unsigned long node,
>
>  		struct mmu_psize_def *def;
>
> -		/* top 3 bit is AP encoding */
> -		shift = be32_to_cpu(prop[0]) & ~(0xe << 28);
> -		ap = be32_to_cpu(prop[0]) >> 29;
> -		pr_info("Page size sift = %d AP=0x%x\n", shift, ap);
> +		/* top 3 bits of the lower order byte is AP encoding */
> +		shift = be32_to_cpu(prop[0]) & 0x1f;
> +		ap = (be32_to_cpu(prop[0]) >> 5) & 0x7;
> +		pr_info("Page size shift = %d AP=0x%x\n", shift, ap);
>
>  		idx = get_idx_from_shift(shift);
>  		if (idx < 0)

-aneesh
