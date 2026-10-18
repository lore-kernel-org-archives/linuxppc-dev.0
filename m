Return-Path: <linuxppc-dev+bounces-29660-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A76ACCA490
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2026 17:09:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j74sk49d6z2xg9;
	Mon, 19 Oct 2026 04:09:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792343370;
	cv=none; b=Uu6dbWCvCpj9grM5qgQOxzvKOzzZKbD2EpsdxqPKuNk9CHUWlPS80KQaBAPy308NkND7bzY+UNQOHPhI0A6U7OOkCb2h7PXYYaXLePBIsX0IiQhR3Aal7YnEqJ2DKsiHgzbWkkfxjE390BZyOoT1Xz/HVzynyJhIvbZclYwVE4SiUrpMNeWV3x6Fzs7hfrMG6dOm0M41DeyoCjaWHsEC84lIgeNoSpwUGPZd3nvq0JYhnxyRjCRZm5XINJk+nDvJysdZAmaDnXYkOPJgdIqAKEuKSe7aesEwDTSvQGsmaacjl7LxNsggNQwvnVHZIF1noeAADrZ64fyMeryTV3A3Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792343370; c=relaxed/relaxed;
	bh=KTLDFca2RUZggMNob4Mpw36J0eNj2WkttT/RfqgV0xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAJgebHErtDsZRFGRxh0XkKnfjyI8ntbfkvi4HuQUppqapDUfvieWor/bFxanVN3jxq/ofz0qmlekBnLZPUHshtA6bAmoWYFDgPbATaKer+QSt0uBtCH3MmAEUsdc3Ud683GyaPuuyg5zvVlVT10UxGtQEN63u4Wc1NDd5BjQ7yAD9paDStu7m8fFGRSUNv/I10LODVmcSYnS5nnAxD1xlhrBGk74AmbGQ34oaeFcK1djTQUaZq9M0U0vplAX+SFgg1gu8o+zUxhSe/X0qRhLJEL/MfCKRuY2VzeRqQePmHIAlc2dBfJWLjW/K7BUzzdwN0VPvCDVQZecHZtJQ71KQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hTnukrw+; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hTnukrw+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j74sj2kNTz2xg3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 04:09:29 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69IFECDl1409404;
	Sun, 18 Oct 2026 17:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KTLDFca2RUZggMNob
	4Mpw36J0eNj2WkttT/RfqgV0xo=; b=hTnukrw+KgL0XWdIWuRmLjhfj1OLNTDNF
	XzzM0q8nTH5yl6CZqCLghCbFB9eElwWYq0xQIlglSKKPxQzW/ljMejl8BwW/1KAK
	zu8KGFgRzByixRbn/w1FITHA1LgalBnkkYUN0ZPnI2zycJoOIeKoORO2gOIVdmnb
	wp+At2Ah98yYQZwP8H7Jpinvwqi3UaCvS6EY2aLjngjcS+Tt37NoUgA/IDBY5b6y
	w7ZP3RBxW0D3jywZdjduQ20XWMTFo443n3jU6KXLOH+s2viSWOIVYH9aqZ6uTsOD
	iLSWf6a3gMEVN3ObPTSvkyNvTHXIgY3Bu4HMFGE4D2TPzkVqjMdHA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0h56qjf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 18 Oct 2026 17:09:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69IFK3RM2693457;
	Sun, 18 Oct 2026 17:09:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hcmbjt6be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Oct 2026 17:09:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69IH992P45613390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 Oct 2026 17:09:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CCAC20043;
	Sun, 18 Oct 2026 17:09:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4960C20040;
	Sun, 18 Oct 2026 17:08:59 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.125.165])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 18 Oct 2026 17:08:58 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v5 1/9] pseries/plpks: fix double conversion of write and remove flush errors
Date: Sun, 18 Oct 2026 22:38:36 +0530
Message-ID: <20261018170844.491252-2-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018170844.491252-1-ssrish@linux.ibm.com>
References: <20261018170844.491252-1-ssrish@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA2NiBTYWx0ZWRfX1ICl1GETBOcL
 mlkHvp5QrJhB7fM4z0kaEa5Q0j9A15v2LKQLi9E6ZoOd0omTxUVJ/wsB+IHfYCEPWQYwTCz7YQS
 09YnYjsmZ8+WJeEI8BMO+SwbK5KPpIk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA2NiBTYWx0ZWRfX59n1QNTmLhNF
 JPgNIEjkOgKQ/meBq+d5uAt4xuMq2QEnaw2usd8GDa7t0+ffJCOqyHhsY6tRRtJqZ/zndwH/0U5
 kBwyQwp4sfcPjn6cGzDlZYwqrVMNTgwUOl/QzGs0CZV4zvkJs94+dUQXNOcCJGEbxwYH3UOEvJj
 09nFKzlO59rmFeX/HvDkNCYO/wX5MeXPXbM3+Mz9hceeoffMvyLUvOiTFDyTiVdvz98Yx4uKKZF
 TmRA6Ci5Mey4bt79tl7qduawNM7qkkUTpGyB7F0iu9Kf/GJ5dcWqwZ5aGPROh9b+DUIybTIw+lc
 +MfeM9Qu0TtxikQrehq/ndE5SMfrwUdWeeIf6HFLaXdHkrtvX9MuUDuoo1jrZQ6fVucY+Onyuzb
 VqhbZ8tTiw87EU0Wp1OMzLXPEfy2dhl57tXBaAflhZ7M1nHe6wppGDgytsyR9gaeW7LgkSw8ZIe
 yeFk0gZVJ/B8wFXuFTA==
X-Proofpoint-ORIG-GUID: 43JaOMQxntEzcb3VBdoanacDKjdIGUDs
X-Proofpoint-GUID: Pug3YLiLMGcY3fJCLotz8WYQBkPmvEar
X-Authority-Analysis: v=2.4 cv=KujYSmWN c=1 sm=1 tr=0 ts=6ad4fd3b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TJ-IsHwomnPjbSOrev0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610180066

plpks_confirm_object_flushed() returns zero or a negative Linux errno.
However, plpks_write_var() and plpks_remove_var() pass this return value
through pseries_status_to_err(), which treats it as a raw hypervisor status
and converts it again.

Convert only errors returned by the write and remove HCALLs, and propagate
errors from plpks_confirm_object_flushed() unchanged.

Fixes: 2454a7af0f2a ("powerpc/pseries: define driver for Platform KeyStore")
Cc: stable@vger.kernel.org # 6.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 240cd5632446..c86960f102dc 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -750,8 +750,9 @@ int plpks_write_var(struct plpks_var var)
 
 	if (!rc)
 		rc = plpks_confirm_object_flushed(label, auth);
+	else
+		rc = pseries_status_to_err(rc);
 
-	rc = pseries_status_to_err(rc);
 	kfree(label);
 out:
 	kfree_sensitive(auth);
@@ -808,8 +809,9 @@ int plpks_remove_var(char *component, u8 varos, struct plpks_var_name vname)
 
 	if (!rc)
 		rc = plpks_confirm_object_flushed(label, auth);
+	else
+		rc = pseries_status_to_err(rc);
 
-	rc = pseries_status_to_err(rc);
 	kfree(label);
 out:
 	kfree_sensitive(auth);
-- 
2.52.0


