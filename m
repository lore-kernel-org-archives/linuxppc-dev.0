Return-Path: <linuxppc-dev+bounces-26281-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63404C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 11:18:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYRLg3S9mz2y2J;
	Mon, 31 Aug 2026 21:18:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788175099;
	cv=none; b=ENjL2nyncPymyOcZVun5sVbAQdhYkDGY0lEqWyFZ2b2gGNgpTG3eM/3KkmBgG5iDYCnifCsB04vCWlRsLi0L0hgifDGyuVmkKksmf0TJGidNrQgbREcf9ilrAlMbYM4ZjIQtHhVLbq+fItbxo9Jp89PGEXNS/7JvY653x9HuFu/pGb8PxkIFc4NVn1KlGAvAPyGf/b04rVOp0UVYJZJhRCydmPnvvU1E3TppWBE7L21qj8PvHJch0i6FCabO6d/ffaCCctf/2vgrGG6ZwEdvj44dXggtu+v6rVjcMUrevFDcIsna3FwOoS2+d40Vn/erdxHFSq0Pv/VcVClAOVrwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788175099; c=relaxed/relaxed;
	bh=frp7duogNzNycmdIwxcJ+of17iEXKSGWdWO2svAK0g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aD/0aPtGHbJ6PNl4ruubZc2f0d7c1AwLFcfmo75l1Pf0NAKJPomGXDllh1VOKSOZRK0djX3JKd6DoXTfAH5FqJzJQyrlYKijTWNn6sbbjV6WSFTJvs2YCFpFUyuJev/HUqJkWmZpgOfWOSnd4y/3B0LNGl8Cxr12LvXLdbIOy2GCVn6BY8JqtvtNBXfnfrpreKRf28u1+F42P57PLZ32CTB/a22VTHg30DZE5ZwXx6enjzprJsCjkOnSfCJlNqTIZ+mHZJf7nll4M54Ys8EFjlYv41atEa1U844kLff32A0R2xbVeYgEanc+aSeCVfiwRSTIq7uklXJy1E4hBLnrfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i/D07dpz; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i/D07dpz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYRLf6Cxkz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 21:18:18 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V8261k1640140;
	Mon, 31 Aug 2026 11:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=frp7duogNzNycmdIw
	xcJ+of17iEXKSGWdWO2svAK0g8=; b=i/D07dpzq9AeoJdn4R/cwyc1w3Qf4APOW
	3Q+8EC68Dl9afAG6N5ZG+ps0mLbvQZWpbjuk7WjGinbmuNjutWJEDptynH2Wuzko
	DpJxwgjvGAJ0sQJY8je/WJiKY/Xs3KtNbSmmRvx86n9Zp15a5UgkZjbb8iGRbcjg
	NitJ7YsaIrz5zI5wBYVj32Wr9Loj/h9rBMiVo4KHF+XXgOiijONw60eNiaa4cUdw
	3z+cKwRSpgVuCvsTW63igUgU/bfLSypWKae4Aoo3/C9JGC6d3f3hJl7dSQqdGlYD
	7T4zF9KWyAfXabG5W9LJRc+fY7lpRF6kOA9nWH/5GgCSMP+8B6lKA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx58vum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:18:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VAuIl6006239;
	Mon, 31 Aug 2026 11:18:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarjwhye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:18:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VBI1le43778328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 11:18:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 971452004D;
	Mon, 31 Aug 2026 11:18:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 421FB20040;
	Mon, 31 Aug 2026 11:17:58 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.bl1-in.ibm.com (unknown [9.123.14.23])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 11:17:58 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v2 05/10] pseries/plpks: rename the default wrapping key macro
Date: Mon, 31 Aug 2026 16:47:33 +0530
Message-ID: <20260831111738.334857-6-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831111738.334857-1-ssrish@linux.ibm.com>
References: <20260831111738.334857-1-ssrish@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a9562ef cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ZsBnnucTmTjdUaLPtLYA:9
X-Proofpoint-GUID: 5tiAgGcZykoCRQGbUvJyvMTrAu5614um
X-Proofpoint-ORIG-GUID: Y9CdX98Sh8gXT05O61HmjXZ1yOi7kYEP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5NSBTYWx0ZWRfX+aoURLXKmsuM
 DBAWmfDj3oKjEG3WZJ8U2p6z7OBCbcOUCmu+ir+hFNgwfD5l/9+W0LiuYwzVF7LJWSwBRGwlHCx
 rwTDiT8VRLUTrnSPCODpiTTtUdvaRCU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5NSBTYWx0ZWRfXxwiVX/ONW05N
 NU/OKpCEugcCmp4lbKNt70BptagjYeP13s+IBjkAJL06uQQvE8wy5OEIgQTlCcsVM6nXWGaIkom
 /5uZsS92yrKhxkC5xz3ORbht59We4zRr69eIla1T1yeNI+nldH+4tNTgEbX4EToA7q0B3xYJu8v
 oiw7Y7+pMsylydpOcd9BSM2/al2x6eLrLKXlZirXGhDPZDxXfLTxC1vD8J1+u6yL2FW+QDua8EP
 B7SpVMjLBkFxAf63efWdVtOz9B1FgU9kIQzIac7msoyneSPPwjJG2pnKahOApi1kHtjuwd23ODl
 9Q12y/o37z+nqfj3oCWstANW6/7UuZiirv4g2OPd+9bJzfCQXj3xN3cPdTR0S2HowJIeNKeShkQ
 re3kejmf4N978VAT+5ZTJ5Gu+chwsFHD/B9oz8sAt7T0w4vdmSgXhecd6My2FUoI0eaMS9yJ0nS
 /kD3o/O5Y7nsr4GczIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310095

Rename PLPKS_WRAPKEY_NAME to PLPKS_DEFAULT_WRAPKEY_LABEL to clarify that
the macro represents the default wrapping key label used by PKWM.

Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 45278c5a45c1..b553f7b130b6 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -10,7 +10,7 @@
 #define pr_fmt(fmt) "plpks: " fmt
 
 #define PLPKS_WRAPKEY_COMPONENT	"PLPKSWR"
-#define PLPKS_WRAPKEY_NAME	"default-wrapping-key"
+#define PLPKS_DEFAULT_WRAPKEY_LABEL	"default-wrapping-key"
 
 /*
  * To 4K align the {input, output} buffers to the {UN}WRAP H_CALLs
@@ -938,7 +938,7 @@ int plpks_gen_wrapping_key(void)
 	struct label *label;
 	int rc = 0, pseries_status = 0;
 	struct plpks_var var = {
-		.name = PLPKS_WRAPKEY_NAME,
+		.name = PLPKS_DEFAULT_WRAPKEY_LABEL,
 		.namelen = strlen(var.name),
 		.policy = PLPKS_WRAPPINGKEY,
 		.os = PLPKS_VAR_LINUX,
@@ -1033,7 +1033,7 @@ int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
 	bool sb_audit_or_enforce_bit = wrap_flags & BIT(0);
 	bool sb_enforce_bit = wrap_flags & BIT(1);
 	struct plpks_var var = {
-		.name = PLPKS_WRAPKEY_NAME,
+		.name = PLPKS_DEFAULT_WRAPKEY_LABEL,
 		.namelen = strlen(var.name),
 		.os = PLPKS_VAR_LINUX,
 		.component = PLPKS_WRAPKEY_COMPONENT
-- 
2.52.0


