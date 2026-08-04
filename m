Return-Path: <linuxppc-dev+bounces-25333-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F291C55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 06:43:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDkWS5rCDz2yMl;
	Tue, 04 Aug 2026 16:43:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785825780;
	cv=none; b=Cwm7rBQW7di4NFTpZVGX/jMq0GO/mei4XdF/XDcz3AMGaE/rIMLKqPY97RBZKyGMNzYAoLNgiobVdYlYDXjNfzTRu/3Q3qDMFXPxCUM+KtDDyHoY5nPrIIns0X4tV74Obi0GPyrEyHHa3cRYIewSbDKv0LcgyhoKapzBQBDi53rkD0FeLkW78O4rmVrKDmfs9Vu/BuM96Yo2oHjuhSEfRjFoB+8jahfMwMlAw7jAeTUTeF3wlu5Lv7ZTBeLF9+ByV8I2ctj2rr7phAqf/qmLeG2lW/2pxPgOKFTneEASuO+wDP/q/jzQyQqlKPp7of6AjB1BFo3umuCVxT13PH7IGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785825780; c=relaxed/relaxed;
	bh=h8GOb0KQTjmORsa1vt04roQA+CwQLVnLsWuOkctXesM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOtBiFcjdd/6ctZzgjOy9WQ8fqJa2RbBq7dX3V1m9VIsDCpWznwcMtcKw9VOgL8nzVqQlYya7oQPHIbad1TODWW2lG14IV/dvjAgro5MlThyUwtpnfcLNthgPQIC2oorjMfRpeGS68LWuX8E03K2uzR9oQwdRuYiynTH+6XvRc8Nq/ST9zIZ62899vx+AhWr7O0r02xdnA4B1XlPbzth2yaSxw0r+DkXAj8bVVJHwZQ48XEZxX7prgV4Fn1GhPstilNldaBrJOr2EITktQBj0iylb+4WpvN9fidgqRz2JlShsIKSw952SuGy5H0Ulbb6hvdysuveEdp0e7rvGAmdyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ddz0NkcU; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ddz0NkcU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDkWS0W7Fz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 16:42:59 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741JH0P1787410
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Aug 2026 06:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=h8GOb0KQTjmORsa1vt04r
	oQA+CwQLVnLsWuOkctXesM=; b=ddz0NkcUEDibeSMp8WQuhD7q4Qv3E3WDUZ47R
	yjVONYtKv0zIAzk2MUmPSMjT4w7kAc+rPLCPtoweDiBFfhTDQJHMADmiNUbCy2Hi
	2CDcH32R7NgR95vSni6jZhzU5naTlvePo6wpq7aZXkq3JPozAfGQeQBOB3RQPLGF
	H+JQ+PQ21oxA7+KReX9ycaY5GXAaiApV48l/B+OaOKWo1Eeri0jLVpgVNBwZSQdc
	UPJ/Tsd3tiSnzf8U+ps+VLNo8HxC2cVAxuQTMuhkAP6ani9McNBEytStTyunK66d
	ytzTNtEXQSfuMjo2oGnn9Wr1jgMJmeRWb127U9JmlwfPm6Tiw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqmexx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 06:42:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6746fLnL014672
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Aug 2026 06:42:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qgxra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 06:42:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6746grTM30867764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 06:42:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F145120043;
	Tue,  4 Aug 2026 06:42:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C86A820040;
	Tue,  4 Aug 2026 06:42:51 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.123.6.78])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  4 Aug 2026 06:42:51 +0000 (GMT)
Date: Tue, 4 Aug 2026 12:12:49 +0530
From: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Praveen K Pandey <praveen@linux.ibm.com>
Subject: Re: [PATCH v2 1/4] powerpc/pseries: Limit PVR list to 16 entries for
 CAS negotiation
Message-ID: <anGJGMG7hnwdUk-g@linux.ibm.com>
Reply-To: mahesh@linux.ibm.com
References: <20260803155724.3272052-1-mahesh@linux.ibm.com>
 <20260803155724.3272052-2-mahesh@linux.ibm.com>
 <20260803235347.b630c20f-dc-amachhiw@linux.ibm.com>
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
In-Reply-To: <20260803235347.b630c20f-dc-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: anClMzOmBLBJg6gwvcBIpCXEQ4K0ALP4
X-Proofpoint-ORIG-GUID: anClMzOmBLBJg6gwvcBIpCXEQ4K0ALP4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA0OCBTYWx0ZWRfX7/Xy+kVeNijn
 +lgVVjme24Bxg/okP983TEbNohAI4VQjPecZQltGl3MRasc+rLC0cqoTUyl+YO4Fqvl3vM9ibv7
 RQMdSsl5EX8wQombOpT6VmC9V2dQFKg=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a7189f1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=3wZ5-T8iQyZXD5-YbfUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA0OCBTYWx0ZWRfX/OjrFHpFgC2N
 9zYPPmjks3LXTIeruUyUW4S/9aZhRnFCQo5BYWhM/GUMlTzcR1LgMywQBmduEl+P21HpYb+oZ2b
 ubA3RCsiGRsbqsBbND7+Ie6UX4B6juOIdBjXkT8rvdkkxNcZCC8AvEkXll9yTICm7ln7xJMD0Vl
 Kqa/dtzTS2MoXn82E2NA2TW8qhHtnCjtCkcsPiCuBsUKgxAiFCFbZHhfBqzZbPh3gl/BemLGrG5
 Pkfd0KUIibVsfWdDiRGnpgunrf+bLwjBUIul/CNPRBe0cXD0nYJVNvlEFbN3LOABQBL+zEaX8pi
 TCg53sLhUfefvKcIb5wgDLYDyl5q6ZHFzNUg3yXbB1nL9AWuCWRB9/0sOMxqMJb21Yf+6raE163
 UYQoqLiv16BNY57hK8baef3OWWa6SW5ZgZc2tslXn91tbEO0meUVhBl8I5EeRaZRfO8PT8CSz5w
 qqp43VTwdosl00vJGNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040048

