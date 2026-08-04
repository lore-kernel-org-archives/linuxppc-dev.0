Return-Path: <linuxppc-dev+bounces-25387-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B611C55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 18:07:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hF1jf5RL5z2yPR;
	Wed, 05 Aug 2026 04:07:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785866870;
	cv=none; b=ExG/gGJuMAia3ZmHBPBL/TN/mSokIE2DFGgpejfpPNc+n5tGfNhnn7g4xrZJXYRR17exe5oCu3KHblim0w2x6dtpbxB04xoXcpbfCYxFvLoOkcVuRoD/kciKULtK9lqY0cK/mQ8f1AYkbqgB6yyaT1zn2AqoZmAZukc7XarsS1j/hlxjhSDtCgkFL+GaKZVtZ0ZNp+ZWITOaT7HZaBNKVYFcp8CE825gpclKYuIeex5FvW4cXs9nQctZZabskDrqrpwS7MuruBLCXqWLWsIV2ho+PEGiwKwj/QTUddRfT7EweRj39mnMShxC5aTxN4wrKc3Pz19pEdTqZdifmwZu+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785866870; c=relaxed/relaxed;
	bh=GoJJkw+x47yTDVQc5S5Te/wMf/S1AyBlGniuSzt/H2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cx04e2fu26o2/DCc2f70MA80quSb8vEdb5wdU57FpMQWG/SPo7Zlz26ZgRg28MYa2YwWlgDtGcuPjGdPd8rVt+lKp/huA6k9HLCQrnmq76Vn0/jbqJxAH5wJ+5dfcrYFskTS6R3Q2P7fphNzU9/h9/vPmnyI+RBSJYHMkqqn1poDi6AxD4pBUwwCzLbVqYozsF8k6YsUt6n9a+X9QSjogQSDIkm6sXO8INFSfIRG34pkb51t1a70L2fdf+DtKREFYvqM7xiDttVzhArqFc7/MtOVKJmzrGPS3nHQVXXZjfK0wN2xzvKPUWnlAyvXesqYLb/s8/KsYzZyIVwHFlcYcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dpr13yiE; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dpr13yiE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hF1jf0cJJz2yMl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 04:07:49 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Fm9Ym1286974;
	Tue, 4 Aug 2026 18:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GoJJkw+x47yTDVQc5
	S5Te/wMf/S1AyBlGniuSzt/H2U=; b=dpr13yiE0PVJeUY0Bu9S4A+dY6iO4j3GS
	4DwDTmc6CF41IPPtakcV6khJ6EjYZ62rF4PoxCBbGuHWlZrsaM+IbDbkB8Ay1Fij
	zoh0S0hDF1Lq84QQ6991H81u3/8ajuSmDKYhoXkqm6ucdbuABWw18cyjDCzgbjuF
	0k5wrj5SDf5WK7OX0Zg+dRW349VChDU5LHujFxUW9mGELe6nqaRxlznkE525K1BQ
	Jyv8H6J6KbwVyVkV4jKo2RhIN3EUg1Dwa7GhGoF9ygOaNv+d9yHGIlXzgKWwJWoi
	bSy2I/cK/s87fUw1nDnV8rm0RgAV892EZDWV7pLP9KeANzifproBA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4ya2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 18:07:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674HuFv4032527;
	Tue, 4 Aug 2026 18:07:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgaxph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 18:07:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674I7Z7C35717624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 18:07:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD2442004B;
	Tue,  4 Aug 2026 18:07:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 258B720040;
	Tue,  4 Aug 2026 18:07:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.28.45])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 18:07:31 +0000 (GMT)
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
Subject: [PATCH v6 4/4] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
Date: Tue,  4 Aug 2026 23:37:05 +0530
Message-ID: <20260804180705.59160-5-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE0NCBTYWx0ZWRfX/Az272bIjiTe
 qYNujim3HknJ/+4YaVGXASi8vd7hyr59wZ2IKg+sn3bm+4Cwa6kRbhBQILQHHV9f8L8ARz6vigr
 AoAHRQcBZhxlQAkMWPPLUlWmRWQBqbc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE0NCBTYWx0ZWRfXwOt9CEX2gkki
 vF1PGsADpgSRl9H1OTS8n6pqdWvSEJnUvEJa/uHHoMgP4GpRAsj+2n+/Ud5M88jY78WaqFXi1lt
 M/CpUMmQMbYQcaIUE2NlhwDgXFAEnmoGjojS/wBa1tRzXpIApJxc1nHZzfBKxs+zpCCq/cJhURm
 IKy1FRd3QrQnOiYewquxG4Khc/Gt7SUl2oMUFex9vAGK1ii1jd28cv/z/c89U4ulx3gKE7KpYPG
 E7TE6GQxHyNzd0L4s/jgltLmKbYnKE4HTY5hRVHsyN939fOPcBeKbqEM5My+GDaU4oQ+fYAb6gn
 LiqKmOcA6+vdRQUuApKYH5GVshz3SIWeF0I7JL72muRJKJ0mhp2KItydTxLaJ1MngUml1SHD3dF
 sN09gz9y8/hODSOMi0IWWZhKyoK2AuxhxwkjTvyrDTS1j9AjZyyeBgVroTzcA0fhtQyXND1zY3D
 DAbnTRCgVkPW045Xh/g==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a722a6d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=hQeoMbdVOOR6M4iuoH8A:9
X-Proofpoint-ORIG-GUID: GAGIrr9w5-deQ8zS3Xe2jj8AoX25laQT
X-Proofpoint-GUID: OyoSbsn5jrvhQYnkQn_aE-ayGaCPueoa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040144

Add documentation for the KVM_PPC_GET_COMPAT_CAPS ioctl to the KVM API
documentation.

The ioctl exposes host processor compatibility modes supported for
nested KVM guests on PowerPC systems. The documentation covers error
code descriptions including E2BIG for forward compatibility, the
extensible size-based versioning contract using
KVM_PPC_COMPAT_CAPS_SIZE_VER0, the rationale for rejecting non-zero
reserved fields to prevent ABI ambiguity, bit numbering clarification
for IBM MSB-0 convention, and KVM-specific capability bit constants.

Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes in this version:
  - Corrected :Parameters: from (out) to (in/out) since userspace must
    set size and flags before calling

 Documentation/virt/kvm/api.rst | 79 ++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e3003a241d5b..22fedb0aa34b 100644
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
+:Parameters: struct kvm_ppc_compat_caps (in/out)
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
+           operation (e.g., on non-HV KVM implementations where the
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


