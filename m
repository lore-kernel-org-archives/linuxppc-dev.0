Return-Path: <linuxppc-dev+bounces-21059-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D37CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 05:44:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJmvJ5K1dz3dJB;
	Mon, 18 May 2026 15:43:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779083036;
	cv=none; b=fu3zDCcYbI+S9lzkYFtyZOG1FRUygL5OWSAHo1s2KO4lcz17e62BevILx8SUykTKR0hzmkwe8+IaRcrlMdQm2jN2fsGA1JNTdoawYCYWQA4brvo4PggU9nc2mfr2PIR+mY1piBQc2MRFBznMVp43YR2JpP5miIv2U+FnAS4KKzasSf8Npme5MORrrMZi8Wm7eltAsTXbiWCSXmKIfXPdp4gNUfBYDVUeRyeT540jjYpT9M9pl/ir6K7EvM07FZSh2CZChDffwB3akGEjY9fPCdykILnbyvRoiq9hHzPOGrpWEoQhXRgCm8rv1rj61HhS2YlhrxCZwO5tHqqfKQz3hw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779083036; c=relaxed/relaxed;
	bh=dCFZvuaa3yEwBxpIAy+fJUhRkspJAlu76DlmxoVmb7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RBMDXXol2aOnxxLtztoQfHA5Jpa2KRgK6E9wcBqMQ3Q00mveFGxKi8r37+5DZVKnbaMsL1xzxIZC3ebzAacFYf+AyHWjUW+83lR/pkuA9IHfMP/XTdivP/kefgIItlipUCLgsYrdhETKL9WnF/FwY4PudAqlsyIlfbmX5qxVUGoAoVK6nhorIIxhOBCA6NHnPSI/3Aq2J6AFCk6pi9uqudawq2ORMPWOWYmSB37f5tw/4rPpLiGspPaD81+056yVBI5YxRynKoUFeKxyOR/n/wAv842iM223W4oyxeQNgjP4SUoGamMZ56emqvnlVY+/Mj52xHNjAJih6yib4t3NdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k16vRzUf; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k16vRzUf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJmvJ1Myhz3ckc
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 15:43:56 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HJK1nC1765513;
	Mon, 18 May 2026 05:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dCFZvu
	aa3yEwBxpIAy+fJUhRkspJAlu76DlmxoVmb7g=; b=k16vRzUf/98lmkdu9vVFF9
	p656lljRN1YvSmC6EDb/DG5nM0pew7EgDwsmrOyiF+TS32rSevua0DcyrqVOI5zO
	jQX2v6nNDOHQ10CZve2bVs+YgX1u5lbWXQChTKIZcgCi9gigpDR39mAT2VUl3PiM
	N1p4juzF6meuwoPqFNPj3Bm0ZIgltpdIaXS/m9GaV/yuqovYce4VK9jvkNfNasFl
	Xf53RQTItTAJre+2VtG6kE78kuq5oaX9CUsUq1tklO/82IWXD4kKyKdBNDsOlAAg
	Xlts9wWY8KmqeEAY9T8WAc9YMKlfXqQgTHMxvIqvEJiyRpM9cjEA1HTK0lAxAFmg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h74pcju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:43:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I5dDvk020342;
	Mon, 18 May 2026 05:43:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739vmfq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:43:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I5hlrW48562532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 05:43:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5FAF20040;
	Mon, 18 May 2026 05:43:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0DFC20043;
	Mon, 18 May 2026 05:43:45 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.43.25])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 05:43:45 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Sayali Patil <sayalip@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>, sshegde@linux.ibm.com,
        chleroy@kernel.org
Subject: Re: [PATCH v2] powerpc/time: Remove redundant preempt_disable|enable() calls from arch_irq_work_raise() - part1
Date: Mon, 18 May 2026 11:13:44 +0530
Message-ID: <177908291164.287704.946864101583283799.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513081413.222490-1-sayalip@linux.ibm.com>
References: <20260513081413.222490-1-sayalip@linux.ibm.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0aa719 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=5fE_oDf0d45QwMV1dU8A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: cM5D_xOJhpqxO_36MybZQGzX3kPENfcl
X-Proofpoint-GUID: 2j1hzYoP_Y5VHTh1Zkvci9TWHFjApWcG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA1MSBTYWx0ZWRfX3fkAKPd7D8TC
 Rm5THJ20ykhgL5uWAUJFy4Cwdeo53EVtJEWeD7r+bIIspBjs+PXp+VGtqlQDsaXIeg0dPt8Ivmn
 ElSeYtlq4ALnAYp0Bw1rGvSCRlm8RxeqXekq3LnNrNt1fft0r+Lga85M77uRqCl9GYsRg8mWiHU
 i01rFcvce7FPhlCXo2HPfR4lROnfUV5R/2aOKDFO9ZkD2jU8OOPyl7G/iHsM8CW4Cwedwkhvadf
 DfbOf2saRhhgG6BMwo88V3iDFWUWYXR423sd80g9oaPIbPSxXbvsKGYrqhWd37jtn+NQyO8LFJv
 OlewwMBiWGBxl38+pn7rlvmCsJ0WEC4GNd5iLtxRXaEBD4maBI2no5+KSkMclF9e3Kc2G3VIvjd
 dcY5Du+ruSTrK6MToEU1gF4sy7g6EzdsYokxWbmy+EHyPM3gFWWh95IR2iP06FMEHuMxanvVZ4z
 L2Saj439E93New3xKkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180051

On Wed, 13 May 2026 13:44:13 +0530, Sayali Patil wrote:
> A kernel panic is observed when handling machine check exceptions from
> real mode.
> 
>   BUG: Unable to handle kernel data access on read at 0xc00000006be21300
>   Oops: Kernel access of bad area, sig: 11 [#1]
>   MSR:  8000000000001003 <SF,ME,RI,LE>  CR: 88222248  XER: 00000005
>   CFAR: c00000000003ffc4 DAR: c00000006be21300 DSISR: 40000000 IRQMASK: 0
>   NIP [c000000000029e40] arch_irq_work_raise+0x10/0x70
>   LR [c00000000003ffc8] machine_check_queue_event+0xa8/0x150
>   Call Trace:
>   [c0000000179d3c70] [c00000000003ff64] machine_check_queue_event+0x44/0x150
>   [c0000000179d3d30] [c0000000000084e0] machine_check_early_common+0x1f0/0x2c0
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/time: Remove redundant preempt_disable|enable() calls from arch_irq_work_raise() - part1
      https://git.kernel.org/powerpc/c/31467b23823ffec1f6fff407f8e3ca9af8b7491a

cheers

