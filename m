Return-Path: <linuxppc-dev+bounces-27852-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D34EC982E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 11:11:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpLBf5RkBz2xk7;
	Mon, 21 Sep 2026 21:11:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789989066;
	cv=none; b=HWuMQdEQdmrrtp/MEkPv+UYXdMst5RJ2l24X/dK9oMs6s8mEuq43t7w0rKBDC5PGGP6gQoHEusi/I861PESHLzLdD3a7tTLNq67BIYzCzc9Aq4Vc5383VgBE5nr5qj0GE45iKqk7CtArd6q7RdpWEr8kKxlGrCLEIip3dTCu5P4MRIDY4jA3Qc8SIjImyp7jl5jKnEAlYBUDpGAcGCasg2x4f9usjGWfCSQbDFsUEQ6fXDpg+6rmd4Sn/+5jqLtYfaqy2b94t51ZKPrGeaQkpNkRcX8/OQn93n2/VTaANlBo/lKH9frHIY+xOkEFRvy3hk49ad+mNH8plJe71E3lqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789989066; c=relaxed/relaxed;
	bh=spcUacc2GkEI6/pcjXq11vkjawtG1NHlSWBJ691pj9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ftaO8MU7K+Z4Hpve8u1xgWcotLrGkFY/6ZLoJL0glRxZMWXIP/aX27XD5IVvAeKhmjG7QaKog3fGOcw+n7XwnmccjpxQjYPEX7tspd/pgvPMxwi4PCyqX9QeZI+U784wI21CBGinaaZEYHsNuWmZYs+dfO00TUCfadkt6wyBEgwTxiFpvCXH5JC/sYCi8gnYyBaVkhhYL+Ep0A3ChY0q5xeVwvkZULII5rgS2NzNV8WHaOFTYw+RiK3ISYJFd1ZTCzGG6lug1AJaHtEcpZn0uK/nmfC+uc9XHkrjKTS36+wcqjODuMOKDgTskPKj3Ni5DL6IioaFaf/ypwTYC9MTAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bQm1VPSG; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bQm1VPSG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpLBd4Y4Dz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 21:11:04 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LB5N5Z1316544;
	Mon, 21 Sep 2026 11:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=spcUacc2GkEI6/pcjXq11vkjawtG1NHlSWBJ691pj
	9M=; b=bQm1VPSGBxiIwsNzjNbZ7eIL4MBm333vCvbJyvUN8FlWb8d/AV/2dZS6q
	fDdG0bRHA3VNExoePk2JA0TDyExzT4g2Ury+TQxNq+L0UbpQ9OiI0PuUQtXuWXcl
	zJur30pMX8BUcRXNnsxLoF2lnzMbPpXfdNFQv7kARKsm/7Jh6nby7pCeZZwjg4lR
	emxOZkA45AV9d/C4dXL6sZbZw+0XmqhDZV5KAeH2gsKgzZdt+68DNEwXLV3GHZo9
	GhiZ8zpRSp37AnFC2n41Igt+XWPuMz63HPetVl/ReVPgDxMBJrL200DFZoKrrudl
	42mCVO2Gc3QZ+gIlCUl2vSBiRc9ow==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2853j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 11:10:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAm3CC1096709;
	Mon, 21 Sep 2026 11:10:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vd35e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 11:10:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LBAmta12058946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 11:10:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB6812004B;
	Mon, 21 Sep 2026 11:10:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20AA220040;
	Mon, 21 Sep 2026 11:10:46 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.bl1-in.ibm.com (unknown [9.123.6.5])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 11:10:45 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        nnmlinux@linux.ibm.com, amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Timothy Pearson <tpearson@raptorengineering.com>
