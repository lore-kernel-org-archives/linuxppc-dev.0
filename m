Return-Path: <linuxppc-dev+bounces-20207-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84347FF886F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 06:16:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4VYf0dcSz2yks;
	Tue, 28 Apr 2026 16:16:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777356966;
	cv=none; b=VcipnOLEApHrTFPKaAvxszOp5ksT8Q0Y3HdfK81NQs9nuPu/dgoUpoCg5LnQD8iYb9SZehHZ03gpEspSeoaOw9bQNY4JSvDD87mXQkAeLz7faJ7a8fhQheqs5q9IM1xlRF9c8b87JLBmtOchFTT9rcwOqmyh268WfWHuZVUrultWF72zQmQVTbte/BjJSfr1QI7jmtw2TtN4g5Fa84LeoiKzGdu6mK2bmf8sHv9KVOzTU/CkgYRLPXxQLiMX0rq+oI67K5TchuEqnMIn1BX6W1mM+pDFkkEw3N5nYB0bejH+ZT8h9925YWii2LfdyK7KTOVHVsAOrHTmfVrPsykHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777356966; c=relaxed/relaxed;
	bh=Zv2le+No9TSgxay/sIfX02Z3YDQPTXyPQ6r9GxP8vSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K3Oh0t+lKYab8bex/UUj+JXZAmDfF305xCTyvVl+mp9nUuXBTP5N6r50OGkmSGTd+ojGEk2jgEKVqjFYF702OHjhOBanPtoI0YGr0jqyU/7ZXjKPgUrRNc//r+kqMcjzAH5ddIXfDselNLit+oTWvKmurM2YyiiGcTWFh8MoBXqamRgZhr19vxp9MgN/7TfikQO1hoGrOvsGCu7VKiq0PfJE+HkoUdrofsr7lYBwdvq6qqNU7iIRTMiR6Ta9EINouzwdWzdmt43BrwSCk/5z+mn+Gycfu6TVLRZpugn3Eq2FPUiEmBKrWxoy4MYAlbM1F8q3UAKkkRz8cJ0T7vNxZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kCkur0Nb; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kCkur0Nb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4VYc53Zrz2yRn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 16:16:03 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S3dq7e2134186;
	Tue, 28 Apr 2026 06:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Zv2le+No9TSgxay/sIfX02Z3YDQPTXyPQ6r9GxP8v
	SY=; b=kCkur0NbAAM1lOtDv+AzTWY+8oqCocAckaeYpm7s5/a7yTqQ84U5pkKmW
	9gjKQAzxclxwb2BZJKQT12OTFXaomX5V3tD4eMXtzP1N1yCC2Vcw6L7ecPV6KfmN
	f5g2OkYHpA2LW55CqVD6juizzCZOboxjQGJVv0GQW0srqbgOa8n+iHKDoW1kuvYK
	6AGwHMme53fiLQ8MkeB2kHKjfUGATrhvxLcE278AH3gWAgrIW43UfYBGWe7xO83l
	9hHIcimtAL0tLCvBewguxNdu2jfaTwIs9SnDf44OahQaamykoWTKaro9Hvp/Wr/G
	4jQ3Qddl6+eQ5rFk7ccypz8LIvYEQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9r3ymf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 06:15:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63S68hYH032359;
	Tue, 28 Apr 2026 06:15:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xk0dkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 06:15:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63S6Fj8657868708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 06:15:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8AD020043;
	Tue, 28 Apr 2026 06:15:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19A6120040;
	Tue, 28 Apr 2026 06:15:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.123.2.184])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 06:15:43 +0000 (GMT)
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Tellakula Yeswanth Krishna <yeswanth@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH v5] char/nvram: Remove redundant nvram_mutex
Date: Tue, 28 Apr 2026 11:45:40 +0530
Message-ID: <20260428061540.73668-1-venkat88@linux.ibm.com>
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
X-Proofpoint-GUID: gPS18S9n2b7CyF5254k6wu4tyTqiWTH4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA1MCBTYWx0ZWRfX8MvJ/qVJHNe6
 B24w5ZSW7WXQTK7mL5jV6RIrkLPBuq0mGOoxQ7xUhNbpUAxAaCDM0Q9kb5sc2QT3v7Ug6Z+u7Q/
 cPxHZqUwgTsuXiHx8Q6XxiMu3BuVgt/ODZBxBM9aPl0ZtglEpS5YB1nmdA2iihsW/6bXre8eOIf
 Exna0j0szVWvfTh/ZnzzoPZn2Rvsa/npeUsMf165m2cSBLNgxlSssFVgsrohCmIRBqzvWEFWew1
 iGvQ9tq3GBQBCIVG30fiEGzqIMWAvyPlUq43BAI9LY5+BrNMfUk6qIXdFGwS/7VJn5fnXZ7WA/K
 0IYQ5B8dSKTTRQZ7PghIV/PxvosBJeCZ2mtY/Jeio0xDTXAG8OyA6WH7Yzi/9738mici/xB4roc
 K0tMvzOFHHDdLnc1gc65gKAiQMywAHg7v3ruREA/SQh2ru83Ow9lwcnpc80uLsR3nsRogtKm39B
 gIAIQUZOJG7uzvbSaSQ==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f05097 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=WqWmceQO84Qbs2Y3kP8A:9
