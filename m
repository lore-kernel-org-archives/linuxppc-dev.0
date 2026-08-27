Return-Path: <linuxppc-dev+bounces-26134-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49C1C61DB9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2026 06:24:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVs1c0bpbz2ygW;
	Thu, 27 Aug 2026 16:24:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787811876;
	cv=none; b=jXn4DjIrP4V5NPxeg0X9AYXXkYS/sLuZmPyEScmA2Rr/jT8g9DOo+/vP6FuEaB9rlOxLnrpT49mYeUvALLfjhn4MZ/Srl40vAoyqqkNiMH7N7kRTAqriH7HPhGENx6KD+Wgo+nMWsT0Zr10utyTNrqcuWsEGMUWOR3IBGo3qb8jjm1r/EpezfpW9vmrTkUZK4/k1yTeLsa5pOiy9jKwxnDfLwM1Rsrv5l59GjfVRCmQGOyX6UPIjcaIqn7zQIH9sV2HEEvX1r5zfLERxupeHCNCaoJx8Dhy/0FvFwnYvz14U2FEFFo0fDLbzbYQH7VxhlXQT50DXexffzIs0j2CieA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787811876; c=relaxed/relaxed;
	bh=frp7duogNzNycmdIwxcJ+of17iEXKSGWdWO2svAK0g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0l0YCtETsyPdQAbvQdNBD35sasBAmv5BfaYl5idsJP0T7bcOhovAb4l+EPYABLquR0EcTPMDuag931y3T6fUJYxYJIatWK64KbVwobMYQmGc0MvIve8f/tFnfjsB4p1O40ILFqMgmM/Pi+1GKD6BdSn7vccGT5G14WIyEuuQWDIY6QwsPnnE0JC+Tuy2GtQWvJ2gzlXjuuA7HXU0Kkz9WCR0yrA53G649L2Nnizy4X0wTBDuAfDpYZXaeMQgbHJoa3iDmrq1fHTPC1Kg31WZD1RSTOEDT3w5fhCgMpEOrtE+cwVU1LX3O/GH5Lx5xBdfdj4cfoQ/FaLjJN24VOMuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FEpsraUs; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FEpsraUs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVs1b20KMz2yfH
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 16:24:35 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R3Veof1823853;
	Thu, 27 Aug 2026 06:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=frp7duogNzNycmdIw
	xcJ+of17iEXKSGWdWO2svAK0g8=; b=FEpsraUsKUCpKC+1ff/AMkt7WoX/w/qFw
	sVlxElMFfHRV6qA3ZSpcmUKkw1NX3fhK3h3EPn7UkQYY6KO8C9WCQQie6/N1rfyb
	YF0EZMzamWi/VNRkzqoYSLqmgFVN/XSA2aMUTpIwonRnZ+2fjtxpIVoClAzTPs/K
	zC4JhQLI/01xJwTd3YnZIcWuevUbNpa8ahcOgD1b3Dddbyr2xGzK5HsIcsza5iif
	q+39xZSKfIJN6DZ87B2P7hQYlLEyDJGFdK2WJunqzNaOdQAdA9A/IzssGae64VQN
	+wC0YtvyP97NX5NNeQ+wI50CDrGovCrznuiHjSzInXD9JOrvcv2rA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g53mxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 06:24:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67R6BNYK032069;
	Thu, 27 Aug 2026 06:24:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhedsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 06:24:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67R6OFfc42074430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 06:24:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B67AD20043;
	Thu, 27 Aug 2026 06:24:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3479220040;
	Thu, 27 Aug 2026 06:24:05 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com.com (unknown [9.76.202.253])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 06:24:04 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH 4/8] pseries/plpks: rename the default wrapping key macro
Date: Thu, 27 Aug 2026 11:53:04 +0530
Message-ID: <20260827062309.724808-5-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827062309.724808-1-ssrish@linux.ibm.com>
References: <20260827062309.724808-1-ssrish@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: eqf0fvjd09CrlrOV8uEVmZjn3iEbWov3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA0OCBTYWx0ZWRfX+Dk+4MOGguXT
 GabBh6cj3Al/QbSQ1En8v4GvpBze7wE0O019hT8gVNwbiGTS21JMwQmDjbnT76VfdwPhLeOaTac
 BezQ23Zm1V/BM3etInaAGlNEkuiCXu4=
X-Proofpoint-GUID: -NLidSNWeEX8s94wb9J7NnslxfpolDZA
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8fd815 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=ZsBnnucTmTjdUaLPtLYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA0OCBTYWx0ZWRfX1nAuE9xCBME8
 JU/FNbbT82yN5yVu+Lh4VPsBalIdtxCwthCErB5imE99AgQE9jEpWjueVIZP8DtvOtHHPB1tssO
 mL8tJgSItqTuF5RATGoZ/SmfHV35QnIr8WA8rXH8Fq6HMkZXvNdew+cUDkIOQOBtQYQ9vFmNfJH
 nrDtXwsTri5JoKdWq8nHu2bR5eD5czghMEHFdqpI0URsFDmO6fwZ9292C3kGZsjeq7VBGMKcaCu
 hGzq5Jic2NurdZDU0rIhvyuBLEUDOYPz1xDMqOK26WDgknR4omtBP4KbbzHtr03xfosEZGX5VGG
 bYLOYKAXBSgkZuxEqWrRTGml4jesTms5o33srfpjkr7NT3i6G5BheAvfBXuP9RyPcd0Aca+nMs6
 xSmYDHraZkbP2BOekkZ9wWq1/PFelJh3h0lFhh0pvnbp/rrvudbSSC0dRne0fmf9LPZVJa/Wz/n
 3bBgoyRrILC2PLlGquw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_02,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270048

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


