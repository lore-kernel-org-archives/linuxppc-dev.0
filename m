Return-Path: <linuxppc-dev+bounces-21406-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDD8CD5BB0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 15:28:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMTgw0KbCz2xSN;
	Sat, 23 May 2026 01:28:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779463708;
	cv=none; b=L5SD8RFG250PsPrC6nklZOJo5i1rhqTSgnlgPSmjajoWQVuriMxTl2eFVnKgmeKqDK0N/1aqCw5ghocLwQ1uTBqHVlrokrDm9jCcinRyjgphkY07sPQ0h3xU7xp85/fubapCKl7+ZDJa00qBvf4sLKG4c/Bt46eT0xGUS8eR+WZUbApDe5R9oT/i+OPdhnj1VgQdMl1WuTE635TTnAhUd4egrwd891FQh7qov6Djs+9ZO73gYkp3YNFmiKJWDsLMNPePVsR3+HpW848lHFmFleek2iLaQEkeVm4iMOKy7tRfeB63h6sN3gxiUzfNnBSgjMtqKM3P0QPJcfXBwtnDTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779463708; c=relaxed/relaxed;
	bh=MsDcKiTCtEL9YEmV+PFaK7W/PFOpWT1cVYMUo4pp0co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoDGVoMtPyVDmN/Te+oRSyl4crzwb6eLnwiMBKXaJaZu/jS3j6v6pWe5iPv2/lpqznYzzU5KcXlOFAehMwVH+XGyc5pcS48bcn6Nx+7MPc3I5bzoki8p5HyaPmIz23t7pak7c2daLqoshqEektv2Sd85IAfL4dA5YPoOBJvHkd7J+EvSQVtmNL/5CmgqPiwLdthaUxah03VJENYKzX+XTG5vJ6O6RRhqe6kh2g3UJ7CEKtLKUeWMCi6uDycLPsBAW3RES29PnbSCJSR64goT/mae0OZaZ+AXKqMcUiBYQEC8B/EmoO+JGyykNA8OPLldc+DgSMl9Cx1cNazm3G53MQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=C6F4qEsn; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=C6F4qEsn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMTgv26hBz2xK4
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2026 01:28:27 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MCdwEt764296;
	Fri, 22 May 2026 15:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MsDcKiTCtEL9YEmV+
	PFaK7W/PFOpWT1cVYMUo4pp0co=; b=C6F4qEsnVMMXjlU5m4C5TEtv02gxk+bc0
	ULZcMFuUrKbItcRcNqAZJcc2cbQKLlGS8Dn80EBOxlQIvKbUTjHU10gwWDV26Jxw
	vuW7e3K7O9MAJfKizd+YuyT/0tiORY/PzhtYuGd9bzcLmwfX7CyoS0pl9j9T3QH1
	ffwUWZMDrVPUTuUixKfZwwwJx2akRk3eJFHIRTX/AslyS78yJbvrOsy20O+UezCX
	YBePWTBX9/S9L/kx/3qMuxAdQ2zCP4M8JrrZowWmlEh28UyV96IzqkTph7MHs6Le
	TwyZEAkeadYI2QCC/4xc4Q9sFq0TkgStV5hYr0xAS3ow2v7qP+QOg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hawk6us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 15:28:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MFO6P3013538;
	Fri, 22 May 2026 15:28:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dj1cv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 15:28:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MFSCGx59638226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 15:28:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 956D420040;
	Fri, 22 May 2026 15:28:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FEED20043;
	Fri, 22 May 2026 15:28:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.216.126])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 15:28:08 +0000 (GMT)
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
Subject: [PATCH v3 4/5] KVM: PPC: Book3S HV: Add support for compat CPU capabilities for KVM on PowerNV
Date: Fri, 22 May 2026 20:57:43 +0530
Message-ID: <20260522152744.55251-5-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260522152744.55251-1-amachhiw@linux.ibm.com>
References: <20260522152744.55251-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE1MCBTYWx0ZWRfX4FXsjy0P3w8q
 gYhrNFFzJA8f2Id/DJtt5yPBT9tBrwmZuycxHbkG6TvME6K61U81jOH3OwHd9/Ih927WAtsVrvI
 wiHPz1B/PvIY7RTjKgxU6rOf0t/J1d9v7elM/o1xnvM0wTUrd2qlocj0eYV4WTlhB8KP3/2a4Hh
 3aQSJmDkCcoblV5DaJIh97dERK1MbyI2RmxcuPC77NOGPSn0MFSDz2MxDT7o9OFL+nawbFoLmhn
 1AASSESeAx0zaIJjhlHQc2yzBIalSEyqDkOqJdPpRCpMfdLBTU4h0G6wgrXDGg9dzZNtq6DbnTq
 cYwKq5fy7q7fmZBL/87fFPvNAi+QowL8ZpEhFe4u9x7dPEJ0879TeVGXl7CqxpMeImaVNONCskY
 LKi8qyxmsOl5GN+xbcENF1GTko+ipL/5UdONCD8XQDMBr6ogX0OTA4qdXUlTtCTaABjV9qPgLk4
 WyqOuPtvISk8Phl1sVw==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a107611 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=LbGGMz8L2r-vpTRwWUsA:9
X-Proofpoint-ORIG-GUID: ejG69M8c7fHnpUbCL9umDKHTMqYjUOUx
X-Proofpoint-GUID: gqHWUPu5-2Tz1rzU0Dr2IZXkpWdtsI7-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220150

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

Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 37 +++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 38de7040e2b7..18774c49af85 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -6522,15 +6522,50 @@ static bool kvmppc_hash_v3_possible(void)
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
2.50.1 (Apple Git-155)


