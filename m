Return-Path: <linuxppc-dev+bounces-22703-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52240CD98E6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:35:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfmfc13Twz3c3l;
	Tue, 16 Jun 2026 22:35:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781613320;
	cv=none; b=DEZLlZ48T40rMRSlIMqLQT/oa4vXF2uu3DevVH76gHcItQDgDeBA+muJBnKxmuVSrYiKMDC0F1Y6HE2lPUzdGdkWUr6DR2UoW/xhjvaTSHPHw9EwjBZ2tD2g6v9LOp9obdJsdVUELr3t8j/LljWbTdQ1LSUPj4yYlM0wxyMoRp0WdhAObfZ338Ig4nOUNSE9qU4iUdUWIW0yyfcXAFgqVSpoIzhOgUOBYVtsrb4YA9GDdLZ583778p9eRaob9X4lYUckaCTNfDvFl6iwlHxsKNuEFDywfDOKKDh4FB4U/Vk9yShmHJ3lZoqaRT1eP5IQYHpOLVvAgvs/NOyqqXUwmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781613320; c=relaxed/relaxed;
	bh=ha+bGUGTR8KBNC6QyJdM1hAIx1NU8+xTC9P5aPe6FX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUl+AIO/g8M3vzlBCoQf6ISMlrQNlOTj8DuVxsA/D786GhpeGrO6aGMH6+Um6y11rgpE27nHrHFVlnKfQ8BVGsm6XdSWD/T5QivTOd97+g4nbN7XbqM6M4nzYjgC9Tp5tvuBSOdFsvIZWGmOkOamW2RsyqV6vdEaijdHiG/sqWT6RqcvEyV8kyegA5xsVCBFy+hZMto1C+mM7EHrGKjnMG2y1NPSFRiHutmgFUA7SlFIg+hENXaCj44Xt/9H+Lj+ZjuYm0iRCiCxGD6BeO3b6ODlUIEyxRSIPNYrS1KjS+mbkyiI91twzQu4CD0MDLkWHumPXE/Bj1HUEak1QIuVPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XNJPt4if; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XNJPt4if;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfmfb0R20z3c56
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 22:35:18 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAIstu1157048;
	Tue, 16 Jun 2026 12:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ha+bGUGTR8KBNC6Qy
	JdM1hAIx1NU8+xTC9P5aPe6FX0=; b=XNJPt4ifnnZffJrnoRspsEVcT3Fx9S4H6
	q76/QlZKSUQSXOptPjWlVezXbQBnb2R/v4C0gIcohKTSSJxzQ/+1MGIwTjyd+NJt
	rK7abPFzSfCb1C/wULNG1Z5WFfjKGk+Kb8sKnFZZuapp9bCOzQ3O7AlLpLoTvzEX
	dI3j5QFG6XHnPXFTMXUzM3P5rrvxX1Vjdn4FZgLpU2dPx/efsSxXpJ2pZja3yZFW
	O3Y32WjA6wUrUiGZxH7rF/uQdsEP+r63DIq6wJ1FJiVh/B7duKP8dexudqlYpxJj
	VZuLCEc33v1q3EddNnZ28itTfkfTXs8q41jGyPLLL+JCxzcFwcWLA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1eg52qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:35:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GCYeXN012938;
	Tue, 16 Jun 2026 12:35:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eshhq3fdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:35:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GCZ3xM30540372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 12:35:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2A0220049;
	Tue, 16 Jun 2026 12:35:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A42A20040;
	Tue, 16 Jun 2026 12:34:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.31.150])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 12:34:59 +0000 (GMT)
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
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lkp@intel.com
Subject: [PATCH v4 2/4] KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM on PowerVM
Date: Tue, 16 Jun 2026 18:03:12 +0530
Message-ID: <20260616123314.82721-3-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260616123314.82721-1-amachhiw@linux.ibm.com>
References: <20260616123314.82721-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEyNSBTYWx0ZWRfX4ePKvYANwdNO
 aRWyIhXwXG+f0J4JdUeiQVA+Fu5KGtL+kdJs6zaUsWCi0zU8JunWBvLGqUiqZLrvA5JJsKJxJ7m
 G2AJah6Fahj1HIaW9v9/w+AnYvNXxt0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEyNSBTYWx0ZWRfXzTruI16xEFQ5
 x6nrDAOZ3Tclozfyry+0CpB8IZiWg7OP5X0BukfwTwUcHfnz0yXXGpo9A5rZe07AY5K2WNj+MyL
 an1F8dM0zqlJZ/KYhLJywCLXENiPamzVZ5KxvZ5a7zbTXBQ07m2Z4Hn+hpYo2uBqI6YQXHihcvu
 2bi3x7VldofY/dO2sPFREyUlhgJ5rnwiXVEZVkwcqKxF6dZKz2ZL+JUtD+SVZIp0oTHlaj2qrg9
 E1oPDRPlLM/FTtiI0agquCW61woYqj0XSdvlMKysAWQZ9GfwcFeto3N9UpbNuQFSYK1wltb1YIG
 +Q3B52hffkUARnOIR4fMIpVJDX8fkLpMV+of72PFD7y1m3qOTJZUGKfvrfA6T/aF8ffAT3Ogpkj
 Jqtq107j5ymCvwBxBnEocaoQxvH/NX5a9JocM34w9k6W/hxPV0OWcCY0/a8q+93KGk9B0CVmVsS
 VtjyfLf0/7Gur6ETbeA==
