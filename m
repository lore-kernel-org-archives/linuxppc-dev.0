Return-Path: <linuxppc-dev+bounces-20997-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC702CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 May 2026 05:56:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gHYG96hvHz2xlQ;
	Sat, 16 May 2026 15:56:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778910961;
	cv=none; b=lxSBO2MUwaq+zNtjMK1cJwuC+Fh7XEeVYT0kpAlfOzM3cKRQl2RV+w/i7TAGom0tE37J/hjh5OA+j3kW3UdafD9iyEz3XNrlnLAH13Aj3NuUugLh78K5ihkmtmNZ8gyT1QV88l0YAede65SVRjN3Jg62ZaPVyAMXE2P4ZfuFQ8O2s+mJUa6iwjBNchLbSo0sA2AwGvc0/ka1VQTWK7HUVh+Hj7zcWQ9dQZG6bePTdfESR1d7Fc1I6fPXo7AtSEvJrx8A8TEWU/kOhxvBmmVTU5F+QhtZFd2acJ6oLQjEXTQinCTlOPsU3gcGu915q0mkNYKQh3w/WhfjuK6QmpBr1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778910961; c=relaxed/relaxed;
	bh=oSCe7T6KwKMEFQoOxm9meIpQXoSdzp7Yuk6EVXXLXXQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=gdke7w+KLO28OjydV2Lf5d6cDUCtESlxv+wbfXhf1bD3uaghE58JWi3E7/4pgW8XrLAUupbtbejVmgFpFD6uDLGaOdHw/5xmO9WmQwqzJgNtWFhWA0KvFJvv8TcUlnKI4MIyceQV0/Q28VJo2l5eLN2/vMMs5MMP8XURVfiKyeB7HfzuUCKxV7H2WEshNw4KYq4woOrZkGJj86Bco7GH7T2z4P6A03j+4QoZq3EkA5nG9NqIe1rCgCQR2aD/F/5GhRcTckir4jrooHOsgqE8P9HQw1ExPHMYkNffI36SbrNrM3l4nr7msRZ4/+vDIf/bPPt/uG3wHcvJRqT/VeMufA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VjGXHwsA; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VjGXHwsA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gHYG84bsdz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2026 15:56:00 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64G4BEEt144026;
	Sat, 16 May 2026 05:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=oSCe7T6KwKMEFQoOxm9meIpQXoSd
	zp7Yuk6EVXXLXXQ=; b=VjGXHwsAa/WLC3ZCyY43MSCdKeltW2LlBbcWepzgKE+W
	Ub5aPht6OqdLOWb8NmSrfs/j+PNeBimnWwqF0mV7HKnp9QlwUopaqooPFbzvsaxn
	d08TR4uJwZrN9KWxkdu0kZHTR8dRH2rVwL5J3w7n3ltGx9lAEGsONXzCMbWF7fL1
	E+IixNxQJNlY1Nf71P9ioLpDRDrNkL34rwjA0h3pkx2oauNHAow8IobVCIAk23KV
	uGeF3r6W++jAzRdrLr4FXeWJkqFr5fVKJHp9agcs81hEZoc1JPaeOYwcEromjLji
	8pPvsTlP5NGYgXBkMgJIH787026VyDwA+QV+9sPPwg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6havr6rk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 05:55:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64G5sGgs031257;
	Sat, 16 May 2026 05:55:38 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e5kvcxufk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 05:55:38 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64G5taeS31851144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 May 2026 05:55:36 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7782B58052;
	Sat, 16 May 2026 05:55:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7172758056;
	Sat, 16 May 2026 05:55:30 +0000 (GMT)
Received: from [9.43.103.83] (unknown [9.43.103.83])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 16 May 2026 05:55:30 +0000 (GMT)
Message-ID: <6d0bf34e-af80-4b1e-aae7-9d2dc27fcc25@linux.ibm.com>
Date: Sat, 16 May 2026 11:25:28 +0530
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
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aboorvad@linux.ibm.com, allyheev@gmail.com, bvanassche@acm.org,
        christophe.leroy@csgroup.eu, julianbraha@gmail.com, linusw@kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        make24@iscas.ac.cn, mpe@ellerman.id.au, naveen@kernel.org,
        npiggin@gmail.com, sayalip@linux.ibm.com, sshegde@linux.ibm.com
From: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-7.1-3 tag
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDA1MyBTYWx0ZWRfX4jQzMblXGI0C
 q/gdvd2QfU6f5lW5bVbZmhKBpcqjtWJKnocodrsYUSQIMV1IO19hWuzLp/PMZ24fuMHmPr8pGUy
 x73SCXtrUlt0w+Zf+N6nDbtixxcfDtTBfkGNaL/l7n0SZYEXuLsd2O7tsRT+tIgj/juzOhW4c8C
 8CZ2pVswZv9zO3xvt3duhzDOua4EnYv0qLmlIz74yl502S9pi3AhTkSHRb7UseaSonWdM23QPfS
 XW6f+6Cg9fj1ZN2pw4JDWHDq26vIPn9Q7s7MqH+OjN3h4I5vCvfUpB09UC0S7vyniHqqeJfDaSB
 Zwib+lfCz7W5gIlhIaleq4uEAT2whKjynwlr2BtvuRRHItWLdxB7F7BWxqJGYr9MxuD/ia2LrQn
 jHHeNg4oNUcI5KrGNdtabuS3+xHYPx5wTgpF/yyHQb9JZzspssfY65AiuVkt6YEm0JeI/awsjDb
 HGaLmFcCa/dRHCqWvVw==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0806db cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=Q11UNI08Q5sTa8sdzmEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xm7IaCUN5UNJQORe2qz90Pfr7VwtRMxb
