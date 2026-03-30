Return-Path: <linuxppc-dev+bounces-18992-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3CFFF4946
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 06:22:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkh4N69mQz2xpt;
	Mon, 30 Mar 2026 17:22:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774851748;
	cv=none; b=BjNFgd9ykQvZmlNvhNH90N7yez0soYAP8hrbY181eqcLyFNoeKLUpyOUx2kFKXiu+Xu9b5NTywmqRg5bMm2jp8tmiSpftPv/0CMkI6OHNsWElaxOdoLzx+g8XCzswDxNZh6VtmigO1yBhBbZgzNiBbGTq+kSaWVziEJBCt/c74+bn6J2AptrX78o+Gr3YiAJX6yy7vcE9CY7y9sgiImu5JvKK5G8XE3J+j+NvZLI5Q3UV/qEo8TKyLmmJ4SEUvHaviW2zSXwLf5s8vKmFwvoOXPrnDz9HbaxpZkxG1F4xw5zkMeSi1Y31DtnImqW19LCr/LHhFHJ9g2tnnu8J9RZGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774851748; c=relaxed/relaxed;
	bh=AysGbeP2sl0w5KLqpo1+5bdxDIFqyUGWAcoJQ4pVIew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WzqN/wdhFn23HxApJQ3r2T5yJW2Q5hJ4B4MwWm4rcRo33yMGv7ijY+T/sGWvFATF9CAynDuHD+qnDFv6xT8ZoPqOz5gjGbo279qCXLP3W0T+8db4O69tptnBekADfTRDy0o02K88S0sf1zCeFoFWO1vRhAV0a3/q0pW3rchqwNB+pRH36rJs2wM8v8/g/e+nradv3XSEyMdnGG03gUdkmjyPnW4l5FYQuDwrPocNafInrTBQcQ20gFaOaYoQEAi50UvTndzPQTmVu+30hbSUhS+yWyI4SymySjfan2xt+OQ3p8+cUdB8KFyQZ8MkLp+rEibsaF85UhOL0ojvo+UkUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Tf9hSzZM; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Tf9hSzZM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkh4M5dyFz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 17:22:27 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62T4WrVF2411380;
	Mon, 30 Mar 2026 06:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=AysGbeP2sl0w5KLqpo1+5bdxDIFqyUGWAcoJQ4pVI
	ew=; b=Tf9hSzZMSLNo/WTQQQSqTbgjGY64tPoDDJv2Tz+8V+wtBaYXw3BIZmaid
	mMQi2Yi4NDX2ic7bO9NXhdJ9Fu7haYThE5RqcVrg5HW7zLOQq/6QTjVSNHgk9W8B
	15Kf0yxXYirrqjZdmyEj0y7O8+rOjPoQ118ZOCN7V5hpoqk6V++Cq/OOw14cUPYE
	V0oIWnTDEECoF5jEUWgKsGQGy/a/hoWcWD3b5+rucMJxzpoIOhKiO60Jb4ra5vmp
	1ATzLAUcExyXy8PqPu1PBuHJxXHEuoW0z93iMa/Air2VWSJdkqgI2U9OpOSoFtN3
	dX313zQUJUsaesbh+5TYTI+jAUHDA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgdcht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 06:22:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62U4uV6O005980;
	Mon, 30 Mar 2026 06:22:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spxurg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 06:22:20 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62U6MGvl52298164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 06:22:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AFBD2004B;
	Mon, 30 Mar 2026 06:22:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02BE520040;
	Mon, 30 Mar 2026 06:22:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.240.154])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Mar 2026 06:22:11 +0000 (GMT)
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, ritesh.list@gmail.com, arnd@arndb.de,
        chleroy@kernel.org, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH v3] char: nvram: Remove unused nvram_mutex to fix -Wunused-variable warning
Date: Mon, 30 Mar 2026 11:52:01 +0530
Message-ID: <20260330062201.2581-1-venkat88@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA0NyBTYWx0ZWRfXz03hlpfJFT+Q
 +rtWUBtKOGIsIXnRC8DQJAO3aYwinSuHxDZKObux4gZHz2JI/c/vFJ2L5Th8k7D9XCZaV0okkkq
 cJucyMs0bP0n017r/E8a4q4hZr0hZlymqxm4k0Sps7l/P6xTKqggc0ubkzHLOcr05sJcY6+VCEG
 mDFOpkyI5YsJFzIRmuakblooyrls95SBjEtRs79VhvFIa3wtaRjP7Zk5HUoOyZVAiWYf2ZJsHtI
 mPwyYtPs2Qqo08EYGQenveIGknVs2c/eqaIzDW4N6Nwqb68OxHQl4k4F2IXbrrGIowRjc9ooCZf
 8mPoC6xa2K9eef7WBUiq/SSqCbQiydwRUNPICsvSx/XUZ+BEdFb+r/klonufnEu9WjDvT8flPlM
 h1tReDm7/F9e5BHhJljtbusfQyo4QYyXJHgXYeyHTi9550MpOv4sipA2JHuPTSNdiX1Cw6EJDzh
 GUBYLXhLXIg+Ku43YoA==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69ca169d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=1sboiQz5TgUy5XRvxJ4A:9 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: 9LAJ6FKGBqwJequDGSOWCXIM5UGnFKiJ
X-Proofpoint-ORIG-GUID: 58y5gv5o_vxrupyRU_j4CNgRxrQmzl4z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300047

drivers/char/nvram.c defines a static mutex 'nvram_mutex' which is never
used. This results in a compiler warning on linux-next builds:

  warning: 'nvram_mutex' defined but not used [-Wunused-variable]

Remove the unused definition to avoid the warning.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
---
v3:
 - Removed global nvram_mutex entirely

 drivers/char/nvram.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
index 9eff426a9286..9ab2744cd375 100644
--- a/drivers/char/nvram.c
+++ b/drivers/char/nvram.c
@@ -53,7 +53,6 @@
 #include <asm/nvram.h>
 #endif
 
-static DEFINE_MUTEX(nvram_mutex);
 static DEFINE_SPINLOCK(nvram_state_lock);
 static int nvram_open_cnt;	/* #times opened */
 static int nvram_open_mode;	/* special open modes */
-- 
2.45.2


