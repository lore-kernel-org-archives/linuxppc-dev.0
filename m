Return-Path: <linuxppc-dev+bounces-19146-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB53D35171
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 11:22:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm2cx6VhBz2ysZ;
	Wed, 01 Apr 2026 22:21:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775042513;
	cv=none; b=V5YL8FsTXNIsAICfpgXKxxhAXKi/ViqiyiVERBrsbEA3jBo1FUSwXxjR7O2xP358qkT8i3Dwu+cCVYDU+vkJ54VQkSrzIex8Y6Gozt6Bbn4zQXGRwaWR4biO/2adEh5O9SL6BL5sX0mfXjOsy2praZWmIW06PGXta5+YrBgE6SKAB1LQCPX3PPkpyo2BU1qZH4kbteXviaDCjGRFGgdBTGHP0zM2ydqgEiIzuTaqs+1AHy5k0gHIdrc+RkNp4Y6Mc3apzzwHBeclkrrNmkZ+VS6E/WmwY1Ypfn/JWG0z4/UJ++1TEr8VlQ7eUH1cbNow5GwLT3NeH1GfVhE6gMcm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775042513; c=relaxed/relaxed;
	bh=BnAL5isth8Y/G2+yCPbQsqWQbOy5blKQ61Du/V6wy+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bIB+l1OWVwfqRICYniC2q9wRRpl3pLzQ/WCogR1v3rYVqKUMPLEU4zONFoU+VKTHuRyib/VRzjqxvb1zF8dVh/ma7Rs3i0dgcY/wr74aVfdVarcdFOkuYwT/aX6NeSB8mnODq7hBrGYONlHS5929KA4LIJ4CiAFql+tMT/wDY4uZEUlx/ez1j7NGnSbZEHlqhoGMexpV24CGkaJSyIP07U25wAc7lXM3cAzJQaQgYQ+LZQUb5QPnRtfWtDQGseg/kRAeEPyK4nRnS6+NF8J8BnBN+PY6GXZjJNdn0sSFbud5QCawNfcmsTeYbS+UZsAJ4RAi3yocBACrKvxpdU+YOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gUuY9V+s; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gUuY9V+s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm2cx0dxxz2yj1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 22:21:52 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VJ0uCs354949;
	Wed, 1 Apr 2026 11:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BnAL5isth8Y/G2+yC
	PbQsqWQbOy5blKQ61Du/V6wy+g=; b=gUuY9V+s/U+MoVX7O3kx8Ds0utfEXvOkW
	kzeujrTBe3Jskp1+rmZ6FL4UYPGAbYJHib1uOAETLL18dihkaxFbpGfUl/ZYuMUi
	mG6hyAl8osjc4fCsYNfHmhN6EUO1b13ZMZpFpmtrI/XQx+Nr1O/WxvF+hEl+TMk3
	H5+SIPSF8unFxc/L/BoE7pUVjcLIoMWkvfjH/y2ueu39ubfAhYfMdHBPKPgdx3/9
	WXo0mObs5byjrEcP0v/frG+1rVifz1/RUbKxWc6LiVzlUfo/lkRHgudIZYbBCjA/
	nGmDL52zLsg+Ti9gRJb5zMUDHlG/UzgLBXPHaY666rtIaQeGG3imA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgq94q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 11:21:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6316eDn0022197;
	Wed, 1 Apr 2026 11:21:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tan5909-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 11:21:37 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631BLXYV51184120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 11:21:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4868F2004D;
	Wed,  1 Apr 2026 11:21:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB1D020040;
	Wed,  1 Apr 2026 11:21:30 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 11:21:30 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, bpf@vger.kernel.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        Abhishek Dubey <adubey@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH v3 4/4] selftest/bpf: Enable gotox tests for powerpc64
Date: Wed,  1 Apr 2026 11:21:33 -0400
Message-ID: <20260401152133.42544-5-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401152133.42544-1-adubey@linux.ibm.com>
References: <20260401152133.42544-1-adubey@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEwMyBTYWx0ZWRfX1Ef1bjBXomOE
 rG6L/x0wLgSd0+LP/4VVNm/VpgWAI2HPVGZEaDGxVqWj9mZ9UuCeDSwILH3knl96Eq3UYalsnYn
 fdhsQyrBbcR25Ownp7Wyes11z/Lw01VdnX4cSk+fqOmfyEcUqPh69LZZTmMzxgpvY8858NLTiCm
 xSnweKqnu+B4Wl3UWF/ryzPbAqRke5OvSEdT8+pUX1sZAHitafRl2+nWR7W9bBNlXbAwAE9kq0R
 g46cru0GOWD//Y/GMcV3mQ4c69n/w/dVP1OU7JZ+LeEMKGoe+Wyl9Bx0Nr8/REejlnsUX5nPgSP
 kVSNbgEUAnpQpdG5H5RCYBXvIcsSKdwKu45f+1gr1DHxm4H6pbg4qQvlC22osFSmuRR44NKGcCI
 adxDkAWNANHsih7iqJy3LVkNJfCdUyXKEbHLoCilJEU7n+K2wFgRHNCIs1aSYoxDy14rVpmCZ5G
 WhEf1VREly4UqeCPllg==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69ccffc2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=cN72D6WRG5boQ4SUoSsA:9
X-Proofpoint-GUID: iRmYhG_HSGew1CF_qgothGl9dIAdlGjT
X-Proofpoint-ORIG-GUID: iRmYhG_HSGew1CF_qgothGl9dIAdlGjT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010103

From: Abhishek Dubey <adubey@linux.ibm.com>

With gotox instruction and jumptable now supported,
enable corresponding bpf selftest on powerpc.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/verifier_gotox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
index 607dad058ca1..0f43b56ec2bc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -6,7 +6,7 @@
 #include "bpf_misc.h"
 #include "../../../include/linux/filter.h"
 
-#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_powerpc)
 
 #define DEFINE_SIMPLE_JUMP_TABLE_PROG(NAME, SRC_REG, OFF, IMM, OUTCOME)	\
 									\
@@ -384,6 +384,6 @@ jt0_%=:								\
 	: __clobber_all);
 }
 
-#endif /* __TARGET_ARCH_x86 || __TARGET_ARCH_arm64 */
+#endif /* __TARGET_ARCH_x86 || __TARGET_ARCH_arm64 || __TARGET_ARCH_powerpc*/
 
 char _license[] SEC("license") = "GPL";
-- 
2.52.0


