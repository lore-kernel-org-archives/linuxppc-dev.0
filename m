Return-Path: <linuxppc-dev+bounces-26522-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1412C79F80
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 06:11:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbmLh6ftVz2y2b;
	Fri, 04 Sep 2026 16:11:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788502284;
	cv=none; b=YDnUh9F8WW/SdtgIibBCbzIxShhtss5aX4LtG5zVi9AIYedpeb24mrBJBcE+Io8svs9mqpv+hlCeerAbdQ/GVSAsdkVAmUf5mYtwYqNvXtp5hQzC1ENQBespn1X7FEwB+FGlcc4r+wV6fZlCjIxDbJNrNrgjG5VLx6zl1SJkmNiXyGlYpu9L4eFtQA1SGkRwLn8k41zYR/x4sdntUkOhh25jSFXUh9tvqmAoKY4qsZ41ZwiEejhhOaRJ2NgeA0I7Qf5ZteKA7XWKjQHSmbCDb2TYLJBR/nWa2j2UwlX8JUKodKCO3CoTaioAAQumj714MBlD2AGlfnY9QnjofdcsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788502284; c=relaxed/relaxed;
	bh=Ur0muUByjP50tq8PtJ3RdLJSMXkfWAfSkEWwZJf6yxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VYnIgxIpyX9zYqIQUyTwXqxw5U6vKFGzcOkYE47TG7vGyLB9dbETsk22kupiXPO7t3YbeH3Ipzmbqk+qoSrSLDx4bBnwoXJDUJsDivqPl4nwKcQnwdsGENMrsin+tOniiVKomcgTL+7Ecxu5lWQLJDCCgbQCt8YSReCIEYS7EUsqVIeP1Dq1UcKiN8R6aC+ZnpzNtmuYdFir4teGf8jT2+no34bXMV3W4hdsvRTiQH35w3K9sqm66AqOGQ7V24SU8vnFj+iH/je5u2pYfz+zOxKfXnOt0ATN8R9J/BmkkBRCWgvrZMuBgeqhZAvTYWsl/X/bNbUAc1gbMLhrdhlh9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mHHJKdm4; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mHHJKdm4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbmLg6Q4sz2y2K
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 16:11:23 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464QSf814607;
	Fri, 4 Sep 2026 06:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ur0muU
	ByjP50tq8PtJ3RdLJSMXkfWAfSkEWwZJf6yxA=; b=mHHJKdm4DC8mthnSDuFfM2
	LN5JWfy7qjy5PKvVBhBOuAxK8idFxHZsp9YaufusX+3ZEOhRaVAeRVhgGVc5TExW
	5tsSYmVC2lfYfJDlPgtIY4LGs0XPOMsPovoTarlfDC7Z0VSNXTxSEEdDzr6tcHgH
	JoJD6R9mFEW8MGvIrDBtXggP07CPfrssqj7dvDz0aHcnttBmzYUXiNL2gsimcB9C
	KT2LBL0oC6SqTH/f1u+AbukI5+t5haChJXjuSnq0VjcDPSZJPrw/tTblsMLYkeFp
	IGvTgIE6SM/lSYJtHZAwMIQMNbFXz0Qe5GxVpaCh9eLGfDnVSfrOpqRhoDxMX+qA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuj8pxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:11:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6845uOl4031382;
	Fri, 4 Sep 2026 06:11:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarkkgj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:11:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6846B6Yv53215696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 06:11:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFC7D20040;
	Fri,  4 Sep 2026 06:11:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA82B20043;
	Fri,  4 Sep 2026 06:10:59 +0000 (GMT)
Received: from [9.61.247.46] (unknown [9.61.247.46])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  4 Sep 2026 06:10:59 +0000 (GMT)
Message-ID: <b6fb7eea-cb1b-46f9-ab33-724e01e2c6de@linux.ibm.com>
Date: Fri, 4 Sep 2026 11:40:56 +0530
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
Subject: Re: [PATCH v2 02/10] pseries/plpks: fix error handling in
 plpks_read_var()
