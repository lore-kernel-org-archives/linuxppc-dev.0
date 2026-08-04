Return-Path: <linuxppc-dev+bounces-25388-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2A3C55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 18:08:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hF1kt1zRvz2yH5;
	Wed, 05 Aug 2026 04:08:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785866934;
	cv=none; b=YvsJa+3oSAsLUkXQ6iRrhSVvcJTbgqyyEegL/1rBSq0C3huGkTwN8m3Detn+qh/mToDEWB2aJa1f4pXyNKxgMRpAsCjDbNcXfetCyKOC2EaRecF+EeEGg7ZWlYTxN3ZUgE4lXs+NB+q342azvpyViDZoFMOGHreOxaZ91ICR+udTkf/LJwF/BlQQkL0RfiBN1SnflqeRfX4scE5nr8eX+4oujqsaBPUPhZ40Qkqqbwdv8tuUnX5tV4pLYO9X1wMKE6Y5CZA3MAlZxQdBiaGXvzYfhEdIULeHRHngQNId8wjTYxBg7ZaCCJl7XFXekiZi2joqpt6sj+RxIBDeFDT6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785866934; c=relaxed/relaxed;
	bh=XXOU/APSKwvaT9fmqxAHzQbFytmWg+/yBqpK22ElJAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omkhF8kRdPjWzFCm6ZOgRMs8YmO/dcsvzJYeStYLlTwmg57wYVfQ2/i9yednEdeeEl6/5nv7VIz47/a9hVE/1Ni9XXpcyJHHVfmX1VrRcx/wTTDS6Sz/ek4vP8vd5td7HWpY1FBvLwVjYy3lQUXbPf8kE524DC9xb+TfEQPfQnvQ52TxEgv4+ALmwu4iEeNz/5xu1sf0tEID8d/G3IwIdnew8CwoTCx/V84PcOhMlGU7Z73SaOqAf8pq/OVQBZSH8goRtDMehRgs8Fq1J9dsq+mGxd58+nC18Eg4dy2LmSxQULpe1kVUB5efBQrhLX6H9YLZpn4+F8X4kHN5ZC39GQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TweXF98m; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TweXF98m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hF1ks2tPmz2xy3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 04:08:53 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Fll3Y1340890;
	Tue, 4 Aug 2026 18:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XXOU/APSKwvaT9fmq
	xAHzQbFytmWg+/yBqpK22ElJAg=; b=TweXF98m+8i39WnA80gVETdaGErKZ1vK2
	hU5LW6xr9ZNfICLOpmZdF8EI9zehfX93Sj2PqB5w+uFqiHjlNubp4ahMEy2MpGDY
	vJ0GLan+btUiMr1i16oUH2ZrVpeqXsSGXjGpGl1Knq1B4kc4d2uT6MNt8k6/WwsS
	YqHPfVzG9pEGOmHENWp76KDFCQoQ/NyiGdm3Lwnk/cFMhN7uPlpi7HDb7FC733bY
	aCvp2HRYv6kv9sp+DdJCFgjNqZ15Tnp9UbZjO5u9aXMIv/ALNycmM7JRkHNcbvsH
	gsn2lRLqg+KOnqCeX5PV9W3MqrHU6AZBBw8GnAxbcbRhe6l4STKsw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eupt61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 18:07:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674HuO0D019969;
	Tue, 4 Aug 2026 18:07:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw386n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 18:07:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674I7Uii16384462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 18:07:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B5012004B;
	Tue,  4 Aug 2026 18:07:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E823A20040;
	Tue,  4 Aug 2026 18:07:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.28.45])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 18:07:26 +0000 (GMT)
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
Subject: [PATCH v6 3/4] KVM: PPC: Book3S HV: Add support for compat CPU capabilities for KVM on PowerNV
Date: Tue,  4 Aug 2026 23:37:04 +0530
Message-ID: <20260804180705.59160-4-amachhiw@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 3xVSlQ6V3hf_ivBYkimkIRWbrfOKS5Gs
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE0NCBTYWx0ZWRfX7qnw8QpC3FLi
 aa1phIRwyl9Crn5eI/GPXA/AnPLjD++9OaJ88hq3aJB/YS2Sl8VezgtPeomIBCtnuCkBYuTMIC8
 OrhBxS89AchAwo41CoMN97ibLDZgnvA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE0NCBTYWx0ZWRfX1XKEmNXSsDYt
 GDFnCyun6cNZxY6WjQQiap6alU/C3Q1tbjlyES8sJIe2Vrp7DvDGh3WudDdyTVHofilkhSj5joB
 744xET11BKwWdXJdy1CmSlH6CjD6I8PkyguriK+CMe9vrUkW/lQ8kKyKSsv/KXd6uEmJRF/GqSN
 NwE09Ve8lV5az7LX8oB3iQeJ/wR6Yf4uRW5ySvqbct0bWFqqSEgpw++0s9zb3rywiZeDGMPhrMw
 1rkNRvb/p13bvHil6O5HVVy/Q86sqRraljmGMRstBq0a2U0IgY9BwhDrMV6hExCb1dSHEiPRbtH
 nSIBseQYGdBl72JAg+NHoi4BZQ9a8iTimlHsiNG3UouXDJpLdXnC1ehn9/6rfQ0R3Aujd/37e2l
 zXK8jsJZ9Z+pumStJM31sJC3qnQxJQmZvcc7bxYcU2jWVk+VnWrq5AVPT8k/pZcT1RtwWIP3xR7
 ZKiQ192ev8a7bcJx/HQ==
