Return-Path: <linuxppc-dev+bounces-20337-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10783CD13D3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 05:51:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5jvm3Htlz2xnM;
	Thu, 30 Apr 2026 15:51:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777528260;
	cv=none; b=Fr8g5VzRmZpttbxAVxkZWCMUAO+oJvRLFwX0rmHPo4GKtIJCvBLQKxKVlnY/EqqD+YxOP+xUG1jL4D2kqbX094ct/10wu5cKb8z5we8aNplmGtarW8Ax6/N9c/qGWEVnDcVKdBixbEVQ8YSB9oVF5d+g1St+6T2SmTV2KaH82YIZdvdyNzkWUi4ym6QEzwjWZqSNBst7yb44f0PqPLlbM08SW6dQfUUdSEf9wf1lwwqxGpK2Xx+d/Ju7cUpR+cwFw/+ZPZZKa8uKzn/Fqq2Bi0K9zE/Y3d9nGlF4bPNsq6XVaYNS9Naz1gRre6dPwj9d9Q7VE/1UEVHVju0S7A6eoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777528260; c=relaxed/relaxed;
	bh=Cy6bOdGwcpAN6PjTw79AQNezQbvoMdFpgvQLRpDMT4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5WRbcNhhep+dzlb1gkxURvPsBVTe3cIkXtt1jdCvztBRLXvVPsgmJCykrnfZipb+khkUdMYXxM4xjgnjnfB7ggEy1uYGbTvr8oz+urgLV3lmfyBhHoJ/eOQaMIKbAcCdMeGo3mkpUJdBz3RN5jJsuvCollTmVy+a6PEF4kIOh+6oUPXLdKWPwv8JrXEKIbrcHqy9bdunP/MYqgBjmJvXvW/0DzqH0Yc2NuJzebtkYOBfXkzAh2HKPIXfQJuxI1R63MD4D/mp9obp2IpXU4+/3iF5g6UlLbixKogo8YupNJnO4cQVo/JPcYjYYmQfo19jWdFc5bLURVFkJ0tZhzwPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Xx6zKEGf; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Xx6zKEGf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5jvl4sQtz2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 15:50:59 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TGV5kW2037068;
	Thu, 30 Apr 2026 05:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Cy6bOdGwcpAN6PjTw
	79AQNezQbvoMdFpgvQLRpDMT4o=; b=Xx6zKEGfL7r8a/2aJpcd+XBzp8SJckW2Z
	N/BTFMBuDZ+WkAvGPbQCWQkNSaFtSRzcGubBS8vCIIdfchvyjn+ZGFkbiETATQyZ
	acb1mVOKzGYpbHyQRmeiROMEvFFfKWLmOeHdnbRqGnTPOxe15Hxw3n+Bg3JzSQy+
	mn/tV92igrKC3WOn/5PCQc4ZrEp8heq4SVa8zEm3hOLZEpSClLEUTVkwXcIRgBeH
	HHsK+26Z5U3mWgBp60T7JDHycQkBDsoYhAR70WTlD4RIChq6VYDyPokj5S8q5LoC
	6pzKbo0ye6GvUN4cbFqVFcBZVRq0SXDvPf9rXoRsEkL+QIa38p4QQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jvm7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 05:50:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63U5colb013174;
	Thu, 30 Apr 2026 05:50:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5ghems-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 05:50:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63U5ojMI43516166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 05:50:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B0C920043;
	Thu, 30 Apr 2026 05:50:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FABA20040;
	Thu, 30 Apr 2026 05:50:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.18.70])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 05:50:41 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] KVM: PPC: Book3S HV: Add support for compat CPU capabilities for KVM on PowerNV