To: Srish Srinivasan <ssrish@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com
References: <20260831111738.334857-1-ssrish@linux.ibm.com>
 <20260831111738.334857-3-ssrish@linux.ibm.com>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260831111738.334857-3-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: -N_IoP0EELZNABakTPqqGhMJ23ZXFBFM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfXz/Z8MWgSVTEJ
 +UbToZy0lU0pyOeSgz7PtOX7T/aSXXbV4bHmqAox5z+1vouwJNmoVTFi4Pq79YTw415tnM6+PoZ
 KzyJt0YBNbcnLDcBULHk90RfjC9EihJ8KCSHe6R37UkPdpS9mjS3z+oax4/qUUL2xSOBh74Ykem
 9gso0QbDp+Ne52BLptFEUzE3q09fHy8oZG8dTCuDqqYXpS5pazKUfhDir30LkIBGs3PRfoQAsgc
 oocrMxgCPgE1g7IyxO9mWMmktIQDrG+K/6Ra3Zp14b0H5TVSwPxV6YEo0G/FG2W+7hXzcGgNHLl
 mom9kIwDi0whEbN9xgs2y9tryhJOMWAonOAMw1wtnyW8Xja3Z6dN1npXkLbZLs29ced9t3kobr4
 zNfJukLRWdh6+bmg1Fg/U9R6weamDX+sBAUCXX4CTcznCQboBQ0tFRGn0kyz9RT8LH5mOMDajJo
 BMJMdVlCV8YjkHj8hpw==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a9a60ff cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Ed2H8Pd2JmTe5eqG1NwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfXz9kPd1UGlPKJ
 U3oauRJ4Rpi87xnB227LsOic6FvajyDpWTdH/x6s3goWeCGoSwUtbFRzXW5ui5yn4i4NjFjGu26
 iQK3qwzpOdwBzNCpn7sF0S96jRLtqsA=
X-Proofpoint-ORIG-GUID: w3GEXpODAvWcbeBj0A-TwOJyA5RQJTVV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040054


On 31.08.2026 4:47 PM, Srish Srinivasan wrote:
> When a plpks variable is initialized without a policy and used to read an
> object with the 'wrapping key' policy set, the hypervisor returns
> H_AUTHORITY along with the object's policy. However, plpks_read_var() at
> present treats this the same as any other H_AUTHORITY failure and returns
> an error without propagating the policy information to the caller.
>
> Distinguish this case from other H_AUTHORITY failures and only propagate
> policy information when it is returned alongside H_AUTHORITY by the
> hypervisor. Remove the explicit assignment of rc to zero in the case of
> H_SUCCESS as it is redundant.
>
> Also return -EPERM instead of -EINVAL when the 'wrapping key' policy bit is
> set by the caller, better reflecting the access restriction being enforced.
>
> Fixes: 2454a7af0f2a ("powerpc/pseries: define driver for Platform KeyStore")
> Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping Module")
> Cc: stable@vger.kernel.org
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

Tested on ppc64le PowerVM LPARs on firmware with wrap/unwrap support,
with and without Secure Boot enabled.

Verified that PKWM initialisation succeeds and the trusted key seal/unseal
round-trip works correctly. Confirmed that -EPERM is now returned (instead
of -EINVAL) when a read is attempted on an object with the wrapping key
policy bit set. The full key lifecycle (create, export, reload) passed on
all configurations.
> ---
>   arch/powerpc/platforms/pseries/plpks.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
> index 23e4e2a922fc..7bd5c149dd09 100644
> --- a/arch/powerpc/platforms/pseries/plpks.c
> +++ b/arch/powerpc/platforms/pseries/plpks.c
> @@ -826,7 +826,7 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
>   		return -EINVAL;
>   
>   	if (var->policy & PLPKS_WRAPPINGKEY)
> -		return -EINVAL;
> +		return -EPERM;
>   
>   	auth = construct_auth(consumer);
>   	if (IS_ERR(auth))
> @@ -856,22 +856,21 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
>   				 virt_to_phys(var->name), var->namelen, virt_to_phys(output),
>   				 maxobjsize);
>   
> -
>   	if (rc != H_SUCCESS) {
>   		rc = pseries_status_to_err(rc);
> -		goto out_free_output;
> +		if (rc != -EPERM || !retbuf[1])
> +			goto out_free_output;
> +		goto out_copy_policy;
>   	}
>   
>   	if (!var->data || var->datalen > retbuf[0])
>   		var->datalen = retbuf[0];
>   
> -	var->policy = retbuf[1];
> -
>   	if (var->data)
>   		memcpy(var->data, output, var->datalen);
>   
> -	rc = 0;
> -
> +out_copy_policy:
> +	var->policy = retbuf[1];
>   out_free_output:
>   	kfree(output);
>   out_free_label:

-- 
Thanks and Regards
R.Nageswara Sastry


