Return-Path: <linuxppc-dev+bounces-26528-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8EFC79F80
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 06:16:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbmSk3hlgz2y2b;
	Fri, 04 Sep 2026 16:16:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788502598;
	cv=none; b=MbCI0/E44yxWeSDm1fmQsw9AW+Z7n+u94KAkBHgLDv9iEaKGGOYv/AlphrDCi4qEm+n9/6KSBfMqQp8Wrq4gY8Et8qDxR9V43MlQx6OY1iiQyppeVfBQVBg6le4pRDAcNSvCdkG1FAPdr+8Ue7bD3Ow/80VDp6mGf2Z7XRHdlhp5YRfJ19dR1kEZ/QPqduqeMiMFiJIXBNkVzPJ2IONEmz0UL7ShlqUwsfLeaGLHls/cbcNtCUKpLFqol1MbVhDBpB0ykZ7shxgVHEHOOgDVjLhws6ADGnHF8MMgcvlB0xxJcAfjSwxzE6zfbPAXkqFZSHsMAt0ujCcXbs1P6eI+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788502598; c=relaxed/relaxed;
	bh=AbibkQdvmMRoMTgIWeQEXRDTHFLZe8F6+Zm4Tru5WBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CRs2hN14KJTyzkigwpPnIo9j2ykJKPblRbaxSKs5kIXF4FaQfI5yZAn9USklkSWVJdYn0jUXbou9TQqkEiU8ajubDGDrYZx+HNLQIVWGol3eei4T2/gk0n59XY+rb4ByGgoU9ivhtFV7F0HjrLg548ZavGtU/YS0PFLPHG0deGLtpHi83h5cF3LHDVheWNCZqIKy4z6soRRpDen0M3CN5819Q6FXH1TgA8wW/MsAS4NIMv6a5PQYaazimZo0qFSlnbla/nK85vLN1GFaW6h8sMUAiKv/88qHwhwvnXCgAi1jOKP9WDPSzxedPnBchog6qJijOLBnY97jxFTCkGG3Jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bCG5Fquw; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bCG5Fquw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbmSj3pJLz2y2K
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 16:16:37 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464Z7S3993927;
	Fri, 4 Sep 2026 06:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AbibkQ
	dvmMRoMTgIWeQEXRDTHFLZe8F6+Zm4Tru5WBE=; b=bCG5Fquw2/IjJW6r298508
	9n6uCwH56HzevLCbed2keCKIYFQi/cvdA/IqLu2dbfYkCd96IdHyED2dZPU+S7ws
	JHHN+KPSDOq3j4yMdMES4WkLEr0lBkjm/2BDp9kav9e1HOK9h5eRcTN0RCbpzphM
	mG5vsNL4c8YecLRemVboZU7hQymwSwK/xEG7BRF7ReZ5jclWfZcKrMuyG/olC+ol
	Gc6i06ICKuMwe6ZWnOWs0am8HGSHVtGsB/mAc6NziY+YPmvH/5U2D4n2JkA+WFIe
	THxc9A73fJML4rt8X/hYBUzUKrS7KdPS0NtKkgqWq9HLcPjDtZlZj9utRGd1ToRQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnue8k0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:16:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6846BhuL026541;
	Fri, 4 Sep 2026 06:16:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceykaqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:16:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6846GKAO42074378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 06:16:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E8512004B;
	Fri,  4 Sep 2026 06:16:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF3E520040;
	Fri,  4 Sep 2026 06:16:13 +0000 (GMT)
Received: from [9.61.247.46] (unknown [9.61.247.46])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  4 Sep 2026 06:16:13 +0000 (GMT)
Message-ID: <8159b55d-45d5-43e9-8cb0-571428a720ca@linux.ibm.com>
Date: Fri, 4 Sep 2026 11:46:10 +0530
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] pseries/plpks: hide wrapping_features when
 unsupported
