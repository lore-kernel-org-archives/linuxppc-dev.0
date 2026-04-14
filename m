Return-Path: <linuxppc-dev+bounces-19743-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453DAED7B9B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2026 10:29:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fw0rw5Jm8z2yVL;
	Tue, 14 Apr 2026 20:29:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776162592;
	cv=none; b=bXzzINYWM3W1Kqy6UxSmOL1ZcRVTYMO0s30B5H7x8AH4dhygueJZXpZUd7kwZyH0J0lUgQYf5rep+3doyWdPXKI6bsyDVChnXJaU/753XXbtrSOFvSbSiBn27roVT/lKbgfxjoPOXCZ4pAAAA04Xre6UbKh0ry50HHGVo97hjbQbOVa7p0Mc1kXS4tpYqFeXsK7HwWI9vC6CltXDkXh6lDeoedcEkpoA2PgZc4cfURJRN6A+IhyLBe8QrILyXE6cRp7RVWccezwN27U5eBSebjDyGY422L1IFWrJ09/VCwpkcmgGGOf/LZRUNRfFqFv1vm+XrD7pFrFVCmvKLq9AGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776162592; c=relaxed/relaxed;
	bh=nRIbkosCjntd5w9JaB2x+EnTNGzBFNVO9qWoU4z4HDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CnFfcFmmKZJwAY9/ocYPKvAIv8uNvnIWIbzMm7ua1aonO6Dmb932cozL6fCKHOZq6OhpRbXlSxpaUvkpW6587+m8+C0hzX51rhR7YSEBaZuWxTTdrGhQHIlkhN/8FwBdaWjnvOZ1KcpuL3fDhIxcbOfgf2VTdLOUHU8RevfHfitCw+uo9ErT5PrNYG+GNryI49P9rMRgmXxVApMrzJKs52B/97eq/9qgoPDIQOTgj0jD6AzXpo+27o/ZzIfv6ZAo9TNK/gFXDFZCfuCd2LIDmvqdEFvLzM0UQPvgvmDQlbCdxSc67nK44EPVXDHTpI2lBxqg1Ffnsr6vahVCD+fzaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=be3GsUxj; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=be3GsUxj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fw0rv5g7zz2ySS
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 20:29:51 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLIQhi1832924;
	Tue, 14 Apr 2026 10:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nRIbko
	sCjntd5w9JaB2x+EnTNGzBFNVO9qWoU4z4HDE=; b=be3GsUxj+tekByNUvkcZ/w
	XG7HAY0mT7RbhfVGffJbTk3nAjlSFvOdkhGv7zuyi1SInhov0xvbKKXydCioW52J
	4eYE7U9p9f5eFRHrFN7RpBfxqaNuy8x5DVw/fDaHu3ahQroccGD6bygrlYnQMFhe
	NLpO9/nMw6WrOcUxKr9veQHW1g2KhrVuRX06zFVnbkF+3U2tODctHqwXluMDZvVG
	TnGXf1eVgdezx5yMjqyLZIIIrilRvzp+Ztte95hX/33TQRx9EeUxga0llPq/oTbi
	wuaR6DOAGSDTZNm8bTanDhLdcMFP48FY0RkzX9i/DRo7GCkEBCrDNzjqdz4iT5FQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89ra782-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 10:29:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63E9JPpJ031099;
	Tue, 14 Apr 2026 10:29:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg10y94jw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 10:29:40 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63EATc9H17891624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 10:29:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 083E520043;
	Tue, 14 Apr 2026 10:29:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B5262004B;
	Tue, 14 Apr 2026 10:29:36 +0000 (GMT)
