Return-Path: <linuxppc-dev+bounces-18596-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8B0FC72A8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 07:33:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffPzB4Wwnz2yZ6;
	Mon, 23 Mar 2026 18:33:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774251190;
	cv=none; b=NmxBumB79yr5aLblHA2PvFIohoZjGR4c6RYOyJAB3AN2DjgX8rgEoxhltCgTAIy8NFeZ2ZJ66zRL4gOvWbqXfk1tR34PaqWh8nd9NOxiiwkxXj9iSYOdDdBpgPLovTQLGdeJrfAZ8SWw0CCxGSFzosofaH/kDZRCBZrMte/23x5YV4bW/TUkDsKlLaTdRJJQ+u2v9zGRN+i0/Tvjh37xlz8XFXvb1adtka28B9bKYFzfIbPMAjvsPDB7WfucBfy+yX5nQaXGKDqQvI5G6P6Igjd1hmDkmQNOpxdDNywvJ4XapZ51377B5G5AaTOmJ7I7yTZzp8CCcR/2s3bRsxYX2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774251190; c=relaxed/relaxed;
	bh=WfVpPGGWsHftmhPb50FUkrCa4gEla1qqQOvZBu1AJqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vq5gUJxsP9kYb4W4+aloCnQ+Xwc8sPBGVEa+Ab3HInQpcht3NxXBpvUAXNY2/LsKM8Ta9j4UJtdvNZrqoGRqAZEaF6CqEfQ5JoBy1UFjVzNy/3+K9D8KmlXBoYZnskZIeNnybtTHMEuchqo9MZhYWclRX8qv8uZ1qkO78VyUwf+nAlIggawAftG6bXMJn89SD+oikrFKQw3BytcvQGCQUiVEo/Trn9LGrwAIp6wBkDjXspGT+zvt4Q8VjZikJTMmCPc0ra/eT55mvOjSSolem3XGzeICNw/THKmJqq5C1K4QR4ZU5AevKBnc7P6Upt1tnQ5aRJ/lIBj06RqUsl64Cg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qF/uGaWz; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qF/uGaWz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffPz94YS1z2yYy
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 18:33:09 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N3sDxX1172616;
	Mon, 23 Mar 2026 07:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=WfVpPGGWsHftmhPb50FUkrCa4gEla1qqQOvZBu1AJ
	qE=; b=qF/uGaWzAnPiPGSCX/aST6ih9w5IuMwbJBje3Dr+KCV/EfLTrmZwAkzYB
	HIMQiauWajVMeQxSUB7oIaLLX+nlpLTN/9EGj6I5iUnISkmHlHTzED0SuEPj21lV
	DnjpukZvrddqw3J0XwK4MlVCHK/hPG7GioHeDlDoFd+IrC85RYglFiBmI5flOcnG
	98/y6t2dk7cxemMeBAPs0qmv+ZLRpR98mr69DhRmh70UFL3O26/etPbh/XrIjn4k
	gkKSLKutaEB/jexbWYnAcQgaSTLsgCIObkYCREPnCKST8xQjud2pbI135gGHZXCs
	JaDJLVlMA0whygwNPMeuNd6NYnMsQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumdjup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 07:32:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N6YN06031631;
	Mon, 23 Mar 2026 07:32:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nsmjty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 07:32:44 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62N7WeQk44695994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 07:32:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A13072004B;
	Mon, 23 Mar 2026 07:32:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0EC620043;
	Mon, 23 Mar 2026 07:32:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.247.60])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 07:32:28 +0000 (GMT)
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
To: arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nathan@kernel.org, nsc@kernel.org,
        ojeda@kernel.org, masahiroy@kernel.org, linux@weissschuh.net,
        tamird@kernel.org, rostedt@goodmis.org, ihor.solodrai@linux.dev,
        ritesh.list@gmail.com, maddy@linux.ibm.com, peterz@infradead.org,
        venkat88@linux.ibm.com
Subject: [PATCH v2] char: nvram: Remove unused nvram_mutex to fix -Wunused-variable warning
Date: Mon, 23 Mar 2026 13:02:20 +0530
Message-ID: <20260323073220.25798-1-venkat88@linux.ibm.com>
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
X-Proofpoint-GUID: Hi2CISShH6Iof_oH2JKOO9ktaPYasrmG
X-Proofpoint-ORIG-GUID: FbRJ3Hh_YJSdw1yG-6PJ7kD244G9CCmD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA1NCBTYWx0ZWRfX4tUm5R23TsI3
 kwNO6SpVXON7P1fnxwk/co3t7UJbBNXIv/5TGh1eSUP6qV9ZvmeMSuG9JJd5ySz+iYyMX6H5VBp
 +5suiYCNsozogEBQES6dxrNweNcQU6DUD0uBYOvTUpuTqlH57HtTSBUvQxiijmnaihad5819/HB
 UX3FVo/M/a3FHprIqxgZCA21K4nMrVa8m/6xnPJV8jOwz6mLlnboGUnL6oFu9RTLwtCn+zYHKlg
 AupZBFCkEz8LV00+a5spVIKP+LRrT6YRFC+RnXaAg8SNlXVuO14OJ4RJiUaPj0L5OZGUMLWtV9l
 nLDyeGErpzkeBUo7exo/pJUn93144I8NEs6hMmk1bekiLxJAboJNZ0nBLrItkvD0M0+nyAQpsIr
 okAUO6XxcpSvZFTtlWRBAatiwiutfCT770bJKPRI4efYuukXJ3Ctv1WLYSvvco3isbbqaNTUFxm
 uFy+/MIkDqPd37p3BQg==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c0ec9d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=HSj1x6wVMASIhtUHg4AA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230054

v2:
  - Added missing Suggested-by tag from Ritesh Harjani (IBM)

drivers/char/nvram.c defines a static mutex 'nvram_mutex' which is never
used. This results in a compiler warning on linux-next builds:

  warning: 'nvram_mutex' defined but not used [-Wunused-variable]

Remove the unused definition to avoid the warning.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
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


