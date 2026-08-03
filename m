Return-Path: <linuxppc-dev+bounces-25216-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C6EC55162
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 03:10:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD1rp3Ywmz308Y;
	Mon, 03 Aug 2026 13:10:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785726634;
	cv=none; b=nvOWGunK0kwtibLVQSs0g14DemnDWtWTJHmKaCEF3PjBd2+pzKqvpyZcKCN1DfdOtIzgN4RMNkubwFoY1JSEXJJtzDuVUkR4dXVFE0LOl7uejSENGdI/ckDWhV4GjoxuzGLbzlzPHC9Mme/h3ii7jaxAmfht0iHMjGTKA0bFyorq9aFNTBsnsRrXQF2bZgg9mNUoi6ev3JitWHboZbjELf2+QJKuOnYogZkJH/R19WzY/BuGyQLeLV/KlnATby/Q0Vfa5dzBO/OWA1+g8SBME99kRned6QBAjCieSVJjejonuyKCFMMzJvgZKln3n5xAq7PvkmthGh6ZO9XmoVYWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785726634; c=relaxed/relaxed;
	bh=IWXrHrFmvIk6fgZCtko64pQRD5Nym9sLqTHsflR96MI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PDSm0wFxk+z7aSiCMBqSy5XknK4Pa+dCRSyOwf69tuF7IcvVK4CHuZh2M6+wg6G2246yqgfQW4s478l+StZrYqfKj4vpOB27x6LcNZx2IURKeNnq3pm/G6tFOJHj1o7Yo4qIzs8o2gk1dOMAgFAZeZwBKRyPB/W9dUqoqYCWyS5yf0ikgjBunBLpAbbxp+hIpnb9WahtA1AdO4PDthJ3QtdNPc5IbpOsTAzCHjMamevgXjUlOoi6cv2h1ykr6gsHonZ4lxwd7NYyhh025/kipL9TtIjX5hu2+xdcwc0qU71fMa81/AZqQmCaseA9jBgTpSUe7oVBaT5XloQUV04iSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bahi7B27; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bahi7B27;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD1rn0RPzz2yhP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 13:10:32 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LlkXP167346
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 03:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IWXrHr
	FmvIk6fgZCtko64pQRD5Nym9sLqTHsflR96MI=; b=bahi7B27poaP7N6HPHem7U
	fRJ8KiBzw7o1mAj+hcNSdDWxmz+OhNI5JqNgvIXc+prAu4XnCfy2mGJTS+7FRZsT
	YXvU2VpxU4NrYNNznYK8dd3V4qTuwl1wEiXjlNgAuGKeW7SIbV0Sw7pMt0ejcBhP
	pMZCAsqMhOtOxeU9pUFhDRFh8IU6JRLWRyB4mjZgJ+9A5rtUCcKIbDKFyWmhpKuo
	6l50MuXvteclah8zLH4aBmjU3oEKWA1qzjX9i5tDgtGulyjfaQksjxQdIkwCW7YG
	7lloTOf+wtLEATy8Kf6iG2dNCB0b1E4Umu7+rOhrlNrJEAP9uMO/SnwtkvxCMR4w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77fxfak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 03:10:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6732uV6n012380
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 03:10:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvuk7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 03:10:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6733AQ4J32964954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 03:10:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E7DC20043
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2026 03:10:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 688D320040
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2026 03:10:25 +0000 (GMT)
Received: from [9.67.71.90] (unknown [9.67.71.90])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2026 03:10:24 +0000 (GMT)
Message-ID: <0c7a7137-97ec-458d-bbd1-949b823cdc00@linux.ibm.com>
Date: Mon, 3 Aug 2026 08:40:23 +0530
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
Subject: Re: [PATCH 4/4] powerpc/perf: Add power12 Base Performance Monitoring
 support
To: linuxppc-dev@lists.ozlabs.org
References: <20260729145405.3230272-1-mahesh@linux.ibm.com>
 <20260729145405.3230272-5-mahesh@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260729145405.3230272-5-mahesh@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDAyMSBTYWx0ZWRfXyAW/mMo4P8mK
 hYyRTweVaPT32uQ9KIOWNAC4zC6M3ZTd52Sa/wj+/nfYUQhR/ZVxR5NOxwh7om5TzNsydtl7vsl
 1CZNGzlzjZMGbWWnSt6C3t/azpb1wZC2o6A58ojV7WeRxRfxLSDkUYhwYZtx7VfU/I1oC+xtybW
 +hS+bem20+60u6F7X7bxMfPH0LXTBPp4t6u9Ji3Z+ftHJ/tS1DwfSY8I+0aRgti1MOvfOrSdcdY
 /Es4GW5unh5fpbLIJQOMogTWWjAXoddlcuUKYnf0i7+EeJoepQG99ZX2B8YCV1E2SxiuVR44JNp
 s+/hq2JunZ+1ZeXY9z/1bcj9mb2G+f03vfzvb6Z/eb2LvFnHktN/AGbRUH5F9TwyBZKtm9uP3l7
 IbRgieoIMcD29ooXJgjPRtuB7voYR7meGrKlvmTsBXCtHOtv+BQyupy55hzGx7yFamFVxZHrcDS
 2br6Vxj5Q197dU59mWg==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a7006a5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=amrY7hgYzxrTlAAqMI4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HiW8sfslwF93_F-2yJVLSywzThZQjFPO
X-Proofpoint-ORIG-GUID: HiW8sfslwF93_F-2yJVLSywzThZQjFPO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDAyMSBTYWx0ZWRfX2PfJ+OM6+C0m
 TjLYDMPhLsXbka2I3dwhA+OwaOGdi2U0EOnsogclTGWFu+UW1iA2rv/RAd6Ibk8cYh16xELhdlR
 HAFuUwvCHpEAB/JtNan2xkMIpX8vgKY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030021



On 29/07/26 20:24, Mahesh Salgaonkar wrote:

> +/* Instruction Demand sectors wriittent into IL1 */
> +EVENT(PM_INST_FROM_L1MISS,			0x03F00000001C040);
Hi Athira and Mahesh,

There is a typo here: "wriittent" should be "written".

Thanks
~ Nikhil