X-Proofpoint-GUID: Jg64hRtQaAf4DBMEhWbYH4ikScW9ZYMx
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a722a67 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=DLIAxpZkpLpJS96MVYMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040144

Currently, when booting a compatibility-mode KVM guest (L1) on a PowerNV
hypervisor (L0), the guest runs with the expected processor
compatibility level. However, when booting a nested KVM guest (L2)
inside the L1, QEMU derives the CPU model from the raw host PVR and
attempts to run the nested guest at that level, instead of honoring the
compatibility mode of the L1.

Extend host CPU compatibility capability reporting to support nested
virtualization on PowerNV systems (PAPR nested API v1).

For nested API v2 (PowerVM), compatibility capabilities are served from
the cached nested_capabilities value (populated at module init via
kvmhv_nested_init() using the H_GUEST_GET_CAPABILITIES hcall). This
information is not available on PowerNV systems.

For nested API v1, derive the compatibility capabilities from the L1
guest by reading the "cpu-version" property from the device tree, which
reflects the effective (logical) processor compatibility level. Map this
value to the corresponding compatibility capability bitmap using
KVM-specific constants.

The mapping is cumulative: a system running at a given compatibility
level is assumed to also support older generations down the supported
chain. Note that unlike KVM on PowerVM (nested API v2), KVM on PowerNV
currently does not strictly enforce older generation compatibility modes
for nested guests - the reported capabilities reflect what the host CPU
can present, not what the hypervisor independently validates.

Introduce a helper kvmppc_map_compat_capabilities() to translate CPU
version values into KVM_PPC_COMPAT_CAP bits using a fallthrough switch,
and integrate it into kvmppc_get_compat_caps(). The implementation
applies masking to ensure only supported processor modes are exposed.

This allows userspace to query host CPU compatibility modes on both
KVM on PowerVM and on PowerNV platforms via the KVM_PPC_GET_COMPAT_CAPS
ioctl.

Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes in this version:
  - kvmppc_map_compat_capabilities(): changed parameter type from
    'const __be32' to 'u32' to fix Sparse type annotation warning
  - kvmppc_get_compat_caps(): replaced of_get_property() + be32_to_cpup()
    with of_property_read_u32() for implicit length validation and cleaner
    endianness handling; dropped 'const __be32 *prop' variable

 arch/powerpc/kvm/book3s_hv.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 152cd08a5b38..4d0307f55e06 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -6523,20 +6523,56 @@ static bool kvmppc_hash_v3_possible(void)
 	return true;
 }
 
+static int kvmppc_map_compat_capabilities(u32 cpu_version,
+					  unsigned long *capabilities)
+{
+	switch (cpu_version) {
+	case PVR_ARCH_31_P11:
+		*capabilities |= KVM_PPC_COMPAT_CAP_POWER11;
+		fallthrough;
+	case PVR_ARCH_31:
+		*capabilities |= KVM_PPC_COMPAT_CAP_POWER10;
+		fallthrough;
+	case PVR_ARCH_300:
+		*capabilities |= KVM_PPC_COMPAT_CAP_POWER9;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
 
 static int kvmppc_get_compat_caps(struct kvm_ppc_compat_caps *host_caps)
 {
+	struct device_node *np;
 	unsigned long capabilities = 0;
 	long rc = -EINVAL;
+	u32 cpu_version = 0;
 
 	if (kvmhv_on_pseries()) {
 		if (kvmhv_is_nestedv2()) {
 			WARN_ON_ONCE(!nested_capabilities);
 			capabilities = nested_capabilities;
 			rc = 0;
+		} else {
+			for_each_node_by_type(np, "cpu") {
+				if (!of_property_read_u32(np, "cpu-version",
+							  &cpu_version)) {
+					of_node_put(np);
+					break;
+				}
+			}
+			if (!cpu_version)
+				return -EINVAL;
+			rc = kvmppc_map_compat_capabilities(cpu_version,
+							    &capabilities);
 		}
 	}
 
+	if (rc < 0)
+		return rc;
+
 	host_caps->compat_capabilities = capabilities & KVM_PPC_COMPAT_BITMASK;
 
 	return rc;
-- 
2.50.1 (Apple Git-155)


