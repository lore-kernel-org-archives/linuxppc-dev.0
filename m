Return-Path: <linuxppc-dev+bounces-22612-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857CBCD98C7
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Jun 2026 17:35:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gdgPg56MLz2yFc;
	Mon, 15 Jun 2026 03:35:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781458519;
	cv=none; b=eOY5rXSutyseN0VmSeAtDaiZMynZZ6hRD2AKClwWKzpoEXAZSOaAe8wGn+TetzWX959XP5hqdITDlJyVazV7eYFNpJOOIjLmh7VyyDDVxj4jNLbd9rnboOeNAbGnz4GGcNS3Or8x7+aHg3hgMKgFHNob+eq4bK6dVSUgk+CC1B6yx7w8SYfXMjc0u2kK/Xeq5XvjZGw6UR4MM8hOZ6X08bJasTfJDaJHp5efYC445XWYy5AmA+683H8l11hGnMM+QW+L3D6XL7FKLDMVMiP4YD90c5IuDTYmlbh677GKWJBkOGMW6uOAtMjuJxIXEUkVUyuE4y5fJsfoRpDR4Vnilg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781458519; c=relaxed/relaxed;
	bh=M6uwfLSCCl68CdWp8kdRQnl9eN3dzx0UzhJ2FTIJyvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L0V6Y2XNTPmJRA0cwtca/yC3prlvLNgfb78yvarB8jR3VR0kJzXkSQCQoO8O51irZJGtjNOtUI9Ni63cytRHBwsRUEYyEJFN+toIK4x4omjHA3m1xkya+qMG1Y+wEWppK9i2asT1ftS39oEHzAxVmrpf7FRWXSl1sP0wgOta0lLLzhhg+/IJeJ/c1S2E5OW6dfWd020XkdkV7gDULTyiooolCLgu0wcVW8Q+MWTtnXHtRNGVGBNtFthcL/bLr+BN0gsmWwg4p529mOoMZQkMeLlq9tCxWlSwdz9idV/kQc4im2h+4vYrg2bCuU4dnA1/Zku0I+QkD4csUG5mzrXdkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Axcwt2rY; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Axcwt2rY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gdgPf0dMLz2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 03:35:17 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65EHIRg54151687;
	Sun, 14 Jun 2026 17:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=M6uwfLSCCl68CdWp8kdRQnl9eN3dzx0UzhJ2FTIJy
	vk=; b=Axcwt2rYwaZMi+polLDIuEc3VhZtBIN54xT3Xnp4S+Sey7954ld9wmMCe
	RpXr+CDSxh5M48hTFoj1Mq+iGY/BzrpSV6/bu1tFImpQtlcyDQ1ZrxlT1zmbVBjV
	CRDG9sA7/r68UR3msy4qrZ4oAhqhzbXE7Xjo738MTy39Jr8c3hs2j4o8RvlX7fMo
	vfx0DoBX5mlBnL3LXmoqMJ9DU6bXb3PvmsKaoaHrF6+XX8ry1mXnFjDrTvzW+anB
	PqN/zAZlgJBNUZnrTwjP2EuRHsFWEtG+uQrOjFB1G1vzw8XwOwu7oZsg3m6rDilu
	NsoHMeyCAj3uDkBFaknruQxq29DTA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1v24tum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 17:34:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65EHYdR7007033;
	Sun, 14 Jun 2026 17:34:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esjhju467-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 17:34:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65EHYmIo51511728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jun 2026 17:34:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0CE720043;
	Sun, 14 Jun 2026 17:34:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01EA320040;
	Sun, 14 Jun 2026 17:34:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.30.128])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 14 Jun 2026 17:34:43 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Gautam Menghani <gautam@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/dt_cpu_ftrs: Set CPU_FTR_P11_PVR for Power11 and later processors
Date: Sun, 14 Jun 2026 23:04:37 +0530
Message-ID: <20260614173437.26352-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDE4MSBTYWx0ZWRfX25LaSoS5Brwk
 KaGYPclNcoE87khX27nDLggb+BZ5BmWZUmBvWMzUGBJS1PmxXiVKQk/Owa4RbmG85pMP7D1aV2N
 rWFX/N9/t8cwlwfRotfAt0MWxJ1W9sE=
