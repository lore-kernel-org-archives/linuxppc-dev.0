Return-Path: <linuxppc-dev+bounces-25291-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0E8C55196
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 18:31:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDQHZ6fnxz2xyk;
	Tue, 04 Aug 2026 04:31:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785781898;
	cv=none; b=KkCpkvm971Kb+fkVot5tzw+fXTzVQ5ynEYMpmo/avmkk35JFl1XhMTlWSm8YQCDlC6E5/kNvr11RsHyldIu0IndLGHQVahqUbx41oigT721HoAJjD2eallLlhHXIzX1KD2VATweGlK9b0C9cjnXDhRjAG9Lr85n7kbLNXqb0qNkYkCBfin4oqVOr0LT6EpVP2Dl9Ac4zJC8JvDWTAH0rdcuxoXQx/GLs7/LaUsuT1PCDllHR+fuAoRE3bCCI2duuZRYmQ2jVwSGrY91bw0Vvcpo0J2aV2dDtA+jpTHIMk2zzaacnZwhBGEXuOLZC1ST+pmPWPPrHVITD7ap7B0baFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785781898; c=relaxed/relaxed;
	bh=euxk42caELwjajYsfrq5eLtpKlA6kyrSpG88ndewEqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADa3RZFsKeT/cEDIW7E0EKCovM9BPDL9TKQ1VMc7CIQ5MK2bKHQiKLcq4UUrgNPJ7A1tCi5r1Rf5yiSGU8Gb0G1r3KDFeKx8FnW6cpV9lOvzU4yQ6th5J/boqzuXZcFY4YUKUF5E8PR1XcEtaIMM+yAMewmUEsOFVIv51G7HVM2PwEox27urMBcebcAjpW0xpQabIHvsbdSvLGsTuMk0Rtpvktir5SnHUCTEQxv+wcKKW+3hy29bYYg/ZAwSmSTQor5rljTc1irqp2mLn/pRih6BWJprr7KnGtCGYkfIS+8yhvXPWt/cI5Ws3nrSOptt+AKywv6OHf4TaM1UXhft2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LCh3aoCD; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LCh3aoCD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDQHY4xzzz2xyj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 04:31:36 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673HHvOo815905
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 18:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=euxk42caELwjajYsfrq5eLtpKlA6ky
	rSpG88ndewEqw=; b=LCh3aoCDETc+3Z6sKIvHawqcOq0MDV+zAHfWGDgcQd5jIk
	q3nnNoO3eoQkXFLxrYyVL5GetqWTuRceBfRhKFdsGZ6QO+wFFIyBjnWEzDJmoyKw
	0d01d42PIEIruOeH4m9/B2tlbpAuu+VYxshB+HP9QSgVe+L7ozmNgoox7D96MbVk
	UAdFV7UCgHTZpWGo3/XHPUlAZEN+98d/sqMdFdcqpq0jGuiXuaqcbNa3NwOtjENu
	EmwEh3c7ft0nNJwXfQeinBIu442S/WNcWuCDpIvPkOwAeaCc74DF/cY9p1XEZdlg
	BTp09cL5AHUNmA9nyODtxQ/IZKk18FdNLpgXbMqw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqj8ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 18:31:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673IQHON014688
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 18:31:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyeeyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 18:31:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673IVTTl33620468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 18:31:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E837120043;
	Mon,  3 Aug 2026 18:31:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B647F20040;
	Mon,  3 Aug 2026 18:31:27 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  3 Aug 2026 18:31:27 +0000 (GMT)
Date: Tue, 4 Aug 2026 00:02:08 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Praveen K Pandey <praveen@linux.ibm.com>
Subject: Re: [PATCH v2 1/4] powerpc/pseries: Limit PVR list to 16 entries for
 CAS negotiation
