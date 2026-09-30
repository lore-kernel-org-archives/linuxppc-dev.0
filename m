Return-Path: <linuxppc-dev+bounces-28613-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7493CA5FC4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 18:50:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hw3yS23Jzz2y24;
	Thu, 01 Oct 2026 04:50:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790794224;
	cv=none; b=YxBRy/BAmF0Qz2tLDDHIqexHrbO1RvGNbY+KXgmoZ7Byx6wifAnAOCQkpuUqVX1GXixqTRDpYhUGA0T4KB9z3H6+sISaNKoDNSlUjFEKF2rPzbgCPtx7ECQdAMO+NxRCGsdQymos6g2ls9bBim/Jd0O++/HwGSqaukX5cXw61gkvz+O22snFlFlqzsejcrHGqW2GTBbVfxhGHVz/NdzclNg+Qqa6SKzWg7Jsa7ItGHvuCBXRPWmIShPU+4DQp3LsViThWul7k79yW5JkrVSI3dPxPVTp3kvQtMRJdJXkTzOGCTnMnPabrH9uHDJSE7sWJiCuAl8d/7prtL+2Rd6NGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790794224; c=relaxed/relaxed;
	bh=1dTXx9PKzcsDo3+a4VtyoELYcYl7kYefOolQcuaR2Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggjhPdFqZ0iT34qJL++RJQwB10adg/kaL78Danygk5WFFXw6jBnpSwUN0BTXKGhMU6GkWB+WIOdGFdlp5Dv8dC6DgGTuQNIeQltpgKgat65fdyv4B5pDK3xhDFc3ChPGrwBgeB++NqGu2PEwFZSPAgBWVpECn5biV4oJkBXoN8T0fGcuIftugvo5QCUW6Y2ujQVPuLMqo0OU5EEE/6z+ewaUM8LmTBYqCtSXmyljOeUbvcFqGbCIuQSKPKIXKKhN7/RA68GEumx37zfq9IyXqZpYoykprfaPtnoTzQr557iNx1Tadle1LVazYjJS9bq0jaPWrspqO9XoTLR3Q5qDNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XudNXRu5; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XudNXRu5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hw3yR1H8Wz2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 04:50:22 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UI5U8H1841064;
	Wed, 30 Sep 2026 18:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=1dTXx9PKzcsDo3+a4VtyoELYcYl7kY
	efOolQcuaR2Yw=; b=XudNXRu5uLn79hoZ9GiGYq5cvhvkkkgwWKwPVSCf+TVkuS
	uwACWaem+QnN8XeozUmoVnmBAjTB/HIHZVLHSjgvevEKPuNvcQ85EaTgvvoxDxZ+
	1tZLI66eC69DwyTZ94R7Zn7T2/Qs/sLpFISNy7CZWbkVUFcjrzMXErzFnS2cN0EC
	MeuI8Zf5QMjulZBOguqOdVzraEakpw0/5W5vK9fcoI6kEs/uvj/82+MPxVHTZgbK
	aWukuLFGnS106+uzSrslAQtgZ1tvaG3CBNfiGQu1zLQ7xsQS7y2fiDeTqk7ZVRL6
	5aPEiqz/vLEnNzLAefbeGaf24S5E4fsgKW3bPrUg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qrevyu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 18:50:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UHliNV3874936;
	Wed, 30 Sep 2026 18:50:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0j23n45q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 18:50:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UIo9Kh33161538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 18:50:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E2ED20049;
	Wed, 30 Sep 2026 18:50:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EA2920040;
	Wed, 30 Sep 2026 18:50:07 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 30 Sep 2026 18:50:06 +0000 (GMT)
Date: Thu, 1 Oct 2026 00:20:17 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Jyoti Gupta <jyoti@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, sourabhjain@linux.ibm.com,
        amachhiw@linux.ibm.com, mkchauras@gmail.com
Subject: Re: [PATCH v2] powerpc/mpic: Fix memory leak of mpic on error paths
Message-ID: <20261001001512.d05b4c2a-13-amachhiw@linux.ibm.com>
Mail-Followup-To: Jyoti Gupta <jyoti@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, 
	sourabhjain@linux.ibm.com, mkchauras@gmail.com
