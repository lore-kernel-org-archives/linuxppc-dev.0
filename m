Return-Path: <linuxppc-dev+bounces-25386-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1E9C55822
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 18:07:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hF1jS3zn0z2yH5;
	Wed, 05 Aug 2026 04:07:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785866860;
	cv=none; b=jtxdRN+w3EEZrUfnEmYszgoMuKBeddkLEnbh8gFqgAD4nUDPamzQRt4zTVQtU4Ye4gwIS998rRYnoiqi1aNR0zElLqM6mATYYriqLi/luDlUVoXDgOzCtS99V+gRDsfqXUwHHKJedyO/9jvW7nq6D7ulLUdBmXv3HkuI7nHSSX4eZQhK4N7alCRIHj8F/wUNT1xpYqEieqlZ8UWGOYyzX91W38Nv6dLCZ38281APaK0R0OV1KUu3B5mA5P9k7l9Ohop32KS6W7QWgMMSTJ/U7stgGv2pM0bcIhZwX9lSy6ID1KPrEJ9lwQZcJLE9lOGjnH//IOPrXDGrH1DUI8ZQWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785866860; c=relaxed/relaxed;
	bh=S6EmFhlsPXTadBY0KSq8+JtgJ8yqQI5GUQMJWErFteo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNkMN5qMHpEJyD4GTh1gUVNnBZcuB4fZta0U4RWwCWs3LFsK97tgqF1SWmusC3DObyDjv+gOuxb6TOzPfE7eUeY0LIQozDOt236E/oYv94WD7e4/y5r5In4WtLeT2XHKwvx+fIHkr1sgcOzzqCcMmza8eSQcY9pMqmPjHkRBdgohFl5kAnHZV7VFhwZqzM7vyDPh5PDEku3xzELugw9tNPnWe8On4MnyiCpnEPa3HLMZXQsKP/HWgC/ELufRlaeexUXc8Hpu+643dVWe5rpScFd7FyQ5pfchfdUm+f8wEZ36kREe6s+yEbPVYbFyklVChPePVU+WXJOv8EIdo61A7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IIGmaGhI; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IIGmaGhI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hF1jR69bPz3bps
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 04:07:39 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Flhmd1286424;
	Tue, 4 Aug 2026 18:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=S6EmFhlsPXTadBY0K
	Sq8+JtgJ8yqQI5GUQMJWErFteo=; b=IIGmaGhI0cJbh/cK7FC0Gi1xz8pn3zGhe
	w5QuZpLYPsCHfP7N08sqbClYQatS9D8fk41QddwfKq9krs117Bp+Ls2xOJ7cIjkO
	PpMcdgYe8B1YscyxlLjc28Wj83lGogiNg8KCj48/b0YPtTbsUNmm6ABVa7ecraAm
	SckmD9kI/7Elu4FsqEjmsjGgmG3u8bUriMrdBESRudJBA9JIu1nKX8OMOpxZcVJG
	YnPV6ka1C+9IO3XSzXJecBG3v3M2A9GVcxLvYaSa+K3vAm84ocVRk5YAsuDaGh/F
	6Yc9kBFQRz0ZYONbGDYHUo+KBWLoTAwEILluxADcnORgzZl/GwnkQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4ya1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 18:07:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674HuFv1032527;
	Tue, 4 Aug 2026 18:07:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgaxnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 18:07:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674I7PrN30278014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 18:07:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA9F52004B;
	Tue,  4 Aug 2026 18:07:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 126C820040;
	Tue,  4 Aug 2026 18:07:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.28.45])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 18:07:21 +0000 (GMT)
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
Subject: [PATCH v6 2/4] KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM on PowerVM
Date: Tue,  4 Aug 2026 23:37:03 +0530
Message-ID: <20260804180705.59160-3-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260804180705.59160-1-amachhiw@linux.ibm.com>
References: <20260804180705.59160-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE0NCBTYWx0ZWRfXyMfJv2oZUfi5
 BRcOrPdbqbrR1QkEu+K2BsGUSOEmVDVCcywSmc5GOyiWuyG6z04Rtn+HnP+hUy+DUZX0RC2t8fm
 OC75hOAJPfI/XUuGcWmIuxadzUHhnUk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE0NCBTYWx0ZWRfX84cHFE2UfVCx
 KQWP++aQv+pUsOH6zAoKphr/+/E7rZ3BvlANA0NlDrsBRv+dTgFFt10HFTI/cr/DitToh89Ek6r
 qK7hlYkZJ1eAPFtLHswko1OqoDVfXv/vBdiLyKvZ9ETwa3l/ONR8ezs24PJMl+hTSyebjD2BIbO
 geDqH41MukTHuG3oqV/f1L0JtLZQ2LDTHOS+NCCj9nS0/zc4uTBEdvQyewvcL0rl5M8GS0TzPGd
 Xr7tY6pyBp6RDGkBJfrF1jgnEUsDVtCq9pHxBok1omlNIJ6DNuaYlgtdEK+leeY97hdAcaA27WZ
 kjC6pxoR9H8jIRf85fnIzDnz3eHtubdJr1ysbvOXdNk4zSRe3uDg1C+LPBi3cu4aISZ2OCt9sA0
 kOjNxKEZS7v0PiuHEuagGuhyTSjQG7zVuIQew4O3JJDNimEQz+w9mq3tMKjIs94EpDpvFArfhUV
 AaHozkhJ4gsRdSHTmDA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a722a62 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=igDgF-0WGXUSGxExIdQA:9
X-Proofpoint-ORIG-GUID: CE_OMmF79Shp7iLHFEu-kwj8Vr0D-eas
X-Proofpoint-GUID: W9SBon8P-WW6oUCMhMSjhbPHEKhqxkli
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040144

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


