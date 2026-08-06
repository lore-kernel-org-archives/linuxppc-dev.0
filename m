Return-Path: <linuxppc-dev+bounces-25499-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969ADC56205
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:07:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGDGy4NFYz3br2;
	Fri, 07 Aug 2026 03:07:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786036042;
	cv=none; b=l3U2uHizYQ2F3DGWBuN7ViscbyyedqbRt2Fu/gnpPEND3dRi4p8Nm3x/Du+a2o212z+Py3IDoRflbxDRG3q5Av8XkjjkNc08OmWif/LiVI0ma2ISFIm9xkiSKcLC6LYMqxqokT0e4CkRkVhrZrX+KGxgQAgO9zmki16yQA9lIFIl8q1/uP9hTUxVr9wcm/vZVhXyt+TABR4ibGVORQ4d82DrWlxnsVaPmMlnoB4UKfyt+by9VBzb8xcgbra6LLjBamwtYoPbEHUq1x+sMbQHdPs3/q3QfpxVvx9FDLfA1VHAmBvI0dayg9gDcuskKfAH+ez2dcXTfqlzImxYcpBVXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786036042; c=relaxed/relaxed;
	bh=3UZH/zqW2AVZf/DrJ+f2oTkR6dbVp6LIpNDQn2wmwM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJ1ApQXC7rBRL8/gGwxW1zoRcosJ0w1GCquvXNF++RLLhRUII9VLtVE3C9ez+hUFAGFfGvXnO4ek1x+EVhAPTEfOXociz+62xi+xyCMBL6dmqKsIYUEqSvBcaqbn1Tu6bRaeofbaPNWN+cKzc0rb8lvb1hlQsFiOPC8UeKgq4+oY5VvpNuUL4bcM8rLJ9S5reNbzuSfJJYBSAi5dasKvor9xxYTfWUXYla6Rx1Lf5DA1hZ9UI0iBGkg0JkoI7rhzHKGR+F6I2y0mn8t5Tul6KkQeHQtvYiA/u16nF4pL2Vm/Bk0XRs9RmWt2C9VLaEtldxyfiLNRitMblCqSuizUTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RsAkDLBG; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RsAkDLBG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGDGx64jwz3bSw
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 03:07:21 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676EnWSB2964719;
	Thu, 6 Aug 2026 17:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3UZH/zqW2AVZf/DrJ
	+f2oTkR6dbVp6LIpNDQn2wmwM8=; b=RsAkDLBGWm8k/5yLJSmD+WACV0OQmS2zn
	ytg+NPgUAd2wgKWWo5y2IopSAfylMSnAmCdwzZFT3pvO6YYyutWKSZ2RXjFOPmtY
	Z5HuCnZzpgFX/uoBJFesLG0lbgANW+6iuYZy94LrakFj7qFf4wEGgBF89SirwHhr
	X01NTpyTIECtyN8NeEcnohl5ezxEUnmjAelJNuIkqulTf5/xqPuphcAInuX4we9+
	LjziOzx947job6HvRVLakoVwrKWDBLJKdl2SnXWjFBhp4xXWlihE5tYNM6RVFIk1
	ZPDiZdFWIHNDB7H/7KR5EDXoW0GXAQjkWBvyNWe+HlVMuJKjCBgFg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h59gqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:07:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676GuYHK008520;
	Thu, 6 Aug 2026 17:07:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwc798-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:07:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676H779D48562524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 17:07:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5F2920043;
	Thu,  6 Aug 2026 17:07:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C83920040;
	Thu,  6 Aug 2026 17:07:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.29.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 17:07:03 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Gautam Menghani <gautam@linux.ibm.com>
Subject: [PATCH v7 2/4] KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM on PowerVM
Date: Thu,  6 Aug 2026 22:36:43 +0530
Message-ID: <20260806170645.11892-3-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260806170645.11892-1-amachhiw@linux.ibm.com>
References: <20260806170645.11892-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEzMSBTYWx0ZWRfX199dhqw5TvmU
 sa8YlkNKPYHBziDNLTY5vM9GjIuKtyAnQyyFX5I6TbF7TbLgIIH0jjHsDhpGUR6D8qtzV/Q+cSi
 uiCq7DLua5epV61fNpZk6wwvFsgIgcc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEzMSBTYWx0ZWRfX17ugA259lhzH
 W6dp8CukQzZu96oD/fBnAsKwQGVla6vXgY88jU6Prg4Q8PtWM+Rzfvm6KdgUawKYujFVbCjUYeV
 DVF05Lm8FyLocmwUEvVp9QMnWxI2xDdEC+GcoVRGF42IRZ4LYSQguIFeT44biPbbbvxoArTTfvR
 cDUy81mB5mQJodRMBrZxCEbHdBBo7BDPOq1eo6eatf5jQQitAmsHnPhOSh5xAwl3xMVrsvXqDtS
 iNS1fwZGrlcIz6KWYC18rlfOKDBYM3PDx9dZvMUTzbAPtHqowea39elcyy9cXQcsVJAhv+0J1rM
 k7FsFC974tutmW4yMSZdxVrXF2b3mIODUMxAgEDI0OX25aT+sPoffam2rT4akFN3aC5U9Nh+E2r
 65YFwYHxNxR7+AIc96B6U+5ItKyZ94Ssc+uoMAvWxYXLhDiqtR6i/xKMErxDuxAz+k5lsweNR9U
 VmIz3zpBaa4lI6TOcsw==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a74bf40 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=igDgF-0WGXUSGxExIdQA:9