Message-ID: <20260803235347.b630c20f-dc-amachhiw@linux.ibm.com>
Mail-Followup-To: Mahesh Salgaonkar <mahesh@linux.ibm.com>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Praveen K Pandey <praveen@linux.ibm.com>
References: <20260803155724.3272052-1-mahesh@linux.ibm.com>
 <20260803155724.3272052-2-mahesh@linux.ibm.com>
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
In-Reply-To: <20260803155724.3272052-2-mahesh@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k4NHwe0q6j6RQXjlphRl4VhYiwOUQ3U1
X-Proofpoint-ORIG-GUID: k4NHwe0q6j6RQXjlphRl4VhYiwOUQ3U1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE2MiBTYWx0ZWRfX9hHsLIMIeDXs
 R6mYWhw7Jz8dp3y3lSECK5phzMRE2zqGPIj7+oP4MD42zg9AaOvV0NDgzNtjSLcoBMtwrGz5sfD
 Z2B8/BJntooCJSggQ8cGA4y6wa+zToM=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a70de85 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=I_aHpoEhBQcPfUWqlx4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE2MiBTYWx0ZWRfX0wLohvTcJH/Y
 rDFIb/9Hro0xHXRWpNOq66Zyg5LMxd5MJyBy9Cn3YS1ZSmqPBUERS/Kq0oGAVU8EuEtrCiw/3kK
 pa28Z1XriFgyEbbjqp0DDS5n8f8F/U93sUjkW54ymgUlXh/i/Vt5Ytw8r+P+QncwY4j3xZfX8ny
 pWVpbUew+8LPe9Xa6z3SVGaMAeyqBDmF1cG6lbK3O2Y5m/pStZqxDfR+h3EshAnV61QYEBXT7dM
 A/mQEyfgsr+rpP+ju9uGM3gfSJNMCmomJPkzXz+dagefgfG6Ldtep423QOhaIzJ0H28VDUiQ+Yv
 7kDKzmf+hXrjD6cwqrudtZmpAon91HWfS0vLrZgStaWyOVqCaZqz50M+G2ymmNg5txNZZNNgQuk
 9K2TQBvV59307vRIUxOBp59t/hliiN0nX39OjQiPwVzOq3FnE73i2yJj8V3agSm1iN0CRZ+4IGK
 RHiiVYn4+44hUvzk/Rg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_04,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030162

On 2026/08/03 09:27 PM, Mahesh Salgaonkar wrote:
> Current Power system firmware caps the PVR list array size at 16 entries
> during CAS (Client Architecture Support) negotiation. Passing more than
> capped size to older firmware could cause an undefined behaviour and
> breaks compatibility.
> 
> Future Power system firmware releases will lift this restriction and
> support greater than 16 array entries.
> 
> Ensure that when running on Power11 or below hardware, the number
> of PVR entries passed during CAS negotiation does not exceed the
> firmware-imposed limit of 16.
> 
> In prom_send_capabilities(), compute start_index to skip the oldest
> leading pvrs[] entries when running on Power11 or below hardware, so
> that the pointer passed to ibm,client-architecture-support points to
> ibm_architecture_vec.pvrs[start_index], presenting exactly 16 entries to
> firmware.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Tested-by: Praveen K Pandey <praveen@linux.ibm.com>
> ---
> Change in v2:
> - Define a named macro CAS_MAX_PVR_ENTRIES
> ---
>  arch/powerpc/kernel/prom_init.c | 35 ++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index 53503937de0ee..6b50870759fd9 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -86,6 +86,12 @@
>   */
>  #define ADDR(x)		(u32)(unsigned long)(x)
>  
> +/*
> + * Current Power system firmware caps the PVR list array size at 16 entries
> + * during CAS (Client Architecture Support) negotiation.
> + */
> +#define CAS_MAX_PVR_ENTRIES	16
> +
>  #ifdef CONFIG_PPC64
>  #define OF_WORKAROUNDS	0
>  #else
> @@ -979,6 +985,10 @@ static const struct ibm_arch_vec ibm_architecture_vec_template __initconst = {
>  			.mask = cpu_to_be32(0xfffe0000), /* POWER5/POWER5+ */
>  			.val  = cpu_to_be32(0x003a0000),
>  		},
> +		{
> +			.mask = cpu_to_be32(0xffffffff), /* all 2.04-compliant and earlier */
> +			.val  = cpu_to_be32(0x0f000001),
> +		},