X-Proofpoint-GUID: szDUMMC9IUAlu9NfUAQ6FG7n9KXAxRkQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605160053

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Linus,

Please pull some more powerpc fixes for 7.1:

The following changes since commit f583bd5f64d40e083dde5bb22846c4d93e59d471:

   powerpc/pasemi: Drop redundant res assignment (2026-05-06 07:49:19 +0530)

are available in the git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git 
tags/powerpc-7.1-3

for you to fetch changes up to 31467b23823ffec1f6fff407f8e3ca9af8b7491a:

   powerpc/time: Remove redundant preempt_disable|enable() calls from 
arch_irq_work_raise() (2026-05-14 11:15:26 +0530)

- ------------------------------------------------------------------
powerpc fixes for 7.1 #3

  - fix preempt count leak in sysfs show paths

  - Fix error handling in pika_dtm_thread

  - Remove pmac_low_i2c_{lock,unlock}()

  - Enable all windfarms by default

  - fix dead default for GUEST_STATE_BUFFER_TEST

  - Remove redundant preempt_disable|enable() calls from 
arch_irq_work_raise()

Thanks to:
Aboorva Devarajan, Ally Heev, Amit Machhiwal, Bart Van Assche, Christophe
Leroy, Christophe Leroy (CS GROUP), Dan Carpenter, Gautam Menghani, Harsh
Prateek Bora, Julian Braha, Krzysztof Kozlowski, Linus Walleij, Ma Ke, 
Ritesh
Harjani (IBM), Sayali Patil

- ------------------------------------------------------------------
Aboorva Devarajan (1):
       powerpc/hv-gpci: fix preempt count leak in sysfs show paths

Ally Heev (1):
       powerpc: 82xx: fix uninitialized pointers with free attribute

Bart Van Assche (1):
       powerpc/powermac: Remove pmac_low_i2c_{lock,unlock}()

Julian Braha (1):
       powerpc: fix dead default for GUEST_STATE_BUFFER_TEST

Linus Walleij (1):
       powerpc/g5: Enable all windfarms by default

Ma Ke (1):
       powerpc/warp: Fix error handling in pika_dtm_thread

Sayali Patil (1):
       powerpc/time: Remove redundant preempt_disable|enable() calls 
from arch_irq_work_raise()


  arch/powerpc/Kconfig.debug                |  3 +-
  arch/powerpc/configs/g5_defconfig         |  2 ++
  arch/powerpc/include/asm/pmac_low_i2c.h   |  4 ---
  arch/powerpc/kernel/time.c                |  6 ++--
  arch/powerpc/perf/hv-gpci.c               | 24 +++++++++-----
  arch/powerpc/platforms/44x/warp.c         |  2 ++
  arch/powerpc/platforms/82xx/km82xx.c      |  4 +--
  arch/powerpc/platforms/powermac/low_i2c.c | 34 --------------------
  8 files changed, 27 insertions(+), 52 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEqX2DNAOgU8sBX3pRpnEsdPSHZJQFAmoIBlwACgkQpnEsdPSH
ZJTIcQ//RUVp6NY4tj5f2NsBZqo62rUAVWCaCFYSgBe0o0oSLU16uRUdP8TJCtYh
As4gP+sgNR2gP5bvURX9HwryB/7hQaJ/nLxehCY6WTg3C1I163BQZqzvcahBrw6Z
D5A5YhAi8ECFgwkWLf8AMShzER65krnFLnWmldmxuvbvGy7KJAUTgQZ6T+HilIoa
I01abDV7Lsv6Tu7bKjiuJLilGZjxWHbLII2MEmvK6OKTrF4od+VuC8cXsXDbG+Ks
9OA9jxz804Lo1fTvBHiZFLZYShaexnzoSmf6XDKP+/aPjg9HW6cYCm0AgukVdoW/
B/khmVdt5HcjJbnaoioifh3GXEZHOZO5GjsImXdQpdRJe/rQMkG99uyoh6t5kA0Q
c9k8UAT8FOWwtk1KzHn3098jZ7szGgPcFH36LCYPWUOnI+w9wFVA3lVKnwW0CKY0
RgAhPqcfwxwtCtNs+76eAZvYM89b9GFtv+v9Z4e5EaQdAUrG1zrBOo90byUuTdDy
M12CZnnqB46KdZIekPHhrRuDQ5teUCY4FqV5302WYZvf+qtb2UfY/rwrHUfl1yQJ
78tDAn/mryI17a+0DBkUo5mZlA0/u6WCn6wiJazunbVlvgRVM7+1nEmFNAuZlkSi
K3eBhzWT/WigrsvCYh2o15GyhYoNgHR5V3U0wBLW7ZEO8Gu4meA=
=ipJ5
-----END PGP SIGNATURE-----

