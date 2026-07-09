Return-Path: <linuxppc-dev+bounces-23899-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE7EC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 06:33:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwlXH6t5Wz3c9k;
	Thu, 09 Jul 2026 16:33:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783578799;
	cv=none; b=Z9tUbBlDYeNxjQIyFGXpDBMwCpX1waVRKxZePrm2XX/dL5eDZzZEmqyPGjXLI7iT+DTcVQ6NOY65vV9zwMLypNKxcXiEkKA8IPHNxA4yYCjh6sHG+x7GFTiIIckKW7m9Fk3XjxQqvdjKLUewNlImrXTbC9H1kRngR4I1wNmNaQ5sTE24sqroHHpb62GvLsWOQICEVLeoJVb0PB/hZFAR2pj0XvIEMKgrwWUcSWJ2tnp2FarXaxPHsQMGqZeJlFeuBJiN+gQ3DkU0I0FapYncn3FdYSyGd1SZYVOA3oyr2B/QtOBP4/p7w91SEM3geMe98Cf0yzca6NF5Z//7bcBs6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783578799; c=relaxed/relaxed;
	bh=sqL3q7hIixuKVwjG7GithS2vRWS1tvYVOKDRgb0HbuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xh75OuaL/wrso1lxP4waofBVNnSpWIWK4Q2r+30fnf0WAwC/jJzGAe4z5n6nYiZOV8k9mE2rxvaUDboenf3crh3pdo7dAn+IQjoUklx/wW1X5e2zQZDlpYEc780TwJZTgMpSWlGQuiAB8I1P+SCbff0cspJOD/xzVHKJHs+Li2I1RV8pYkyAKyP7L5YKIlXWGzsBxWtIXYSDwquA1XJXUL4YBD31aoqEHftUCIeijLe0Ix8BmTS2nwRhZQRjs9ItDDZQIoxCtKInq1bTHtEU73DrUtv2cznLlcIdp6kiQqXL0Kl59HWynw8UrI6GA6spxpMmRtpUnKlZ5imXPi33ow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZnzT25Re; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vishalc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZnzT25Re;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vishalc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwlXH20Ylz3byZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 16:33:19 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696ILfs1897187;
	Thu, 9 Jul 2026 06:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sqL3q7hIixuKVwjG7
	GithS2vRWS1tvYVOKDRgb0HbuI=; b=ZnzT25Reys2P3Snj5i8wf/3r1XOUVKQDA
	OO5vf4+JXBjY5BT5ecoXpRtY+2hd+CFud8YU7EyVlihUbXB6nidGYfXBqpGYmxRq
	qsPU6iyt5Qfc2Bbg0LA3og52VR4S84Hh3upmDzE4m2tQGYmq7YeeOjKDQI2ejtPH
	hUv5cP5AXfrEt+Wa0AJXT6EKWQFzAihwtvaPh5tUpzZVyFcrlS5q4ahlTkc00VDl
	ykYagUpCHBXDxhUXKFomsNshovBfPJYfrkyVbR5DQjBc2zsUVjGEw4kJxSFLoIWQ
	gLuxZnPjR+zJy1qVbgnvRpoPLlRk2RpCL2XTLJ+bh40zc4oSOiNpg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sur0316-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 06:33:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6696Jbhs007590;
	Thu, 9 Jul 2026 06:33:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqgbpbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 06:33:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6696X2hf13697376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 06:33:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 662CE2004B;
	Thu,  9 Jul 2026 06:33:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED8F720043;
	Thu,  9 Jul 2026 06:32:58 +0000 (GMT)
Received: from vishalc-ibm.bl1-in.ibm.com (unknown [9.123.2.84])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 06:32:58 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: maddy@linux.ibm.com
Cc: peterz@infradead.org, frederic@kernel.org, npiggin@gmail.com,
        mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com,
        amachhiw@linux.ibm.com, vaibhav@linux.ibm.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH v3 2/2] powerpc: enable to run posix cpu timers in task context
Date: Thu,  9 Jul 2026 11:59:42 +0530
Message-ID: <20260709062940.1679427-6-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709062940.1679427-2-vishalc@linux.ibm.com>
References: <20260709062940.1679427-2-vishalc@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1NyBTYWx0ZWRfX6/pcE0+XHUDp
 RKbkdGKB4FHI4WW9mX+I9netXDaqlheSU5yLHM7aeXnlwgKunbEW5FS4O16r5YIx/vGL2TrZStY
 TTetPjzP3xMO9ppr0PwEnWewEjOMQnQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1NyBTYWx0ZWRfX4JQMFtcNs+Hz
 QzJ0l85vOqQj9/1608slUzf/r+/oWOv5eqjYpVqQqlTaI1XIV2dqSuYkgBi2sqCOWCDK6Eg99r1
 XL6AIk3PLvfgiRGe1Y2xRwqQYZguJM6cKuEwoQ18aEK0z9xrUw2VXjvoeRy6rgsjTN1h3dFsKx7
 ClBkPluK95B5wocuRLtTzTt7oVzkBIrMcRWZ9lechNGdzqX+9OyJPEYHXlnmd8T9RB41wb9Hdf+
 zi7NQO35KjQtCwMe5sbft+jZ3aRintLusnNHBLpMxNQu1lzF8RJn5EpmTaFwH75QurnAFBfEYMa
 xj1HqxUSfUM3ksE6OD8gR3LWxISqZM/A8EMlFqqlvD1nQVbfEaqZsoz8J+IYhE213iK14tKp7QL
 C9eRuIHyKKayFTP3G/s+t+PRkuVkPte3e4JpN+JnyxXUxVIJ2QAtBN90vt/CKF1HJ+x7g+Hp7VN
 ugtBs4Jke6O/YAaY/RQ==
X-Proofpoint-GUID: yEIgEwfQtYazhRWS5Z5rWyY5OXhjMPHs
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4f40a3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=7mPU114Ar3IJ09b1OIsA:9
X-Proofpoint-ORIG-GUID: DUoshtoKsdss-swwmIVeHa4UdgpkqwAZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090057

From: Shrikanth Hegde <sshegde@linux.ibm.com>

From: Shrikanth Hegde <sshegde@linux.ibm.com>

Now that all kvm entry to guest paths handle the task work
using the generic framework, enable HAVE_POSIX_CPU_TIMERS_TASK_WORK
which allows running posix cpu timers in task context instead of running
them in hardirq. This would is a necessary step towards enabling
PREEMPT_RT on powerNV systems.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f7ce5fff81f0..51555a0b1a26 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -281,6 +281,7 @@ config PPC
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_PREEMPT_DYNAMIC_KEY
+	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_RETHOOK			if KPROBES
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE
-- 
2.54.0