Subject: [PATCH v3] KVM: PPC: Book3S HV: Avoid spurious interrupts caused by LPCR_MER bit
Date: Mon, 21 Sep 2026 16:40:42 +0530
Message-ID: <20260921111043.49825-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
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
X-Proofpoint-ORIG-GUID: 7Js7S6Cc_0Lsr-IVK1KaZSIBUY5o6rkR
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab110be cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=yKAn6K1XAAAA:8 a=_AprYWD3AAAA:8
 a=VnNF1IyMAAAA:8 a=lIyXSIJ_195hEhgqkI0A:9 a=6M1ixcW_PCWoKiWyFx5v:22
 a=fKH2wJO7VO9AkD4yHysb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE2MCBTYWx0ZWRfX59weTEn1vE/U
 ZqVri69RqlN+KkQszLh32gFt4uB/vCACVg66nEQq1msFWL1aY0EKe+/4eNIgR38rgXCI0HNqXO/
 AZogsDk3oj9esHXsCX5HovFmV1I4mwlX+80T9Cs2GEDN6x3fUaeAu70XVIoXYafSOHai0mES17Z
 e12fcsXC2UZceb3EUTqSaphfXWQm1FoBZ2NvRZgAYWZZvcgi2dEWuakTnGAk5tQnr+D0Gz5V852
 YJ+0kDrTO6Ig9U62RqOMTXL+0B6Z7NKWipRYWAez9iCkFAH94izWkvGiQvGYzA/Xs2rfki1j9n6
 19WqugHb8ODxu06/8PWAUfjkWd67KTs6uF8lFeQuTpaOR/myhRYxnrK8IdhW4SIFR/XrmDeOU67
 3nuMC/AdP+N9cU72zhOG8iX+erPGIgLAzK7gkxMoi6KMKxJ5QW8gm3ippWhTjyIM1eOEZkUV3Zw
 oeKWz81ZhGk3mECsnQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE2MCBTYWx0ZWRfX9zpJ33Pjjuyu
 FcMI3h0CxwGISS8m+6Oz1FDrze9R1MLNDCP/sho/FXS7/4/TfmC3ChLh8ZPwbZkt0rK9Xq0wNQs
 lM6bJSH/wV5/Bu0R+AYyKpcI19LVmdM=
X-Proofpoint-GUID: KteZVDsxXEQHrfqAau4WzZlVGG2zIK21
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210160

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

Fix this behaviour by not using the LPCR_MER bit whenever native XIVE is
available (currently in case of KVM on PowerNV only), as the XIVE hardware
can present interrupts to the KVM guest vCPU directly. So the LPCR_MER
functionality is not required. This reduces the number of spurious
interrupts drastically.

Fixes: ecd10702baae5 ("KVM: PPC: Book3S HV: Handle pending exceptions on guest entry with MSR_EE")
Cc: stable@vger.kernel.org # 6.8+
Reported-by: Timothy Pearson <tpearson@raptorengineering.com>
Closes: https://lore.kernel.org/linuxppc-dev/582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v3:
1. Continue the use of LPCR_MER when kernel-irqchip=off (Sashiko)

v2:
1. Handle the case where xive_interrupt_pending() is true and also the
external exception bit is set. (Narayana)

 arch/powerpc/include/asm/kvm_ppc.h | 7 +++++++
 arch/powerpc/kvm/book3s_hv.c       | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 169ea6a7fbad..580ad2548c2b 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -747,6 +747,11 @@ static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
 	return vcpu->arch.irq_type == KVMPPC_IRQ_XIVE;
 }
 
+static inline bool kvmppc_xive_native_enabled(struct kvm *kvm)
+{
+	return kvm->arch.xive_devices.native;
+}
+
 extern int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
 					   struct kvm_vcpu *vcpu, u32 cpu);
 extern void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu);
@@ -782,6 +787,8 @@ static inline bool kvmppc_xive_rearm_escalation(struct kvm_vcpu *vcpu) { return
 
 static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
 	{ return 0; }
+static inline bool kvmppc_xive_native_enabled(struct kvm *kvm) { return false; }
+
 static inline int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
 			  struct kvm_vcpu *vcpu, u32 cpu) { return -EBUSY; }
 static inline void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu) { }
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index dbac3573b2c8..cb2bb29451a7 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4980,7 +4980,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 			if (!kvmhv_on_pseries() && (__kvmppc_get_msr_hv(vcpu) & MSR_EE))
 				kvmppc_inject_interrupt_hv(vcpu,
 							   BOOK3S_INTERRUPT_EXTERNAL, 0);
-			else
+			else if (!kvmppc_xive_native_enabled(vcpu->kvm))
 				lpcr |= LPCR_MER;
 		} else {
 			/*
-- 
2.55.0