X-Proofpoint-GUID: f3HYISmmWK1FFVXaYcFsx-blu_6K8pPS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDE4MSBTYWx0ZWRfX/wt1i8SW/arx
 FY0/pZcVYuEL7/bTO5TMnjfCJThbU6BNoQO5PSwNoVhAZckxWd1iS7Amq3OqspidihnWsH0MOZX
 csjHWNP+9Gm5u13bc9kfq2uDIuo8qHgrJqFRSqW22/FJzgAOl/+YgLq/el/u9jZHpvUywNn8gTC
 pjBdf/Oqc3uDnX6iR1CR5NRB3CcEgQo/x1aiFCp0lZaXyjhGCAxfFGMnwlhSsWHTBGPEe6AZRdT
 Zwrnhf3wpVXWgMa71espMhMwyUtHVB8/pM4WfGxeDQAY/e9YKwl7XazLjAD7WPATqmru62KXt2p
 0wxuMe4yo4DExQYF3NRKwQ2VScmhwoQA9vp9nADuIcKrUfjykFVXnUpeCe+RtVq81QA1KE7xVxW
 tBKUxrweIkJocaiivH5PmCOq2eg5kIQMTCGcBGIPi0FLz3EIAzhoSjNQnZDe1VWmYHhG02aL921
 HKfU0tIck+HWJr4yDbQ==
X-Proofpoint-ORIG-GUID: 7X9SvMqcsHuSui-NHCuD2yrme5VKuOM4
X-Authority-Analysis: v=2.4 cv=Dd0nbPtW c=1 sm=1 tr=0 ts=6a2ee63d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=NKTdka9ramWRCaAy5DwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_04,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606140181

When using device tree CPU features (dt-cpu-ftrs), the kernel bypasses
the traditional cputable-based CPU identification and instead derives
CPU features from the device tree's "ibm,powerpc-cpu-features" node
provided by firmware.

However, CPU_FTR_P11_PVR is a kernel-internal feature flag used to
identify Power11 and later processors, and is not represented in the
device tree's ISA feature set. While ISA v3.1 support (indicated by
CPU_FTR_ARCH_31) is present on both Power10 and Power11, the
CPU_FTR_P11_PVR flag is specifically needed by code that must
distinguish between Power10 and Power11 processors.

Without this flag set, code that checks for Power11 using
cpu_has_feature(CPU_FTR_P11_PVR) will incorrectly return false on
Power11+ systems using dt-cpu-ftrs, leading to incorrect behavior.

This issue manifests specifically in powernv environments (bare-metal
or QEMU TCG with powernv machine type), where skiboot/OPAL firmware
provides the "ibm,powerpc-cpu-features" node, causing the kernel to
use dt-cpu-ftrs. The issue does not affect pseries guests, where SLOF
firmware does not provide this node, causing the kernel to fall back
to the traditional cputable path (identify_cpu) which correctly sets
CPU_FTR_P11_PVR during PVR-based CPU identification.

In powernv TCG guests, the missing flag causes KVM code to trigger
warnings when attempting to create KVM guests, as cpu_features shows
0x000c00eb8f4fb187 (missing bit 53) instead of the correct
0x002c00eb8f4fb187 (with bit 53 set).

Fix this by setting CPU_FTR_P11_PVR for all processors with
PVR >= PVR_POWER11 when ISA v3.1 support is detected in
cpufeatures_setup_start(). This approach ensures forward
compatibility with future processor generations.

Fixes: 96e266e3bcd6 ("KVM: PPC: Book3S HV: Add Power11 capability support for Nested PAPR guests")
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Related: https://lore.kernel.org/all/20260609053327.61563-1-amachhiw@linux.ibm.com/
---

 arch/powerpc/kernel/dt_cpu_ftrs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 3af6c06af02f..e5853daa6a48 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -704,6 +704,15 @@ static void __init cpufeatures_setup_start(u32 isa)
 	if (isa >= ISA_V3_1) {
 		cur_cpu_spec->cpu_features |= CPU_FTR_ARCH_31;
 		cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_ARCH_3_1;
+
+		/*
+		 * CPU_FTR_P11_PVR is a kernel-internal flag to identify
+		 * Power11 and later processors. While ISA v3.1 is supported
+		 * by Power10+, this flag specifically indicates Power11+
+		 * for code that needs to distinguish between P10 and P11.
+		 */
+		if (PVR_VER(mfspr(SPRN_PVR)) >= PVR_POWER11)
+			cur_cpu_spec->cpu_features |= CPU_FTR_P11_PVR;
 	}
 }
 

base-commit: 424280953322cf66314f3ba5e2d1ef345f21c770
-- 
2.50.1 (Apple Git-155)