X-Proofpoint-GUID: WhMlhZqK6MpE-jcKybBoM7Z8DvqO_Wm2
X-Authority-Analysis: v=2.4 cv=NuDhtcdJ c=1 sm=1 tr=0 ts=6a3142fc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=igDgF-0WGXUSGxExIdQA:9
X-Proofpoint-ORIG-GUID: Px51e8qT1QLwWCMxbUPtoKJFEUKP8z8J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160125

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

Add support for retrieving host CPU compatibility capabilities for
nested guests on PowerVM (PAPR nested API v2). The hypervisor provides
the effective compatibility levels via the H_GUEST_GET_CAPABILITIES
hcall, which reflects the processor modes negotiated between the Power
hypervisor (L0) and the host partition (L1).

On pseries systems, obtain the capability bitmap using
plpar_guest_get_capabilities() and return it via struct
kvm_ppc_compat_caps. The implementation defines KVM-specific capability
constants (KVM_PPC_COMPAT_CAP_POWER9/10/11) and applies masking to ensure
only supported processor modes are exposed to userspace. This information
is then exposed through the KVM_PPC_GET_COMPAT_CAPS ioctl.

Hook the implementation into the Book3S HV kvmppc_ops so that it can be
invoked by the generic KVM ioctl handling code.

Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 arch/powerpc/include/uapi/asm/kvm.h | 11 ++++++++++-
 arch/powerpc/kvm/book3s_hv.c        | 17 +++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 8a38be6c3b03..730488681443 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -443,7 +443,16 @@ struct kvm_ppc_compat_caps {
 	__u64	size;			/* Size of this structure */
 	__u64	compat_capabilities;	/* Capabilities supported by the host */
 };
-
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
index f9380ef65750..f674386df62c 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -6523,6 +6523,22 @@ static bool kvmppc_hash_v3_possible(void)
 	return true;
 }
 
+
+static int kvmppc_get_compat_caps(struct kvm_ppc_compat_caps *host_caps)
+{
+	unsigned long capabilities = 0;
+	long rc = -EINVAL;
+
+	if (kvmhv_on_pseries()) {
+		if (kvmhv_is_nestedv2())
+			rc = plpar_guest_get_capabilities(0, &capabilities);
+		host_caps->compat_capabilities = capabilities &
+							KVM_PPC_COMPAT_BITMASK;
+	}
+
+	return rc;
+}
+
 static struct kvmppc_ops kvm_ops_hv = {
 	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_hv,
 	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_hv,
@@ -6565,6 +6581,7 @@ static struct kvmppc_ops kvm_ops_hv = {
 	.hash_v3_possible = kvmppc_hash_v3_possible,
 	.create_vcpu_debugfs = kvmppc_arch_create_vcpu_debugfs_hv,
 	.create_vm_debugfs = kvmppc_arch_create_vm_debugfs_hv,
+	.get_compat_caps = kvmppc_get_compat_caps,
 };
 
 static int kvm_init_subcore_bitmap(void)
-- 
2.50.1 (Apple Git-155)


