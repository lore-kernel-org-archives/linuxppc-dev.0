Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A5C606A6E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=O0RSiD9r
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWS0G0Z9Nz2xpt;
	Sat, 21 Nov 2026 07:40:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795207246;
	cv=none; b=K8mQpe+p97fQEKEdcySke/WBmPxhU53DD+RpmAKTLm2TxJj+woXPtaX6chF+YPtgFnBIfAnN7dVsckPhk3dbvoD+AT0Ui4ehHwqL5rvwmSXota+38/3zgbBv2cN3ZXbfmgSBQMB7CeR34AVrodUCcF5CBu4a/nM8+oJ/sLVeufrnELTBj55sxgcjPj1bSv8r0F0LX5yJ1Kn+sMZMnNEA7LEogFJRUl8r/cnkhPy4Tod5ptqwVd6xuRSZLxSoxQUIfa8bNX51ljIWdeqS0JbpTvEtEmab2LB8OsIeY/o06phSc7PeC66e0BsrZ7alw/hk6zczQKZmmeYS5dbUzHhX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795207246; c=relaxed/relaxed;
	bh=wBEpo5cCtyGvI1uSjV2ZXJiyglZ+oxrIOzyU+FRlVZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VxRH44TAg48/tvP/anJxsnI2rRv5iGTeHGWw0GtQxBFzgSVWSuFjHO5mMqyaPYPNj/0aw336UkHgmAMZh4AhUYTg5KEcgAJ4nxMVJDGUADWmHrL1kl7F63hCyH77MZWYU+Rm5Px5NonuXpZk3uAPpOiNSO35tWsWVUjyNjFZS67jBmZG4ULA0NgXQ1afuTkWhAAdWf+xFJcA8QXQVvYx2ttwCTlYpl4NQcbcmP1bm4PsT5BPVF0KUQaZ6OFuwyEX6MDxI8bDIiIyq34FA3RozGOtdFf1avqeqPWFUoMzUN1jv/XZo9QW6t7lW1XOcndrLRW5+qxHDRZCSJlc3Csm8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=O0RSiD9r; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=dtsen@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=O0RSiD9r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=dtsen@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWS0D5M5cz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 07:40:44 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKEuBGB3369721;
	Fri, 20 Nov 2026 20:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wBEpo5
	cCtyGvI1uSjV2ZXJiyglZ+oxrIOzyU+FRlVZ0=; b=O0RSiD9ri5GKEGjYxwNX95
	7Crr4ymHuxtwAP9a+m/FL55aYdjNv9Dr3vvEd6BKd0CJgP1TYB9AvzwfU5NoW17n
	xDKPPmnYW+6JkysxzA4L5BFoJaioAaJ4FHC53pfnvSKnLey/N/CKCoUzPPFxnjEV
	fpMPR8w+tCD9hdS+l8lvulT+fZFkKlYAarrbt3Jjdo0QcDcc7FfDYq0yeOOz6HZl
	D1UXcXKVOpvuOvCazfjOM1BEWDz0MrvyXjGa0nsits70BIkPl7yXY2TELIxqtrsM
	DsEp/UkJCFceMwYYC1EDYvVFSX0hzFCAfLcK1o2LJFvKcH+/V69jMn9YXvK0z+fQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105xanja-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 20:40:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKHvRtu2445446;
	Fri, 20 Nov 2026 20:40:23 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1m3j4cun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 20:40:23 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AKKdUIF8913494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 20:39:31 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91A1158055;
	Fri, 20 Nov 2026 20:40:21 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0F7058043;
	Fri, 20 Nov 2026 20:40:20 +0000 (GMT)
Received: from [9.67.108.139] (unknown [9.67.108.139])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Nov 2026 20:40:20 +0000 (GMT)
Message-ID: <8facf804-6207-44be-829e-db79d271d005@linux.ibm.com>
Date: Fri, 20 Nov 2026 14:40:20 -0600
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] crypto: powerpc/p10-aes-gcm - Fix IPsec stall on bond
 failover
To: Breno Leitao <leitao@debian.org>
Cc: linux-crypto@vger.kernel.org, stable@vger.kernel.org,
        herbert@gondor.apana.org.au, nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com