X-Proofpoint-ORIG-GUID: UXq2YvKsH4VdYDIYSVhRaq6thgwSKCfE
X-Proofpoint-GUID: R4wJaup2cdv5Xo0vkjdf7UqZDVUqH_4k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060131

On POWER systems, the host CPU may run in a compatibility mode (e.g., a
Power11 processor operating in Power10 compatibility mode). In such
cases, the effective CPU level exposed to guests differs from the
physical processor generation.

When running nested KVM guests, QEMU derives the host CPU type using
mfpvr(), which reflects the physical processor version. This can result
in a mismatch between the CPU model selected by QEMU and the
compatibility mode enforced by the host, leading to guest boot failures.

For example, booting a nested guest on a Power11 LPAR configured in
Power10 compatibility mode fails with:

  KVM-NESTEDv2: couldn't set guest wide elements
  [..KVM reg dump..]

This occurs because QEMU selects a CPU model corresponding to the
physical processor (via mfpvr()), while the host operates in a lower
compatibility mode. As a result, KVM rejects the requested compatibility
level during guest initialization.

On pseries nestedv2 systems, add support for retrieving host CPU
compatibility capabilities for nested guests on PowerVM. The capability
bitmap reflects the processor modes negotiated between the Power
hypervisor (L0) and the host partition (L1) via the
H_GUEST_GET_CAPABILITIES hcall, but is retrieved from the cached
nested_capabilities value populated during module initialization,
avoiding repeated hypervisor calls. A WARN_ON_ONCE() flags the
unexpected case where nested_capabilities is zero on a nestedv2 system.
The implementation defines KVM-specific capability constants
(KVM_PPC_COMPAT_CAP_POWER9/10/11), masks unsupported bits, and exposes
the result through the KVM_PPC_GET_COMPAT_CAPS ioctl.

Hook the implementation into the Book3S HV kvmppc_ops so that it can be
invoked by the generic KVM ioctl handling code.

Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 arch/powerpc/include/uapi/asm/kvm.h | 10 ++++++++++
 arch/powerpc/kvm/book3s_hv.c        | 20 ++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 19e53d5ae540..913a64b901a3 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -445,6 +445,16 @@ struct kvm_ppc_compat_caps {
 };
 #define KVM_PPC_COMPAT_CAPS_SIZE_VER0	24 /* sizeof first published struct */
 
+/*
+ * Capability bits for compat_capabilities field in kvm_ppc_compat_caps.
+ * These bits indicate which processor compatibility modes are supported.
+ */
+#define KVM_PPC_COMPAT_CAP_POWER9	(1ULL << 62)
+#define KVM_PPC_COMPAT_CAP_POWER10	(1ULL << 61)
+#define KVM_PPC_COMPAT_CAP_POWER11	(1ULL << 60)
+#define KVM_PPC_COMPAT_BITMASK		(KVM_PPC_COMPAT_CAP_POWER9 | \
+					 KVM_PPC_COMPAT_CAP_POWER10 | \
+					 KVM_PPC_COMPAT_CAP_POWER11)
 /*
  * Values for character and character_mask.
  * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index f9380ef65750..152cd08a5b38 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -6523,6 +6523,25 @@ static bool kvmppc_hash_v3_possible(void)
 	return true;
 }
 
+
+static int kvmppc_get_compat_caps(struct kvm_ppc_compat_caps *host_caps)
+{
+	unsigned long capabilities = 0;
+	long rc = -EINVAL;
+
+	if (kvmhv_on_pseries()) {
+		if (kvmhv_is_nestedv2()) {
+			WARN_ON_ONCE(!nested_capabilities);
+			capabilities = nested_capabilities;
+			rc = 0;
+		}
+	}
+
+	host_caps->compat_capabilities = capabilities & KVM_PPC_COMPAT_BITMASK;
+
+	return rc;
+}
+
 static struct kvmppc_ops kvm_ops_hv = {
 	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_hv,
 	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_hv,
@@ -6565,6 +6584,7 @@ static struct kvmppc_ops kvm_ops_hv = {
 	.hash_v3_possible = kvmppc_hash_v3_possible,
 	.create_vcpu_debugfs = kvmppc_arch_create_vcpu_debugfs_hv,
 	.create_vm_debugfs = kvmppc_arch_create_vm_debugfs_hv,
+	.get_compat_caps = kvmppc_get_compat_caps,
 };
 
 static int kvm_init_subcore_bitmap(void)
-- 
2.50.1 (Apple Git-155)


