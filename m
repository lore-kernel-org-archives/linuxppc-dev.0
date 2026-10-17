Return-Path: <linuxppc-dev+bounces-29620-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0184CCA463
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2026 07:50:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j6DVb2pCVz2y8Z;
	Sat, 17 Oct 2026 18:49:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792223399;
	cv=none; b=HhykPk9aK6BSBQrUdodlhtbi/F8gr+OvfW7D4XwFgiamtOalGX384bUMFMKV57iZj2URNEZrhDJvzuUauJvKojTJmO9ZIwrb/C0TZXsAOqDvBUD4UCDXuwcgsrm+pluJ4gPg+00zauix03JJLaCPIwqyahUtymYkGuXDYSDeiok5FJuF5OBDK2RPKZz3hnVAT9yLam4y1cCliy38uC20NrOAHf/UCSc2bUX516IWvmUxM2VUYqAMpRmwPDCAnM1XmZ0yGmBQPddhiU/bZt56ZWY54q5eX2tu2d1NActpW51yVUM24fZcXxVvJEQ1LxHlJBGemiP6hgYc50sA8Rndbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792223399; c=relaxed/relaxed;
	bh=TzjXRaGDFHVgAyX5XZwWn/VzZjkJ8CrZs+wqvCCu2LE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkF9YInoF7XMtjh4TXG0BKga1UqdwhzL2fRcedItz3N1mPgAkotolKhaqAAZ9DAT/ivETtisXJ3dqXsefRyOWimaiHwrY/DtUfJF25KMPzHzjUgbZ5TI5NiDnrlZtLOn9FArz9lGp1+upZ5Q2UEaNBmnVeekZAyYzQzTzmL2AgtUUXmwR+XwbxwNZrP3YVISAplLkE0lHLZ/DzXwDth9dSeTf5rwOcChKU4uhK8Bf6GcHPp6aYjuKxoX+kxY013Ns4rdi7Mj8/Iuas1/Qby0DCY4qm48vuC0n7hhoXKsCM7BinJrcfDZcJoJBtVfqaXAwV4Zrrcrydrv4Fpx+GaJ/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iKGv5GWZ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iKGv5GWZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j6DVZ3rbdz2yFQ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2026 18:49:58 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69H7ECN3660074;
	Sat, 17 Oct 2026 07:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TzjXRaGDFHVgAyX5X
	ZwWn/VzZjkJ8CrZs+wqvCCu2LE=; b=iKGv5GWZPIKMX5WABtl4MQJb1Rr/j/x5U
	HVCOYwMZNAK9LCdT9Xf4jmmlU3kHvDWrk+Gpvt9ErLRR4Ge4zeQtE3r5hNRPBQA9
	QcfQ5C7U8S05LJXyGU6Vzgq1zZHIIEVWwYP1GNpFg1noat/Uch/XDwj6ump3b/OY
	nBCU9kYwEPkM4yrZp+24GRRJGAnIStEZAp8ECtSmt6EA6MofWXQP0ZnVdXdll2jj
	8SU0NnLLQKCVi6Ndwp2hpqbNtNKETZOA03wM/3k+0wBY8cck9WYTtUoh+uSzYgW3
	sH3eyJvAIuuhg4bgJSWtCceabRDRM8sWeOpxPlNLYIJah483iDrgA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hbyepgwjh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 07:49:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69H6nqwB729104;
	Sat, 17 Oct 2026 07:49:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hb36wpuv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 07:49:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69H7ndIW47841728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Oct 2026 07:49:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5777020043;
	Sat, 17 Oct 2026 07:49:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5988520040;
	Sat, 17 Oct 2026 07:49:31 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.66.83])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Oct 2026 07:49:30 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v3 3/6] keys/trusted_keys: clear sensitive PKWM buffers
Date: Sat, 17 Oct 2026 13:18:47 +0530
Message-ID: <20261017074850.164031-4-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017074850.164031-1-ssrish@linux.ibm.com>
References: <20261017074850.164031-1-ssrish@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAzMCBTYWx0ZWRfX6WRCvgAAYY93
 3ecyrcXYC2XpZnR0krXg60O/geGE6S/OoZbiP1jBj1cNpsLtAPguNCewdbe2VBWzeSqkI/8WkH+
 ZvhXkjHeIcvAhFxPPSg9NAF0b0KC6uw=
X-Authority-Analysis: v=2.4 cv=Z4R5j3RA c=1 sm=1 tr=0 ts=6ad32898 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=0K-bQ7w7VnYq07X3RDEA:9
X-Proofpoint-ORIG-GUID: pQ_U88MVLMH2ayV5-tbYxDOFTeN_dna2
X-Proofpoint-GUID: t4wt0HvaE2goMA7bG7OzNuVX-9Llh-mH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAzMCBTYWx0ZWRfX29nI1EYEE/R7
 +dgrZI0QFjEoWWcanL5afsSWalt9pntVYS7zvuznCzcWVC5PsE5SBsYGcgsSQCIB11DrPACMfZO
 eUgBz0HzA0+UJbfGDYlXtaqkSUaXgv82Me9XlqFKbuzAQuNSeklwFKBJjkKwo+QCdVwe+Hk+WKw
 4xVpfcQ+Iw+9iaW4AKqri6P+QNdKym6eaTVuxxAHtVxjqnW8Zm5hHaxceyzjxfEnpZH61od2bCX
 HM8sVKVSDdWIiQaA1mf9x8C5gpJiaBTHleD56gxFXHaLJ+wCyn31D+NGEtFkpGs43aYj+xz3/BV
 V9hUyTdLQmoNaveleelXcQFnWRfFJoLs/RsfrNvR6lYk0C92yuKV/IAA8b+Y59CmAPNOmWQNN8B
 fYDyeDRT8V2KYxYoXTNcJcjlM7kjFv0K9Jx8mOa4DrP8WOQ+2GLjD9qxUJhN8g+GHaISI2he3Dt
 Mk1mUzQgDC/cy0JLzNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170030

The input buffer to PKWM seal and the output buffer from PKWM unseal
contain plaintext trusted-key payload data. Freeing these buffers with
kfree(), without wiping the contents, can leave sensitive key material
in memory.

Use kfree_sensitive() to wipe the sensitive key material when freeing
these buffers.

Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted source")
Cc: stable@vger.kernel.org # 7.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/trusted_pkwm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
index 633a7674d065..6774557f818a 100644
--- a/security/keys/trusted-keys/trusted_pkwm.c
+++ b/security/keys/trusted-keys/trusted_pkwm.c
@@ -118,7 +118,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
 		pr_err("Wrapping of payload key failed: %d\n", rc);
 	}
 
-	kfree(input_buf);
+	kfree_sensitive(input_buf);
 	kfree(output_buf);
 
 out:
@@ -153,7 +153,7 @@ static int trusted_pkwm_unseal(struct trusted_key_payload *p, char *datablob)
 	}
 
 	kfree(input_buf);
-	kfree(output_buf);
+	kfree_sensitive(output_buf);
 
 	return rc;
 }
-- 
2.52.0


