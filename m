Return-Path: <linuxppc-dev+bounces-19657-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8ECE937E0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 12 Apr 2026 11:31:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ftpK71DGFz2ypW;
	Sun, 12 Apr 2026 21:31:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775993499;
	cv=none; b=ANbN+Z5FvCGpOClIa4ZanjYuV/Nc0e/0tfzQF5dQovS0NiignJ40Vp1UpXxe44Pve0BcnMjN+6bSiLwPd9QDqQiueDd7PPZSua7I17zNB9CkSgxEQgOhHVOxjPmaSKZo9KoDxC1Y5Vk6+1z0yVe4+ezKxuECEOvpIvsroYICPxNTS/j2NBvXmpVt/SDSo3Yze/QO38RS2DWjJle9wQ33KEzmMLV2ub0WZ88sGqh1ZRoiCxRBhIuiCqBuVQFWGY6bmw881BbvXQdyv4fh1JlydW3vyqaKb84u1KhamffbzaSBitOadO7N4ycxHUOquTNi9Hv5sw72phQZSJmdPnj24A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775993499; c=relaxed/relaxed;
	bh=XM5wDcj1k25RA0EBnRvrSb7gbfUdR4j3rsxxhwvBUiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m1uhSWzjVZ5cTl4nzNO5woUshdxQc1QlGamIglqEkCK0KWYQRwLohMcj6B14eNC0XsltR32wMSbpYrG0B8QGStlSmXBWzi1hnyS5TMWp/j/yZwYVJmkRExz7xkhlpsBhW5dRSYHkxWNkARuXVcu63xPMH/UINUybtEND0w0jpSFd5SwkH7fefz5E6tst58m6PGphdBV4nI2iAMhxrjB8Aw27W5YdYrDp5IyYQx1OTl2E/kU/YtnnK2LLPyzOn8eO+pPMYcsgpPe52y2sGzWiGmYSgzK4BnYj/Z6kfAxBevmnV8oXUbPT9+a2EeXafs8UWdpO8aVPq7sFah2TfS9zXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Nnc0ThNe; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Nnc0ThNe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ftpK54Tmwz2ynv
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Apr 2026 21:31:36 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63C8rTBJ1681100;
	Sun, 12 Apr 2026 11:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=XM5wDcj1k25RA0EBnRvrSb7gbfUdR4j3rsxxhwvBU
	iY=; b=Nnc0ThNetnszIhhPSu8p1+iSTIP//AXQ3eV1zjq1OffJVEKip3zzfRkn3
	5yBSFUAULoLx5yJXqZo7jTNo/h6pnQcFJ1IvFj7HlwsOyVuxHk5SKRbQNiJ69dxk
	Y0dBgZmgva/eJBU6e+HEK8BSwzyZVragiDxar06APC5Zt8XdGSWKVh7czue3sewP
	YBgs+Pv8ajlrwpAR6DSF8uZWIpZnhxPjpKrj3lHBzieDJ5EwLdj42nTtOAETn1b/
	s1eTvqDHphzXt+l4R01bHMD1vDqW1P9Hv0ScRj3mklGffAg/OsXPmIaOGuPtvjKr
	iSM+DWE1VSoVjrIsS+cO4vodnUFiQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdxwuk74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Apr 2026 11:31:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63C8oY6F004179;
	Sun, 12 Apr 2026 11:31:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24k17nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Apr 2026 11:31:09 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63CBV5bA19530112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Apr 2026 11:31:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CED062004D;
	Sun, 12 Apr 2026 11:31:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E33B120040;
	Sun, 12 Apr 2026 11:31:00 +0000 (GMT)
Received: from shivang.com (unknown [9.39.24.219])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 12 Apr 2026 11:31:00 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, kees@kernel.org, tony.luck@intel.com,
        gpiccoli@igalia.com, ritesh.list@gmail.com, rppt@kernel.org,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Shirisha G <shirisha@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v2] ppc/fadump: invoke kmsg_dump in fadump panic path
