Return-Path: <linuxppc-dev+bounces-25050-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B336EC531D0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 05:41:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9dP70d0wz2xwH;
	Thu, 30 Jul 2026 15:41:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785390107;
	cv=none; b=Ce/h+BrmRynY3sJX3fE4LG78yWgwAiVXt8zuz5lrWY0nt7BeZn6tyhHzOyZAAuyUJxEIgq0jeQzWgJZHq7/H5xMwS2OJ71BZNp6Fucn7BDEbCOek0SoZXEbY55ew48WCk8Dj/hmqY/K8sutxJYJ0wNIO+jbEbVfTLO35q29IoItxR1eSJvTliKlUxOf3Qq6ZEpvptYy/2d412X+VD1AqBZK5Nr1hpJrcnWet98ZWB6psBLIrQCSlgPa+aWlfTU4EgpHOazRr2TUiR850u7JxOT9zTDlalFHcwNR71euJLw9GAxDJGBMH5e0hYda/mcOliEPByVJ/nbur5QIEbBjLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785390107; c=relaxed/relaxed;
	bh=AX8lyLzW64lX1zSaLDQopx/83TlvCP1ZLwVv6jEJWXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLvK7Oi4p52+aMkcsKBzVjZcC6jP7cCyvSb1V3Q0AOO5MBhwJ+LeVXiWwOc2quoZEILQTdI7hHkCfcXgXrTiQwifcNpzWxqiI0zkSC7/GOKUjFGyYaGZO16mdDAQZMJoL94pZPCLnXRo+F01ygP7fi2ttniwwboGA32z6tjfyntF2T4u09/skmfvRtrmExPX6x9DNV6tMhpGAFdXK95I+nSXUpt9va9fABMSVQqU0/0dG7XlwIqjN6mtA5Ecz6yCm8BAC6EuhnZCQVw5TP3p2D50GD3wdyAC6fK0gC9WLYePJ+38RK0eqcNcAtvhcn386s7VZgY3Zk8zYvRvhV/TOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NNmY2ufI; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NNmY2ufI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9dP62btcz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 15:41:45 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U3mXhi039480;
	Thu, 30 Jul 2026 05:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AX8lyL
	zW64lX1zSaLDQopx/83TlvCP1ZLwVv6jEJWXU=; b=NNmY2ufIwGrIxkv6kmeIL2
	om2De1t3t8BaZgLF79o7g4lUVKKivGYLKCX9s7U7WmbM3zoHGpf7HmLfP78PJfxB
	ka6Nf1MJcbVuAHuYoSlsY4SLwn11DhHWyMwl6fACUcb7q31UekIJgzw2QqgkVx1h
	CfFhAKO98pPAVhAN7mrRO6TjOPMKJEtl3pMzy4X0bif2dpT8CwMvrcvrjRLh0Sq/
	uz+ZQe/v3fjFUtB1mEF65xUeBANDXQSLvx5ahzPweKHlRgQPztAmmskd7scInjTz
	8qeojt8VZTRJlauGKKDoIx0p7TVtDntOtS3IQ9zWoQ4izQYyLDxgGnjecjj1p7wA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycp488-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:41:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U5fHTJ027063;
	Thu, 30 Jul 2026 05:41:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqj445-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:41:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U5fJn351904850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 05:41:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A16EE20043;
	Thu, 30 Jul 2026 05:41:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD35220040;
	Thu, 30 Jul 2026 05:41:16 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.85.187])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 05:41:16 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        sshegde@linux.ibm.com, mchauras@linux.ibm.com, ruanjinjie@huawei.com,
        thuth@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] powerpc/970: fix nap return address corruption on async interrupt exit
Date: Thu, 30 Jul 2026 11:11:15 +0530
Message-ID: <178538948388.1278583.13605273327516988662.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707172430.790040-1-mkchauras@gmail.com>
References: <20260707172430.790040-1-mkchauras@gmail.com>
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
X-Proofpoint-ORIG-GUID: 8d_yv7jEmar2mtF8tmvTmxm-dpQdEE8d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX7tZ7CZGHoJkL
 lRWfifoMfMucwwP0bCNzJWi7uWZdTcAiHpWn2zqbg6C4bI6nRJtbTL1Ot6DFfYMZ9X9mQ7YUXEZ
 jJZ43pojXuAnS+Lf5CE6RLbitOVKbFL/xPG3Nie0w3OZjBzbw8Rt5L4IjWaBFIiDAZ9YjVfbU2r
 AAo+YzH6m+kiK2UTMXvPJN+F8lTFfUSqc5/3zsd21isZTM3q+v9OUzAKi9jN/lfTfKrkMQZl0Nz
 Xdowy7zEQEXrf7aqyTMUz1Hfgp0+Hm6A2CHTO/xvXeY3SndVhj+8qMGpywN4iRZseEqwR+mBIKR
 GeabpVaXy0oavtCavhzPIMoH4zwCpdnTIkmQ/ieKed66GV8MFu8wIdjyxuqppcH0VxnDLABjV68
 WTcrwPiqFEJCWa7fZhfsnTny+CabknjKZ9yQ6HbJJ1EwrjGTm3M9iDDuoB7Tc/e1DNLDJ6VK0kP
 bOUUZkLztnNWFOV8TEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfXzpc5hgtengxk
 C3KCKDpTxfv3o5VUq0pM/rAzgG+zoJ+ev0awQlp0+5Q8mw8nLlt2/CauoxNeqOAmr95CJeuxsXL
 suUUS8zkByV/sHlPxCN+LLjXRi8Bpcc=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6ae405 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=qyr4IQK-_AybPuE7BrwA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: TIVdtpBAOpa-geLQqLwAL0wIeEOPZ4Fi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_01,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300033

On Tue, 07 Jul 2026 22:54:30 +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> On PowerMac G5 (PPC970, CONFIG_PPC_970_NAP) the system panics shortly
> after boot with symptoms including instruction fetch faults, kernel data
> access faults, and stack corruption, predominantly on SMP and always
> somewhere inside softirq processing.
> 
> The PPC970 idle path works by setting _TLF_NAPPING in the current
> thread's local flags before entering the MSR_POW nap loop.  When any
> async interrupt wakes the CPU, nap_adjust_return() is expected to detect
> _TLF_NAPPING, clear it, and rewrite regs->NIP to power4_idle_nap_return
> so that the interrupt returns cleanly to the caller of power4_idle_nap()
> rather than back into the nap spin loop.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/970: fix nap return address corruption on async interrupt exit
      https://git.kernel.org/powerpc/c/bddf7540099bf653eaea339e886add6f62555cf3

cheers

