Return-Path: <linuxppc-dev+bounces-18589-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CA9FC72C5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 07:25:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffPny6pHmz2yZ6;
	Mon, 23 Mar 2026 18:25:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774250710;
	cv=none; b=MbMxwAK5SuEfNL5D0XuA4LSuzNnWkFliOOjruR+RbVwFKj+tmt9xZde+O5a4oaP4DSRG2g1njPRQeRUhwzK3ELM1azoHlksK9LwScYFKH1bj3rEmWp1+2TGfh0YkzCH4KlhpdEqhNQBieJJCnrKlygYjIpoBPy1Cr3yNlVtdbLX6841kFJrwQFLjoW2UY//sxJnzqabYMUayu/zsx/P/ueY5iWuGiUTI1lyPeByzpPOzxSZ1pHDkQGFVwKXi+mtzjBs9M8k2nyRZ6015fJi8HMIaEYQvWyq814lemUDHOOA+89BV6pvZMy79BWrLAL4TvfO9SR/jBdeTy6SOmIDfvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774250710; c=relaxed/relaxed;
	bh=jAO59f310du7QormdyuLxv3apotxnRlrU6xoEvAIXr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GXkH9XHeYqNHLTDbiQrqAHayOCM/+P08TiKixCTbJRyJZj3yB439ZxWPQLX4dhjuhSjEPmJ9Z2eO3TlpnSw/Oo1Q9xdt6M3KLnZPUwE4JvBemUG0oUrq1UW2buwC0hLp/ZSoS9KDL9GjzCQ7xbg4kcvE7k3NpC0Pb+ZZmRYALn9YJ4f+bkxGpG1n0Www9hEbcjIE/dzAvy5ccDkRluuc4MXEzURtFjK+kr5aeGnGH0mOmlQGJDQKE/d4mT6JAXvlL/QgAx1G5iOm2PFFumPXLiqS8bJYaY4A9hICqJExUNptuWASjZrejL9VZmx1ucKzx3n46ayS1uszjPQLPntyyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jx+o0ZDc; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jx+o0ZDc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffPnx46dMz2yYy
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 18:25:08 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MB0K4o3743898;
	Mon, 23 Mar 2026 07:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=jAO59f310du7QormdyuLxv3apotxnRlrU6xoEvAIX
	r8=; b=jx+o0ZDcFg1AlC9LpBRt9rF3So2ZwVvjFn73OdrJB7f4nfFGLX6SngQ7P
	E7B+NB+ytbBXaHjY1R1AMSuHkv7DcYEzLA2sUvZdf2y0OcxehirJE5/NUHDqySC7
	+vCaksidPvjqXELkHbj6ENVvcsaKc8amxwS2+V0wVbNhsvqsCxjTipqBVH8/s9s1
	Uu+YQ8GYY5CvnQAEU79omJJfPk7M5izU0zpZJ/wrooiZodJAHjjAda8pI/cyD+Ob
	3PupuwebZwM6HqN31QFCRyANQotk6z81UDV7AQENf/gcuJE8qDOdobPm4uTFOEA9
	6mFa332LxXX+cWz02gnURPr8YpPBw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxq5swq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 07:24:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N7ItZr008749;
	Mon, 23 Mar 2026 07:24:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nncdxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 07:24:40 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62N7OawB22086016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 07:24:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43EE92004E;
	Mon, 23 Mar 2026 07:24:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A483020040;
	Mon, 23 Mar 2026 07:24:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.247.60])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 07:24:27 +0000 (GMT)
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
To: arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nathan@kernel.org, nsc@kernel.org,
        ojeda@kernel.org, masahiroy@kernel.org, linux@weissschuh.net,
        tamird@kernel.org, rostedt@goodmis.org, ihor.solodrai@linux.dev,
        ritesh.list@gmail.com, maddy@linux.ibm.com, peterz@infradead.org,
        venkat88@linux.ibm.com
Subject: [PATCH] char: nvram: Remove unused nvram_mutex to fix -Wunused-variable warning
Date: Mon, 23 Mar 2026 12:54:22 +0530
Message-ID: <20260323072422.25730-1-venkat88@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 7EOGw3xU-fF7FPWBWLwp8g_3yTZxUJat
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA1NCBTYWx0ZWRfXwtVcgvRfCMLi
 0BfkRj+clU+sJN9YBDTvMWimUa6YHaFe6EFWb1TLaTiD8xVd//sATAiUymq98oIQ9trSTp9gOk4
 4wy6Rvf1iFWRkP/p99VYKxKigHU5Rldc5K/nbq0JMDrxnw0/gDFQGGjYR9V5FeQ6RlZuK7X151s
 rOSkjuz4fiymmocmIamRm+QGnMUHpR+1J6ZC3b6/fPoEnoedEdM2uJ9iO3Wk51WQr4eBzuYKqfr
 e3ZV4SD9ud0gGpwjhH6HkHWYBjW+xnCP0VE7r74VIrrqB4PtZLRMSsQfoinj3e86xuo3BaAFtT7
 0WRFvgcKomKGFGk1lohR2XXEnmPfiCBB9/mo4iR586jY+bmMQcDToi+DP6NR4dnTr1K4UdanvbH
 XoSKmjlzG1AqKMBuqQ53yHlkb0686eoziIspB+ITz/5qB4xII2YDZgLjdZV29uEcvmJJARU/RwY
 GYAdZ6oZqAUna9zAYvg==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c0eaba cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=HSj1x6wVMASIhtUHg4AA:9
 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: _M4EmJC2Qippd94GV-49dPGM0g5gFrUc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1011 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230054

drivers/char/nvram.c defines a static mutex 'nvram_mutex' which is never
used. This results in a compiler warning on linux-next builds:

  warning: 'nvram_mutex' defined but not used [-Wunused-variable]

Remove the unused definition to avoid the warning.

Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
---
 drivers/char/nvram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
index 9eff426a9286..2ce3307663ed 100644
--- a/drivers/char/nvram.c
+++ b/drivers/char/nvram.c
@@ -53,7 +53,7 @@
 #include <asm/nvram.h>
 #endif
 
-static DEFINE_MUTEX(nvram_mutex);
+static __maybe_unused DEFINE_MUTEX(nvram_mutex);
 static DEFINE_SPINLOCK(nvram_state_lock);
 static int nvram_open_cnt;	/* #times opened */
 static int nvram_open_mode;	/* special open modes */
-- 
2.45.2