Received: from [9.124.216.108] (unknown [9.124.216.108])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Apr 2026 10:29:36 +0000 (GMT)
Message-ID: <e0fec974-4bea-4a34-8b3b-2d9defca332a@linux.ibm.com>
Date: Tue, 14 Apr 2026 15:59:35 +0530
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
Subject: Re: [PATCH] powerpc/fadump: Add timeout to RTAS busy-wait loops
To: litaliano00 <litaliano00.contact@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20260406061542.22354-1-litaliano00.contact@gmail.com>
 <98adc953-322b-45fa-9128-cdbe831006e1@linux.ibm.com>
 <CAK-CEVPA-qi9CvPyurDarLT-OFtOQJDmFoe=+pE1bBBy5fuLOQ@mail.gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <CAK-CEVPA-qi9CvPyurDarLT-OFtOQJDmFoe=+pE1bBBy5fuLOQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA5NiBTYWx0ZWRfX5Dff69lmdZYt
 3UQJsgG1r8NtLgwis59qIw+Txng5awEbg+qxG8BWuPNqnCdDQ+CbX2x2a/fVPdK0zqoPLmsfBN0
 3WmhwR/8XyG3nrhDofvdTusNhxEwW0s0jSAIGrtCNriA7fjykN0732f43zuWBr9zIr8OLzCYbCF
 DnY7++7iOAFWUysngqrs58grcX01Q092bzvAeqR7C/S/ZOYoPUOYw0CgRSGEzuAlCUDXX0utw5U
 StG/2o8j1bvsPS/TbLhRCIGxUSgjMit0Oq6cartyA7VpFM5IFJXMlvBBy+QRZ0GjC/At6a9ybNw
 qy3nKDAEhfKYRJq4oE0KyfFmq+4Z3qqf2aTmDXHIdJ8ieR+ViX9q+icJBuamhujay+Wg+hmwQry
 uSUctKCzkSNUxhQ751KNz7/h1SEsEOoA3L3JDruzXEWu9Ddp9tK3/SmISvOp2OrCvRagfQUaudE
 xcgatzzvFbaipDZKmSg==
X-Proofpoint-ORIG-GUID: rX0txqulZupOavtsUAUvfVYhcePFJ-Ll
X-Proofpoint-GUID: kosgvy-PTX_qiU9hAVoHq0VnJ_-VxfEf
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69de1715 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=RpNjiQI2AAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=26oqrSpA1joMOLRANYMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140096



On 14/04/26 03:07, litaliano00 wrote:
> On Mon, Apr 13, 2026, 15:=E2=80=8A50 Sourabh Jain=20
> <sourabhjain@=E2=80=8Alinux.=E2=80=8Aibm.=E2=80=8Acom> wrote: > What is t=
he rationale behind=20
> choosing a 60-second limit? The 60-second value was chosen somewhat=20
> arbitrarily. Looking at rtas_busy_delay_time(), the maximum
>=20
> On Mon, Apr 13, 2026, 15:50 Sourabh Jain <sourabhjain@linux.ibm.com>=20
> wrote:
>
>     > What is the rationale behind choosing a 60-second limit?=20
>
>
>     The 60-second value was chosen somewhat arbitrarily. Looking at
>
>     rtas_busy_delay_time(), the maximum single delay returned is 100000ms
>
>     (status 9905). In practice, legitimate busy delays are expected to be
>
>     much shorter. I was following the spirit of rtas-rtc.c which uses a
>
>     5-second limit for simpler operations; fadump is a heavier firmware
>
>     operation, so I went higher. I am open to suggestions on a more
>
>     principled value.
>


phyp/RTAS is a black box to me, so it is hard to conclude
what happens during fadump register/unregister/invalidate.
However, based on QEMU's fadump implementation, all three
operations do not seem very complex.

That said, I am OK with a 60 sec timeout.

I would also recommend adding pr_debug logs when the wait
time is hit. It might help debug cases where the kernel
reaches the 60 sec limit especially during boot.

- Sourabh Jain

>
>     > Would it make sense to introduce a helper function to wrap the
>
>     > rtas_call, along with handling the wait time and timeout?
>
>
>     Absolutely, I will introduce a helper in v2. The three sites are
>
>     indeed identical except for the FADUMP_REGISTER/UNREGISTER/INVALIDATE
>
>     argument and the struct pointer/size. I will factor out the common
>
>     busy-wait loop into a static helper.
>
>
>     Will send v2 shortly from my new email adri.vero.dev@gmail.com
>
>
>     Adriano
>
>


