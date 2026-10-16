Return-Path: <linuxppc-dev+bounces-29596-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A5BCC6B38
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:05:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5htB6wkGz2yjw;
	Fri, 16 Oct 2026 22:05:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792148706;
	cv=none; b=XwIY+D1vt6zwU3FgOwt+ux4V9dPnFr4tJkQpEvps+dPU5A2gwTM8FF80qAm9lp8XgeJS3ieuh79iIXk15lvc59keWR4FH57BH+wGpjcL8C2Hb9zDM8b84cKURBDVDLiJcbLWIPJRqsE5gTM7QRfDyDzQYjh4Tvdv0q+bv6hzb+kSiKBf8DTsNFmp+5RQYVg0doyeKDBzwGDCnYJ6ZIdSuFDFyySlXK/EISreWiDFoVXtqSu8oaom/Uqg8yq0CF9CgeJshe6acEIme8S9rpQ6yCYMyP5QZAeG0LqhbRlWdGYYawUTq7AB6ABLh+R4fSeKBeguRg8zM7dWn/XaLo3taA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792148706; c=relaxed/relaxed;
	bh=zOTKNbcwNcD+7i7DDEEMfLzqEMXAgS2uGXftxjAvwSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CW0O6YqgGykaNGrj4b+JFT5Yl256BO9NJBXFIAHZecMwfbAEFpBzBF1xUFBo93ZW/LalLiRKcmWxwGn4UkeYhf7m2bdCTR6FIaea5engEbpRFiN89w4TonjA8Qh1zVS2tfyST1txPnLXeeHRIDV3I0Xu8S6WJtME/9kwnICWMgIaAt4NwZzRTLroHnTS1TyEAwRSgjnDiwjESl0Vhy0cskAQz3DUc41DxhTUmAwLMtNjCATZVSokXb6GnLRNBEhUKXX6U/34AhgLewHAMWQWT2KV3D/HdWQqMkiqi3X7tE4ra4+L3yTUsWsbTpzlDp56y7roiUEXcvmYcA0o+At00A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LjA1jPmO; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LjA1jPmO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5ht93Gj5z2yVL
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 22:05:04 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAE7Yq3538252;
	Fri, 16 Oct 2026 11:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=zOTKNbcwNcD+7i7DDEEMfLzqEMXAgS2uGXftxjAvw
	SY=; b=LjA1jPmOzDH7IPKWMLlqYhLq2pMhximWovQdaB6zr258lVBy4005VuGkp
	S0H10UDTu2aMg3sicK8WFAu+OVfoOiYhty1ITxVPWu9rArzRr+V3bOXr0FIG/BV2
	i174NL7wPhKhLGNQS3USaVzc5fJb1OqvfSugXZJgtg9rXK31rTg4b3jnzSpTsoat
	9J55YLncz/KnFVFwLJRwEE32lgJ3hqSeRCQVNH72t80mNwlWq3TKS3PbaCRsMpy+
	iUYkSvsgtkfsPQ7NmFkhmhXPyjmdxo1l03pY6MP51y3N8iHW6aPKu5aP4+AhQKca
	VcJilpIuYPeNWg64nRjbLxAcX1qHA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1wp4wj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 11:04:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAJrMM3541643;
	Fri, 16 Oct 2026 11:04:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hb2393e6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 11:04:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69GB4geA39321902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 11:04:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D80E52004B;
	Fri, 16 Oct 2026 11:04:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2365820040;
	Fri, 16 Oct 2026 11:04:41 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.123.124.175])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Oct 2026 11:04:40 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>, chleroy@kernel.org,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] powerpc/numa: Enable coregroup support for shared LPARs
