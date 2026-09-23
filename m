Return-Path: <linuxppc-dev+bounces-28060-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A0BC98304
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 18:30:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqlrj6T6qz30WQ;
	Thu, 24 Sep 2026 04:30:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790188229;
	cv=none; b=FItHQaNHbwBhxOWd41xDjBTebjxBnc4NbKO277p9WbjlDF69J4WEl8CFCSovYCNKiCKxfdTGmEcxu8nnqLVlF0S1NOOL/X2uCoP/P7AaXbYFV6gkrzDHQy4zjynTILTSCnCQQ1tdx2S6nJnzZRPBi/tJToxxBMgRg2TBHvsJk9jCYXKg5tP8Kpz8PwLz0MoUVzBYsftcPdRz2shuVnzIneOdSnfluYxOCVCKhhDcnUCb3MXUdyeGUBrm4l7JYc+o3BGjM2QSr70B9jNqfMf7+tf0sFi42qIgLCIrLE0odU4UXGa3L6TFc8gG0GqlcaxMFc1wXgw8qahIgRGiX3lrEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790188229; c=relaxed/relaxed;
	bh=nRBPVkwZlntLgCYvEn3XzhJ8yN0rCtAWrZRJ+coOhBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZcnKlnSsad3IhuMTFHedopQCTQzrswBu9vhwB5NbvLbHC1SAzl9ia04ebhSFPrpwd8os2shSDGyhJGxK+LtLxf8Hz2JlsjyDHky3CqvKVIaT5qZYwImDx2cyNFUl1D8g7bHzCTT/E0yeKytjWGpyopenz47+ZQARzc/ICJHPqjZxUYx0kHLRqijzM0S0AkcIWQynKCx7U4zhm1CAhfnp1VufEbjfIVrohZMTd/3srwlqcctI3eWPJjvOiDiVrXaUKYpkePHgr2lusNXGZaJllEX8fDRQMb2XQBqopcx+BQPah51ABkoFJaPWYfxC1BM8a5f9AUihEuVUZRj6cJ1QQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VahgeL8L; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VahgeL8L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqlrj1NbSz30M6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 04:30:29 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGZmbV3926266;
	Wed, 23 Sep 2026 18:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nRBPVkwZlntLgCYvE
	n3XzhJ8yN0rCtAWrZRJ+coOhBM=; b=VahgeL8Lwj7YVN5RLQvFf0tnqSDAr6g8+
	e0+QTnZz7vbQRVlZAQ6iOWQH0g2b5L6ODd4KFufiAT0CED1MRsd+b80g/vHgS+1v
	T/OjjBh9eBGvRZkegmlfJjfsJiI0MWGqrFiJl+gV4VSQo1C/5rSB60oi4HzSKzUy
	9QZrXk2rvJJYPhvkAq3sMYnBvZZXhEbewyR/nHFsndrIuF6aPWU573dZWG2lkYRK
	xWXexIfvRXmqekLhAKmHuETdADeLXKhC98dWzW/S9QVz9wa9GDVZLsgMw0v/+ki0
	5+rZ1ckQdFd80l18SeggTOVGujCSAv1tTfYnQrn/pA3s/ntLhxC8A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2n0v9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:30:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGWtuv664875;
	Wed, 23 Sep 2026 18:30:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe1t9ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:30:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NIUDfX42926346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 18:30:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C697020043;
	Wed, 23 Sep 2026 18:30:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33D3720040;
	Wed, 23 Sep 2026 18:30:09 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.83.254])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 18:30:08 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, nayna@linux.ibm.com, gjoyce@linux.ibm.com,
        ritesh.list@gmail.com, sshegde@linux.ibm.com,
        linux-kernel@vger.kernel.org, rnsastry@linux.ibm.com,
        ssrish@linux.ibm.com