It may be a good idea to add a comment (like below) above .pvrs = {
explaining why the oldest entries are at the front, otherwise the intent
of start_index trimming from the front is not obvious to future
contributors:

/*
 * The oldest/least-capable entries are placed at the FRONT so that
 * start_index trims them first when running on older firmware (Power11
 * and below) that caps the array at CAS_MAX_PVR_ENTRIES entries. As
 * newer processors are added, more old front entries will naturally
 * fall outside the firmware window. New entries must be inserted in
 * newest-first order AFTER these oldest front entries.
 */

>  		{
>  			.mask = cpu_to_be32(0xffff0000), /* POWER6 */
>  			.val  = cpu_to_be32(0x003e0000),
> @@ -1032,13 +1042,9 @@ static const struct ibm_arch_vec ibm_architecture_vec_template __initconst = {
>  			.val  = cpu_to_be32(0x0f000003),
>  		},
>  		{
> -			.mask = cpu_to_be32(0xffffffff), /* all 2.05-compliant */
> +			.mask = cpu_to_be32(0xfffffffd), /* all 2.05-compliant */
>  			.val  = cpu_to_be32(0x0f000002),
>  		},
> -		{
> -			.mask = cpu_to_be32(0xfffffffe), /* all 2.04-compliant and earlier */
> -			.val  = cpu_to_be32(0x0f000001),
> -		},
>  	},
>  
>  	.num_vectors = NUM_VECTORS(6),
> @@ -1347,7 +1353,6 @@ static void __init prom_check_platform_support(void)
>  	};
>  	int prop_len = prom_getproplen(prom.chosen,
>  				       "ibm,arch-vec-5-platform-support");
> -

Nit: Looks unintentional whitespace change, please drop.

>  	/*
>  	 * First copy the architecture vec template
>  	 *
> @@ -1403,6 +1408,22 @@ static void __init prom_send_capabilities(void)
>  	ihandle root;
>  	prom_arg_t ret;
>  	u32 cores;
> +	int start_index = 0;
> +
> +	/*
> +	 * Ensure that when running on Power11 or below hardware, the number
> +	 * of PVR entries passed during CAS negotiation does not exceed the
> +	 * firmware-imposed limit of 16.
> +	 *
> +	 * Compute the start_index to skip the oldest leading pvrs[] entries
> +	 * when running on Power11 or below hardware, so that the pointer
> +	 * passed to ibm,client-architecture-support points to
> +	 * ibm_architecture_vec.pvrs[start_index], presenting exactly 16
> +	 * entries to firmware.
> +	 */
> +	if ((ARRAY_SIZE(ibm_architecture_vec_template.pvrs) > CAS_MAX_PVR_ENTRIES) &&
> +	    (PVR_VER(mfspr(SPRN_PVR)) <= PVR_POWER11))
> +		start_index = ARRAY_SIZE(ibm_architecture_vec_template.pvrs) - CAS_MAX_PVR_ENTRIES;
>  
>  	/* Check ibm,arch-vec-5-platform-support and fixup vec5 if required */
>  	prom_check_platform_support();
> @@ -1427,7 +1448,7 @@ static void __init prom_send_capabilities(void)
>  		if (call_prom_ret("call-method", 3, 2, &ret,
>  				  ADDR("ibm,client-architecture-support"),
>  				  root,
> -				  ADDR(&ibm_architecture_vec)) == 0) {
> +				  ADDR(&ibm_architecture_vec.pvrs[start_index])) == 0) {
>  			/* the call exists... */
>  			if (ret)
>  				prom_printf("\nWARNING: ibm,client-architecture"
> -- 
> 2.55.0
> 
> 

