Return-Path: <linuxppc-dev+bounces-21489-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A37BCD5BC8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 02:01:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPbb464GKz2xSb;
	Tue, 26 May 2026 12:01:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779760896;
	cv=none; b=XUvgLRAjNb7kDv7YSfS1rf8doj3NIPxmVI/L4JSMSPDkZp9va8bl1AIZRyCPP3e409sBkKpDmc2spgMI9anu1QCIURGcGVhMGGsjoVtmpZcdvaE24AzBNnuCRZ4aMQWIx+LGpGmEw8k/IOm2IFCgJUW90ISCa4zDvddWBGJM2lkCxN6FXPyfHQRNnBB3D+s776DgeosG3oeJwa/wderNqqzo9WOq6HAFG6tz7tcFIAWayXYSzoPYH42CbDe+eBfgMNUqIQ6mMadMZm60rwTxyd4K0yNJg8rbKaCG2ykMIo1RIhsJ3KW7XEWd10Ogh0jAf2nLoizmDNwDnBAWsLKyXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779760896; c=relaxed/relaxed;
	bh=WZccG3fnlNQe3qXKwjjLMWKLgAPr8Y1x9vAwmdo+axI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AbHUf79e9CDXGdUYt4B1VqyVo+vzKEMD8LT7o/c2n2N5T7GntttQnwbV8iwW2xcT/eFFqR/ODfkjvRRAmmZzsgZX6wgQnHM1dtZGJPSgPpgr6gmG/BbTi1ymaISqCTfzprqlch/sZyI8Z5QSpg1c2R3Gho7tgrjjTHlTybzqA4HM3F4txzbIWaCW42XygtkBHvkKR9Yy3sivg4mLKWBJmRBXTzu+ZtTUi5X3JJEbGQYTKmpK3jPYbFL8PpfXzk38pA0Dd8ieZTxJ2dYtLyvspoa7YrAhCE05gFNr2ZPVaiMJkwtYbGcJbrgGpRP6mWVjPWmEAZodvwcKbQOItsZqWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e07O8oYp; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e07O8oYp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPbb31blnz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 12:01:34 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PMJaPi739435;
	Tue, 26 May 2026 02:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WZccG3
	fnlNQe3qXKwjjLMWKLgAPr8Y1x9vAwmdo+axI=; b=e07O8oYpnAJrIw6Z+lwL17
	kQdN5s3lJ95ksVqy5Iki3/EtExPvuwr4qcpwtEQbgXU3vhFSBBYztPUHvlXbpCnF
	UwrqOXSFHxYidWCzaizY/1X9qCyNjD1AUeNajbc8Vu8NJN0egfSw4+/PpY/RRJ1N
	p8hdocibjnqUA/mgBHn82eFQvS+PXvpbhWSixHL/xbZP+CpQ9I3gWXWAmnE1B4ZK
	5GG2zEW9m6LHXfmshGIhOSOEl40wbZcJhWIpOFHY+5CfzGHWI3JNYRqCO031MS9L
	w4Ma81lKrBLGiidt/V4ebSRbCmPTbZjBErGl9lvNLxaRfbrrC5UeNCz5qehB3JWQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4qbsvu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 02:01:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64Q1s7IX003587;
	Tue, 26 May 2026 02:01:17 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ebrsg740v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 02:01:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64Q21Htk4653802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 02:01:17 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 147FC58054;
	Tue, 26 May 2026 02:01:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5714658064;
	Tue, 26 May 2026 02:01:13 +0000 (GMT)
Received: from [9.123.2.213] (unknown [9.123.2.213])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 May 2026 02:01:13 +0000 (GMT)
Message-ID: <6d525c47-a667-4440-8910-81b20a6d8eef@linux.ibm.com>
Date: Tue, 26 May 2026 07:30:55 +0530
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
Subject: Re: [PATCH] MAINTAINERS: powerpc: update VMX AES entries
To: Eric Biggers <ebiggers@kernel.org>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?Q?Breno_Leit=C3=A3o?=
 <leitao@debian.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260524212943.799757-3-thorsten.blum@linux.dev>
 <20260524213525.GA112327@quark>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20260524213525.GA112327@quark>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDAwOCBTYWx0ZWRfX4ckxd1zouxHm
 rwDijT5ca6g5HotfZr9RrgBr/bqA/oU1R83xA8+oo/PVhXIbnqEYGAMf5+CL8xKjUDmAnvJdIcO
 PY+qHEiUbFUxAkwctfF5YiF93WlEsMuCxKl61Dq2tRTkj0pidgCsK7oYe6Y5D/oAQA071NFxF7C
 efnBrFXLr/AR0ZtCZvqbBt+zjNelgZOzW4R6CuajLBno6tsBrbrLUZs5ItPMz5yiWc0skdeNbtL
 g4z0asQT/ELww3YwElRX4C8Dp4Sdl/MmCevTfDz6hMwrfaSTQx2uVmnWEh52jA9uEwIMDcUGaSS
 +PR/8f0ATMsEOVe5MYnBjFEO9Zz6YmkpLhI2XZWWgpxVcTjoyni5HGnCX3gYMim3/ASDE7wOduL
 PIA+QToZAd7lultSMCW0W/aQY+lRi0NY9F7y/pTz2alcy96j+B0cS21Uo206Z/eQzMTztO5oMu9
 87jHDCJZbICSvnvVrqQ==
X-Authority-Analysis: v=2.4 cv=KItqylFo c=1 sm=1 tr=0 ts=6a14feef cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=QeX2k3-f3KgXQTKCy84A:9 a=QEXdDO2ut3YA:10 a=0lgtpPvCYYIA:10
X-Proofpoint-ORIG-GUID: V5B_mq3WKa17XdYF6enYRCQ_VXJ2y8sX
X-Proofpoint-GUID: QbJddNLEi_mvrceoSBn4RXYgu4UJthR0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_07,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260008


On 5/25/26 3:05 AM, Eric Biggers wrote:
> On Sun, May 24, 2026 at 11:29:45PM +0200, Thorsten Blum wrote:
>> Commit 7cf2082e74ce ("lib/crypto: powerpc/aes: Migrate POWER8 optimized
>> code into library") removed arch/powerpc/crypto/aes.c and moved
>> arch/powerpc/crypto/aesp8-ppc.pl to lib/crypto/powerpc/.
>>
>> However, the "IBM Power VMX Cryptographic instructions" entry still
>> references the removed file and no longer covers the moved aesp8-ppc.pl.
>>
>> Remove the stale entry, add lib/crypto/powerpc/aesp8-ppc.pl, and tighten
>> the arch/powerpc/crypto/aesp8-ppc.* pattern to match the remaining
>> header only.
>>
>> Fixes: 7cf2082e74ce ("lib/crypto: powerpc/aes: Migrate POWER8 optimized code into library")
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> Acked-by: Eric Biggers <ebiggers@kernel.org>
>
> If this doesn't get picked up through the powerpc tree, I can take this
> through libcrypto-next.
>
> - Eric

I can take this via ppc tree.

Maddy