To: Srish Srinivasan <ssrish@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com
References: <20260831111738.334857-1-ssrish@linux.ibm.com>
 <20260831111738.334857-8-ssrish@linux.ibm.com>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260831111738.334857-8-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: UJuBmFw9NMuEjy1KfBITFKiNLJ0AJyrj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfXxHjM55lhqUbv
 uLvj+MCwxroG8qb4SUv1JYu9CteNNcJgOQWmcytSA+sl8y7PVQ/p1229Ex5bSV/KNOIBjyN2hoZ
 d4EbS7sQu/3HozB456CFRJ9wWFX4SrRFh+XxBIhs4NBIRj2w6oVdEFgqT2SCoB1WTQnQ6xqh1pp
 unvPHZC4X+Xgxsiq+vKeHXQQLsQV+S2AGBCHrr2b7Bp3dDDZAhoW7tzh524Qh7My/Ln78a27bnB
 aauBDIWPsCI1T7pSr/v84V30wG3nLQoai4Tc9kdu0VscxevtX6ITfcXHoMRlGGSJW7W/M0mksEk
 xV6G9OvUnSIktKfT6lA7+FjM2ahD3IvzXDVsIermyX4Avww9TSEFI9ph+pPcTaXkjYgHQZGiUDZ
 0stz36Huu2dpy86fpBd/JU1x2k5uXDNIMkYanTZ18EKAiSBKqfl84pj4Q44yQ+BGc5GJ0Z2Q8Mj
 uMNPAL9YjIklmssM5mg==
X-Proofpoint-ORIG-GUID: taQ9suFacG0L0iiTtEI9m_ziNksHiFrU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX1q49YKGPmxYl
 G2MyLt3LZDJbBhvkps8PS0JBmcKF7ZwlzhxDq9TrPtu8AUJdB2RuaP1xPJD8BOStQ/b5/ij8fs8
 ICz1rztspMB8gXUZPS9kSi/Zwk/3oX8=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a9a6239 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=mUOOc771WLDZFK3RTqsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040054


On 31.08.2026 4:47 PM, Srish Srinivasan wrote:
> The PLPKS wrapping features config is only valid on systems that support
> the "Key Wrapping" feature. Currently the config is always exposed, even
> when the feature is unavailable.
>
> Add is_visible attribute_group callback to suppress the wrapping features
> sysfs attribute when the "Key Wrapping" feature is not supported. Declare
> the attribute group static const, as it is not modified after
> initialization.
>
> Fixes: 447eb1d5ef00 ("pseries/plpks: expose PowerVM wrapping features via the sysfs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

Tested on ppc64le PowerVM LPARs:
   - Firmware with wrap/unwrap support: 
/sys/firmware/plpks/config/wrapping_features
     is present and readable.
   - Firmware without wrap/unwrap support: the wrapping_features attribute
     is correctly absent from sysfs.
> ---
>   arch/powerpc/platforms/pseries/plpks-sysfs.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/plpks-sysfs.c b/arch/powerpc/platforms/pseries/plpks-sysfs.c
> index c2ebcbb41ae3..f2436229f323 100644
> --- a/arch/powerpc/platforms/pseries/plpks-sysfs.c
> +++ b/arch/powerpc/platforms/pseries/plpks-sysfs.c
> @@ -45,6 +45,16 @@ static const struct attribute *config_attrs[] = {
>   
>   static struct kobject *plpks_kobj, *plpks_config_kobj;
>   
> +static umode_t plpks_config_attr_is_visible(struct kobject *kobj,
> +					    struct attribute *attr, int n)
> +{
> +	if (attr == &attr_wrapping_features.attr &&
> +	    !plpks_wrapping_is_supported())
> +		return 0;
> +
> +	return attr->mode;
> +}
> +
>   int plpks_config_create_softlink(struct kobject *from)
>   {
>   	if (!plpks_config_kobj)
> @@ -52,13 +62,13 @@ int plpks_config_create_softlink(struct kobject *from)
>   	return sysfs_create_link(from, plpks_config_kobj, "config");
>   }
>   
> +static const struct attribute_group config_group = {
> +	.attrs = (struct attribute **)config_attrs,
> +	.is_visible = plpks_config_attr_is_visible,
> +};
> +
>   static __init int plpks_sysfs_config(struct kobject *kobj)
>   {
> -	struct attribute_group config_group = {
> -		.name = NULL,
> -		.attrs = (struct attribute **)config_attrs,
> -	};
> -
>   	return sysfs_create_group(kobj, &config_group);
>   }
>   

-- 
Thanks and Regards
R.Nageswara Sastry


