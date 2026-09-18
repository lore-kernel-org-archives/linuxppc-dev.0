Return-Path: <linuxppc-dev+bounces-27652-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C64BC982D2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 05:24:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmLdl1xY3z2yql;
	Fri, 18 Sep 2026 15:24:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789709051;
	cv=none; b=LWdYz7IywwoQNXE8Q68lONKk2Shil3B7GkX/7d7/VqzVY2YLyFW6a+i9Xw3b8JdhFjD9UbEOsk1+ac5p5e4QMPIGvVEZgHzyLPv3sBQG2Xa7YSzDE8Oh55YJwYCS0EnSkgzfU3tgZ81g92jn4M4z0mGDRpKYQWskwGM11JMyGkBR6Uj6+zMyZdt2JeVNcLS2yY4j7P4sSy//48Sds6C7lzdycW90CD7x4OP5XqOE952MHjrGx4B6/xJy2LMImFMNSJhUOIdNMafNWhPskQTTuEUTcJFQtO57T2Vc/6WJegUoWtfruCaAEDc4opLtY17J3EThopVuTEfCIRlLr/9Z7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789709051; c=relaxed/relaxed;
	bh=flOoCeiIYmtIwmF7mKO1K45FYQZ6Mrfw6jpQatZb2GE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEuKn1czYphCnBu/zoh/zwjz08nRd9WHQbSTV2M3rCb0463fxAM0rGMFOvO7Z3FUD4+JWU6KueUCMpYJga2jIOaEaUeAlD62Y/7Aw2Z9s9Gq6dGKERtvBUvTwGUCg4AXZ4DKiRUIawslUg64nivVBx1ZfKreU+5ciNrQufzTwEjF9/Sj/zRtFcq9uXNwimO4YH29uSVbLYk4D6jEp04HzprlQf/hTmnyhh7FbtEx54HvgYsozbyR6xAXckXmoZgpQw9KJki3wcVSTcLqebl8DqJYNr1Os8ERHlgKFgWfYjym7PHB8LRqUzYTm3v/AyAvpix8evUHaM/rXYocUnV2cg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jsfy+Llt; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shirisha@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jsfy+Llt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shirisha@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmLdj2sY3z2yqd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 15:24:09 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I2VRoN042714;
	Fri, 18 Sep 2026 05:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=flOoCeiIYmtIwmF7m
	KO1K45FYQZ6Mrfw6jpQatZb2GE=; b=jsfy+Llt/yBhbQRXtGCyVcNNiOFX/VX45
	xaagFmye42xRoT3MOitw/nA2ZDsSVOoA6IfD2xn5WmCtWNbjeNRdCiUwdtqiZv06
	gC7J776HGjQEr+9FHGKT+iJ4pMqVKVbfgNGvSnWs4Ni7T3RmW3e5reaZXUAcBLuf
	Iv/EHWsF2KRqoLYEMiJL7NkWJyOaossfdJhwAffa9cJOVq1mwZRLoWmIQttqbet2
	rACX2gECvgTDdGoAr2ClH7061hH5mNizdRiiFWbbTGGFPGe6KlpRvblxg+LFTIHx
	vHwZthqoEJEuml8tCuueDXQXc8NggPpJ8stN+yWro5K/iIQ8dQ9mQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx846c2n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 05:24:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I2Z7JQ009697;
	Fri, 18 Sep 2026 05:24:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5ffdwk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 05:24:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I5O2db32178560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 05:24:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C913620043;
	Fri, 18 Sep 2026 05:24:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02BAA20040;
	Fri, 18 Sep 2026 05:23:59 +0000 (GMT)
Received: from li-d12addcc-2792-11b2-a85c-bd8df30615ab.ibm.com.com (unknown [9.66.68.7])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 05:23:58 +0000 (GMT)
From: Shirisha G <shirisha@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kselftest@vger.kernel.org, maddy@linux.ibm.com,
        venkat88@linux.ibm.com, shirisha@linux.ibm.com
Subject: [PATCH 7/7] Subject: [PATCH] selftests/powerpc/rtas: consolidate TEST_GEN_PROGS definitions
Date: Fri, 18 Sep 2026 10:52:42 +0530
Message-ID: <20260918052321.932660-7-shirisha@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918052321.932660-1-shirisha@linux.ibm.com>
References: <20260918052321.932660-1-shirisha@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA2NCBTYWx0ZWRfX14qVpEkVlSrO
 I6jYUEuX8Wc5PrnZa3p6LpBpDyZliqTmff9oGifaxhRqVZwu6ZWdSfrwoK3Ik0ttyjvJ9obSE5J
 Kqgyemn94AXGj6c5u6liflpkj71XH5aEYdixAQIHi/sKiw8XEMxmnZpeQGTiXBozpFGZ29lxC94
 LxmMkMEaucEwBNMtz98I0TCMiAMxGv/phser1AcyxHKVZRR7SstvFRzF/m8yIdE6rjOqNT0r5OB
 cXS70Ymlrt3nA87D6XwgLtCbCnpJYjtILTogHib+ihWQdMVj+GySZLHY96h243MPLdbdF2y+ulu
 I+WZMQ2Lkvfhvu086U9xshtiWC6+TkyrgQcSk3J5bKYW4UEsj8KNHJxzaeCFaC6dV/xzVNuiEiz
 0+tZIo6XOG8BMwJZDNIRd4PKzCWs3POQ+R6PEZRLT1tDLxYDsxqTqcMOavhnGQShU810stQxvsu
 QqdDLau+GGHuppIUDmA==
X-Proofpoint-ORIG-GUID: cvoS1Ct5q-llaZ_zpkx5zebQc_SSq8D_
X-Proofpoint-GUID: cvoS1Ct5q-llaZ_zpkx5zebQc_SSq8D_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA2NCBTYWx0ZWRfX0EJRHFJscUXV
 8aVIQu4Y5bUXsrlxH+SsjTV+8p3ZQ5pkJaLUYx0Zy8oGyHOZthsjqTWM/rCnksyQbQ3Q5nBXdXJ
 i92pE6ToSbFti7XBNHhG7KYLdhoYaRA=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aaccaf7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=rbTJAiSUCfbnr-_MOTEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180064

Use a single TEST_GEN_PROGS assignment followed by incremental additions
for the RTAS selftests binaries.

Signed-off-by: Shirisha G <shirisha@linux.ibm.com>
---
 tools/testing/selftests/powerpc/rtas/Makefile | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 tools/testing/selftests/powerpc/rtas/Makefile

diff --git a/tools/testing/selftests/powerpc/rtas/Makefile b/tools/testing/selftests/powerpc/rtas/Makefile
new file mode 100644
index 000000000000..eb30f62c5636
--- /dev/null
+++ b/tools/testing/selftests/powerpc/rtas/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+# RTAS tests
+
+TEST_GEN_PROGS := rtas_rtc_test
+TEST_GEN_PROGS += nvram_test
+TEST_GEN_PROGS += rtas_proc_test
+TEST_GEN_PROGS += fadump_test
+TEST_GEN_PROGS += rtas_flash_test
+
+top_srcdir = ../../../../..
+include ../../lib.mk
+
+$(TEST_GEN_PROGS): utils.h
+
+CFLAGS += -I$(top_srcdir)/tools/testing/selftests/powerpc/include
+CFLAGS += -Wall -Werror
-- 
2.43.5


