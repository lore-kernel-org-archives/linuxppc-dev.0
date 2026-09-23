Return-Path: <linuxppc-dev+bounces-28052-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A463EC9830B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 18:29:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqlqX2dY5z30PJ;
	Thu, 24 Sep 2026 04:29:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790188168;
	cv=none; b=lfX+U0+if9tmVD3+aaM39mdw+GhRAXtrb+Lr+XUPmy6Ed8NNdbGbV7KJocE7PHkFFxbCe23oDzHJKELPsC2o8ZDtQPd1/h/kei529ufu0mmRtSHU3iCAsEWEHWnLn110/V4C6dnB/zWvjITX2QxSQqdgLEl2ogOpOe13JrGOgnB+0gJ1WOSVay2guwfyrZqPBWPMvAlXULwKAprQJ8LpT0ptsKWFDBUmFyOlYOsOE8qYvhO95ExW+4R/dG4fLBIkq9z4w2mznZIG5q/5JBkgCZaQ4/NEwDIvWjtlLqqPSe2exjV2T8wtcrfvwsXy2Wmwiwy+DJeyhwlmJRTQk8tkVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790188168; c=relaxed/relaxed;
	bh=+wT9UEH0zRXl8PkUHGwD3BWZzUNntpye/wP+VfQ6Xng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDOB2pi09zsdOomplL4/JOQxlyTukBsy9wWzNN7dDuyKJey2Th2TKiqqztjMoRwY3eFcWJ625QdI2chtez45w+WAFCYVKAtWNepqfP/od9KIifnaqQoqCkJt4H0DGuRKJ7JuxwulZK/e6ArohQK442uRDl7hycluSlTzyvC4Y5jw55wq2zIcY+NusAkJHHRukesDRxTva21BXfx15vEn/x4tU8TNOW412L/Wu9liUeFhW/GLKwLaS/uy2N6j1LX4NpLII8wmrwLSNVRRZF7Q8NN1YR1eYYmk1f7wcUO06nNpCHT7Tx8dzLpRqRaUjTtA/AnXHTuxCiCeVthwASXmCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Vv46exxg; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Vv46exxg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqlqW4NZ9z3048
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 04:29:27 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGZR5G3922270;
	Wed, 23 Sep 2026 18:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+wT9UEH0zRXl8PkUH
	GwD3BWZzUNntpye/wP+VfQ6Xng=; b=Vv46exxgD216knRyALJ6l3GAUPGmWU9bU
	Pwre7jx3E3bsqZ+2VFwoVFlAtbbjVFmgbbpzOcJWEZ+ambc4neVzbYBDY2kmj7o8
	2bjgASBKE6akWj8AH2vCopHhkYr6GCHW2nLFZMQ+ddOjCQBE3PS50juOI0e+7AxX
	lp5UTl6dbc4REwLHQwBMJXKaA3JKdbDsokr4QAzBIoHDjl2XcngNL/5wNOC2+rNc
	jSvXFm4UP+Rrvu1yTKyRiSySfJGesqCmDSwOi55ISwqXgMaHf/c6cvKq5EP15Ibo
	yCCytL2lGT9IllpCtUruQLtSezbOFoO22gBvRPvdJn8gYn7L4Jycw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgscxkk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:29:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGWmM2681761;
	Wed, 23 Sep 2026 18:29:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qj9tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:29:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NITCQT51642750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 18:29:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0C7D20043;
	Wed, 23 Sep 2026 18:29:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7588920040;
	Wed, 23 Sep 2026 18:29:07 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.83.254])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 18:29:07 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, nayna@linux.ibm.com, gjoyce@linux.ibm.com,
        ritesh.list@gmail.com, sshegde@linux.ibm.com,
        linux-kernel@vger.kernel.org, rnsastry@linux.ibm.com,
        ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH 03/12] pseries/plpks: validate input to plpks_signed_update_var()
Date: Wed, 23 Sep 2026 23:58:07 +0530
Message-ID: <20260923182816.151451-4-ssrish@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab41a7d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=sfM6kBY1oWISPlYXYLMA:9
X-Proofpoint-ORIG-GUID: me28gTSg2Pl1wzWIz2Xth_1DeFbfD_4I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfXxAFBXPd4zp25
 81h2EO2kPuuDC5847UE51MTT5NMdytGlOgUqi8T3jVdL2cDSUEr6bsRHMyzlqzFvADD9J8CqHsO
 0anYtKGm58Xt4YZfszdcAP87t5DK2DXy71ZT+G8M9mcQ5DidRWwmutZzYlsTPnjm61VGKEViHEV
 BIr/SUebODwcH+nHxZO0aWhGRRExvnFQbmi7HZWzJvJxG8Zt1pmHk4F94quTqhswWbCBhZZZPTy
 /PFFxGEAZA85lre9jYBAZt6aD8fCD/8iaD+i42gFpMJvzjU2JnGu5K1BnWgIHk8RpuN+hIqju0n
 LXirzDaBkkmPxNWDODk6Tjo6d+7lkvkHdrsKL+QiFRbSIUMWGyFopnvM/KMe2i6y5QvaCYZshp3
 Q2O0l0qY7Dv5AUhYm/mIk34+JRm2xl5c6KLhODE35QGExgvxgdWPaHTBspQp2dpfp419Q6jeGsP
 QH9GZWUMzc+gSI2C2GQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfXyGLiQgqATDfe
 /QxFWURxJS9DW8bJd/2H5oU4woaFXHoM3AWW0rPhZQWyhPJhsq37JX3uFCzsZ2kCC1gzBgX8Kiw
 wDRATw72eXx3QgoPPwJZ1lDLAgXmDWI=
X-Proofpoint-GUID: hIWcNDcfGi5OTBbQEdXaplvwqC5_rohj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230072

plpks_signed_update_var() dereferences the supplied PLPKS variable pointer
without validating it. A NULL argument could therefore result in a NULL
pointer dereference.

Reject a NULL pointer argument with -EINVAL.

Fixes: 899d9b8fee66 ("powerpc/pseries: Implement signed update for PLPKS objects")
Cc: stable@vger.kernel.org # 6.3
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index ccf5765a907b..e3ae2cd78247 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -637,6 +637,9 @@ int plpks_signed_update_var(struct plpks_var *var, u64 flags)
 	u64 continuetoken = 0;
 	u64 timeout = 0;
 
+	if (!var)
+		return -EINVAL;
+
 	if (!var->data || var->datalen <= 0 || var->namelen > PLPKS_MAX_NAME_SIZE)
 		return -EINVAL;
 
-- 
2.52.0


