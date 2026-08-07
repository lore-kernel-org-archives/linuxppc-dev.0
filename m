Return-Path: <linuxppc-dev+bounces-25539-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9F8C5AC7A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 03:54:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGVdh3N2Zz30FB;
	Fri, 07 Aug 2026 13:54:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786074872;
	cv=none; b=SJPg+ZjAk29UweE3qXjViolu/jpcxJWMUB3LsLROwHlMqAQxvq0+P+B8+TEuVAnQma7+1vuTfw+SFpdJuJ0SmxjpwMqtwni3Uk/psIYO+qCRKpauG8UGTCDZiGS5fXk5RXgfPrGD0rPMhPg/oy63TqpyZJYGuc9GZpMvbpBt7dPo8dhS7qH13sPltJm2uomRJ2Dtkr08jgBof8jlOdJpq8tz+jQ2sxdmb7KUD3cGqj4RBWtSp0t4T65PtkXGqxqC3ubTZ01y+9aNNdUuGJkL5OFbXkPvAYwLg9g8m81CJH2y50W/RPXeVmm7DXoQBiLZm5vo7BocASJJQB8Lt6tSyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786074872; c=relaxed/relaxed;
	bh=3oWywf9E4FFyVRBPVd9nDFuhcsrdVyBGtZdVUoKPXzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GmlsxFJyABawm9iPQ/yyG2bK61ftLCRww3NwXjVy4Izt7t3nkKp5ynhN9Jyk31cdQGxiHFFlbbIz2/We4z/G8HptJhDpSGnhBSGr9/iDTIinPDIHK8IhLsEeok3uwfL1Z54UNHbimBhuhcdFqSAwj/NQNPnbk66TRjIkIWigw6Q/IFfbHdG4E0X1nBU1T7qI9a++NnG3np62/YC1tHNcANXEir7stfonsZwDChFJLlZGHkuStzIOKjwm+u/Kt3GIZckfcAS70+jjn/ZTyIMPVcVtAZDJxdnLTezd2EIpvyCkGhZoTxThDMNRnziVMPNwooNI+ZH7U4Rhwj0fkLYCgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HcaGxXpL; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HcaGxXpL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGVdg10kVz308Q
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 13:54:30 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770HiRw4161684;
	Fri, 7 Aug 2026 03:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3oWywf
	9E4FFyVRBPVd9nDFuhcsrdVyBGtZdVUoKPXzo=; b=HcaGxXpLMRnqaTxd8GuFln
	AwLuhXzjM7t/0yQbNlB0shXHscW5X1CIR/n78j5eZVtSYIDubUs7Sba610sxK7P0
	e6muN62c8xoUDdswsYeiGWIABGhyB4xLQrSV/iEgiiykzN8rsiIQAVjuNUN2gwx6
	lwXjY0HM9v18EQApBXYcGrmLdQ98s1a7VnVy/r5wjgv7hQFT8Kwrpq6EyxqzpwLG
	1YcGCEveKRhJxOjNRMsyQar4Yy24g0NbjdRjYJssZCqB3EanIGqlrpNqFn692u1Y
	gFw12V/9J/ZNXIwDN1k4pIqzBxUC0PAKfgLhdUBwevIFeilBB82p2PF/PsganuPw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvxyyt3fs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 03:54:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6773fKpi028260;
	Fri, 7 Aug 2026 03:54:19 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhp2fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 03:54:19 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6773sIZ932899400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 03:54:18 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB2F958058;
	Fri,  7 Aug 2026 03:54:18 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5F835805B;
	Fri,  7 Aug 2026 03:54:15 +0000 (GMT)
Received: from [9.123.14.9] (unknown [9.123.14.9])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 03:54:15 +0000 (GMT)
Message-ID: <7e249d0d-52d5-4df4-800c-8dbd081dad7a@linux.ibm.com>
Date: Fri, 7 Aug 2026 09:24:13 +0530
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
Subject: Re: [PATCHv2 0/8] gpio: move ppc4xx driver to drivers/gpio and
 modernize
To: Linus Walleij <linusw@kernel.org>, Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20260803223539.86303-1-rosenp@gmail.com>
 <CAD++jLmKBR=nHQ5O5URC9qmgA25X9=xYWQAx-dyRyUGMG+hKmg@mail.gmail.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <CAD++jLmKBR=nHQ5O5URC9qmgA25X9=xYWQAx-dyRyUGMG+hKmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SYrHsPRu c=1 sm=1 tr=0 ts=6a7556ec cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=wf8haQ8ew-7n_kzEmYcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDAyNCBTYWx0ZWRfX+CqrSpzsGbR4
 TsO2RbJdiITuCSmQ9NOyATViihVXhjZ61DJGAGWAKXcoRtRR8KZ9aRFWZc1MZ8+V21MAdco1is6
 Jt47i6q533H/I9tkhgT70EjQXHVcs9Q=
X-Proofpoint-ORIG-GUID: WvwbCTzeP1eMD5EubWYw4qBjQn7U964I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDAyNCBTYWx0ZWRfX2pEwP6FzbbLx
 u1TwTF913n5fHprjDCSUbeWNW0FOiBH9l2omjJtqFFNwUnBNDzrGXja8g6hR4obHIhPA0wYTdVV
 y8OBaH1jvIGn1AIgUD4uA14vcdVKsn5tZUpvL17Cndffa5/lYReVeTsYoM0/FCw1rvq7hd4meaR
 Rm/qlcLaeRU3nlbzf48sIWH5OD1o/6NcH2xURTJtoCF5J2sOu2e+BXNGPnrYyVnFF9BDWSIJpfa
 DWIAxU9Ei/4L58n9OpUzjfRz8oTgGfBk6i6X5o3LoOSQXnZzdIxBTrVfGe/mFT8sYKQ4rJIl6hV
 qYCDFo5T6Nr2NOQ82TmgWMlVmgKIOpyS97P59Qo/6/6TDqyWVFLK1OJka5mQaWn0ecLoIl5F7+2
 H4kvyt2cQl1ZrMcvSZIXvEYO5ykUTVbZyPUNKRxGxmk/ktEGNr87TxuG/oRy12fntAt7aAsZKqZ
 gV3Ewf+ywR015nFCOpg==
X-Proofpoint-GUID: JXuSyszOSKKI5keZsCMq-WgaEQageF5v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070024


On 8/7/26 3:45 AM, Linus Walleij wrote:
> On Tue, Aug 4, 2026 at 12:35 AM Rosen Penev <rosenp@gmail.com> wrote:
>
>> This series moves the ppc4xx GPIO driver from arch/powerpc to
>> drivers/gpio, converts it to be a proper platform driver using
>> generic MMIO helpers, drops architecture-specific accessors, and
>> prepares it for module build and COMPILE_TEST.
> Excellent patches!
> Reviewed-by: Linus Walleij <linusw@kernel.org>

I will take this via ppc tree.

Maddy


>
> Yours,
> Linus Walleij
>

