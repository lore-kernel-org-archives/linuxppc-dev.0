Return-Path: <linuxppc-dev+bounces-21026-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA4ECD343F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 04:44:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJlZY5cRrz2xfB;
	Mon, 18 May 2026 14:44:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779079461;
	cv=none; b=QESYgWUKEAv5p3jmJ0etmfYF9Rz/6MGjK9JXk+SEPGAvNxA/iJUYnoUmEZDqjNjceftJ2LgNtj6wMz7nrOn9bRGJWP8BolXvGCidftwedJwi5ZJhlDyEc0D9+4BkzudlpkbjtRvA85BwRbFGDoM3n/qilaj3bLEnuM0Svp8f2qDEgd7IC0WKOUsSXzHfKJmrzNmOLjtriacWm1JUbzUrUB44RxB9kxZCgZ1vPS5A+hGQrJECOyC881h+j3/A79x5382QsayYSBEDYNtw19xdE2En+z4w4e5SLRTJnQBf8YlTJbxvzf1Hs6ZOwWAM9HK9CbgVd+kSwiaQcN6H8IBStA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779079461; c=relaxed/relaxed;
	bh=HamLZEp239TZgkHmy0+6e5I4NJw5ztecqIRxR28bPp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rkzfa7EzQ1WSH2+pkAXC5KssfZ40ztCrfCX/PvziVB5227veJ2GChpVzbA8TXB73IkkbJLZ/fvgxgZ1KBdn1NX0L5U8vb2tNADTgFEB4u/VT2/KL4vmkVOPMaWII4VfUMrbiVraoi4KLZtO4p69mEfn/7wFdNcg/4m6R7i0IVfDRW4Tze5e4W3WxakAZZwZkVzi6DptkDm1/ZJ7RgIPJ2bsXAf4bht6yQxYaRFgcbvMMTHpU/vhGymTZSoa4gI4uNnuQjxBYBgDHNKGFjxlQaz44eBYjz4EsZRIS/25rF3Ddt5nbBlKbkbr0lLaQU/c+LCfI6lv80yWH5hwPLG5OVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sc3UErXU; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sc3UErXU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJlZX09mFz2xWP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 14:44:19 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I3nRhM069465;
	Mon, 18 May 2026 04:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HamLZE
	p239TZgkHmy0+6e5I4NJw5ztecqIRxR28bPp4=; b=sc3UErXU4Gtz6sE6C4BjDD
	Zct92naCoZH6v9sijxJeoydt66KqgCzp8J5KjRKjweUfLJLLw8fgmOkfgCoi5niK
	8bB75WVOpNCxZM6iCUDSk+lMECarKBXzly6U3NamkiA8JmdqL93fUxfu8SgYZ4iO
	X6JAnpLjFZRan83e1VisVoV4XDd8iOOQVuH8U1BCYPep5WKz4PCh2b0skgB8f2gQ
	PulvZUI1x29oQ8jVXz4i/R2mQlRt0BgfC8HLQnDh2P9zCH7qo/m9CZT/HeMoq3UU
	VZHOV7nqR1a0bTpW/oRSdkhDAmZ4WeBUkN6l9QertRMWZaBhXtk13Z1jbuDk90ZQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8me64s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 04:44:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I4d9uV021389;
	Mon, 18 May 2026 04:44:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739vm9bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 04:44:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I4i4rY47907086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 04:44:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADEDC2004E;
	Mon, 18 May 2026 04:44:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7344220043;
	Mon, 18 May 2026 04:44:03 +0000 (GMT)
Received: from [9.123.5.233] (unknown [9.123.5.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 04:44:03 +0000 (GMT)
Message-ID: <0233138b-57bb-4cdf-86b9-8a48fa8b54c3@linux.ibm.com>
Date: Mon, 18 May 2026 10:14:02 +0530
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
Subject: Re: [PATCH v2 0/4] powerpc: A few misc cpumask changes
To: maddy@linux.ibm.com, chleroy@kernel.org
Cc: linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        linuxppc-dev@lists.ozlabs.org, yury.norov@gmail.com
References: <20260427044715.559137-1-sshegde@linux.ibm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260427044715.559137-1-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Zokar5nU7Vtah9k8N-rgeokwIphCipFg
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0a9918 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=PQsHxT7xaXkNK9Fa26gA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-ORIG-GUID: JMKCCp5x6alCdm1wCm6yU40ECtVCuqhi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA0MSBTYWx0ZWRfX3Dk8sb+g1kEx
 USC/BXO5RNZ0w04q+K+iDbPL3jCJGjj9FZ0TiumONXTKdu6F59kQrhn5iuEWM6VU2EuTTvQgfP/
 2xcz8QKJruliDciyYZCrvxFoWlN7E3t7a47zGrStlzYqJsoW0ksqNBlbKTx56JD7T0Lv2g9gZSc
 liDp6AZJ77Pwf5yqWbq37EJ3F/5dS2uVng2LZQsOyAtR6AN3Re+/My6QZgr8DSQzBi+fIO2HllD
 R/VE6trxp74p3UYtuIDdZyDkpyyiNG4V86Jwqy7Ov5f3TLamTMWOVya981MuiCW4haXftU/7t/q
 9UmoVc2bSX5K3VXclaXa50MrkNBgRDvlAkwJxC25t2SCxkfLpGZD0fx3QFL8fcggHlyeYrauS5+
 RNC8BxcIkvu6ZEXiQUvZzvKmfhWRqZ94ZHWigujCfviIv1/8MIUpm9YwzftgvXxsiL6n1JzmiS/
 Hi1Jihm4yqIZ5OS4ZXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180041

Hi Maddy, Christophe,


> Based on tip/master at: (dffc5753ba4c "Merge branch into tip/master: 'timers/clocksource'")
>

Gentle Ping,
Still applies cleanly to today's tip master.
  
> Shrikanth Hegde (4):
>    powerpc: Use cpumask_next_wrap instead
>    powerpc: Simplify cpumask api usage for cpuinfo display
>    powerpc/perf: Use cpumask_intersects api for checking disable path
>    powerpc/xive: Add warning if target CPU not found
> 
>   arch/powerpc/kernel/irq.c             | 5 +----
>   arch/powerpc/kernel/setup-common.c    | 7 ++-----
>   arch/powerpc/mm/book3s64/hash_utils.c | 4 +---
>   arch/powerpc/perf/imc-pmu.c           | 6 ++----
>   arch/powerpc/sysdev/xive/common.c     | 1 +
>   5 files changed, 7 insertions(+), 16 deletions(-)
> 


Do you have any comments on this? Do you want me to resend with yury's tag?

