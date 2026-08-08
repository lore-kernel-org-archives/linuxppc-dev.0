Return-Path: <linuxppc-dev+bounces-25648-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71093C55174
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2026 16:12:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hHQyx2rJdz2yrr;
	Sun, 09 Aug 2026 02:12:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786205561;
	cv=none; b=care7C670EQudLkh5ER0NuT5DC9yA6n4AGBHYD5g+3LNvUJspHAZiP2FSy1C8JoLWwnZZU6Xp+E8kQ6xYd3f36Lq/6iM/uCRkKnr9Ed0ttkKULPEC32a1N8UYSE1em3r90zy0WcrolKdugeXrUWDmcmbGlMFZwt7/V5lwM0tn9L0ibO37VJg9xD8e8NGKs9UAavdfxyMiuFVQLnKWJDYmKFi89NiKxlRdtb2h+TVq+PjNAnSghlDNv4VjyJK/zmQuKhRARxacN1pO1sskFGdtWjH52C9Aw33ODmwzkTx2mL/BVVhHMNyEJfDIDmG4fczrih1l91FT2vZDR/I+J/nxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786205561; c=relaxed/relaxed;
	bh=gj4ui9kz41zX9V9VUJmxHpEXrLvfRCtOc/o4abThskE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1BgVwNi1rToI2hx5tQ/6UypSfE3q6MGxMgcNHnlAgGqkaVUxwNGB6biUfIF/N/dm7N6Rr6OhpQVrUdPuBXdbD8EnUroagJ/3YA8RWPDiSEjU+eWEqfekTtRNeJoZtQ1MvuX0J6SaQROf+fIXpBZgn6b0BND1B2KISwBuCHANgVd5uJEML7xttwb0rELp2GoX59uNvvi3PwAVcbWV+zAsq1llgkFxZJmZa5uTgtn3qrCYPFa35uuV8tXD1mRD4y/eXgAtK8LljVW0gwJbQe0UeOh8qgLNDbDB6lItt0xOM+rf93DBeIvg37BvWFQFpyG47tPc6V4GJmT2ee6jdT0SQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E49/3/Yr; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E49/3/Yr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hHQyw5MZcz2yrt
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Aug 2026 02:12:40 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 678E1rHO2693437;
	Sat, 8 Aug 2026 16:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gj4ui9kz41zX9V9VU
	JmxHpEXrLvfRCtOc/o4abThskE=; b=E49/3/Yr8NkjeBjs7Iw7siefdhK6Rbkba
	rxusIUbX8EjeJxs4z1vaFolY2YKDp6LMIEixWJCV18FGY0GogD9DFOeDjHh7AZX5
	wL4qUW4IbHPg8kWn6Q3EewyeJBoArjL9t4lOH/e8Gf+BBxAk1rPEHRkKtufWE812
	qfGi4euet6Pd349AfUHbhKY2f2CDWPaXT9tEMBg7BVJGdJ2a4JPu8JJsf8j/09Ja
	072qEjvEhs+Y5DheI0ICdkVZTagnNgeKwyW9udB9Gb9WZq7VSFtWgv3uZUBjnMFy
	vRRqjfcxRIEyz9ChJL9kOgjqkvDQFZhlGiOoe15EDNZ3igyWN9d4Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjyhmkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 16:12:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 678GBHKb003347;
	Sat, 8 Aug 2026 16:12:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwm1wq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 16:12:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 678GCP4L32571692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Aug 2026 16:12:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AFA520043;
	Sat,  8 Aug 2026 16:12:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D199620040;
	Sat,  8 Aug 2026 16:12:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.213.63])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  8 Aug 2026 16:12:21 +0000 (GMT)
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
Subject: [PATCH v9 4/4] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
Date: Sat,  8 Aug 2026 21:41:48 +0530
Message-ID: <20260808161148.66673-5-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDEzNyBTYWx0ZWRfXzzjJ0qtsCbNd
 +9OzBcp7gBYdoo8TKQb2OXv+2m70vGbJidu18biu3MM/Y9fs3OU0E3gGwLeX74Wtwhb7vc0F0ky
 KH6VbRziyeuKB8NSQ9KgyZLbQjFjOQrw8GauiG2cq9bOWmt9AIqvOKVDQizBx1fBtlpUoGiepdC
 j0YsCDUfFBsZrEZMJkY8+5doUKQ0kGrrGHwCE1HELYn5LL+eHV37rjfXktMdklRIqHIJmKjKJ7r
 KXEB1D36fCdRIXpCkOsF+4aWpxyj21/hSQAl7Lm2H/9XkDkQGi8kFrujoRZGYsSAgOJbnyiUTWP
 f0bGLBSh4T6vOfF4Qh2cyFt5LWS66SWulFyGk8c14qtghiYIru+hY9QuxtvjQDTCyIXWYk67f4n
 WEdRPuTbulgJl+PB6hMLQQ8SE0AewH4dCCntIKT+1Qb4YUQh8y6QyAPLBe34JD+W6x9KYDUU3Ka
 9+tx3kytJqUMg7zrdTw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDEzNyBTYWx0ZWRfX5aaLY79UMRiI
 8MiEHywuvTWT7774//X7Kfrg8bXVutzb5dzEuXF470ptwaz9QPLeFW65T6Us+ajSsVGRWqMSZt6
 WVhg79n2y46M2707oP3VCAtMaJ36SNw=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a77556f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=hQeoMbdVOOR6M4iuoH8A:9
X-Proofpoint-GUID: nCJEZoLmeAcTg7JuNgY6yQYjvdRt3rYh
X-Proofpoint-ORIG-GUID: u028xhPpvvCdjVTo0ORtRjWovfm7cRba
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608080137

Add documentation for the KVM_PPC_GET_COMPAT_CAPS ioctl to the KVM API
documentation.

The ioctl exposes host processor compatibility modes supported for
nested KVM guests on PowerPC systems. The documentation covers error
code descriptions including E2BIG for forward compatibility,
KVM_PPC_COMPAT_CAPS_SIZE_VER0 as the minimum size floor, the rationale
for rejecting non-zero reserved fields to prevent ABI ambiguity, bit
numbering clarification for IBM MSB-0 convention, and KVM-specific
capability bit constants.

Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes in this version:
  - Simplify versioning paragraph: drop the three-case explanation of
    copy_struct_{from,to}_user() behaviour; keep a single sentence
    referencing the functions [Ritesh]

 Documentation/virt/kvm/api.rst | 77 ++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e3003a241d5b..3660d7478fb9 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6566,6 +6566,83 @@ KVM_S390_KEYOP_SSKE
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
+to support extensible versioning.
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


