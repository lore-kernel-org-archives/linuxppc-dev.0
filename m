Return-Path: <linuxppc-dev+bounces-22706-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1A2CD98DA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:35:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfmfn2C6vz3c3v;
	Tue, 16 Jun 2026 22:35:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781613329;
	cv=none; b=EewEhLDOYpFoAnSw0yPchWgLdgkWgwre7pD29xLr2BECx8rxI0igwGlxn9mAIXADojXSvqoyjAHmhq7RvRZqRPgZGMmvhCeZOksYkuUujcu8wFk4MKsHVnA7ErSZCmiNafB8kIbQMjIvztq7a93B+SvrB6C5CXatG8WEu9y7+F0AALmlBp9bmpvN/n9MxMEL2bbar7StKy6xTaivtKt95WFxyBT1NMKBIHr4LQ33gWzabbxFVXhcjfOtHCTK+TY8eUQuf8xCkNUt3H2UzklpumH31vN0zP3+HICdD5twnX/6wfX8yxX2wlntxEFFTTtq6XbRjT+32mHN3dkYrdTRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781613329; c=relaxed/relaxed;
	bh=VuRc4io9USge/gkQFeOWbWCm8AnplEJOLVioewD/i2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0mksKrpU77d88X7JBuP2xdptq+wNzYTQMryM7O9gzSuoL0MW47K0/QJ985C7oDS95mU6Uf3TYLpsXOIWCwYFFnaR1V5VXwS4tujdvOjlwQRGN4Q5WpNg0YKatOJ/6nVgFR9yuQggVy3svjCR5X7cWKfdwm1QqRbARh5GU4TL3cw5f/WkSg3ZXeHMMKXoEIxT6QSo5UTCIDlEcZ0Pw6NRNRlRcGQJ3pxpcFSUmwJf5hkGFap4C3FinbRJ33Uz41ZCjkTs8K9a2ZaT/8rP9RdLs0e/dJht6Z7N/Asa/NDYyy+QN81hmJgcUPWXQ55AwRWMrz8ZEw6UVX765wruqBg3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tZK1/BqW; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tZK1/BqW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfmfm3fl3z3brH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 22:35:28 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAIZeP1156428;
	Tue, 16 Jun 2026 12:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VuRc4io9USge/gkQF
	eOWbWCm8AnplEJOLVioewD/i2o=; b=tZK1/BqWSgLwoz+VeZxW1B6MCmJK3xFBW
	mlGnkSebd90fOAK4Fwd4A1kILIrl24uzADEgbGPcbpBiUnRqVarnRNdjEqG51fDK
	4cD7bHrYTswmUjqlQJuIaTZM+CdiQ6SCARSWNrGO5JyRmn6TRM4V9bZH2V2IqM2F
	WWpx6rGb81T5zznPwlJYI0GSilujKF+Eoouq8POLtYefFxtuatuyfzARcMRksXTz
	9+kvdc38oS3+Vd+Kh8VbLLmgdxRDDtBfpvKqQ7qUQ+VySG7ObPaL0huggxnlzfJg
	Jo/bk5dwIoZA94fQRfTqoVIJSQQGD1hRE/nklmTSKcgX78D6MHHtA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1eg52rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:35:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GCYa2p010632;
	Tue, 16 Jun 2026 12:35:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esk1h37km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:35:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GCZC6S24969704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 12:35:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3E7320049;
	Tue, 16 Jun 2026 12:35:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 677782004B;
	Tue, 16 Jun 2026 12:35:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.31.150])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 12:35:09 +0000 (GMT)
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
Subject: [PATCH v4 4/4] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
Date: Tue, 16 Jun 2026 18:03:14 +0530
Message-ID: <20260616123314.82721-5-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEyNSBTYWx0ZWRfX27qjVEKWtDkF
 KPi2sjKZOi7GOA7KAMzRH1GIZAYXKS/mhSzVzHYcOClT+3aoDo+wPqZLEpzqUa5jIdmoHkOHm7k
 axAGOqIhdiUR92lueXttaidEaRcsIOs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEyNSBTYWx0ZWRfX4fzyNJGkCMhU
 T/S2kdkdoGM/o/4y8pUGprqkN60nVgiiNnsyEzEEo0g7Hd/HNla8CMi1kJt+l5415rVL4HA5jpr
 wVoK2jb520OUc/zaQztz7zoTBuhg6JaBRsH+lDIMTu0GJicnCwxAwQ2irJNQDlQXWc/fBLb9ZqO
 OXyHvPSQpWUGoe8qD1bRG2G1x3Z3JYRn5ByBLhQQEWvBmUBoz6I98QwxyfL4nbHsfQTB+aHDMfE
 e+2bJzGPCE4V0oKXchCDfBWxOmrnIHJSB2vIez+CDDV4PGf72tZpuOG8Q2Dzxqbmgm1VeFjghes
 /Fg2n1Bbt07hJcW3k4FvH70iM5iX+iB9l0ZBQwiiIarFf3Z+wNxT5TMP8DBBeNBnLMYF6gjxf/H
 /ao6MiIp4dSV9gD1NqCT3LC0fYyvf/9R/6dFRyJy0jXq+ooLrA9glvn/EkDQlVT5TX6JDHWz0uB
 rOMU+YmpMxqhVoOk02Q==
