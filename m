Return-Path: <linuxppc-dev+bounces-25293-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7383DC55182
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 19:17:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDRJJ4c6lz2y8F;
	Tue, 04 Aug 2026 05:17:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785784640;
	cv=none; b=Wn+utkciW8Qi8zAzvY8wDu6SHpC6lTlKEnX0bot4Yw9IKncfkkXnLkxgKDp2rmASs/M5ZPZYmK8RMSX/wC1nnyga47VJZa3rBZpB5qMgPC/fcCvDjO6p6Q2niydgFpXFcxGFGdRilrAEFAP2OCRq9fBvmet9eEmkEpHS9zQOUBIkWgB1uVxpgP1JToy5Ck0SUF0o50J7q8F1qdo76HIdELEphSzjr64VMFVmRfl7mGxu3ecPPMcR8jnRND3znk3d+f1x/InXBeO0L0zqY0E2Fkkoonj7mCFP7Q0VVGE0dt25wsEHXaCb0wezVhIvUXg3EatodF4T4FcAQf97suSQEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785784640; c=relaxed/relaxed;
	bh=L5ijzF0bnn6gxGXdqr3nhKVYdG4vyul/mymF7ZUHsnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4L7RaholU6gJjmbV/gIwyMlqFke7mV6Br//lh/cj354oaPDG0q5hjEKrD9oCoHAZVHn3MRX2i42So77fH78/NBIBAyo7Vq8QIr5mbczylKExb8mjEa/V0OIK/pvnWGk3aqBXhfxMegRZ1wbd+DtaMk4Uo1kJ4S4zv+6Wu3Tli4+6dsHvoYrmk6EMb9Sp+4PNonBNCZcLnBOOgY18UgPxq6iXvmRen8xUnSQGiPfOQ6dbO38w6722sYgfcjn9rti3VUTS8lJofo5sTEpyLOxyaNv1rxUay1M9wB5n5xRbDRDDn4UFB2ybn78Mm/8uD1UYQQWN/CYbciOHO1AvIiuBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kViTNIU9; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kViTNIU9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDRJH3jBtz2y7Y
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 05:17:18 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673HI2Zo2607667
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 19:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=L5ijzF0bnn6gxGXdqr3nhKVYdG4vyu
	l/mymF7ZUHsnE=; b=kViTNIU9jT8uURhrm2cH6+Wsw/I63EeKReZl51Qi3hfWwG
	KnjgKqtPK80s0lZa0hnYxFltmp1klZl5I4jme8c5o6IAollL/P0ihs5H057JVmD9
	+FiggQ/X7JMS1pEZXzijaJvD+rRL6RJNiD+w8HvjNpUgv40gSomiTuRFUpTrSApd
	c6pvc/2ca9NAj1Hs7tRK5dvhMjsC1uZackG+Ovl2ARvR9U6tsQ5It2Q82exuVR6z
	HrbgHzs41PvpirFJI8NXgXdlDSqMiZTTgcTJI9YYXrn8cgKYAhzd8snqLyCc0sE4
	JqWVU12L8fOGJ98jSxofba1udM4ivYf0DjJlgmZA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g28rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 19:17:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673JBKOU030437;
	Mon, 3 Aug 2026 19:17:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg6mha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 19:17:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673JHA2H29819186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 19:17:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AFDE2004B;
	Mon,  3 Aug 2026 19:17:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3D2220043;
	Mon,  3 Aug 2026 19:17:08 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  3 Aug 2026 19:17:08 +0000 (GMT)
Date: Tue, 4 Aug 2026 00:47:49 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Praveen K Pandey <praveen@linux.ibm.com>,
        Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Subject: Re: [PATCH v2 3/4] powerpc: Add Power12 architected mode
