Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22D7C282C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 09:06:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 005F920861
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 09:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005F920861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kzsm599rzDqLS
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 20:06:04 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kzqv2FHmzDqGC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 20:04:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43kzqv1Mtvz8t7p
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 20:04:27 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43kzqv0zf0z9s9G; Wed, 23 Jan 2019 20:04:27 +1100 (AEDT)
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
 by ozlabs.org (Postfix) with ESMTPS id 43kzqt59Tdz9s4s
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2019 20:04:26 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0N8wqAQ144084
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2019 04:04:25 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q6kfc5ap4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2019 04:04:25 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 23 Jan 2019 09:04:22 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 23 Jan 2019 09:04:21 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0N94K9050462972
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Jan 2019 09:04:20 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6DE7CA4068;
 Wed, 23 Jan 2019 09:04:20 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A2E9A4062;
 Wed, 23 Jan 2019 09:04:19 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.69.250])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 23 Jan 2019 09:04:19 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/4] powerpc/64s: Move SLB init into hash_utils_64.c
In-Reply-To: <20190117121328.13395-3-mpe@ellerman.id.au>
References: <20190117121328.13395-1-mpe@ellerman.id.au>
 <20190117121328.13395-3-mpe@ellerman.id.au>
Date: Wed, 23 Jan 2019 14:34:17 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19012309-0020-0000-0000-0000030A387D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012309-0021-0000-0000-0000215B7148
Message-Id: <87y37bbv8u.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-23_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901230070
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> writes:

> The SLB initialisation code is spread around a bit between prom.c and
> hash_utils_64.c. Consolidate it all in hash_utils_64.c.
>
> This slightly changes the timing of when mmu_slb_size is initialised,
> but that should have no effect.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/prom.c      | 16 ----------------
>  arch/powerpc/mm/hash_utils_64.c | 15 ++++++++++-----
>  2 files changed, 10 insertions(+), 21 deletions(-)
>
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 14693f8ccb80..018ededd1948 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -229,21 +229,6 @@ static void __init check_cpu_pa_features(unsigned long node)
>  		      ibm_pa_features, ARRAY_SIZE(ibm_pa_features));
>  }
>  
> -#ifdef CONFIG_PPC_BOOK3S_64
> -static void __init init_mmu_slb_size(unsigned long node)
> -{
> -	const __be32 *slb_size_ptr;
> -
> -	slb_size_ptr = of_get_flat_dt_prop(node, "slb-size", NULL) ? :
> -			of_get_flat_dt_prop(node, "ibm,slb-size", NULL);
> -
> -	if (slb_size_ptr)
> -		slb_set_size(be32_to_cpup(slb_size_ptr));
> -}
> -#else
> -#define init_mmu_slb_size(node) do { } while(0)
> -#endif
> -
>  static struct feature_property {
>  	const char *name;
>  	u32 min_value;
> @@ -379,7 +364,6 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
>  	}
>  
>  	identical_pvr_fixup(node);
> -	init_mmu_slb_size(node);
>  
>  #ifdef CONFIG_PPC64
>  	if (nthreads == 1)
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 4aa0797000f7..33ce76be17de 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -344,9 +344,8 @@ static int __init parse_disable_1tb_segments(char *p)
>  }
>  early_param("disable_1tb_segments", parse_disable_1tb_segments);
>  
> -static int __init htab_dt_scan_seg_sizes(unsigned long node,
> -					 const char *uname, int depth,
> -					 void *data)
> +static int __init htab_dt_scan_slb(unsigned long node, const char *uname,
> +				   int depth, void *data)
>  {
>  	const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
>  	const __be32 *prop;
> @@ -356,6 +355,12 @@ static int __init htab_dt_scan_seg_sizes(unsigned long node,
>  	if (type == NULL || strcmp(type, "cpu") != 0)
>  		return 0;
>  
> +	prop = of_get_flat_dt_prop(node, "slb-size", NULL);
> +	if (!prop)
> +		prop = of_get_flat_dt_prop(node, "ibm,slb-size", NULL);
> +	if (prop)
> +		slb_set_size(be32_to_cpup(prop));
> +
>  	prop = of_get_flat_dt_prop(node, "ibm,processor-segment-sizes", &size);
>  	if (prop == NULL)
>  		return 0;
> @@ -954,8 +959,8 @@ static void __init htab_initialize(void)
>  
>  void __init hash__early_init_devtree(void)
>  {
> -	/* Initialize segment sizes */
> -	of_scan_flat_dt(htab_dt_scan_seg_sizes, NULL);
> +	/* Initialize SLB size and segment sizes */
> +	of_scan_flat_dt(htab_dt_scan_slb, NULL);
>  
>  	/* Initialize page sizes */
>  	htab_scan_page_sizes();
> -- 
> 2.20.1