Date: Thu, 30 Apr 2026 11:19:04 +0530
Message-ID: <20260430054906.94431-6-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260430054906.94431-1-amachhiw@linux.ibm.com>
References: <20260430054906.94431-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA1NSBTYWx0ZWRfX8jDAyDYbPtOE
 Eg8rmNMFA6EGZhA7uZg0FYtC9vDsNcUzUjLGExNIk3+kwyY+t8qXirKd9C1fVicTKqbsF0lz6xv
 JhPRPoqW2DUNEzFAK5fWm75SK9Gy6cu6nI2ySzSxiatxEx4tiwQAbGG8hgq5YZ3TKpBZ4ALUWTU
 x6dqeZzEl/XfKF3b0dm8JLOSjRXSqGHK3m4NORwa2eWHz38eHO0AJ009+JoR9tq1bkZN16dF9rn
 S9ho+lIanXoi19X4FAEmkT3iMPT9Vrhvzy4pNqLY/kRbyjuwOC1jh2Zl9/nNXfi8C59wjqc4Z50
 1jnb48V85Sim/CxmKC7BIlXy0NhdCDGO32aCZXyWFP8XSC9Jt0LVhSCJ7GijVvjXWURDEp+DxqH
 ioeJL0EsSvuTM0R0rzdFgKYJlTi49/15MScXq/M183CSHa0c2MChBkN9NNK2GYlJjJT26esuTEw
 dwOMZCN0UdUF7Tf4+kA==
X-Proofpoint-GUID: iUj-YKxo3sPB2St381_RksO7wj_EEXK9
X-Proofpoint-ORIG-GUID: xI8XyEiWmMkw5kpVVqnlBb77BpNUczlI
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f2edba cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=LbGGMz8L2r-vpTRwWUsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300055

Currently, when booting a compatibility-mode KVM guest (L1) on a PowerNV
hypervisor (L0), the guest runs with the expected processor
compatibility level. However, when booting a nested KVM guest (L2)
inside the L1, QEMU derives the CPU model from the raw host PVR and
attempts to run the nested guest at that level, instead of honoring the
compatibility mode of the L1.

Extend host CPU compatibility capability reporting to support nested
virtualization on PowerNV systems (PAPR nested API v1).

For nested API v2 (PowerVM), compatibility capabilities are obtained
from the hypervisor via the H_GUEST_GET_CAPABILITIES hcall. This
information is not available on PowerNV systems.

For nested API v1, derive the compatibility capabilities from the L1
guest by reading the "cpu-version" property from the device tree, which
reflects the effective (logical) processor compatibility level. Map this
value to the corresponding compatibility capability bitmap.

Introduce a helper to translate CPU version values into compatibility
capability bits and integrate it into kvmppc_get_compat_cpu_caps().

This allows userspace to query host CPU compatibility modes on both
PowerVM and PowerNV platforms via the KVM_PPC_GET_COMPAT_CAPS ioctl.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 37 +++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index d602d90111d1..25d05f1ccb72 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -6516,16 +6516,51 @@ static bool kvmppc_hash_v3_possible(void)
 	return true;
 }
 
+static int kvmppc_map_compat_capabilities(const __be32 cpu_version,
+				      unsigned long *capabilities)
+{
+	switch (cpu_version) {
+	case PVR_ARCH_31_P11:
+		*capabilities |= H_GUEST_CAP_POWER11;
+		break;
+	case PVR_ARCH_31:
+		*capabilities |= H_GUEST_CAP_POWER10;
+		break;
+	case PVR_ARCH_300:
+		*capabilities |= H_GUEST_CAP_POWER9;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
 
 static int kvmppc_get_compat_cpu_caps(struct kvm_ppc_compat_caps *host_caps)
 {
 
+	struct device_node *np;
 	unsigned long capabilities = 0;
+	const __be32 *prop = NULL;
 	long rc = -EINVAL;
+	u32 cpu_version;
 
 	if (kvmhv_on_pseries()) {
-		if (kvmhv_is_nestedv2())
+		if (kvmhv_is_nestedv2()) {
 			rc = plpar_guest_get_capabilities(0, &capabilities);
+		} else {
+			for_each_node_by_type(np, "cpu") {
+				prop = of_get_property(np, "cpu-version", NULL);
+				if (prop) {
+					cpu_version = be32_to_cpup(prop);
+					break;
+				}
+			}
+			if (!prop)
+				return -EINVAL;
+			rc = kvmppc_map_compat_capabilities(cpu_version,
+								&capabilities);
+		}
 		host_caps->compat_capabilities = capabilities;
 	}
 
-- 
2.50.1


