Return-Path: <linuxppc-dev+bounces-27654-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3CBC982D2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 05:59:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmMQP5Kdbz2y7r;
	Fri, 18 Sep 2026 15:59:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789711165;
	cv=none; b=iaRIYtDjf1hCI0z2RVTeX1Rt2N0xFij0vLwYO2NfySuX1It2DqQEfLU64xirqsQrjqQd4BE7fLh1VI4dtPU3VrsBQlAbgTYjvaNVAYphsaSQv8UYIbpJA0682ZQ1RCeTf2repQbmLTLzvoZwIK1y4hF+e7JKhgRLgsokh2Onuce1d4Mlg16hNCR/QHXyEEcXlRvT3yOe5Dtz+hG5m6sDWez5TN9Qr2UfxOKSa9Ge+PfUWfCsBgWDaUKXYorwQcypyk2ytaqAMxPX9brhVOOFFM7Ss/XD47EW7wi5EKD55RgcQeAv9iYtPMVxcR6l4a7nNH3VT2IyL50jBlBqvZExgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789711165; c=relaxed/relaxed;
	bh=Gu3CyY2cPSd04sTF2pYnIPNZ6GDVbmQxXpMwm3bVruA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aww3/f9Mpft39s7cyu0UjKcvV0sDz5RAoneYiM2AMNvELCOL0BQp+hXKI42LIZxrVg8q/gqBkxz+itKovwhACp3HfyCSRuL4YMkR1rg4ZGki99XUB3s8UYtgd3DdNgpFjOeR8P+bMOENgf1Zv88qiKJZ30lXL5NTcAUVCIsU9ktXlxfMTgShOm5yystOSWJM26+n6ogQ0qAKNpYGzN/VFs39VGMVaTV/A2vabEapSBgE44ahWb1xzOhyZHhRtsudaNCzTCgTo3ANCJuX4Hd7GnY0+SZU+labQTaVMmOV5xdzVX2RZOonDoGMzI+hnoDpYKWlLi1rRIP++8CBXm+MxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mJjICfUS; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mJjICfUS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmMQN69PXz2y2W
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 15:59:24 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I2VXop3075103;
	Fri, 18 Sep 2026 05:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Gu3CyY2cPSd04sTF2pYnIPNZ6GDVbmQxXpMwm3bVr
	uA=; b=mJjICfUSyg84ZRERN7Hdkykg7wkzZ98fmrm6un6hrBC3hwDl9KSAMCEjp
	u12r7EesUXTMJI3HCzWpWHzzUdABQOg/0nUcsyDCyVqEAEwRbe2XA3MfOiMcTYUr
	YmLQbK5UlS3iKqoRVfq10hr8fu4RwvMsxC1FUi9t7vTjCdezKdudrYALTA6YKxWb
	cZ4hkaKH9FjuHDLsFZrHcS2VmFcofTRGhkyBfhSbsSdWOm7mPIymG2JaOFSmsmCZ
	3jD3RWyFMlZgk008Ab7Pa/aXRBLfIlCtHLCxEXifCZfZEOskbUnujZQ2wc7jnHWR
	CMXeKiVQ1/EqnsT406RBeWLYfLXKA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5ee0mw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 05:59:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I2Z4Vs918832;
	Fri, 18 Sep 2026 05:59:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr7genk50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 05:59:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I5x2DG47382888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 05:59:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3553C20043;
	Fri, 18 Sep 2026 05:59:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DFD020040;
	Fri, 18 Sep 2026 05:59:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.70.22])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 05:58:59 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Timothy Pearson <tpearson@raptorengineering.com>
