Return-Path: <linuxppc-dev+bounces-21407-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE4ACD5BB0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 15:28:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMTh04f3vz2xWR;
	Sat, 23 May 2026 01:28:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779463712;
	cv=none; b=CXlOgbjw0IjNLteFOnmiKS+bgda8pKwNiIFzqfzeMhMDg2KZ3XNnS2CaXc1kjyGZLy7vFZ3DfB1FdP9autjXtMR8kPRt4Vh5we7fDrH+eaJRugr8aecJc9p6HpXQH1gaeR38A03TFZPt2a/3xipT1jO38VnldTY6eXlNlQ1314MS9EcXtU93jhOQpF2QSnsICt+7I6kB8g95lmpB925ef/flG5V0jWyrmf2eYCIJLDlTBvr+elG01jc+NA9ydDjNpD9aarcJ0aGCvJWKhvfFyXlb7PX771gLEj1+ETR/qcBadzisAFU2YPWY57oBz1WVOJ5q9UUCpKw+HgC9aG4Eng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779463712; c=relaxed/relaxed;
	bh=3l6k7dsLP3JZwEsNPXWfNE6Mhp0p34DpYjZTyfH0XIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axqjvWUsFV0fEIrKav43zMQIDslrBozaG1aE/FGSxD1MDs7SUhaRdnAD1igX9KqR2LI6pDwVlPzmFxzlt5lQYzte/bF8hPjGhcCdtvxsXgRdH/Ty2EnJAwIsG2YkermqmMDgfUdzaQfxWBK7MwiHDCCoVZFp5JnTBJAd1lQarMqF3mpFgMYReNt8BbvDcTRaczik8pfLF1hyjPbhjGcOao9JYkwluDaTP31xGvdlMfa+u+lGok0nbQi3r6YhTZxgWvP60Jv6AKych7qIFL7oA1KC08b2RFmx7MyI7hDKlm2+xguVUZJt7xKeVbdJvbB1QIvUWlaP+KmhWjWtKiMMQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=L/RUx5/2; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=L/RUx5/2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMTgz6khkz2xK4
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2026 01:28:31 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M7a6Ve3386862;
	Fri, 22 May 2026 15:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3l6k7dsLP3JZwEsNP
	XWfNE6Mhp0p34DpYjZTyfH0XIk=; b=L/RUx5/2eV7/mRn/Q6DioIxiPwhdk1R7q
	sFIMjeYiYZ14vqFoW6x2GePfAlyw7CngCl4GzCq17g73V4PlhX+ztF0YtzwfBx9a
	ApVpfdtGwbK4kZgLiHqrR+Fv9++SVDZqrN800FpBPX66WXKhnr5Bi1Ae27Pt5UJR
	vHcvExGeaQQiJYD1QGtSPNfRokalyc0biDeRY/rpQnM108oUPwqLVIqofCdbWcxm
	25sqA3a+5XMQI9RHFERUsdO0W9XxraiBptPnKWgjpE+fI+oDMIa7+9FLFcdeMjgU
	aZNltChNo4r5RVIfDx7F3H4pYTNLZ28y4wI8BmsnKCHrArHKOttOA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h75cm2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 15:28:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MFO5OO011013;
	Fri, 22 May 2026 15:28:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wqhpp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 15:28:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MFSHAK44892584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 15:28:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F12A2004B;
	Fri, 22 May 2026 15:28:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2EAE20040;
	Fri, 22 May 2026 15:28:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.216.126])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 15:28:13 +0000 (GMT)
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
Subject: [PATCH v3 5/5] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
Date: Fri, 22 May 2026 20:57:44 +0530
Message-ID: <20260522152744.55251-6-amachhiw@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a107616 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8
 a=pQ3QZ_9PhTAbB05LSQIA:9
X-Proofpoint-ORIG-GUID: xthWjmlSwBS7y_rcQfNy371c7kz1n9c_
X-Proofpoint-GUID: Yq3yS3t5hXjft7UV8PrLQHSYHAbgAnXD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE1MCBTYWx0ZWRfX9qx8pc/vEaJ0
 5yKYWqoDm5bFwrvdYy/Q+sCjomSIWc+BmjYgETfQ1M2vZ17dOVUqhcK9fuGOTijeLUo4B3QweUA
 Kpc7QrnalHyI0Z1USJmd+NB3EdcgCi7kLJ2rB19MGngTUtX3SLYDYvAu3RiRkx/Sh+sw1a30kvl
 BNKV78LzmwAC5zPKZuRiUmL0HAxBd2i/cYOV/I/BC4C0KJpRIWKXokE7OKf0z4rTs5N/ow0Q3ij
 C0PG3FMdVQ3mGdFutXT4F+gyLv/FFClMzKYdj2XYBe2hzLlesw8klEz03GXpWoAWcyoxDJ10MwY
 BR2XrHEPv+FFNvxWZbl3a3rekwxt5yBAIqMOzq1h8UgqC6SFRtNC7HHmJNxxiTwqqVUAjCgd/Qv
 +BvJc+EG0US6Q/IL+/7vY+qG+iO7rhNVDqYlf2tsBjZCfYbVXO1pv3HOdWIubfpt9coLxwjQrIX
 Hh71aKNLWLoj6h2FmFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220150

Add documentation for the KVM_PPC_GET_COMPAT_CAPS ioctl to the KVM API
documentation.

The ioctl exposes host processor compatibility modes supported for
nested KVM guests on PowerPC systems.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605140717.W1StD3Ke-lkp@intel.com/
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 Documentation/virt/kvm/api.rst | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 52bbbb553ce1..d11e054e6665 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6555,6 +6555,41 @@ KVM_S390_KEYOP_SSKE
 
 .. _kvm_run:
 
+4.145 KVM_PPC_GET_COMPAT_CAPS
+-----------------------------
+:Capability: KVM_CAP_PPC_COMPAT_CAPS
+:Architectures: powerpc
+:Type: vm ioctl
+:Parameters: struct kvm_ppc_compat_caps (out)
+:Returns:
+	0 on successful completion,
+	-EFAULT if ``struct kvm_ppc_compat_caps`` cannot be written
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
+	__u64	compat_capabilities;	/* Capabilities supported by the host */
+  };
+
+The ``compat_capabilities`` bit field describes the processor compatibility
+modes supported by the host. For example, the following bits indicate support
+for specific processor modes.
+
+::
+
+  H_GUEST_CAP_POWER9  (bit 1): KVM guests can run in Power9 processor mode
+  H_GUEST_CAP_POWER10 (bit 2): KVM guests can run in Power10 processor mode
+  H_GUEST_CAP_POWER11 (bit 3): KVM guests can run in Power11 processor mode
+
 5. The kvm_run structure
 ========================
 
-- 
2.50.1 (Apple Git-155)


