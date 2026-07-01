Return-Path: <linuxppc-dev+bounces-23246-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BB0C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 05:15:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqp9h3n73z2yfy;
	Wed, 01 Jul 2026 15:15:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782882904;
	cv=none; b=LuqFxZWw8ROcLETqweloAzTD4TrzdFAjEnaCmjEluJQWNGVqqaIPUAeiei7l29wYFpxQsnYF3GYiPBnDYRZFFXgvODw1JsE29qvy7UeHgaGPlimRSZzzfAVuF1E84SOZ41B9ujxaf+ObhbTb61IRNRNFCWY45E8Ntxsy0F6lEkdQKItlEejBTFpl9JOUeKoZSyB8Is/NqesM4a62rttABR0X4yp8bPM5++7YYYsSGXJnlL+6qLAv3X8tg6m/5/dfj5qZfdl8ybAE3pkATkofKu4aO9C2xHKgq/9JWCz8gA+xUvU/Zx8/QLO01xT5oPmIBzNXGwY4iTtaLV0vgfiFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782882904; c=relaxed/relaxed;
	bh=E80IxCKDLZdgTEyKIiEEd2vjIqfJG2YG606BV3dpUpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpNJ9kZymhT5+syNJ6NwEKMOmzRHE3cyAPr0/wnygxbjLKBfxJMGt0wsOx7DgaAABZewAts9D2wjP1Z3BDq2Se89W/M/OyOn548DPrLY9fZbJA4zOPy+S95NEcsb2/rshjgylXd8wScYQkC8zXQEozA55J3wqQrTJvf6vG7Gt/c2zzcdgZn7hGliyYManugL2kuko1C0ASyRnwo8qmwZMROLymrfXf+DcPL6cTBmG3D7R2ztQkQ4Q7CS89lijJIcQ9F+Wutdq/RKxJAgxOV/mrjWFuf0HSF1SkKT6aU8lQvUeWvhHVaZe6J/G+jLwFpCY9j5MEVHIuo76lBYsJDM3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kksbbEZv; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kksbbEZv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqp9g5JZfz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 15:15:03 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6613Igbq3760289;
	Wed, 1 Jul 2026 05:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=E80IxCKDLZdgTEyKI
	iEEd2vjIqfJG2YG606BV3dpUpc=; b=kksbbEZvJEDgztmBJqS6lQftnhQXdWgV2
	WF0dTt7ABkAHGb6QEjExOAGxb6+PeyZytB7XCLbz++NoGACSTtX2qHAzsEWSOAfV
	O3FHQb5/Bxj+RmIyYAHkireeohr3PGVAVPTsDCRx0ZTOZ/gc8F69jNqErxR7PqL8
	RIeHAaY86d/QEavWKWWLgRP7lEs0UJXJHoXLEhcTXQlPGPWtYNqIWocbOXZdS1aw
	WA7ogmtRFySe8TFVk2CeR1WkK9X2JmFJWofGfN36MAekooH62tL13X526Ugs8D8Y
	ClHvsjzQBAEgU8Zafreke3T8g7HdsdUV1Xo7ovabOJ5YiICM1CoqQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjtbv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 05:14:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66154beJ005002;
	Wed, 1 Jul 2026 05:14:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhydg6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 05:14:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6615ElFV24117692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 05:14:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A07D820049;
	Wed,  1 Jul 2026 05:14:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23D6D20040;
	Wed,  1 Jul 2026 05:14:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.211.190])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 05:14:43 +0000 (GMT)
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
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v5 4/4] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
Date: Wed,  1 Jul 2026 10:44:09 +0530
Message-ID: <20260701051409.51820-5-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260701051409.51820-1-amachhiw@linux.ibm.com>
References: <20260701051409.51820-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA0NiBTYWx0ZWRfX4R5o/5XJK5AS
 kgfFwIrFim/X/cp7GGk6IsBxHs+YL9kap9IHciKSveFcnLr30LJhaIBHiPjbmnJk01Cnx0+F3Z/
 TROx67urqgLKPd8dxNg/T/eLbC35/Ipyq1tKbjR/7oyoT78EcmTcHrbeG6fc9cwWX36zShp6Hwd
 ks9ey+6Oy/ovGE9qb3Na/bfTVsH1xkPVEb6Rhc1apI+6THnuaAc+bF85TN9f3ATEIupmzJ/RooG
 ohRn9b2iDTgZ7xc/VYPE8ckANCLuBHoMKjN77qEn/clyY+Z8iM1FhZVEoV+MfeBnbnspMxq+3r+
 IL4fTgK9u38Sud0JWozfARUQTTAQOsAA7yWeqmYz/vCH3rUNYioBYPWU2KxjtMInc2krK6T6YGr
 xJ41Pv9XohNM/1xVCY0tn28OnOdmuM+bZJmxGNTdFF3EZXDFNxSQkAo0tjPP3apNkPXL1oHTctl
 CYhFMJulkni3wP957DA==
