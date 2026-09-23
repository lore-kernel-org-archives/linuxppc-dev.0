Return-Path: <linuxppc-dev+bounces-27961-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC60BC98302
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 06:15:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqRX62czRz2xs1;
	Wed, 23 Sep 2026 16:15:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790144102;
	cv=none; b=FpBEY2RJUbeM6VVaOkQY3sQm84O3CR1i6xKETyMRsA2eaWNE5R3DpIJs8lV18Pmh9N9/5ej00KJ53w+A+Ue6iB2Mih+EvIDM/dS+kdEKkkVaQVajhZMkt0ZgCxVFpYlj/x2U2no8Wopl62Lw6Y/C/VNYXMSGfL0+Q6HAw9pWCsDowCTfalepCmxJTGNPWcDgOjt+4KpJb/6OU1OFhN5tB1i2ODRJiWnGhqtt8bhyIlhks7rsh6VP0bEhCoOpTdrNMuZYK02yNy870gEMeaowaXcc1Sd508o+wuN50JiyCVOl1BJXl7WAyjy7onvFDH+9nhs9Kt37MShxL2uXI1laEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790144102; c=relaxed/relaxed;
	bh=tThlscAIBYYjehZHYLZww9EPHzyovFYUFt7eyNMPnWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4JNOdIutTcoopB2OEfAVKTZNrd70X+tjK+o4MJshQ5fsQ77nYTUudx0cYyqEku747hHpIPn3iWQ5gDrz69HkaNDd0HylkIqpQcqBgw6bfhh45hIHzcKZy0PD90UwDfDe/RByuHrZ/sxh7xA+84NGxktivuuZIyUrR5ch6bh1GUWlmrOA5mtojpiBbIMO2A37wwJPZxmlSUuBPMKhSzDGu4Fw5mTK9o6P1zIB4xjt69jN/FBGUvP3mrKzTvakwj+6/meAmbH5BFaEPvrqSrgvQKtS096Wv1zwEsCqFJGnljdN+lr4yn2iPq5dBOL4Dp38zBMv0BewiupFdp59dYwmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f+CChofh; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adityag@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f+CChofh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adityag@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqRX50qLjz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 16:15:00 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N45Vt62384448;
	Wed, 23 Sep 2026 06:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tThlsc
	AIBYYjehZHYLZww9EPHzyovFYUFt7eyNMPnWs=; b=f+CChofhgyJ8lfF8h2ytVz
	Rj5Ie9xYUPZRZ+vgsAxGMn8SiBR8fNcXY0WDQ+yybEtPDyG2gIIm0GJKZed8MWMO
	7h7WTngB6SYugsSFW5F8R2EDZNczvaCNRd/Tc0YtsJHkm/hIP6whN4mzZI1FOjpM
	w2d1p7gq2j/MFjWuw0cDN/p0C6GDJS2p/m4B6FDBP8ou/4geE9sxdkiLCnZh16yP
	ZdyXxrQ+FR3P+hFGBALgqVSLgSLJR/RwxM1HhAmpBFUlVtYLOgjqX4BXol3AwjwI
	OLVE9O99TNqkc/VsBptXXGWRy5NmNgEoy9Ek/1ZFtrvSLhZQKGIkLWRvuux17Tyw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv95ue-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 06:14:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N3lZZh3898093;
	Wed, 23 Sep 2026 06:14:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qqd5eq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 06:14:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68N6Ejpg13173084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 06:14:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D88052004B;
	Wed, 23 Sep 2026 06:14:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8794720040;
	Wed, 23 Sep 2026 06:14:42 +0000 (GMT)
Received: from [9.111.20.163] (unknown [9.111.20.163])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 06:14:42 +0000 (GMT)
Message-ID: <1522da4b-b772-4278-a59e-c727de5027bf@linux.ibm.com>
Date: Wed, 23 Sep 2026 11:44:41 +0530
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
Subject: Re: [PATCH v2] powerpc/powernv: Cache OPAL check_token() results
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: chleroy@kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        mahesh@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        sourabhjain@linux.ibm.com, thuth@redhat.com
References: <20260626123534.396456-1-shivangu@linux.ibm.com>
 <arD9skpQHxR6a8A4@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <c0cd49cf78a1f1ffe8768c48785df0c3f6a2f528.camel@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <c0cd49cf78a1f1ffe8768c48785df0c3f6a2f528.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: cahu8p9HCVM70Irmp_58gTZzuOrU_-pw
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAyNCBTYWx0ZWRfX9biQkG3ojswO
 U6QS/g9Q4nOSL45e3RKq3cl0eL7d43gTYMlbGTKCJ3dMgoOe00t40rubVfJ7aw74teDqqCi16uF
 O4Jx3ikPLLPGXI/b/KbsaX9dgkOfqkw=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab36e5b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=giXSt0XIefesC8dGrNAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JoGzYg57dvOfGJW0BDbFF_k4BzjFQl6c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAyNCBTYWx0ZWRfXxR7/MA1fg9mQ
 NPjdwjaJ6U/vxIv9jcV55d6YLOgQw1yj/4ipEM3KRy2g8gseJN/9pieMmpnNo3y3sUzpeRR7vY2
 TvR/C1lJsqi7OmiO7vUJicTRWsGvnykfCHw1Hwzf2kGBBjX4AECwAnPV+17Hb8jrTDSw+iFgLfJ
 /4nk60bcigkxn6gWl0cAqd6n0NbopuEkkJLWlh/qVHVAxscILJncJ4eZytwYj/YpbGer2pa3UFz
 9g6hvDQaBX/ACCjKk3mSN23Mo/jdS0K9zVfUm6/AQQRHnyFMwE+6BFhaggxCYCL9htIvUL6AlTN
 nPSkF/8ZtwVuk25k08GZ5IekEezikPIXdbDBzt4c+cKlLvtuk9h24Aev83M6QelGiJSZToNYYUH
 +PXTOQtRbbEUVRZcLwVT9j1u0PM945vrZzUn3HzSkGkeeyPn9FxjNvtcMFfOmz6z+k3pAFxxmxm
 Un7l38OaillaaQDplXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230024


On 23/09/26 11:43, Shivang Upadhyay wrote:
> Hi Aditya,
>
> Thanks for the review.
>
> On Tue, 2026-09-22 at 11:06 +0530, Aditya Gupta wrote:
>> not a suggestion to change anything, just an observation:
>>
>> based on this in skiboot:
>> ```
>> void __opal_register(uint64_t token, void *func, unsigned int nargs)
>> {
>> 	assert(token <= OPAL_LAST);
>> ...
>>
>> static int64_t opal_check_token(uint64_t token)
>> {
>> 	if (token > OPAL_LAST)
>> 		return OPAL_TOKEN_ABSENT;
>> ```
>>
>> along with other usages of OPAL_LAST in skiboot, OPAL_LAST is being
>> treated as a valid token.
>>
>> there are no handlers for OPAL_LAST and kernel doesn't do
>> opal_check_token for this
>>
>> I feel the logic should better be fixed in opal to not consider
>> OPAL_LAST
>>
> As per my current understanding, I assume OPAL_LAST is meant to be the
> length of all valid opal tokens, Not a valid call itself.

I agree, hence the current implementation looks good to me.

Thanks,
- Aditya G