References: <20260930180919.335930-1-jyoti@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930180919.335930-1-jyoti@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3NiBTYWx0ZWRfX8BUYyjC9W8QC
 /lq8BNzZiDQ51gKo0inRMBql/bnu1FWAWUhUcOijy0wuFUBamCSQfBvwDWLjLgaOhOGxvppPykL
 zsOwvTy+UlATZ/Cd10sVUXUQS3OpTS0oyieaACPopWX5wZNIsUizFLKWpcjn4AuoxwMPBPRJg3q
 ZcL+qfNppR03VoZ1XuViM1DsgMESHKP1xcAgr3hljFBVX0paSvWkgmUUFoZBsMRBi2FsdD9otqy
 JPmXOeXsKH/ylWBY9KsAa7ee5LBUOmeRqth2M7k4ju3/RoofkfDNTYJFo2lTJc5SUjr5HSZzZBu
 wNtVGZ0FxSpqZPq4VlOQlxBMTzDooFHa8p4HvTu5JsSs0Zz4020Yg1JRcK8aPkx3qnGoyPRrZsr
 biEg38bnBrUgEA7kKvDW+LyrHer1ecBEBEXez/in03Wi90DrO6TQ3ZZ2IXYQyYe3rl3SS017AI+
 MyPe5G6H670Z563PzSA==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abd59e5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=CS3MOvVH99t8aIqqJu4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: u-pSqun8MXNJtRGBmivHS1ct8lQU_ntb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3NiBTYWx0ZWRfXyuqaN5xZUgqw
 ghWzfxbZZRxl4rXF4cLCUpK5aUFCNttSzTNMFIvToreJ8sFBCKCMzYs0bjm4yYimg4gNM5U55bU
 gRsxwKcdpdPBKHmC+Tj2g8ZUhBl8T3Y=
X-Proofpoint-GUID: zU34nzlbqTLC8hRb3jdn6vd_4M1lVFdH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300076

On 2026/09/30 11:39 PM, Jyoti Gupta wrote:
> mpic_alloc() allocates struct mpic (and optionally the protected
> sources bitmap) but does not free them when mpic_setup_error_int() or
> irq_domain_create_linear() fails, leaking the memory.
> 
> Free the bitmap and the mpic in the common error path before dropping the
> device node reference.
> 
> Fixes: 996983b75ceb ("powerpc/mpic: Search for open-pic device-tree node if NULL")
> Signed-off-by: Jyoti Gupta <jyoti@linux.ibm.com>
> ---
>  arch/powerpc/sysdev/mpic.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Thanks for addressing the comments from v1.

A couple of minor suggestions:

1. Changelog & Links: It is always a good practice to include a changelog below
   the "---" line detailing the changes made in this version (e.g. "v1 -> v2:
   ...") along with a link to the previous version(s) on lore.kernel.org. This
   helps reviewers and maintainers quickly track the evolution of the patch.

2. Minor nit in cleanup logic below:

> 
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 257886ec3f70..b21a880777cc 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1389,7 +1389,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>  		if (fsl_version >= 0x401) {
>  			ret = mpic_setup_error_int(mpic, intvec_top - 13);
>  			if (ret)
> -				return NULL;
> +				goto err_of_node_put;
>  		}
>  
>  	}
> @@ -1488,12 +1488,8 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>  						 intvec_top,
>  						 &mpic_host_ops, mpic);
>  
> -	/*
> -	 * FIXME: The code leaks the MPIC object and mappings here; this
> -	 * is very unlikely to fail but it ought to be fixed anyways.
> -	 */
>  	if (mpic->irqhost == NULL)
> -		return NULL;
> +		goto err_of_node_put;
>  
>  	/* Display version */
>  	switch (greg_feature & MPIC_GREG_FEATURE_VERSION_MASK) {
> @@ -1527,6 +1523,9 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>  	return mpic;
>  
>  err_of_node_put:
> +	if (mpic)
> +		bitmap_free(mpic->protected);
> +	kfree(mpic);

Both bitmap_free() and kfree() safely handle NULL pointers (and mpic is
guaranteed to be non-NULL at this label anyway), so the 'if (mpic)' check is
redundant.

Other than that, the patch looks good to me.  So, with this fixed, please feel
free to add:

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