X-Proofpoint-GUID: AGg3uB9dIx5Oe_b3jSGqQJQrpCaDgkzo
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a44a24c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=hQeoMbdVOOR6M4iuoH8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA0NiBTYWx0ZWRfX3GGeuCGBMGG2
 NdKG0Ez7iwRmp+aEj2bm5Z+uZxpj/Gx8nbVLA+RQjptBqnHDp3JrycHI07EXdnrS1wd7K39eNbU
 upCuEQrreZlcjrAqvQzdslR3ApNXFTk=
X-Proofpoint-ORIG-GUID: BMOTeKnrgBkY-1nC6moSJ13IWjwAXBZM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010046

Add documentation for the KVM_PPC_GET_COMPAT_CAPS ioctl to the KVM API
documentation.

The ioctl exposes host processor compatibility modes supported for
nested KVM guests on PowerPC systems. The documentation covers error
code descriptions including E2BIG for forward compatibility, the
extensible size-based versioning contract using
KVM_PPC_COMPAT_CAPS_SIZE_VER0, the rationale for rejecting non-zero
reserved fields to prevent ABI ambiguity, bit numbering clarification
for IBM MSB-0 convention, and KVM-specific capability bit constants.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes in this version:
  - Updated error table: EINVAL now reflects size < VER0 or flags != 0;
    added E2BIG for new userspace on old kernel
  - Replaced stale strict-size-validation paragraph with description of
    the copy_struct_from_user/to_user extensibility model and
    KVM_PPC_COMPAT_CAPS_SIZE_VER0 versioning contract
  - Added rationale for flags == 0 enforcement to prevent ABI ambiguity

 Documentation/virt/kvm/api.rst | 79 ++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index a5f9ee92f43e..43810c451317 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6566,6 +6566,85 @@ KVM_S390_KEYOP_SSKE
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
+  EINVAL   if the ``size`` field is smaller than
+           ``KVM_PPC_COMPAT_CAPS_SIZE_VER0``, if the ``flags`` field
+           is non-zero, or if the backend fails to retrieve or map
+           CPU compatibility capabilities
+  E2BIG    if ``size`` is larger than the kernel's struct size
+           (new userspace on old kernel); the kernel writes back its
+           own struct size into the ``size`` field so userspace can
+           retry with the correct size
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
+KVM on PowerNV (nested API v1) and KVM on PowerVM (nested API v2) platforms.
+
+::
+
+  struct kvm_ppc_compat_caps {
+	__u64	size;			/* Size of this structure */
+	__u64	flags;			/* Reserved for future use, must be 0 */
+	__u64	compat_capabilities;	/* Capabilities supported by the host */
+  };
+
+Before calling this ioctl, userspace must set the ``size`` field to
+``sizeof(struct kvm_ppc_compat_caps)`` and zero the ``flags`` field.
+The kernel rejects non-zero ``flags`` with ``-EINVAL`` to prevent
+uninitialized stack values from being silently accepted, keeping the
+field available for future use without ABI ambiguity.
+
+The ioctl uses ``copy_struct_from_user()`` and ``copy_struct_to_user()``
+to support extensible versioning: if userspace passes a struct smaller
+than the current kernel version (``size >= KVM_PPC_COMPAT_CAPS_SIZE_VER0``),
+the kernel zero-pads unknown trailing fields. If userspace passes a larger
+struct (``size > sizeof(struct kvm_ppc_compat_caps)``), the kernel writes
+back its own struct size into the ``size`` field and returns ``-E2BIG``,
+allowing userspace to discover the kernel's struct size and retry.
+``KVM_PPC_COMPAT_CAPS_SIZE_VER0`` (24) is a frozen constant marking the
+size of the initial struct version.
+
+The ``compat_capabilities`` bit field describes the processor compatibility
+modes supported by the host. The following bits indicate support for specific
+processor modes (using IBM's MSB-0 convention where bit 0 is the most
+significant bit):
+
+- ``KVM_PPC_COMPAT_CAP_POWER9``  (bit 1) -- KVM guests can run in Power9 processor mode
+- ``KVM_PPC_COMPAT_CAP_POWER10`` (bit 2) -- KVM guests can run in Power10 processor mode
+- ``KVM_PPC_COMPAT_CAP_POWER11`` (bit 3) -- KVM guests can run in Power11 processor mode
+
+.. note::
+
+   The bit numbering above uses IBM's MSB-0 convention (bit 0 is the most
+   significant bit). In the actual implementation, these are defined as:
+
+   - ``KVM_PPC_COMPAT_CAP_POWER9``  = ``(1ULL << 62)``
+   - ``KVM_PPC_COMPAT_CAP_POWER10`` = ``(1ULL << 61)``
+   - ``KVM_PPC_COMPAT_CAP_POWER11`` = ``(1ULL << 60)``
+
+   Userspace should use the defined constants from ``<linux/kvm.h>`` rather
+   than hardcoding bit positions.
+
 .. _kvm_run:
 
 5. The kvm_run structure
-- 
2.50.1 (Apple Git-155)