X-Proofpoint-GUID: scu1KpZ4l-1LY3zb04YQdNszFH0o9x3O
X-Authority-Analysis: v=2.4 cv=NuDhtcdJ c=1 sm=1 tr=0 ts=6a314306 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=2j00mp7kghxW8n-l3msA:9
X-Proofpoint-ORIG-GUID: A5Bq7V_ernKKJXORVev7vQbUnysMsTti
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160125

Add documentation for the KVM_PPC_GET_COMPAT_CAPS ioctl to the KVM API
documentation.

The ioctl exposes host processor compatibility modes supported for
nested KVM guests on PowerPC systems. The documentation includes
comprehensive error code descriptions, structure field definitions
including the size field for forward compatibility, and KVM-specific
capability bit constants.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 Documentation/virt/kvm/api.rst | 47 ++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 52bbbb553ce1..ba6feba74d7d 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6553,6 +6553,53 @@ KVM_S390_KEYOP_SSKE
   Sets the storage key for the guest address ``guest_addr`` to the key
   specified in ``key``, returning the previous value in ``key``.
 
+4.145 KVM_PPC_GET_COMPAT_CAPS
+-----------------------------
+:Capability: KVM_CAP_PPC_COMPAT_CAPS
+:Architectures: powerpc
+:Type: vm ioctl
+:Parameters: struct kvm_ppc_compat_caps (out)
+:Returns: 0 on success, negative value on failure
+
+Errors include:
+
+  ======== ============================================================
+  EFAULT   if ``struct kvm_ppc_compat_caps`` cannot be read from or
+           written to userspace
+  EINVAL   if the ``size`` field is smaller than the current structure
+           size, or if the backend implementation fails to retrieve or
+           map CPU compatibility capabilities
+  ENOTTY   if the backend does not implement the ``get_compat_caps``
+           operation (e.g., on non-pseries platforms or when the
+           required KVM operations are not available)
+  ======== ============================================================
+
+IBM POWER system server-based processors provide a compatibility mode feature
+where an Nth generation processor can operate in modes consistent with earlier
+generations such as (N-1) and (N-2).
+
+This ioctl provides userspace with information about the CPU compatibility modes
+supported by the current host processor for booting the nested KVM guests on
+PowerNV (KVM nested APIv1) and PowerVM (KVM nested APIv2) platforms.
+
+::
+
+  struct kvm_ppc_compat_caps {
+	__u64	flags;			/* Reserved for future use */
+	__u64	size;			/* Size of this structure */
+	__u64	compat_capabilities;	/* Capabilities supported by the host */
+  };
+
+The ``compat_capabilities`` bit field describes the processor compatibility
+modes supported by the host. For example, the following bits indicate support
+for specific processor modes.
+
+::
+
+  KVM_PPC_COMPAT_CAP_POWER9  (bit 1): KVM guests can run in Power9 processor mode
+  KVM_PPC_COMPAT_CAP_POWER10 (bit 2): KVM guests can run in Power10 processor mode
+  KVM_PPC_COMPAT_CAP_POWER11 (bit 3): KVM guests can run in Power11 processor mode
+
 .. _kvm_run:
 
 5. The kvm_run structure
-- 
2.50.1 (Apple Git-155)


