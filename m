Return-Path: <linuxppc-dev+bounces-25614-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AACC5AC7A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 17:25:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGrdZ1pyQz3c7d;
	Sat, 08 Aug 2026 03:25:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786123538;
	cv=none; b=JDty2rjZ/iFNKnbp0WR7QD5wze3qaKq/GxjnzFRWrwtgfliX755niFYyL5ChhvUq6hoKcOuCchuX7Nvhmh2SDtQLx/80oG91Lg0LRbDvA1+x4Z1GSHc+YyV/zTo4hKxrgorKrFNGFGYVrTKfQoch+h8C1cgXohsdmHZ1iAQw9pZD+ERnJNS1ZXoXm2VP2h8MdSovb2zqnGpHI7n8h8g1EDv39OTGfDIZm9v0+1Xq0622oxkA/EF04ql5lN8UZ9fOa2jh5kmGp6ZEcszimlx/lZxBmsRSiXRe/5y0rabnJsoeLEpFymTJe1WLL4t3cpIOp2i1D6E2jgZpvoHzdc9JTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786123538; c=relaxed/relaxed;
	bh=ri/s8/IRsCo9q7qhjpmRMpMFjLqk+LSvHjimzadH/4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZy+9PVUf9C7Dau4zI03jTyhC7cSdeMYFqYVnSRvgAYleiJAgLW7BDOcEKjXdTs6lSSc++dq8o0jhU2YhkcSARJu1ADweXzCNgSsZKNMFahDX+cWx4WcXhOiWVcsqju1tqnjUCxKF96svnN2KgS4T8IkL5uSvKnwxlN8sogmIklCe08SuA2MhUueAvH2My8GwG975BLUFho00gZRdPWgjHJFS4ewKSgfvI6IfQXenGfDlegFmmBvyEkTsTGG9a37DN7+Bb1aAca7BHMTvuwd3qBWMDKAM2tYw/0kma6IiokrHsewFPxwDbjHtorZjPf1XJPEImUFSK6VCSHG8rGSeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KoQRI13W; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KoQRI13W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGrdY4j85z3c6f
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 03:25:37 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677Glwqv1928128;
	Fri, 7 Aug 2026 17:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ri/s8/IRsCo9q7qhj
	pmRMpMFjLqk+LSvHjimzadH/4E=; b=KoQRI13WvBzQBsL+ZudeixKf+V0iIJMFt
	NFAoznlKiuqSKJuZTtSFa2dDjxvuOo0Uq8yY6mRo27y/naZZfE0uywNnVpsTBnhM
	XuWEaGqm6xXNcjsXPNTsR/z/1WOiR3VmAN5vBLDOOC11Kioor1vfdDY/WYyeaiaV
	tePHRzyG7GSAuJwdOxPswkD+koAOULLNw1XwTQd5yEopgVo++nKPTJ+B/sF7NPEx
	qSSNh8cPnsPtwueHXlrVu3GSE8MScN1j+REboPATS8yK8LoxkymLgXPPxBc74Jsj
	/x/wiDngVwSrFVZ74S8qdjeuUBXylCU9EgY277licNNPzJbPIv8xA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02cx24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 17:25:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677HBPYd009569;
	Fri, 7 Aug 2026 17:25:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgrfd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 17:25:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677HPLdd50135318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 17:25:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FE0720043;
	Fri,  7 Aug 2026 17:25:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0E9C20040;
	Fri,  7 Aug 2026 17:25:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.216.72])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 17:25:17 +0000 (GMT)
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
Subject: [PATCH v8 4/4] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
Date: Fri,  7 Aug 2026 22:54:33 +0530
Message-ID: <20260807172433.82045-5-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260807172433.82045-1-amachhiw@linux.ibm.com>
References: <20260807172433.82045-1-amachhiw@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a761506 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=hQeoMbdVOOR6M4iuoH8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEzNSBTYWx0ZWRfX/x6h+07+hx6U
 Bf/klCiC3CC+/GSSKwiGJlvOXIZ3I+hOBG48ZXLkBuDDtIlFKRmb721U/PaENhA83V5OE+a4btO
 qVc+deCX2ZKDUz7HBZMWK0Pb5aQjXe/Uywn3yX8rXsqEgUpXcnOhDjHOIUOE/M4cl34LrC9twHR
 8pxgtsltyO5HUFo1NFY4JtLeRUGdjEbqNy1h1qVtX9dfL9JDD/0vdoAb2eE/3T3/uFDaxJ8wF5k
 OqS5Lp8qyxtCtvlSds2G97yaAzzB5sO+I3woKl/0YCVsT9DyBB0UQrzWH86UU9LvZ30LPkP90tW
 0vbQf47d2vAy5aF1kHZZa2OO47yVEV/Aln5+VedPlfclcMHqwL7hJG6LiGg2eCvwLZDftw5Mbf4
 jclnmEyqpxOqwueD8HeOe6OfbTQJGaM5+6cxWYJlD836zet12h58FGFZunI0Mvs1Z5DyGuHD3Pb
 4gJXhh4xE08uXN7ZAsw==
X-Proofpoint-ORIG-GUID: 3Wm6WCw3j61AcVtrdKDiKqzDhx_tFALz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEzNSBTYWx0ZWRfXzrVfHVSZeArH
 4LiqDTNWKFo9DJPrJOqVLc2P6Dok0avAF+xhcKd/KqTtiQ/w4S/qHFbZ5YYEMYxFHbaLe6WoXK6
 spPD44PZm6C/UpW62tSNyAyXT7q374Y=
X-Proofpoint-GUID: vbxh3gC8tQCtsoH6IvGUyCky_0BfrTww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070135

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
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes in this version:
  - Update E2BIG description: document PAGE_SIZE guard as first case;
    -E2BIG for usize > ksize is only returned when trailing bytes are
    non-zero; zero trailing bytes now succeed [Ritesh]
  - Rewrite versioning paragraph as three explicit cases to match the
    corrected copy_struct_from_user() / copy_struct_to_user() contract,
    including the usize > ksize zero-trailing-bytes success path [Ritesh]

 Documentation/virt/kvm/api.rst | 89 ++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e3003a241d5b..e656d117cd0b 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6566,6 +6566,95 @@ KVM_S390_KEYOP_SSKE
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
+  E2BIG    if ``size`` exceeds ``PAGE_SIZE`` (pathological input guard),
+           or if ``size`` is larger than the kernel's struct size and
+           the unknown trailing bytes are non-zero (new userspace on
+           old kernel with non-default fields set); in the latter case
+           the kernel writes back its own struct size into the ``size``
+           field so userspace can retry with the correct size
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
+to support extensible versioning across three cases:
+
+- If ``size`` is smaller than the kernel's struct size (old userspace,
+  new kernel), the kernel zero-pads the unknown trailing fields before
+  returning, and writes back ``size`` unchanged so userspace knows how
+  many bytes were filled.
+- If ``size`` equals the kernel's struct size, the struct is copied
+  verbatim.
+- If ``size`` is larger than the kernel's struct size (new userspace,
+  old kernel) and the unknown trailing bytes are all zero, the call
+  succeeds as if the sizes matched. If any trailing bytes are non-zero,
+  the kernel returns ``-E2BIG`` and writes back its own struct size into
+  the ``size`` field so userspace can retry with the correct size.
+
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