On 2026-08-04 00:02:08 Tue, Amit Machhiwal wrote:
> On 2026/08/03 09:27 PM, Mahesh Salgaonkar wrote:
> > Current Power system firmware caps the PVR list array size at 16 entries
> > during CAS (Client Architecture Support) negotiation. Passing more than
> > capped size to older firmware could cause an undefined behaviour and
> > breaks compatibility.
> > 
> > Future Power system firmware releases will lift this restriction and
> > support greater than 16 array entries.
> > 
> > Ensure that when running on Power11 or below hardware, the number
> > of PVR entries passed during CAS negotiation does not exceed the
> > firmware-imposed limit of 16.
> > 
> > In prom_send_capabilities(), compute start_index to skip the oldest
> > leading pvrs[] entries when running on Power11 or below hardware, so
> > that the pointer passed to ibm,client-architecture-support points to
> > ibm_architecture_vec.pvrs[start_index], presenting exactly 16 entries to
> > firmware.
> > 
> > Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> > Tested-by: Praveen K Pandey <praveen@linux.ibm.com>
> > ---
> > Change in v2:
> > - Define a named macro CAS_MAX_PVR_ENTRIES
> > ---
[...]
> > @@ -1032,13 +1042,9 @@ static const struct ibm_arch_vec ibm_architecture_vec_template __initconst = {
> >  			.val  = cpu_to_be32(0x0f000003),
> >  		},
> >  		{
> > -			.mask = cpu_to_be32(0xffffffff), /* all 2.05-compliant */
> > +			.mask = cpu_to_be32(0xfffffffd), /* all 2.05-compliant */
> >  			.val  = cpu_to_be32(0x0f000002),
> >  		},
> > -		{
> > -			.mask = cpu_to_be32(0xfffffffe), /* all 2.04-compliant and earlier */
> > -			.val  = cpu_to_be32(0x0f000001),
> > -		},
> >  	},
> >  
> >  	.num_vectors = NUM_VECTORS(6),
> > @@ -1347,7 +1353,6 @@ static void __init prom_check_platform_support(void)
> >  	};
> >  	int prop_len = prom_getproplen(prom.chosen,
> >  				       "ibm,arch-vec-5-platform-support");
> > -
>  
> Nit: Looks unintentional whitespace change, please drop.

Hi Maddy,

Let me know if you want ime to send out v3 to handle this unintentional
whitespace change Or do you think you handle this while merging ?

Thanks,
-Mahesh.

> 
> >  	/*
> >  	 * First copy the architecture vec template
> >  	 *
> > @@ -1403,6 +1408,22 @@ static void __init prom_send_capabilities(void)
> >  	ihandle root;
> >  	prom_arg_t ret;
> >  	u32 cores;
> > +	int start_index = 0;
> > +
> > +	/*
> > +	 * Ensure that when running on Power11 or below hardware, the number
> > +	 * of PVR entries passed during CAS negotiation does not exceed the
> > +	 * firmware-imposed limit of 16.
> > +	 *
> > +	 * Compute the start_index to skip the oldest leading pvrs[] entries
> > +	 * when running on Power11 or below hardware, so that the pointer
> > +	 * passed to ibm,client-architecture-support points to
> > +	 * ibm_architecture_vec.pvrs[start_index], presenting exactly 16
> > +	 * entries to firmware.
> > +	 */
> > +	if ((ARRAY_SIZE(ibm_architecture_vec_template.pvrs) > CAS_MAX_PVR_ENTRIES) &&
> > +	    (PVR_VER(mfspr(SPRN_PVR)) <= PVR_POWER11))
> > +		start_index = ARRAY_SIZE(ibm_architecture_vec_template.pvrs) - CAS_MAX_PVR_ENTRIES;
> >  
> >  	/* Check ibm,arch-vec-5-platform-support and fixup vec5 if required */
> >  	prom_check_platform_support();
> > @@ -1427,7 +1448,7 @@ static void __init prom_send_capabilities(void)
> >  		if (call_prom_ret("call-method", 3, 2, &ret,
> >  				  ADDR("ibm,client-architecture-support"),
> >  				  root,
> > -				  ADDR(&ibm_architecture_vec)) == 0) {
> > +				  ADDR(&ibm_architecture_vec.pvrs[start_index])) == 0) {
> >  			/* the call exists... */
> >  			if (ret)
> >  				prom_printf("\nWARNING: ibm,client-architecture"
> > -- 
> > 2.55.0
> > 
> > 
> 

-- 
Mahesh J Salgaonkar