Subject: [PATCH v2] KVM: PPC: Book3S HV: Avoid spurious interrupts caused by LPCR_MER bit
Date: Fri, 18 Sep 2026 11:28:47 +0530
Message-ID: <20260918055848.28390-1-gautam@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA3MiBTYWx0ZWRfX16NPBwFAaT+O
 UAgOzr6YBjQuhaVqDP/RwGGYM4L1MjMahMx6/dtAIaC3hYNFF0fU2scCxvlmKDWozIZHzXgLLej
 xDb7Y/WSpfcE7MGLJ8gwwQBMYF5mXR/iPAeqnXSX/K3LnXdc8MMfdu+S9mwtd68FG1LoeOp/jHQ
 PpzVKBxdRJXH1Fh1lWsQhCWQ3dfXwIlDlFpeVDba9P+JCrDex+R9UzcMH2XwGebZC0ICJOrZTx7
 LpfWqLqwL66mNS/TbWPvgEUWFbH21LICJGQKEdYKDjzm6mmldAiKdI2UtS91ACenXK1/9mGm7me
 FF/o3njIZTWu5uHKxGrhoE+eXBU0sMIOZ1CUDCWxBjg6BDiWUvUb/jRCWe98emjEnPeNvtI7uiq
 sX8J72Y+HLTkgRdupY3xJGbm11phEDVXOI9LunkDSAfM6qSAsPpmbfKDLICZrkqIPjd+A7ZrNlm
 Uiw48wbvryUS7B4E3LQ==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aacd32b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=yKAn6K1XAAAA:8 a=_AprYWD3AAAA:8
 a=VnNF1IyMAAAA:8 a=r95I5fjiukzm4VaaYucA:9 a=6M1ixcW_PCWoKiWyFx5v:22
 a=fKH2wJO7VO9AkD4yHysb:22
X-Proofpoint-ORIG-GUID: tt32x94vHuGk4pnxneHxbSzCeDo7yIZp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA3MiBTYWx0ZWRfX8FYpZe9/zPPT
 mJgCkXp+DisA82Rv4eHdYk5yL7+R/nL7+wfMYADlsovjsfp8NWPxTQpqma0bxSKBkXOLaf5rF4+
 PvLrIMo6rnyP0WvKGlxD93DugmzLT54=
X-Proofpoint-GUID: uYJ5aT56HSo-DAVALs0w8ZzyRhKxWAW8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180072

A huge number of spurious interrupts can be seen immediately after a KVM
on PowerNV guest boots up in XIVE mode.

$ cat /proc/interrupts  | grep SPU
SPU:     223705     192439     273526     147623   Spurious interrupts

This bug was introduced by commit ecd10702baae5 ("KVM: PPC: Book3S HV:
Handle pending exceptions on guest entry with MSR_EE"). The root cause
is that once LPCR_MER bit is set, it is supposed to be reset by
software. But when a vCPU starts running with LPCR_MER set, the vCPU does
not exit back to the host until the decrementer expires or there is an
hcall, etc. This is because KVM on PowerNV guests have support for
native XIVE, so they are not dependent on host for interrupt emulation.
Due to this behaviour, a huge number of spurious interrupts are seen
since LPCR_MER continues to be set and LPCR_MER cannot be reset until the
vCPU exits to the host.

Fix this behaviour by not using the LPCR_MER bit in case of KVM on
PowerNV, as the XIVE hardware can present interrupts to the KVM guest
vCPU directly. So the LPCR_MER functionality is not required.
This reduces the number of spurious interrupts drastically.

Fixes: ecd10702baae5 ("KVM: PPC: Book3S HV: Handle pending exceptions on guest entry with MSR_EE")
Cc: stable@vger.kernel.org #6.8+
Reported-by: Timothy Pearson <tpearson@raptorengineering.com>
Closes: https://lore.kernel.org/linuxppc-dev/582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v2:
1. Handle the case where xive_interrupt_pending() is true and also the
external exception bit is set.

 arch/powerpc/kvm/book3s_hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index dbac3573b2c8..f4d12a97311b 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4980,7 +4980,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 			if (!kvmhv_on_pseries() && (__kvmppc_get_msr_hv(vcpu) & MSR_EE))
 				kvmppc_inject_interrupt_hv(vcpu,
 							   BOOK3S_INTERRUPT_EXTERNAL, 0);
-			else
+			else if (!xics_on_xive())
 				lpcr |= LPCR_MER;
 		} else {
 			/*
-- 
2.55.0