Subject: [PATCH 11/12] pseries/plpks: rename the default wrapping key macro
Date: Wed, 23 Sep 2026 23:58:15 +0530
Message-ID: <20260923182816.151451-12-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923182816.151451-1-ssrish@linux.ibm.com>
References: <20260923182816.151451-1-ssrish@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: WjcLWUqHA8MIeP_pIhRS1a527kYUfZk3
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab41abb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ZsBnnucTmTjdUaLPtLYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfX840Hjm4nSwOw
 Lyel4RONMC/Mr4cRZmQkt2C7DsDDtTmOZzErRUX9XZ9i59fwfJpuI4YRfTgEMnEqP3DMuggc4vp
 m6nHOxc9qfWV1178TON61WR9tLHddyHBNuA1EEiGvjApmkMisLdLpW0ch+AvpIjJnuTMigrbNfS
 ICaHERg0XhM6ydi7mtcagnYN9vld1eX22VojB4K/irSa1SAy68KDY0KaB/QduPgSVeUSdnZ4p48
 aPfIUgt0ytBR1rCmOCFmpH2pLmEnB+97Zi4ME43FrIl127bW2BF2rbAZrNaiCqsdiwNXk+u8TB7
 KtTOMGMGMon3Eh6PwLUGw3/OOgxlSsHmSNyamriwnQbZwXLUYUQPy7io/YyaeCp+V1im/BUMv10
 URJMtVm5ZR3CPp1uopcufBcQSkjXtPP/A6e2/hZ6wS+YW0SXpvPMjrJbvt2oMLcoM88428tqua4
 XIdMttKE8G0jhc/u1Vw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfX0VO5mMp6ZxhW
 WRmtWoxaC9xXrRnW7NzxXcfXVKuX1uVP1gd7puGfgbKlyHUqOrQ4d13dafoXENTCfFZT+9O7l/L
 glj9HMS7661BKq6j8o2mzygmbFLZmyo=
X-Proofpoint-GUID: OMqHZxx-qGQH6QWrixx_ZecZtsUgYwMc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230072

Rename PLPKS_WRAPKEY_NAME to PLPKS_DEFAULT_WRAPKEY_LABEL to clarify that
the macro represents the default wrapping key label used by PKWM.

Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index eff968fe5ae0..240cd5632446 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -10,7 +10,7 @@
 #define pr_fmt(fmt) "plpks: " fmt
 
 #define PLPKS_WRAPKEY_COMPONENT	"PLPKSWR"
-#define PLPKS_WRAPKEY_NAME	"default-wrapping-key"
+#define PLPKS_DEFAULT_WRAPKEY_LABEL	"default-wrapping-key"
 
 /*
  * To 4K align the {input, output} buffers to the {UN}WRAP H_CALLs
@@ -938,8 +938,8 @@ int plpks_gen_wrapping_key(void)
 	struct label *label;
 	int rc = 0, pseries_status = 0;
 	struct plpks_var var = {
-		.name = PLPKS_WRAPKEY_NAME,
-		.namelen = sizeof(PLPKS_WRAPKEY_NAME) - 1,
+		.name = PLPKS_DEFAULT_WRAPKEY_LABEL,
+		.namelen = sizeof(PLPKS_DEFAULT_WRAPKEY_LABEL) - 1,
 		.policy = PLPKS_WRAPPINGKEY,
 		.os = PLPKS_VAR_LINUX,
 		.component = PLPKS_WRAPKEY_COMPONENT
@@ -1033,8 +1033,8 @@ int plpks_wrap_object(u8 **input_buf, u32 input_len, u16 wrap_flags,
 	bool sb_audit_or_enforce_bit = wrap_flags & BIT(0);
 	bool sb_enforce_bit = wrap_flags & BIT(1);
 	struct plpks_var var = {
-		.name = PLPKS_WRAPKEY_NAME,
-		.namelen = sizeof(PLPKS_WRAPKEY_NAME) - 1,
+		.name = PLPKS_DEFAULT_WRAPKEY_LABEL,
+		.namelen = sizeof(PLPKS_DEFAULT_WRAPKEY_LABEL) - 1,
 		.os = PLPKS_VAR_LINUX,
 		.component = PLPKS_WRAPKEY_COMPONENT
 	};
-- 
2.52.0