Message-ID: <20260804004514.39870804-35-amachhiw@linux.ibm.com>
Mail-Followup-To: Mahesh Salgaonkar <mahesh@linux.ibm.com>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Praveen K Pandey <praveen@linux.ibm.com>, Nikhil Kumar Singh <nikhilks@linux.ibm.com>
References: <20260803155724.3272052-1-mahesh@linux.ibm.com>
 <20260803155724.3272052-4-mahesh@linux.ibm.com>
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
In-Reply-To: <20260803155724.3272052-4-mahesh@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE2NiBTYWx0ZWRfX7NSm8F6JTBWc
 SK9dqD3MPbYvm5CVrTLJks00JwZ7tCZ+82aKBCO98NJMQLsqdgS4YRJJYS91vHmGAmY3/+8dX0R
 HVq9JVQA5s86Pfc4ndAgRxocGYmlySVQLIkAhv2s1vVsUzLJuq1Lz4YH+WjQmS4pm2KdoIoiNTW
 FI1VzC4vnbGN1dHNLJBaWQvUhrRmAW5Xi8cXfjzExUtAllXmC1VESPIkAm2TYyrogQDOfXvBfUk
 AT1J81wfPP4mGv9TYOtxco1W5H1az8w6QA9lyHRl+SJOwOVwhAbrMZkzMz1CfPO5J35TCus/opM
 0O4PtwRRpPx8Fr9WXcBkyVyWmgtSk3ZfNTx0lSEm+GNlyvZcUnh8DR5ld385KYG1QSacFxAT8Yl
 78dsCzdtrE7Aa/ZdWZ/IQS9BWOvXDU89FdQqDR+WD4qLti/M9s67NBUeCsCI6cM4rnGiHscv5Mo
 a+h+1EaEuM3lcmilrwQ==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a70e93b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=U2DHCgGNv_utI2aiw7QA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: o9taV3Hv4TKZ_yeBWaSu42zCqg6NYuls
X-Proofpoint-ORIG-GUID: oFGZnsoYiaeGk4P2Oou5p99JfOZDcY5M
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE2NiBTYWx0ZWRfX425ZEJgHMOzA
 JIIw7TEFloBzvMFR0b+o0MI1wHgfBcxpgV1YLp7K81EB8QYwOdO6Rp15OWFviuTwQDY35g/l6Za
 E/rNc4gqOk01OPoE4CpwKeGgUs/mnpk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_04,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030166

On 2026/08/03 09:27 PM, Mahesh Salgaonkar wrote:
> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> 
> PVR value of 0x0f000008 means we are arch v3.2 compliant (i.e.
> Power12). This is used by phyp and kvm when booting as a pseries guest
> to detect the presence of new Power12 features and to enable the
> appropriate hwcap and facility bits.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Tested-by: Praveen K Pandey <praveen@linux.ibm.com>
> Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/prom.h           |  1 +
>  arch/powerpc/include/uapi/asm/cputable.h  |  1 +
>  arch/powerpc/kernel/cpu_specs_book3s_64.h | 14 ++++++++++++++
>  arch/powerpc/kernel/prom_init.c           | 12 ++++++++++--
>  4 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
> index f4991d10d89ec..cd025c7225ee7 100644
> --- a/arch/powerpc/include/asm/prom.h
> +++ b/arch/powerpc/include/asm/prom.h
> @@ -118,6 +118,7 @@ extern unsigned int boot_cpu_node_count;
>  
>  #define OV1_PPC_3_00		0x80	/* set if we support PowerPC 3.00 */
>  #define OV1_PPC_3_1			0x40	/* set if we support PowerPC 3.1 */
> +#define OV1_PPC_3_2			0x20	/* set if we support PowerPC 3.2 */

Minor: OV1_PPC_3_1 and OV1_PPC_3_2 use extra tabs relative to OV1_PPC_3_00.
This is pre-existing style inconsistency in the file (not introduced by
this patch) but new additions should match the surrounding code. Please
consider aligning them.

Thanks,
Amit

