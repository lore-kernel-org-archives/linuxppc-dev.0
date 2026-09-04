Return-Path: <linuxppc-dev+bounces-26524-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9B9C79F80
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 06:13:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbmNV6hctz2y2b;
	Fri, 04 Sep 2026 16:12:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788502378;
	cv=none; b=TTCIMbPAWtRbIKsEO7bQXOieXPXAqOtNJYPOB9Eqy1c7CHQsQtn0mLC/AVorG8/KwMYpIvVzAoCQuq9A/LvBb8Iar11BmczMCWSciNiaHnrXDW1u7xhz00o7S/wy3s2+dMWCW5wtnuMS5FC0EsubYcjdBbsCSnR0DazOzwOp0am/IFrBSoKUKFDMTNssSXZ182JSTmdSIMlzXwlGqSzEDMpUQ85p4IdM5M2eBmoSGWXas5unVbwj/VpUPjXetHyDud8IEsJK8fTvaR0DUOuOj6/C1K4j0xPzOHyN1y14tPgXNsL+NgWHo+UI/HR+ywA9VoJ8t+PjcClnKg2QME0hZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788502378; c=relaxed/relaxed;
	bh=Ts2bREG0zyJuFUU2VnWPDTmqtpkw84LjwMYQbmh2+cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKBSqHAkm038hpd/E+Cf7JiCqq3tnULeCbaSTBFnX2F3ENLz8JVcL087bZcmj/PLyqOjUssJF2tX2CADv6/7KUwjTJ5TVzuXyvoPtqTGSaL+4it35CmNOSchA/fOMkdgcylKJLNV8Qwwi79QY+WAJN9SKnIwMCNmUHnnsBpBgoibEfsEhk+pMOL5RZ6qYjFpbit6aW3zkE9FZ/8oYntD3RTBdHeWMt0dhL4Leia8TR4wUMZ/l4+9AJYbkax8xPcawOrE4/Su53PwlVMn/9NyEAetj8y1wJGS0i+P6ReE/b8VwTIOgqn7SM/SipLMxsIQ3vwJhjWkz5kWE8PIP3vIrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dR6jOVal; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dR6jOVal;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbmNV0B2Sz2y2K
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 16:12:57 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464MXt3254202;
	Fri, 4 Sep 2026 06:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ts2bRE
	G0zyJuFUU2VnWPDTmqtpkw84LjwMYQbmh2+cs=; b=dR6jOValOdttQaTT/E8+/7
	rVYo7567DtUeAUnwmOf0b5gon5Q24Y0/eVWMMuEKmw8LSXZvnrA/ypPzC+fgl/li
	yATOgaboH/4EkjhkfB7sfnQuSKUXQ2qV9KTz9r1jp9+9P3N8Q7Xrpwt68vQ6YVEI
	P5Id6bWLQ35llpFRhHYdXtMk60sCyeTLRblVwq2HTDWfyTEv//h+wEs6QB2zBz3/
	N8guSR/y6K0OR4mmBC3zh4eVpQitGjzEHMBcL9Y6iPFcmbNrSsR571uAm/upR9Cq
	7SnvjTs5uF/HArRCKVypWowC6ZnncDhCef76tTlyGawxwKeqmuNxH/2QsqsEFltA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rs1e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:12:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6846Bd9E023228;
	Fri, 4 Sep 2026 06:12:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqup28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:12:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6846Ceng12779894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 06:12:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65A1F2004B;
	Fri,  4 Sep 2026 06:12:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EBF320043;
	Fri,  4 Sep 2026 06:12:34 +0000 (GMT)
Received: from [9.61.247.46] (unknown [9.61.247.46])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  4 Sep 2026 06:12:33 +0000 (GMT)
Message-ID: <68bd90a1-3151-4df1-bc81-9aa5f3c86ab9@linux.ibm.com>
Date: Fri, 4 Sep 2026 11:42:30 +0530
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
Subject: Re: [PATCH v2 04/10] keys/trusted_keys: propagate wrapping key
 generation errors
To: Srish Srinivasan <ssrish@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com
References: <20260831111738.334857-1-ssrish@linux.ibm.com>
 <20260831111738.334857-5-ssrish@linux.ibm.com>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260831111738.334857-5-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9a615d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=QkqUArtv-mRflJTW7hEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX1mvMlK5bde7e
 6RQ3RCZ4cC7sTD/Fs42jcPTooAukYuO+zjeHHYkPMAVZJPag9A3O9Bxs9khcwlvL1CjKm2RBDyE
 U5RY1HIr0E+LX+vdNIGClB6xnQ++BdMpK5Uwlht83VyD7qYBd55raz+NdoMw/R2MkftGunCn6Ig
 Lm3Bov+1izdzqtv4iwhpmz6Yy8xT91F1+esSy9ykiHAE2fLiloNS5ujhthOymEASVWh95YZQeXZ
 jgBp0/NKddidYEyWVjIBAs5bVbLJAtLJb+uHOjsF68rBrdzXInbkw1GdKu8k4fq0a0w5RmdOcyx
 L3/RctSmTcjHx8OBqvXSJbXGYv8LAfL/zGTpsYleorCiZbv9i3cureiOhy1gwysorSQeZjFIMDI
 bQo6nvteLES8A4qBU0DU+UuCUa8/4Okgi1D6ECaow2mfhsb+eC3B3OOJogAurTrTjTSB4lXYUKY
 GzKPq7Eg3wvf3h6+1zQ==
X-Proofpoint-GUID: GWPhcDzqtsDrRCFH-JUKXzDYw0IYJ3aN
X-Proofpoint-ORIG-GUID: r6K72qi81_KSyYzLjo1X0oen43nBpOxf
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX05qJagPJpIn1
 MeGAMQN1B7BazjZDU3BMF18zMzxZS5sgyPoPeATtMzRet8gct4NZo4/W0yQ1Hkt87ojXvtxCtON
 Xm0I3Y7N9iB2cNl4jLoiKIedRRVJna4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040054


On 31.08.2026 4:47 PM, Srish Srinivasan wrote:
> plpks_gen_wrapping_key() returns a negative errno when default wrapping key
> generation fails. However, trusted_pkwm_init() returns -EINVAL for all such
> failures, discarding the original error.
>
> Propagate the error returned by plpks_gen_wrapping_key() unchanged.
>
> Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted source")
> Cc: stable@vger.kernel.org
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

Tested on ppc64le PowerVM LPARs on firmware with wrap/unwrap support,
with and without Secure Boot enabled.

Verified that PKWM initialisation succeeds on first boot (wrapping key
created) and also when the wrapping key already exists from a previous
boot, confirming the error from plpks_gen_wrapping_key() is now correctly
propagated rather than replaced with a hardcoded -EINVAL.
> ---
>   security/keys/trusted-keys/trusted_pkwm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
> index b6b5697426a8..633a7674d065 100644
> --- a/security/keys/trusted-keys/trusted_pkwm.c
> +++ b/security/keys/trusted-keys/trusted_pkwm.c
> @@ -170,7 +170,7 @@ static int trusted_pkwm_init(void)
>   	ret = plpks_gen_wrapping_key();
>   	if (ret) {
>   		pr_err("Failed to generate default wrapping key\n");
> -		return -EINVAL;
> +		return ret;
>   	}
>   
>   	return register_key_type(&key_type_trusted);

-- 
Thanks and Regards
R.Nageswara Sastry


