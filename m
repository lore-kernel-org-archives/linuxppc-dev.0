Return-Path: <linuxppc-dev+bounces-20823-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791F5CD484C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 04:36:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFgf80nSkz2xld;
	Wed, 13 May 2026 14:36:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778647008;
	cv=none; b=EL80yc7TmxQd8Of3CckGgr8gflvVPehpeFmg5N50A4qGrbiHpHTG6e/OuXGtPCaZBgn4ctpRbQ7SlrpfX4+vRRz9E+ueqnwXtOeZoV8ZMNQv74BDvxHZv/lpn9tTcL72zVRELB8piPdmut2BB61WoPgd/CCKQx+sot1Yl4srt4qSDvI6qdmVERInsleCfYrux/qtOBltt0NEV8XRu7TcuL3ZaP7ZpKxc6KxweeZRmVymKd+VN8NWcdxJiZIG3yclLu2Gbk4yhhMqTqz+XpmoiQ4vsBUHAhFgkBg8s1EYW/rLTJZXui0/HJkHmMX9CuW6gL9p8ImZMJHMODKJiLzQ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778647008; c=relaxed/relaxed;
	bh=M4u8rbwtxUflV09UEV6XuYkTaxCTyaoYKBUSERTied8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHgkhEBOunaHUrcTggIUy8L2dIvI/gi+jPuNCg/eoCbSZClK340eyaPuW0rvHUblWN8n6enJmPKhjHMxylHdLIk6Lorv/ab+p5CjdQvgFuwlGWRQ9w+Nt8ZNqujOWL4xS/dFOuj5+k2f2BeiuHTtovs69kVUKRmL+W6j0ASeUcxHX6WAN4PVmdddXp76zFY42vuR3/pm9JHl1YPwSSSSI92BXYsQT2DoaVBg+N+IDfHJfgb9cl2CMwjOuwPHDlFl7xTyVPtooGMDAKpC5dbgRC8jmMb+BGfk3PBh0rmmrceNOwa4W82ZrmBYs2s3yA8T/l/sbhR4IjKKq6xKEO80Nw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MIxUdbgZ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MIxUdbgZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFgf66yN5z2xlV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 14:36:46 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D1dmN12608399;
	Wed, 13 May 2026 04:36:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=M4u8rb
	wtxUflV09UEV6XuYkTaxCTyaoYKBUSERTied8=; b=MIxUdbgZmh3lPu3YHHcks8
	vrS2aplSXbS95uM/obXAdd/7MuJW/YwnoeEkq8x6Ds5pnw/UQgedEmwTfABWQIRC
	4/RaOOYmrAuqLfZDvDGt5qq2uuI2ogaJEDaRGkGo9CC035ozP+EtL05Bq21CzeBA
	USv7qQLFIAotRaSslXGBtbL/8ogsTO6x73s03IU6kRla6r5TiWT7NUVRGgsKf4El
	IpAQCiWyk6Vct4sjvzv8fNeLvmTCKSfSdzuCPqaokfMIM1mKdGY0K15nhP5lmBUf
	InrUl3Anw9Te+n0TbiH4lkJr0rdmvpYzay9Wk/BOFdlXRts6HQX//BguNh44uC6g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv561wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 04:36:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64D4ORVm013529;
	Wed, 13 May 2026 04:36:08 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgp6xe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 04:36:08 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64D4a6Jl65667438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 04:36:06 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABD0E5805A;
	Wed, 13 May 2026 04:36:06 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA7BE58054;
	Wed, 13 May 2026 04:36:00 +0000 (GMT)
Received: from [9.39.26.26] (unknown [9.39.26.26])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 04:36:00 +0000 (GMT)
Message-ID: <fce0a701-ee58-4cb2-b34b-8aec26aaab5d@linux.ibm.com>
Date: Wed, 13 May 2026 10:05:59 +0530
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
Subject: Re: [PATCH v3] powerpc/audit: Convert powerpc to
 AUDIT_ARCH_COMPAT_GENERIC
Content-Language: en-GB
To: Paul Moore <paul@paul-moore.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Eric Paris <eparis@redhat.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        audit@vger.kernel.org,
        Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        ritesh.list@gmail.com