Date: Sun, 12 Apr 2026 17:00:57 +0530
Message-ID: <20260412113057.46090-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEyMDEwOSBTYWx0ZWRfX+A3DUCKDbbML
 oaLKSg7lJ5S4RkJxVUux6v25d5urZLDgr4dHmli2/BPP/VaSDcE3dj1hk+7Ix+L8ZtPJ0P6blYj
 5XTE8s9VR50zaswgxXPND0IJnqq+2oPkLZjM3rLX5n4bGhGXBmXP92LPjkAWHgMQwhXX52Piwvk
 bZDJG9FAxLOLSf5QhKXGnKNA9VtjwiaTo3PsYopjwzmI0Xpre2le0lplOmOge1axRdT9s9K8VE1
 nwGwssp3V9UP2/ovjQ1VaRlz210jS/57QTRx6+xXz2JaRYw1OYPrKET9NDlWdJv3VM/4FSfRE1n
 yD7kGCSgpmJi0JCkoTTnbOglzREPDBxax9A6+mgg5f0fYQyKMcYk3oTIl1UAtuy2loqFSnY+SfF
 eUmi+oGlKfRxB5rmpVpE0Zmu1NABgfydoq6RZB/+o9G96olqgii1jk56wRp4Pwx1fRPv8Shg62z
 r/ZJhm3dO0FaaE16mJQ==
X-Proofpoint-ORIG-GUID: JE8r2Vi0-32O3uLZhHk8y7ybrW57zYQR
X-Authority-Analysis: v=2.4 cv=TId1jVla c=1 sm=1 tr=0 ts=69db827f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=wpMxpv9DbCWzPGTgfgQA:9
X-Proofpoint-GUID: wYDc3eL1nJlKq2cNdMIHGqURCzZqelb5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-12_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604120109

fadump is registered in panic_notifier_list and gets triggered before
kmsg_dump_desc() in the panic path. As a result, kmsg_dumpers such as
pstore are not executed during fadump crashes.

This is problematic because pstore provides a critical fallback mechanism
for crash analysis. When fadump fails to successfully reboot the system
or capture a dump, pstore logs may be the only available information from
the crashed kernel. Without invoking kmsg_dump_desc() in the fadump path,
we lose this valuable diagnostic data.

Invoke kmsg_dump_desc() from the fadump panic handler, but only when
fadump is actually registered (checked via should_fadump_crash()). This
ensures kmsg_dumpers are called without duplicating the call that occurs
later in panic() when fadump is not active.

The call is placed before crash_fadump() to ensure logs are captured
before the system attempts to trigger the firmware-assisted dump.

Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reported-by: Shirisha G <shirisha@linux.ibm.com>
Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
Changelog:

v2:
  address comments from Sourabh, and sashikio-ai
  added should_fadump_crash()

v1:
  https://lore.kernel.org/all/20260407054341.308710-1-shivangu@linux.ibm.com/
---
 arch/powerpc/kernel/setup-common.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index b1761909c23f..87afc8003a03 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -68,6 +68,7 @@
 #include <asm/kasan.h>
 #include <asm/mce.h>
 #include <asm/systemcfg.h>
+#include <linux/kmsg_dump.h>
 
 #include "setup.h"
 
@@ -744,6 +745,13 @@ static int ppc_panic_fadump_handler(struct notifier_block *this,
 	 */
 	hard_irq_disable();
 
+	/*
+	 * Invoke kmsg_dump (e.g., pstore) before crash_fadump() as fadump
+	 * runs before panic()'s kmsg_dump_desc() call.
+	 */
+	if (should_fadump_crash())
+		kmsg_dump_desc(KMSG_DUMP_PANIC, (char *)ptr);
+
 	/*
 	 * If firmware-assisted dump has been registered then trigger
 	 * its callback and let the firmware handles everything else.
-- 
2.53.0