X-Proofpoint-ORIG-GUID: W4EQXKQtZa3ZwQO0U5DU1g9z1XXYpdcG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280050

The global nvram_mutex in drivers/char/nvram.c is redundant and unused,
and this triggers compiler warnings on some configurations.

All platform-specific nvram operations already provide their own internal
synchronization, meaning the wrapper-level mutex does not provide any
additional safety.

Remove the nvram_mutex definition along with all remaining lock/unlock
users across PPC32, x86, and m68k code paths, and rely entirely on the
per-architecture nvram implementations for locking.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Tellakula Yeswanth Krishna <yeswanth@linux.ibm.com>
Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
---
Changes since v4:
- No code changes
- Resent after v7.1-rc1 as suggested by Arnd Bergmann

 drivers/char/nvram.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
index 9eff426a9286..e89cc1f1c89e 100644
--- a/drivers/char/nvram.c
+++ b/drivers/char/nvram.c
@@ -53,7 +53,6 @@
 #include <asm/nvram.h>
 #endif
 
-static DEFINE_MUTEX(nvram_mutex);
 static DEFINE_SPINLOCK(nvram_state_lock);
 static int nvram_open_cnt;	/* #times opened */
 static int nvram_open_mode;	/* special open modes */
@@ -310,11 +309,8 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
 		break;
 #ifdef CONFIG_PPC32
 	case IOC_NVRAM_SYNC:
-		if (ppc_md.nvram_sync != NULL) {
-			mutex_lock(&nvram_mutex);
+		if (ppc_md.nvram_sync)
 			ppc_md.nvram_sync();
-			mutex_unlock(&nvram_mutex);
-		}
 		ret = 0;
 		break;
 #endif
@@ -324,11 +320,8 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
 
-		if (arch_nvram_ops.initialize != NULL) {
-			mutex_lock(&nvram_mutex);
+		if (arch_nvram_ops.initialize)
 			ret = arch_nvram_ops.initialize();
-			mutex_unlock(&nvram_mutex);
-		}
 		break;
 	case NVRAM_SETCKS:
 		/* just set checksum, contents unchanged (maybe useful after
@@ -336,11 +329,8 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
 
-		if (arch_nvram_ops.set_checksum != NULL) {
-			mutex_lock(&nvram_mutex);
+		if (arch_nvram_ops.set_checksum)
 			ret = arch_nvram_ops.set_checksum();
-			mutex_unlock(&nvram_mutex);
-		}
 		break;
 #endif /* CONFIG_X86 || CONFIG_M68K */
 	}
-- 
2.45.2