References: <261b1be5b8dc526b83d73e8281e682a73536ea28.1773155031.git.chleroy@kernel.org>
 <CAHC9VhTyOuuPs1uovodM9M_8zZeJnVXs9xrWSdPhZcjXUb=mvA@mail.gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CAHC9VhTyOuuPs1uovodM9M_8zZeJnVXs9xrWSdPhZcjXUb=mvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA0MyBTYWx0ZWRfX2ySjBRHf1ifO
 sZtPjOZRjZv9XruT2/Qeanu0d5sV4Ze9wdKlIC/06tYDrnvwXRNbsY2c310z18n51SzamH/oXd2
 HayGlZnXqRdV6o2uopIXDuOlvFyrxTzav+Xx7nxcPm5DpzlkFn1aSneKfnU6OY6FAF+HKZC2xFg
 uPdouBdYipC+j/fl9TSFLyidBM4i45Xly1UBetQUJGztCVLp8z2RA4eMsHo9bP7x59VXvANyhdN
 +6kQpPXJt0nnaSGBZ1zu/VTeq4e5G/zRspndHz71wHK56VJRSJrt704xmzqi2vYF3VPfPsIycYF
 eKXl7WyiHQD6E34uIX/HLGaRZ4/fgM0jXS5zvQFJDiKRZqpRLmFYipgBE1YID78y3eie/t9zu3s
 /tXyQr7uVlWFgYdLDiusSlGZ4/Nh/Dkm3JclaI7pr7e6rDyrBeVv4SAg8I8Lwods1QYAOPPz0/Y
 /NQcnBz7riLvUC0AAow==
X-Proofpoint-ORIG-GUID: _U2tDHj2DvVrKAdqK3lGFQq7FqDIQv_E
X-Authority-Analysis: v=2.4 cv=Jc6Ma0KV c=1 sm=1 tr=0 ts=6a03ffb9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=1UX6Do5GAAAA:8 a=aow-egSQAAAA:8
 a=c3vZd6dCDRh6lx_OUBwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Et2XPkok5AAZYJIKzHr1:22 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: WTnx8P3coCCvEntJqiTgZBrH5JErmR21
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1011
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130043

+ Ritesh

Hi Venkat,

On 11/03/26 12:49 am, Paul Moore wrote:
> On Tue, Mar 10, 2026 at 11:08 AM Christophe Leroy (CS GROUP)
> <chleroy@kernel.org> wrote:
>>
>> From: Christophe Leroy <christophe.leroy@csgroup.eu>
>>
>> Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
>> targets") added generic support for AUDIT but that didn't include
>> support for bi-arch like powerpc.
>>
>> Commit 4b58841149dc ("audit: Add generic compat syscall support")
>> added generic support for bi-arch.
>>
>> Convert powerpc to that bi-arch generic audit support.
>>
>> With this change generated text is similar.
>>
>> Thomas has confirmed that the previously failing filter_exclude/test
>> is now successful both without and with this patch, see [1]
>>
>> [1] https://lore.kernel.org/all/20260306115350-ef265661-6d6b-4043-9bd0-8e6b437d0d67@linutronix.de/
>>
>> Link: https://github.com/linuxppc/issues/issues/412
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>> ---
>> Venkat, a test result with https://github.com/linux-audit/audit-testsuite would be appreciated.
> 
> Yes, I'd like to see confirmation that the audit test suite runs clean
> on ppc systems with this patch applied, and unfortunately without a
> ppc system I have no way to test this myself.

Is it possible to include this test suite in the IBM CI ?

Thanks
Harsh
> 
>> v3: Rebased on v7.0-rc1
>>
>> v2: https://lore.kernel.org/all/a4b3951d1191d4183d92a07a6097566bde60d00a.1629812058.git.christophe.leroy@csgroup.eu/
>> ---
>>   arch/powerpc/Kconfig                |  5 +-
>>   arch/powerpc/include/asm/unistd32.h |  7 +++
>>   arch/powerpc/kernel/Makefile        |  3 -
>>   arch/powerpc/kernel/audit.c         | 87 -----------------------------
>>   arch/powerpc/kernel/compat_audit.c  | 49 ----------------
>>   5 files changed, 8 insertions(+), 143 deletions(-)
>>   create mode 100644 arch/powerpc/include/asm/unistd32.h
>>   delete mode 100644 arch/powerpc/kernel/audit.c
>>   delete mode 100644 arch/powerpc/kernel/compat_audit.c
> 