>  
>  /* Option vector 2: Open Firmware options supported */
>  #define OV2_REAL_MODE		0x20	/* set if we want OF in real mode */
> diff --git a/arch/powerpc/include/uapi/asm/cputable.h b/arch/powerpc/include/uapi/asm/cputable.h
> index bc9bd225f5876..68215b7ce67e6 100644
> --- a/arch/powerpc/include/uapi/asm/cputable.h
> +++ b/arch/powerpc/include/uapi/asm/cputable.h
> @@ -53,6 +53,7 @@
>  #define PPC_FEATURE2_ARCH_3_1		0x00040000 /* ISA 3.1 */
>  #define PPC_FEATURE2_MMA		0x00020000 /* Matrix Multiply Assist */
>  #define PPC_FEATURE2_ARCH_3_2		0x00010000 /* ISA 3.2 */
> +#define PPC_FEATURE2_DMF		0x00008000 /* Dense Math Facility */
>  
>  /*
>   * IMPORTANT!
> diff --git a/arch/powerpc/kernel/cpu_specs_book3s_64.h b/arch/powerpc/kernel/cpu_specs_book3s_64.h
> index 7619dd157646f..26fa40aa34db2 100644
> --- a/arch/powerpc/kernel/cpu_specs_book3s_64.h
> +++ b/arch/powerpc/kernel/cpu_specs_book3s_64.h
> @@ -303,6 +303,20 @@ static struct cpu_spec cpu_specs[] __initdata = {
>  		.cpu_restore		= __restore_cpu_power10,
>  		.platform		= "power11",
>  	},
> +	{	/* 3.2-compliant processor, i.e. Power12 "architected" mode */
> +		.pvr_mask		= 0xffffffff,
> +		.pvr_value		= 0x0f000008,
> +		.cpu_name		= "Power12 (architected)",
> +		.cpu_features		= CPU_FTRS_POWER12,
> +		.cpu_user_features	= COMMON_USER_POWER12,
> +		.cpu_user_features2	= COMMON_USER2_POWER12,
> +		.mmu_features		= MMU_FTRS_POWER12,
> +		.icache_bsize		= 128,
> +		.dcache_bsize		= 128,
> +		.cpu_setup		= __setup_cpu_power12,
> +		.cpu_restore		= __restore_cpu_power12,
> +		.platform		= "power12",
> +	},
>  	{	/* Power7 */
>  		.pvr_mask		= 0xffff0000,
>  		.pvr_value		= 0x003f0000,
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index 6b50870759fd9..7ebfe048f97a2 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -953,7 +953,7 @@ struct option_vector7 {
>  } __packed;
>  
>  struct ibm_arch_vec {
> -	struct { __be32 mask, val; } pvrs[16];
> +	struct { __be32 mask, val; } pvrs[18];
>  
>  	u8 num_vectors;
>  
> @@ -1021,6 +1021,14 @@ static const struct ibm_arch_vec ibm_architecture_vec_template __initconst = {
>  			.mask = cpu_to_be32(0xffff0000), /* POWER11 */
>  			.val  = cpu_to_be32(0x00820000),
>  		},
> +		{
> +			.mask = cpu_to_be32(0xffff0000), /* POWER12 */
> +			.val  = cpu_to_be32(0x00830000),
> +		},
> +		{
> +			.mask = cpu_to_be32(0xffffffff), /* all 3.2-compliant */
> +			.val  = cpu_to_be32(0x0f000008),
> +		},
>  		{
>  			.mask = cpu_to_be32(0xffffffff), /* P11 compliant */
>  			.val  = cpu_to_be32(0x0f000007),
> @@ -1054,7 +1062,7 @@ static const struct ibm_arch_vec ibm_architecture_vec_template __initconst = {
>  		.byte1 = 0,
>  		.arch_versions = OV1_PPC_2_00 | OV1_PPC_2_01 | OV1_PPC_2_02 | OV1_PPC_2_03 |
>  				 OV1_PPC_2_04 | OV1_PPC_2_05 | OV1_PPC_2_06 | OV1_PPC_2_07,
> -		.arch_versions3 = OV1_PPC_3_00 | OV1_PPC_3_1,
> +		.arch_versions3 = OV1_PPC_3_00 | OV1_PPC_3_1 | OV1_PPC_3_2,
>  	},
>  
>  	.vec2_len = VECTOR_LENGTH(sizeof(struct option_vector2)),
> -- 
> 2.55.0
> 
> 

