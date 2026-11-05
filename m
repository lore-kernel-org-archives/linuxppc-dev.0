Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE87606A32C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 14:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=POWN+xbb
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jL4nh5pMkz2xN4;
	Fri, 06 Nov 2026 01:44:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793889848;
	cv=none; b=Cci0gKvRlOPZflg3SL3lPzd+0CvrpZySlgLnKJRGXilKdubUoxnnRdwrd2C5BhwO4K56HQL1vKYTVrWTAnd5OnmlKXJ7ZIFgFbAyvQfIxhMud4L9EzDsATGQJcQaCIk17nl4niT+OtU3F2uqVGuWNqjgDds0GnfmOyq4WE8jJTaG3ZAYA6nbSIUrUNi3pjYZr5n+lp8Xvj/tPMW57NhQaZgO0PjCpGtNg9UYtzIKbY3P0cQLEbLmpICt8l11tvB5G5LxWacsAKwkrZ27PV8Uj96h5EVEfSEen/buUqCOsy/2+9m6xc+5+FiAQJlCxObUzmSU6XULzgtO8v4+1r+4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793889848; c=relaxed/relaxed;
	bh=wvVFjIs0Ka0Y5841mv7erNB9pFMfMsIvUKo9CfwDgAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbnVvlQMF+EOg6rEc5IQewZTZn5Q1N06znmBcvfRVofRKFOb0NCxCwRF6dlQHrLA6U9ZmVhk70Q5n+lE1F2kPs5LWyCEiKUcYbMGd6oncEqQOLGm/UQGjcFq4BWzwJmAeD4yLkaCp0sFCfwIvzK9IGiqbOroOypTrysg08Cr/k2TCGPrQmP+LRYA2i+cQt6/nqWp0R6cwtNmmWuTE1Rc9L3vMBA9FCuYbiHh/Lfnw0DhDf7caUkxg2KFHnPi3C/ZNHQP1Ks8GXIhvur0JDT1oBnkAuYpMSNb8en9B4CGRujDK7yI/ETlfsEcM8vBzEBhB73Gil6iIqiEWI3R6zXMMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=POWN+xbb; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=POWN+xbb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jL4ng5bwqz2x9c
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 01:44:07 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5AEAFM3231095;
	Thu, 5 Nov 2026 14:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wvVFjIs0Ka0Y5841m
	v7erNB9pFMfMsIvUKo9CfwDgAw=; b=POWN+xbbTjYnP+p+OMIQlToA1TQigxGpa
	sjV+Ce79aTqPT9FsdWOTv9eEbZe7ycbWvsfx469M6zS05Ujqjuf6kXVbQ9Hhx33K
	Ur1sBTp/+GSYT//CR978GO9PMClQGQZvgYyr+aGiOz0zQ4Fs8pJXOP4VQWhLpisN
	ZpO74Dx81qH/Ut7diRliaaewMZFthzyIAzWLK6hFaMDNIMW7jl05rOpqWAM84P0c
	2FRQQiGvRUYj9ozg1n5ap5ANphDU5bJpG8DYX1EF1R/tHxs2zqw0XYlyLCTq1n6W
	tE7uz5L6CkZD4Mvi4e+lCXFCYBeDRVfzLRHDC2SpCN6DkxlGyaGlg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7ysadrq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 14:43:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EZ03G1796702;
	Thu, 5 Nov 2026 14:43:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrka6tecy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 14:43:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5Ehmf943843984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 14:43:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C5A22004B;
	Thu,  5 Nov 2026 14:43:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C63922004D;
	Thu,  5 Nov 2026 14:43:41 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.70.234])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 14:43:41 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v6 2/9] keys/trusted_keys: fix PKWM output buffer cleanup
Date: Thu,  5 Nov 2026 20:13:13 +0530
Message-ID: <20261105144320.357260-3-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105144320.357260-1-ssrish@linux.ibm.com>
References: <20261105144320.357260-1-ssrish@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Mcr5KJ/f c=1 sm=1 tr=0 ts=6aec9629 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=0K-bQ7w7VnYq07X3RDEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1NiBTYWx0ZWRfX/Mj1WLo7gm31
 C19LPxTkjMRpwmImTjnDDb6PPW27PQW0h0cRDfgDK88V1d8/NINy2AuKssTGwVM/f/QPv/0TtMg
 iIMIx7jFEGQrx/gKkFlU/4BLc0jjkFc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1NiBTYWx0ZWRfX9hYE0eWBKy4+
 8s8eaZqS7miEkcZccyDOupfZSTpHQpDynqAHwn1i2L37Sgjc/cr3ELpB/XT+P7+RNtMQN3GdmXE
 z7XbonYP1F1tp4v9qj7l+Rtn6ptPf2LNImssn5Tnh7Qvxfo3E736D3Bsz1pjNLCGwUyYo9932fL
 0JLWR1Hy9VLUEdXq9YjqN6t0z5zNSl+mf6x6cqnITB1FnrtW1q/gojuBt6R7d1EkDeVdsdps8H9
 2d+6S4gyjlqaV2kAQAuIyHX/XvJuVIaoDoGQ0m2nu8l5F6Bs5ezfrHuuidBvHsQOAF7lUK00oFm
 v3zYBTtU9Epjz52lDeRFKo/zyoPUjn5/X8RlpHfWOnm4JNeXt3iSCkdX8BWdaaaYTlig4XD7MSz
 G81/8WB56i1Pgi4otVFMlGT2m7wx2lKTAZnGta1rP8qGYbZ2149XBqk/AtdVRbmRtlmSmin8yqP
 xOtMLzj4LfanFJ13fcg==
X-Proofpoint-GUID: Z1l_u3PWSBwNlJLDXtEVmHc4I-wnRqVI
X-Proofpoint-ORIG-GUID: 4rQ5Xp4fr0Z16AbWXF9e3lgxW5XBM7vr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050056
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The PKWM seal and unseal paths unconditionally free their output buffers,
but the PLPKS helpers can return without initializing those pointers.

Initialize the output buffer pointers to NULL to make cleanup safe on early
failure paths.

Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted source")
Cc: stable@vger.kernel.org # 7.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 security/keys/trusted-keys/trusted_pkwm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
index 422f752598e1..97ffec0ce1b7 100644
--- a/security/keys/trusted-keys/trusted_pkwm.c
+++ b/security/keys/trusted-keys/trusted_pkwm.c
@@ -82,7 +82,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
 {
 	struct trusted_key_options *options = NULL;
 	struct trusted_pkwm_options *pkwm = NULL;
-	u8 *input_buf, *output_buf;
+	u8 *input_buf, *output_buf = NULL;
 	u32 output_len, input_len;
 	int rc;
 
@@ -129,7 +129,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
 
 static int trusted_pkwm_unseal(struct trusted_key_payload *p, char *datablob)
 {
-	u8 *input_buf, *output_buf;
+	u8 *input_buf, *output_buf = NULL;
 	u32 input_len, output_len;
 	int rc;
 
-- 
2.52.0


