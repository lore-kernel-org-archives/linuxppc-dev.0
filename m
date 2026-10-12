Return-Path: <linuxppc-dev+bounces-29232-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F2BCA9ED2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 08:29:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j39cp2vfrz2yYY;
	Mon, 12 Oct 2026 19:29:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791793786;
	cv=none; b=bmhYXJfjGoGd3JGf4eFUHI5bprzQA3xi5TljMVpimDZFkHyQl9sXgX/RxY6WD6wg8FIHfVxPke7/s6xIN5u56o9btPh3YCykUBu92r6QiPYGt+KurzAdrFcyl6Pb8yOKzpHxtaXs32SLaIm77+CJhtcmv4ENVSEKgVbJEqU32qQQATgRnAnrBf24ZeWLrY6fjRmOn8MnJuG2Mlvf21AHpR25CNMXp36AsAdPV2ZAtw88rHfkmag7KquqfZQR9wOYW7O0urbAQxMoVRBM2RWEV0/a1UT651i35ixnvaX87lDwOJfBw5fNgVycNtWQwTZUipAlPSEDQRcr91rRVaIuCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791793786; c=relaxed/relaxed;
	bh=+6tpNDjE1w7ilG85ZAOeh77bT6+DnFUVHo6fhQ3df0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZPyv1m1iqHGBYHtBBifzmVJJzSjlorwYbJah0vozK2XMEBlE8pmxVlsh9Fhvp2VBcOWLjXSLSLCrWCMIxg3wkmjAKlrchoitg9RBDSn5jY0uJ9rWmt8Geu1ayO9/NtCunoM7J6U2ly/ZcBvRLNA07b6U+9ZlCt/NFPxrdtktR77pAx54MXpsWRXgd1+zUKy8w60TDQw3bdd0+Xz32cDe2xbGKTNZSj9Xvb4TkfVhlMKcAoFgnWoQE0yfhPzp+jLxQ0XPL8Mulh1rWUlOQdgk56pu17ald718+NGgVW/z5tjfU2maVqjYViPlSJoIraykaTmtMXUdMf4taLHcJsh9lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lc6kvHgu; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lc6kvHgu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j39cn0fCjz2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 19:29:44 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C5EtNJ3322446;
	Mon, 12 Oct 2026 08:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=+6tpNDjE1w7ilG85ZAOeh77bT6+DnFUVHo6fhQ3df
	0o=; b=lc6kvHguAuQSJzDLNnTMzXhEMAaLxcDtGNNnNXrw9MHTRD24RgP0pJxNY
	oqD0rbKNLABqlWTVy6V/t99y+FbqMIDO9C3cK0zBMspM77RmFk6PDbwHV98ww16z
	u/A14ItLwOB/V1GnnBENFsNWTVtpDzDbrA3lnFkqVm0RozihpXyCKSRtafzI4bJJ
	huuHavRiM95P+m3J+k2A35AyIfxHcAiEnsP2ESHx5PFocfJ54COb64sH0tM/f/bt
	SZ8tkCZk3xOouGohcxUWYMyCHF9fOmOSaFEqQVz3NR49OKEpBAHMIFHf2TJNAAKA
	KgBcHnP6mrcdhDlL2uSfOFKhFu3HQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhqn4j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:29:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C5Juxg769698;
	Mon, 12 Oct 2026 08:29:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vmfbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:29:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C8TTnj29491678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 08:29:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CAC22004B;
	Mon, 12 Oct 2026 08:29:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9074520043;
	Mon, 12 Oct 2026 08:29:26 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibmuc.com (unknown [9.39.28.91])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 08:29:26 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, sshegde@linux.ibm.com, amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Fixes for KVM HV around synchronization and initializations
Date: Mon, 12 Oct 2026 13:59:16 +0530
Message-ID: <20261012082922.218799-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfX4UoCLr2DmviZ
 Sl9Nsy+Ob6oVD+e5C8b9XCCUFYrb8BsmLJyRuRq79bNn5+B+5ExMb47m1lkRij2wWw7ipBAi9bd
 tJIh56LggKkaBSBY8OeOYaHQi1dBYgZgq3VgHQpUIKEl8oRqo2sjY6KeH5GyoUM+ADtuvTf2GNp
 Bv64GMKtIAq4z1P02erFJJWVntu1J68vFBP9gM6X1YOQY0dqiCXBQTOW5g/K8NwZW6ulnfeU+fd
 EDc8xJFI3iaOvMCb5C/yFdEdnDTtcP1VsmDft5KScVgLxzCrT/b0iDFVujKX2esAfQHawcgeugI
 IJRcya3GyU0D3xvsiWbdepRhMPzOo0YcOwlMIlYWXD9jQ33/FIkl11i0KodC8oX/qZ+lnPOwci9
 cbExf0PjckQklU5nO4tHYKHiAj28cxuxeCqHhfc8wMcVsuQTcLcho29NMATs8lS+jmIsGlm3X2k
 9xIvgOo+lVBH2I3ByxA==
X-Proofpoint-GUID: BCNmUqFsZt1X_pJuJvXTPx1klhh1FYWk
X-Proofpoint-ORIG-GUID: kAXZjuGCB-t8_r6addJ96iA7dZXo6Oc7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfX4vXptgi4neW4
 RnaSVc9biJ4qG3UzEvfwATR1GtTwMwYdUVEdcbIOGYH+tcD6FojV+2ysWEL3Qbo9Hz3XND4v9wT
 2vqZ0FbWReujdPxHdwa+p6yfjsDi3Nw=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6acc9a6e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=3shF3zVF4xkQSgwXEr4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120032

This series contains the fixes for synchronization and initializations
bugs in the KVM HV code.

Patch 1: Fix for concurrent calls to idr_alloc

Patch 2: Initialize the arch.irq_type correctly for cleanup to work

Patch 3: In the cleanup function, add a check to avoid NULL ptr
dereference.

Patch 4: Add a srcu lock to fix "suspicious usage of
         rcu_dereference_check" usage.

v2 -> v3:
1. Patch 1: Correct the patch description to reflect the code changes.
2. Patch 3: Add stable and fixes tags
3. Patch 4: Use srcu_read_{unlock,lock} instead of their kvm_vcpu*
             variants.

v1 -> v2:
1. Patch 2 : Avoid NULL pointer dereference when calling
kvmppc_xive_cleanup_vcpu(). Split this in a separate patch


Gautam Menghani (4):
  KVM: PPC: Book3S HV: Ensure that calls to idr_alloc are synchronized
  KVM: PPC: Book3S HV: XICS: Update irq_type for cleanup to work
  KVM: PPC: Book3S HV: XICS: Avoid masking VP IPI on init failure
  KVM: PPC: Book3s HV: Take SRCU read lock around kvmppc_h_page_init()
    call

 arch/powerpc/kvm/book3s_hv.c        |  2 ++
 arch/powerpc/kvm/book3s_hv_nested.c | 34 +++++++++--------------------
 arch/powerpc/kvm/book3s_xive.c      |  5 +++--
 3 files changed, 15 insertions(+), 26 deletions(-)

-- 
2.54.0


