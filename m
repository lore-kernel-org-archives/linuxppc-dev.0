Return-Path: <linuxppc-dev+bounces-26280-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C790AC61DE2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 11:18:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYRLb032Zz2yfH;
	Mon, 31 Aug 2026 21:18:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788175094;
	cv=none; b=oKLSoChCsNF0dgYk2hKh92Z1HkrH8XGK8mEklIr++2k5C5q9nLpV2Ga3+rsoCzcnYn+9CaBb3PajtWsQyAASo8mGvH55w3BqOYgHVYLdrrZcXFU510FlQSc+5vqq/afpMbEnN7yzXpbwKd6Ww4QboVxniLOs+QW+rmK9E5ivEG+uoRX8Hd2aiyPRhoYIpoHJUIZZSZsC7wzy/wKaFt44u3AzG22fe9Vy0uMRnOVW4EOTdA4+QyXGjHLcDIq1u1tV7rHqe5OVU0wXW3T0yMSEjUTf6/Zzm93qVJz+jza83Ubjk/nqk6LRjCwAOLl2JqqBoWjgiEWu79LAuf28Obc6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788175094; c=relaxed/relaxed;
	bh=PV3cVrQcJkRs1i1F5rp/AhTohaUA9pg0WqA1IdNOVMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLOx2n3pqM0AugoU2clOZtVpoxvvWginR31Qg/38pq3yL5CJqImlTG4jy2MTZ8mJ5SQdEsKz7jstx/lDD/CRB5HlimMrwzT2aZFahw83qydCQLfdIABqi06gOEe9UvsNUm9jEnxUO7UvqTiwOtLiDFkxo6UN8pkQT/tvbYKp/O3/P+m3RDl2X9mA/7pXYREJcqJFWY2u8gC5WAHs6bfMWbBcvm8tELubw7gcPGsdN4cyR+zk4kd8v/dDDS7FH878aEXxQGN3+mSvzSaSjz+0Lt7H2FH4gXmX0hkd+CCH7APYSHgzGXJgIS9DudT+iNOyjcAoUBIP42Nx3DvYC/Mw5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PShtSmON; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PShtSmON;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYRLZ0wv2z2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 21:18:13 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V82VXh3960350;
	Mon, 31 Aug 2026 11:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PV3cVrQcJkRs1i1F5
	rp/AhTohaUA9pg0WqA1IdNOVMI=; b=PShtSmONMSrgXCW5lioKXXVCnX25NcuxE
	gqIO15Ax4RWhlH1aGpoeUZzfiErH5m2kq1DtXOn3HHyqDvuW0+lRantLUfrEowvy
	4jC0RIOFYfRnGYglTMF7bQpXU/ztszCwRwYCWrn0qSCCiZI6Eir2sEQT7IEnDQmt
	j7jW41ULTHZzofeGAJQ+9McfR+RwzxWfRwKmA3TgA7wGRo+ak2XmY+Vgd7Oyylj6
	XFjcIWEhIu8wCJWM0PY2lwlHn85mF4PJmoJx0a5PBxazQh23lKqBZ6jH5XJh5DZA
	8vsUrnpzYUC5Nc8+NAOmJqdBUXOrOdPj4xy+S5SJlYfrJ/RM24QlA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r0u42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:18:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VBDFZp021934;
	Mon, 31 Aug 2026 11:18:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexwach-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:18:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VBHv4q39649708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 11:17:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2EA62004B;
	Mon, 31 Aug 2026 11:17:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42FA720040;
	Mon, 31 Aug 2026 11:17:54 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.bl1-in.ibm.com (unknown [9.123.14.23])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 11:17:53 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v2 04/10] keys/trusted_keys: propagate wrapping key generation errors
Date: Mon, 31 Aug 2026 16:47:32 +0530
Message-ID: <20260831111738.334857-5-ssrish@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9562ea cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Li9DeLKnNFycptmB2j8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5NSBTYWx0ZWRfX9recuVghaAAz
 2WgN7ZAkQVN7cx2gNxGkxG30tYuMPsRYAgwF+ivoBL1z3x3Sa5QkF3q19eGRSOcvYbMBjyPPN7a
 knckmkXbU8IPoE7rGG48lAybJvQk9xb2XrUqh5+vEiQ/oEUanmPq6C7Lv5S8ZWqhUvDzyyDj7nz
 AtuB3sYySnl9PWwB6nDyHj5fYI50soAayigze9kuR0ZO0r/Cqd++MZfC7+tnGSAqxvPN9j8M8nv
 9LGZX5guz/xchYhfRXx1KXsHvL6lCXdZuueHOODcKm44SMuebOmQgZFLQyzEop2w52dzJzqvWL4
 ma4q0W8YfIMu8p2V9DyLcPLEEKsXbmOC+0tz3dP76ZiudH776hjsB5yjSHWGWLSG+sPFaLTz6ca
 f0QXaKltI0Ck1GIdxS027O11+dGrEevLwSvhzT3++xqHssUYS9ZFmmorL/tDBq7Jw658+1ci7fe
 NbcS4FS5yOlLgaNvHsw==
X-Proofpoint-GUID: _AqKu64lJZO5KVmhO_Z_RGObs1c503Kj
X-Proofpoint-ORIG-GUID: 5_uZ-5GU9o-a1Bo1qXRy5ctL9yrDOOe3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5NSBTYWx0ZWRfX/yxUZ+unbHch
 iiwLFG/wjJ1kq60OK/5/+QpUFkUignmIUWPM+C48Mm82LP5guX4VjeM0If5XpXc+BiKFOR6n2rb
 Ydmg/mNCyQ9WzNYz15YPyNyzngZqcmk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310095

plpks_gen_wrapping_key() returns a negative errno when default wrapping key
generation fails. However, trusted_pkwm_init() returns -EINVAL for all such
failures, discarding the original error.

Propagate the error returned by plpks_gen_wrapping_key() unchanged.

Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted source")
Cc: stable@vger.kernel.org
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 security/keys/trusted-keys/trusted_pkwm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
index b6b5697426a8..633a7674d065 100644
--- a/security/keys/trusted-keys/trusted_pkwm.c
+++ b/security/keys/trusted-keys/trusted_pkwm.c
@@ -170,7 +170,7 @@ static int trusted_pkwm_init(void)
 	ret = plpks_gen_wrapping_key();
 	if (ret) {
 		pr_err("Failed to generate default wrapping key\n");
-		return -EINVAL;
+		return ret;
 	}
 
 	return register_key_type(&key_type_trusted);
-- 
2.52.0


