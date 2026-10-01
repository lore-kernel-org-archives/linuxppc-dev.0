Return-Path: <linuxppc-dev+bounces-28636-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351F1CA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 10:02:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwSBy6LlMz2yTQ;
	Thu, 01 Oct 2026 20:02:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790848954;
	cv=none; b=jP2iPJWP6HbfBy3rq4fpH2jAGbxkuUBKto9ZagjPRtu64EnBWoKt8ik1ai7swPoM3lXTBxsMOn9GqMfAKpxKlMSdj/lMH2hx9Fzk2lmzzTNDFs2u2MH/VQtGdMOXKVVMTsZp4Ticwe0aAmzlaL8U7u2MrYJx8j42p0U3pxYsCW14+Rf12N+Py/PHtTgbEEQHqk82TOKCQvAdk6+p3mGtTLniJFIIMvy9CCtS4WU9g8pIG9NGD6hgjgr7HLy2f27Z/lXD5RYufWmU4ovDL6ZS2sb6tqI9f9Dxzpn/uifgNZLBCPAz+5bKANMqSHsvgEYlKUJf7YyNtVL2NkLEzJPRiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790848954; c=relaxed/relaxed;
	bh=ZB3m0fyJJhUP/96XQJqgLWHi+TlvJ6Q9QN+j7WYdzPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OiYTUlEuM+nmV1DPjX8IRZZd7Pmn5gfCHEuV7jBTlgQr0ftoK2BDoWFOySfIHs3PLL4LWZyX8xnwUIA6i0QkhjKsmWUZvO/nnbtIq+36Jvnmm8mf3Y81T+NrYa2v5YdbzDBxaxmf0Z7n5Uwhf3pbwDhqnDPCGPAfAYZB056W5Kaj3FCgjh/mszipdi8Z7rtYX2tb1zelyXnN2q5iw5fuTdfA5VbQYRHBwvUVIoR8H/25RU/DfPWMZ2/WtyYLuEzpl8UKrOxgNps7cOFRO9yxvnH118dGlqDIpx6INH+vG/3T0P0wEG6Nv9o5YI1zNyipSN+ztlR0fOlliiKw93kmog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Lb0tKi0A; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Lb0tKi0A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwSBy0YZcz2y2Z
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 20:02:33 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175WaY1086340;
	Thu, 1 Oct 2026 10:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ZB3m0fyJJhUP/96XQJqgLWHi+TlvJ6Q9QN+j7WYdz
	Pk=; b=Lb0tKi0A3JFjlWX3DIgSpDOYN73LytWl4AbDojDnQbeK7zYKVZsBV72NT
	b4sdEVIHbCOc3E6+aH9aRCNnolisKga0fuuUHVM4kRmzZ/U8hF4ukSeimA8/HYNV
	YB5c2XLxpxI9t3YtZxkJ0BdKAMLbGbX6xBOa20UGRUi9NNgzDncM3jAU+iT7Coeq
	jvg+0/U1kNC8a/ksmoqE2UFdE8yDkb35A8deiqYtCqcYOwKW1zbFy1My4qkCeEI9
	wTgvTHEay06uFyG/DZRzou161LqWCVVNjPL6XK1DW0QUgYjR7I+phnv6OSz0Z+kK
	KkNleJbJ1U+uS+wsS+7brfYcK7Uzg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5jefw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:02:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172teX3460494;
	Thu, 1 Oct 2026 10:02:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4petmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:02:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691A2DEO17367450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:02:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3140520065;
	Thu,  1 Oct 2026 10:02:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D3DA20067;
	Thu,  1 Oct 2026 10:02:11 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.bl1-in.ibm.com (unknown [9.123.6.5])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:02:10 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        amachhiw@linux.ibm.com, harshpb@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Fixes for KVM HV around synchronization and initializations
Date: Thu,  1 Oct 2026 15:32:03 +0530
Message-ID: <20261001100208.1271628-1-gautam@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzOCBTYWx0ZWRfX5RF8kEI6ohHr
 kyVn8jiLkguh6cfl4cdm6PukUGvRyEv8J9vNk+W8ZDYSBDVc0/KTmPAGF0WrRK+XNO1JF7ASa6r
 ifGbsKe/whLQXbIfmKnEkzBnLbG9CC4=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abe2faa cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=BB4zp169t_7L_k8pMqwA:9
X-Proofpoint-GUID: K_flqD8z0vb_NFxw3VmAokeb1c2mK1wm
X-Proofpoint-ORIG-GUID: JeUiZOM6sB8RCAPxJwKrTI6Nhf9I-QwZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzOCBTYWx0ZWRfX1Ixorp/QQMuz
 lnCNreRBWHOW3M0UxZ9+WLkxY3nhbvourQvcYP0QbnDpbc6HzMKLg7+2RRAqVQb4U6KIKDrQqr5
 keyolMefk4Z0ftA9A9ef7uBOHwzmtNGjxGtIGrCcer74BcG+5yZMZjtLJfXFOeBRjCJ22gJpofu
 OruxXYLn+6KvQc2WklBGwGxBz68Fely3uVJ7mVenXE2k/Gq+GlF24MbYYsI5+1lAwrYuw5C4jB1
 ObKWsfDJurqTv/DABF8QA1h2OuwuR9R7BmnP3YwURt4cxpYJUw2+UO+/8ux4r1XGqNsmjIMG8m6
 gV5iW5pONCGvDNf27vYgLJmvth725CLM7/y6iMQOHvT8iCcfvGdd4h6h1MERYC6hIUg5rFwuiNO
 H4quP+Fs4D5zV5s2j1apMEKVUUYahXGNYdWuDmAohE3VX3clbIdX8Frt0tIdLrCMRSvaUrpIVah
 6T0p/z/5nUgocDGD6rg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010038

This series contains the fixes for synchronization and initializations
bugs in the KVM HV code.

Patch 1: Fix for concurrent calls to idr_alloc

Patch 2: Initialize the arch.irq_type correctly for cleanup to work

Patch 3: Add a srcu lock to fix "suspicious usage of
	 rcu_dereference_check" usage.


Gautam Menghani (3):
  KVM: PPC: Book3S HV: Ensure that calls to idr_alloc are synchronized
  KVM: PPC: Book3S HV: XICS: Update irq_type for cleanup to work
  KVM: PPC: Book3s HV: Take SRCU read lock around kvmppc_h_page_init()
    call

 arch/powerpc/kvm/book3s_hv.c        |  2 ++
 arch/powerpc/kvm/book3s_hv_nested.c | 34 +++++++++--------------------
 arch/powerpc/kvm/book3s_xive.c      |  2 +-
 3 files changed, 13 insertions(+), 25 deletions(-)

-- 
2.52.0