Date: Fri, 16 Oct 2026 16:34:05 +0530
Message-ID: <20261016110412.1380298-1-srikar@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA0MiBTYWx0ZWRfX3ZEQ9v1dDNYV
 VA+pqk/IT0vNNEWjLX8S+GKrkySQL6vP/JMUy1QNYmFFAaWmLGj+ZkIpO3xPHgnziCKCNRV0YEQ
 huvb/xhD860USeik84fEGYHcMSS3xNI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA0MiBTYWx0ZWRfX3mfmbLEtOPlV
 sFmhrFyrj9l0XCl6ZmfxwsNYoZw+wOr0+VaVuzHW+F+6nczzPBzovoMIFuCovgIkMEDlTRgX30X
 HFZtL17C7LS6p1tVciNcxnzgEsDfhyeuEmfw1xt4YCCbQHTsxLyaTW5HyrEIp0gyEaRHSFKd1Bk
 K2GykL/ClUVq4OTrI1n4uF8UnktZ1v+/jc48wYs7FY2LWqNxwmEDb8NicsxtGGjCZgxjNNzPxdT
 8QdQtMyg404zdjzLGf+aemNkoPYLlbx42pKUU6EB3CtLqGked2UlwH3Nrl8XeAEFxAut8gA5LM9
 5K7o1+PgrWuKjh5VBtHj7L0xy/HWcnZaRX4lPUNEP+MXNYbB39ByxDxvJ7YF/wYPiSA1/kpLLYW
 7cclwFiEZ9Iw3f4uezhtjECUSVxZDMP8Oflq98L5FLq6GY60/kf3j0gNzkmODYK4XP186WbqiDn
 pMd3lzc8f6ha14i9EKA==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6ad204cf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=4VljeqTyPbWTWyxZsgMA:9
X-Proofpoint-ORIG-GUID: M6UMwZji_DolVP0klWvnpstZIN6DjgDX
X-Proofpoint-GUID: i6bXg-fxbTgBJ77YSpcn0h0X9HYhJ7v_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160042

Coregroup topology is currently disabled for shared LPARs even when
coregroup information is available through the associativity hierarchy.

The associativity hierarchy differs between shared and dedicated LPARs.
For dedicated LPARs, a coregroup level is present when the hierarchy
extends beyond primary_domain_index + 1. For shared LPARs, the hierarchy
has one fewer level and coregroup information is available when it
extends beyond primary_domain_index.

The processor sharing mode is not known when NUMA properties are
initially parsed. It is determined later in pSeries_setup_arch().
CPU associativity therefore initially uses the dedicated-LPAR
interpretation. Once shared processor mode is known, reprocess CPU
associativity to detect the coregroup level using the shared-LPAR
hierarchy.

The series also separates coregroup discovery from NUMA enablement.
CPU associativity is processed even with numa=disabled, while NUMA node,
memory and PCI processing remain disabled.

Patches 1-3 prepare the coregroup detection code by removing redundant
coregroup detection, consolidating the VPHN associativity lookup, and
factoring out the coregroup-level check.

Patches 4-6 allow coregroup discovery with NUMA disabled and restructure
CPU associativity processing so that it can be reused after processor
sharing mode is known.

Patch 7 accounts for the shared-LPAR associativity hierarchy and
reprocesses CPU associativity after shared processor mode has been
identified.

Testing
-------

Tested on:
  - Dedicated LPAR
  - Shared LPAR
  - numa=disabled
  - CPU hotplug
  - Memory hotplug

On a shared LPAR, /proc/schedstat did not contain an MC domain before
the series:

  domain0 SMT 00000000,00000000,00000055 ...
  domain1 PKG 000000ff,000000ff,000000ff ...
  domain2 NUMA ffffffff,ffffffff,ffffffff ...

After the series, an MC domain is present between SMT and PKG:

  domain0 SMT 00000000,00000000,00000055 ...
  domain1 MC 00000000,00000000,000000ff ...
  domain2 PKG 000000ff,000000ff,000000ff ...
  domain3 NUMA ffffffff,ffffffff,ffffffff ...


Srikar Dronamraju (7):
  powerpc/numa: Remove redundant coregroup enablement
  powerpc/numa: Consolidate VPHN associativity lookup
  powerpc/numa: Factor out coregroup availability check
  powerpc/numa: Allow coregroup detection when NUMA is disabled
  powerpc/numa: Consolidate associativity lookup in parse_numa_properties
  powerpc/numa: Extract CPU associativity processing into separate function
  powerpc/numa: Enable coregroup support for shared LPARs

 arch/powerpc/include/asm/topology.h    |   2 +
 arch/powerpc/kernel/smp.c              |   4 -
 arch/powerpc/mm/numa.c                 | 176 +++++++++++--------------
 arch/powerpc/platforms/pseries/setup.c |   6 +
 4 files changed, 83 insertions(+), 105 deletions(-)

-- 
2.47.1


