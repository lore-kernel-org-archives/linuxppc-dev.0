Return-Path: <linuxppc-dev+bounces-22151-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149B1CD8C8E
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Jun 2026 15:18:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gXhlF10Xfz2yRM;
	Sun, 07 Jun 2026 01:18:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780759097;
	cv=none; b=Oya2opvkXRpBJArMN4H03OrNSxOon5l9UeRVfpMTz8EAw7eDj4zngvwnmM3f21etRqxn6HPpm22x4h1LeZjLODyRP1Enprv/7j4L0mfiiSKRfG1BM3WCCY0NJKipyMarNO+1+bEqcrDglN5OO5pcAMn/EXMATIpOQ/mADH2XvQY/7Bpccl6wxCoVMttLGrdWoY4deQ/h6D775eKiHEHqCbzmuJW4JDSChyblrpUVPkKVc7gz4udhUfBbh8qpyGg0Qso/XSmhCLAk+HjvOeEy94bW4mDuTT05hNjlCdBXfL9Z5sWd08C1Q4f9sRmxefj63rZQfN+cuWHAEQ/UOTkRzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780759097; c=relaxed/relaxed;
	bh=dkVHnnA08if32/oWn6DxocKokofTh/NQX7Z7+IuZpIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O+WC6WDyP7i6CgChQYd8TulK7krYATiV3GWCF6ERwZgRxqxrXlBV4hKFK83NyL5i3PO6WIrYkik3lzlZ41u8242uEQqg3w0IfFkjyeNjkbPgAC6uzJ3hcB0X3Sb8we7wztcNhwC9CGDZ4MFn0z5Vq6APrf3qv3CTJtYewIQxNSUwyI7K0dHrJ419Te0DdPp5W/9rZS4JK9xGgoDeUQn/5g7o1O6aatp9YLRhjE6p/DdZ0a2uyusW3O2LKp6kn1DGaGaPyZ000HKP32z49ne320df9i/QAr4rHs3aGcoDEeK4a7fbdWEMT375jaBbHXOSRgqcYAjZBvEbtlD8ruwhnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tOzEMeCR; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tOzEMeCR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gXhlD1M1fz2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Jun 2026 01:18:15 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6562tnlJ2916563;
	Sat, 6 Jun 2026 15:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=dkVHnnA08if32/oWn6DxocKokofTh/NQX7Z7+IuZp
	Iw=; b=tOzEMeCREUUfV+aPOePx4tO7PJPC3mplmnR35CQy6U4gxPQ8Ee4dikjaq
	5iYJ4vogiiX8kAphaL7I/AJCMpYtyFXburb2M2ioKmonHHH6TG+vMrECHUBFKnyq
	YTeyPJe5Ybto510O2a2Pjj4SW9+4KgCKm+M9UngPLwzHx0Lh6uWUkrWB31xhle5V
	2isEHwhmNC75cB/PB0StOGLUrVicx2LgZBmYjsTCCCHXBW0KOWaMBqHIMmMR4Tlu
	VB7UdbBjbQ+0dWUvoPED6NeLyoSB3APBHU0qW1xZNNiYSmZ1645AQ776cDyoX0Wy
	khAwT8ffavjub+4duP7DoEoFPLXvw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6shb0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Jun 2026 15:18:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 656F4txC012429;
	Sat, 6 Jun 2026 15:18:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7kp48d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Jun 2026 15:18:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 656FHxdP30212810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 6 Jun 2026 15:17:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D0E820043;
	Sat,  6 Jun 2026 15:17:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95A1120040;
	Sat,  6 Jun 2026 15:17:53 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.124.211.229])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  6 Jun 2026 15:17:53 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com,
        adityag@linux.ibm.com, venkat88@linux.ibm.com,
        sourabhjain@linux.ibm.com, avnish@linux.ibm.com, sayalip@linux.ibm.com
Subject: [RFC PATCH 0/1] powerpc/fadump: move crash memory reservation to middle of RAM
Date: Sat,  6 Jun 2026 20:47:38 +0530
Message-ID: <20260606151739.1720246-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: mZGUwbJIIx3ZYAlxaQaBJc1hvlBt1yx5
X-Proofpoint-GUID: QS3Mm4Rb_aNzMr8ZVGx7EQHM_hNen6uE
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a243a2c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=JhGMq8jloO8KDEW7JQwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDE1NCBTYWx0ZWRfXyFvX38bCNrU5
 namuO9IyLc6QvSqwFCCxDVCu4l74oTbm1UGhycxLQY1E9+W/HJhWSHRLd/a5fqv7aDsp/LGfH/f
 FKoGdNq6oJyRMVWaoUANPq9633veVxaveO+5+gDe0G9bTeUe4jqn8ZD494h7t5xM1m8sn4gDkLB
 b3QN9X4S/pR6MVsNQk95jP/ip7ty5uwANw9vrm2SguWtSVZnB0xzdD6n87yoXF6LQUjs2mCxtKV
 gp1k6XnS5i0y0JnVKmF/IIMRwPupNBN2phR9BmDyLNJ5QUM8t7pMY5pwuWFeGu0ZG4PzTZpJdCV
 M+8YrMCVj/ICRx4hIvl+wcdhYWrLbNiBl5w+BCn7xTO2uhx8CbY3cDyiCsRww2NfPY21cz7cXX6
 rFgZtvcYT7NQd6ByYUmGza8MMikiW5aq+0WSAefILkeOKVBwpFyjJSA0YJZjXCHCDQddqdcEN2q
 3zPwxLM8mXDcSvrg5jA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606060154

The current fadump crash memory reservation policy places the crash
memory area at an offset derived from the crashkernel reservation
size. For example, with crashkernel=768M, the crash memory area starts
at 768M physical address.

This layout assumes that bootloader memory usage remains below the
crash memory reservation area during the reboot flow after a kernel
crash.

With fadump enabled, a crashed system reboots and firmware preserves
the crashed kernel memory while passing special device tree properties
to the next kernel. Before the capture kernel boots, GRUB is invoked
again as part of the normal reboot sequence.

Currently GRUB limits its memory usage below 768M, which aligns with
the minimum crashkernel reservation supported by fadump. However, if
GRUB increases this limit in future, it can potentially overwrite the
preserved crash memory and corrupt the dump before the capture kernel
boots.

To avoid depending on bootloader memory limits, place the fadump crash
memory reservation area in the middle of system RAM instead of deriving
its base from the crashkernel reservation size.

Since we have changed the fadump crash memory reservation base address
policy in the past, I am sending this patch as RFC to discuss any
potential side effects before moving the fadump base address to the
middle of system RAM again.

The following commits are related to the previous reservation policy
changes:

Commit 140777a3d8df ("powerpc/fadump: consider reserved ranges while
reserving memory")

Commit f6e6bedb7731 ("powerpc/fadump: Reserve memory at an offset
closer to bottom of RAM")

Sourabh Jain (1):
  powerpc/fadump: move crash memory reservation to middle of RAM

 arch/powerpc/kernel/fadump.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.52.0


