Return-Path: <linuxppc-dev+bounces-25647-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC123C5AC67
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2026 16:12:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hHQys5VPsz2yRM;
	Sun, 09 Aug 2026 02:12:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786205557;
	cv=none; b=hSst94j/VYz8e3/RvcNSd8cdSpwzYGq7cjm/LcynwuzZmWelLmm3S3pfkEIbCc8lyAZVYalQQIHOrURZxG7DlDC0tLcIpgvWwHmrZsRIM8ybQqXeNT7m/P6k0l6yMmwlHqlaDYjuweok09rfLHGI5YIjdzCeIb37zXin95fR3lpDHHvHUmub5Q7wpRTFco1FAhdt7TDscwNHRqM4U7JEbHcBs8oYSDw0+0diIIM/ghuFgSX6fMBNJYwV5tBKcxGVL0M8iTDPcKbm1acLxRkDmgzeRPBDLPuJXLLyrQcO6kNrG4gbs99JMorTG8MMvEbC3PkV/RbJSa5aIdgHjajCWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786205557; c=relaxed/relaxed;
	bh=JK/HgCIRS7bWKsUL0/9kFYeCHCkOOqKTR3vxOapEigE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZgCuurqhI9LZT22bqnj6AoBbiW30JUYeKpS745jVf7iLNichi/ACkUMxuCJ+Xgl2zeEhbBTnuhloOevsK7CPFomVRQkKfT3AZZeRzHco5yRc0fZmd7KsVE4KpEypkpSVsFIM1hPz9V45+lM+qgziGcO16pxdqHQ1nPpCcL521nmuMIvUHi5ZHUVWR2TVUhb0OZPf07kMF3rUgGkOK1y8nJMZZKDs82vnoJ/ofhEQaAqBjNAZ631KAVkCmGNF95oyNSnhkDABzyd6FAh/3laTC7jOJArn1SmoLjgtQ18eeyfFFWoQieHSYK9gsmlQvlnCiBj+Lf4xvQsVdmDegPXrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NYZ5UZ7L; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NYZ5UZ7L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hHQys0B6vz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Aug 2026 02:12:36 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 678E1gVl259165;
	Sat, 8 Aug 2026 16:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JK/HgCIRS7bWKsUL0
	/9kFYeCHCkOOqKTR3vxOapEigE=; b=NYZ5UZ7L1of4H+Pvn490jDmtA5T3NnEFX
	xrqrlFbmTi3P0LMCs8IAUPI7bktx/3mTD+p9MRj0YMbldGIVeuDiXUffg7UkCPsy
	XsHvk2GluLvlYkLRiPKLipxZj9f/B4NuBTdnFhbFT6cKPyQGgCZB0coZKcG0w6wJ
	iarmkObkRIYBfpgjwIfRX87Wvgv5Ezx/9LebHOJs8HbcPh21Kxg5MXkbfhnxY2rU
	J3OE9Ws7k+Q1qBdDBbp7TtRC1xlvYZgYE5RJCW4o7OETJ9RvAS9OpoV399p7OQkX
	LP3NrUDgvN+p3YnDyK68RoLEoU0BDU93XIM8QIr7Tk6SBtKPrKJbw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvkchh4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 16:12:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 678GBJam022001;
	Sat, 8 Aug 2026 16:12:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4r42yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 16:12:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 678GCJvg16253370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Aug 2026 16:12:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DDDC20043;
	Sat,  8 Aug 2026 16:12:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADF5020040;
	Sat,  8 Aug 2026 16:12:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.213.63])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  8 Aug 2026 16:12:15 +0000 (GMT)
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
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Gautam Menghani <gautam@linux.ibm.com>
Subject: [PATCH v9 3/4] KVM: PPC: Book3S HV: Add support for compat CPU capabilities for KVM on PowerNV
Date: Sat,  8 Aug 2026 21:41:47 +0530
Message-ID: <20260808161148.66673-4-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260808161148.66673-1-amachhiw@linux.ibm.com>
References: <20260808161148.66673-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-GUID: j_XrE5XMtz4JE_WllbMeEDU6Ps1XoviZ
X-Authority-Analysis: v=2.4 cv=J86aKgnS c=1 sm=1 tr=0 ts=6a775568 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=jUdWb-NNBahwQYUnPB4A:9
X-Proofpoint-ORIG-GUID: KQ4qhbchK1-rAF86Q0UmdrMVGzQTJ0P-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDEzNyBTYWx0ZWRfX9fCXkeSQ53Z+
 Hd4CF0Cj9AzZSDMwshNqSpy/d5xw46wt0Pfq7FfKbYscLOgFU9arqJTV0rTP6IZJRjVgMlUyoiK
 4Ax1bmvocZjtU2YQ0dSxRA697XQvJhfN6GkdWmIkDNz56QQvTdD2Aqf5++EtRZbpyGC/pusD66m
 GPsldyxhpQ/XImO05Q+I5IclH0oGk5ZvqXzymO3hSYv2hvqgREpQiInVmQwg2XAA7hw/SuE6W+K
 t4rG69mqYjMv7MmNEQTD13n/asZS66M2yb9e+G3XAO8Hlg9mkkdCnZkecIT+A39IXrxtKnIhqHE
 a6XFi2B898AHZDt8jFD+05Z2xjR19iKFYbqgLPr1EWUROkn/CkNXupWjDf1inYOmGLXmNN1RbGb
 0huitwLG7uYhTomIl8v39j+aZracH/qQAqCck5xjE3cj6ccDmp8gY7ogvF94jrNuAA9/WDoefvJ
 2to7p9jdS0B4Cnvcgtw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDEzNyBTYWx0ZWRfX6pyyLdP28/kx
 SAOQ14VRyzRS4TEeI9os/snb4+Vdp4JGsxqx141I8/O5Aoi3cqSuLkwjg2kXTtAJxvdTh66CU/r
 Ti+hsBBmQSI26iJs29maZmYgn+Ji0Dg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608080137

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
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
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