References: <20261120181657.6396-1-dtsen@linux.ibm.com>
 <awCpkj5wsxEPt-Vd@gmail.com>
Content-Language: en-US
From: Danny Tsen <dtsen@linux.ibm.com>
In-Reply-To: <awCpkj5wsxEPt-Vd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lpRUkSlYIZpBGCY0_WBq0CQMZJMLVdaG
X-Proofpoint-GUID: lpRUkSlYIZpBGCY0_WBq0CQMZJMLVdaG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA4MSBTYWx0ZWRfX2EL5erKl5YeE
 jktCH4p4WuI3NJSseojFO0gDON2qH7ubk+Xw6XWTy3B9zAMzr6qndv2YIIiX/1mqvjMXx1uo427
 F+J7tTo88SFfK+020lkukg0RDSlS/N0g/Bc+VL6NEBM85S78nNHdQXyEPLutaUIPo2F4QtTPJiL
 iQRuI23Kvj6fqyQhMMYJcCn42gm0JFO9asOyW8qlBqEywykvUGhaxa0SHsfzY6niXzEHwdP3iAX
 a3oxZYlMdF4cxf7/ergLOSi1pXDqfzrZNRHFhJ3TnBkfKAnjC0E6+ZxVXD/ZdGUpdr0cCaWEe+L
 xGbrLszEmupGlLGYUQSiiYjfW3mch/Q6jJ7M8mEzyFHE5t6h5FW/px4VD9nFKXK0wxd66UZrzqR
 6w7ouRDY3XOVyuZ8SHpLzuOZ95ttekIRa2h05c6XMH+gkHi+JurojmATlNQCZb1rqw3KJSTg0oV
 RXSP2w1VbpVR8mK8qkA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA4MSBTYWx0ZWRfX2jors8qI2ou1
 W6TzHdGjG2Y0UGV8p7M7pRonMhfp0lW+h2mU+P7vYxqcYiohx2ZjdTc1TryIV+rylZonn+icffm
 IEh9tUFXDlCTVk7hmmb3UdljlrTNSBw=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6b00b037 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=xNf9USuDAAAA:8 a=UG7Ak6WqafkiEiLPWlwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200081
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/20/26 2:14 PM, Breno Leitao wrote:
> On Fri, Nov 20, 2026 at 01:16:57PM -0500, Danny Tsen wrote:
>> The Power10 AES-GCM driver registers its gcm(aes) and
>> rfc4106(gcm(aes)) algorithms through the crypto SIMD helper. When
>> crypto_simd_usable() is false, for example in softirq context, the
>> helper defers requests to cryptd and completes them asynchronously
>> with -EINPROGRESS.
>>
>> This breaks IPsec traffic during a bond failover. With the crypto
>> offload device active, traffic is switched to a passive device that
>> has only software encryption, and the ESP requests then go through
>> aes_gcm_p10_crypto. Under heavy load, some or all of the TCP streams
>> drop to zero throughput and do not recover. The stack is seen to drop
>> the ACKs as invalid, which points to the cryptd queueing delaying or
>> reordering the packets.
>>
>> Fix this by registering the algorithms directly as aead_alg with
>> CRYPTO_ALG_NEED_FALLBACK, and allocating a "gcm(aes)" or
>> "rfc4106(gcm(aes))" fallback tfm in ->init(). When VSX cannot be used
>> (!crypto_simd_usable()), the key was not set up for SIMD, or
>> cryptlen < 64, the request is handed to the fallback and completed
>> synchronously in the caller's context. The driver no longer defers
>> work to cryptd.
>>
>> Remove Kconfig option CRYPTO_SIMD and add CRYPTO_AES and CRYPTO_GCM.
>>
>> Fixes: c954b252dee9 ("crypto: powerpc/p10-aes-gcm - Register modules as SIMD")
>>
>> Signed-off-by: Danny Tsen <dtsen@linux.ibm.com>
> Reviewed-by: Breno Leitao <leitao@debian.org>
>
>> - * Copyright 2022- IBM Inc. All rights reserved
>> + * Copyright IBM Corp. 2022, 2023, 2024, 2025, 2026
> Do we really want to change this in this "fix" commit?

This is following IBM's copyright style.

Thanks.

-Danny


