Return-Path: <linuxppc-dev+bounces-19472-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AA0FD5F6F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 04:30:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr97Z6w3gz2yfl;
	Wed, 08 Apr 2026 14:29:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775622554;
	cv=none; b=nPF6FDSAG+zsI+s/W3fwFXkhXTn9oPLLB4xSKxj/31RaRKPmDwHMMgk+qJJ0pRw0PXrR+VGRlLQqnRyafjtrzgW1ZBcGxbYcc8lTeiLvxL5YrLMAEpesta4FAgF+jmZxoRMIWKOh6HFdElhtI+Q6rmk2Orr4e7l4QttWN8bwopTCtjhcMxFHM8SHRvkVeMlrlhyHGj3PCRobDi7QP2Tc9x3xqK3B6kNFdPK5Ggdkhu2G0W8ZuvoTEPUT+q33XvikH3y0uTsDt5VB76K932eU23pFVD3m9L6G5ArQj6H6ZR8ESsnir60HAFa3CVpxRFCkm21ME7qW3JLxb/424R9bVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775622554; c=relaxed/relaxed;
	bh=vRnjyUrhxcfoZPRura3rLTuODCZMqQIqjwvce3mBf9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E1f06cCDwvUPxUyOobaJBpeGN4Ql8MiOSeE4m99+8aJMseZXokQjrB6KI4afLKO0SMypbnDgSZB+Kw+kgRqM/gn7qf5XiXNH2lUzbhtosU00UYr08lBUFzsSOMzFhSoIoqGEereWiJHDtrtf0CVsI3jqR0nGgRs0J9CSHyUcwu5eeD84qC4KAyYN7ZVQg1SHXMHHi130T3PvXHuPZDdnkHBj3Hk3TNvb2wt+q0UEeH3//z2PUzzZKIi0S0GYIjfZZXRM5LVGZtfi0Mol2MF22+w5fe0pF3d1V0AUKfaeHfG53HqBlfK5TMoletyDTL1c78Z1Lia7kaF9AMRc0f/zLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MNqm3bzR; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MNqm3bzR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr97Z0p40z30Vw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 14:29:13 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637DK1DQ2297920;
	Wed, 8 Apr 2026 04:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vRnjyU
	rhxcfoZPRura3rLTuODCZMqQIqjwvce3mBf9U=; b=MNqm3bzRfWGgi/TLn5da9x
	I7Kb9FLPfZA3THeSVUC7e0Hiyj9m1CMGxNHBe8AwIedFbwukXuYDXQiSrBK7JNyI
	pg1IL5h7Kqx46DrG67QuYbmylWUXJAYDlRZW0ZpjExZQ/PHhAlJFzzPNwNw0+TFQ
	2EfocfCKxcrLBCEt+3+WFnVib5Mgj9ObHohnPfmM9JoiXhLCdvLfQTKi4FLP6O06
	x7HTuJUuGN0HlGjtKswqlTLavXda/VGQK7E3y7PtsZMUkk6UJgUFTT/uN2pdm+Fr
	oPKyp9lP4EiWU8AvGsGdSlpYGU6Wh6+XDnFo08pAiudV4+VI91L6Ba7gwzJkWkxA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fwrst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:29:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637NwmkW030062;
	Wed, 8 Apr 2026 04:29:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7dysr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:29:01 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384SvVj29950274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:28:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 784132004D;
	Wed,  8 Apr 2026 04:28:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40E9720040;
	Wed,  8 Apr 2026 04:28:55 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:28:55 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Nilay Shroff <nilay@linux.ibm.com>
Cc: namcao@linutronix.de, mpe@ellerman.id.au, npiggin@gmail.com,
        maz@kernel.org, ritesh.list@gmail.com, gautam@linux.ibm.com,
        stable@vger.kernel.org, Christophe Leroy <chleroy@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH] powerpc/xive: fix kmemleak caused by incorrect chip_data lookup
Date: Wed,  8 Apr 2026 09:58:54 +0530
Message-ID: <177562236416.1381144.5101696715064742344.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311134336.326996-1-nilay@linux.ibm.com>
References: <20260311134336.326996-1-nilay@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d5d98e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=pGwZmBqalxsbcZeRzjQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: bBCfRcRgAkZLsukp97XLVoO6Dj3vri2N
X-Proofpoint-GUID: u6olKVah22N5aIGIO2sJnKoVr_01cIOG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX4MMAHTOxPtLo
 1hFpFt/WbSQDOZtB0Lr8avdFT1MBCCm0tkwoN6ix/sl0LC+rh7LIkSbQTLH58NMT8pIRVrzmK4Q
 UCLY7hWWoe4KYxtKXAnmY20aDiWs7QdoT1wcvV7Vr9u0LUad0wO8gqcy81BMaHXBd778kwMMRAF
 agHwV4FcVqjNNFVAV1/WvTbVOaht25ZMVEzStM8Fyr0wbk7jV86bKBZs5q9jmYNohsr7Kq939Hx
 yGLj4K0t6jBCtsXOpKBeTA+n+sJ9KIvXwhsa39NSyvIPe4WTOTxNT0pUB4trh0PYkMw5UOyfDu4
 Xv/mNvn/dHkeH69sRhZGZTGeG95zGynxQ2nk3wDjzRob55gvSkC6sZpALTTIuZmFGW8NrZbWA3O
 xVRLsUj5FnbdyD+Xv3FbXhhxZal7a/Z7ZPFwdmTX6dFvSTDgVQhooPWg+A0LbkZ061LUorqmVQ1
 amvZicI95FE/WYXz6JA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Wed, 11 Mar 2026 19:13:31 +0530, Nilay Shroff wrote:
> The kmemleak reports the following memory leak:
> 
> Unreferenced object 0xc0000002a7fbc640 (size 64):
>   comm "kworker/8:1", pid 540, jiffies 4294937872
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 09 04 00 04 00 00  ................
>     00 00 a7 81 00 00 0a c0 00 00 08 04 00 04 00 00  ................
>   backtrace (crc 177d48f6):
>     __kmalloc_cache_noprof+0x520/0x730
>     xive_irq_alloc_data.constprop.0+0x40/0xe0
>     xive_irq_domain_alloc+0xd0/0x1b0
>     irq_domain_alloc_irqs_parent+0x44/0x6c
>     pseries_irq_domain_alloc+0x1cc/0x354
>     irq_domain_alloc_irqs_parent+0x44/0x6c
>     msi_domain_alloc+0xb0/0x220
>     irq_domain_alloc_irqs_locked+0x138/0x4d0
>     __irq_domain_alloc_irqs+0x8c/0xfc
>     __msi_domain_alloc_irqs+0x214/0x4d8
>     msi_domain_alloc_irqs_all_locked+0x70/0xf8
>     pci_msi_setup_msi_irqs+0x60/0x78
>     __pci_enable_msix_range+0x54c/0x98c
>     pci_alloc_irq_vectors_affinity+0x16c/0x1d4
>     nvme_pci_enable+0xac/0x9c0 [nvme]
>     nvme_probe+0x340/0x764 [nvme]
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/xive: fix kmemleak caused by incorrect chip_data lookup
      https://git.kernel.org/powerpc/c/6771c54728c278bf1e4bfdab4fddbbb186e33498

cheers

