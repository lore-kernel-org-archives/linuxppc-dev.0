Return-Path: <linuxppc-dev+bounces-28057-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC14EC9830E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 18:30:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqlrG0G4vz30VX;
	Thu, 24 Sep 2026 04:30:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790188205;
	cv=none; b=bw1nQu2VRmrFcw4EwgaMSQW8J22t/PgD+7BEPi76xyfqwYbWLU4GxIqabpH8ZD1+Bps3riZG+d+CIThjWhjtbgB3L1xoRc5SHjaGja/xpJ2P5g+SXHkSdIPfWFVaI8AnYh5um3b7nMVIcfTzuyFSsob4z/iQdQ1wDDpeYr267WiSgUnUqU9+rEbOvCACvrnCN7YYfM+xY01lhvGUYBE1quPPEO1o72mGnP285S9lKCPXIxzenkRpdpom9+pxSFTakb76SBndHNH+d06gYi8QXrAENLTgOdJzNkwh91aRKrfgeQBkYnHxI7u5end6wlSyD+zBeCHf9rNmm48+LZYMMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790188205; c=relaxed/relaxed;
	bh=iaEz+6QywLOSl6dATa3b4zYaVDYmXm67qihLDTlnzZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzLv+a8ykrfWgSashRXvKNcns99TBllM6aXv7EtNq+UVY+m0llLtOt3PxIHwuVk6VlOsj+oTqfL/068pMUgesgpw53q1vilF1Rt/BO7dQibaE3Rh5lIMP3f1RfPyxnQYbKsRV4d/vEE6HI7tpkTThpoHPY6EfWHjqa9mN7rVoUgwV7yrwkl/Npkth30dLyQqKcoDanLNT+yowVzJvu4NVI+UqdQL31Vx/1i0LdVNvlqt+inl1srBQu6MR1a8rhxJ/OBEis95c3ygXGCmETW/H1lEGK/Py+uiRiRZWt3x15LlJaNMqp5IKMKwc051hCXCDOEYowuydTYVYSxe4Tx79Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ITnSxDkX; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ITnSxDkX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqlrF0Jqbz30Pn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 04:30:04 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGZU0t2748589;
	Wed, 23 Sep 2026 18:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=iaEz+6QywLOSl6dAT
	a3b4zYaVDYmXm67qihLDTlnzZk=; b=ITnSxDkX1Xvi8eIrVJEJLNRB1FwtJU3RG
	BbEZb19AbFq4/n+no+7mT+to2dlQJQENQRW04mKHQizibB+hueY/UE0+b7kza/fa
	y0lTBXz85/Mi/jhJrEEujdBPYnLuUSr3cJ7MPgboiipszOZ5rB7ZyNYvcTAoHVTW
	pPAiACzP1L0VvfbAFzbKYVKCsvJtYIeaJ6jqirmT1oB+LxnEhfFTCXt2VNzKlk8l
	VsKRYC1nOP/F0lReNm9YBeRgbAHUpvfNBZPpL/qcdDwVirbSN+z09wzshuRGhkFu
	QxCqT3Ll8tVU8hHsFyS/tpx/6++OpWOERKxIJEmsBlFncU8wJsKNg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqmcaf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:29:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGWlHQ627135;
	Wed, 23 Sep 2026 18:29:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2t5cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:29:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NITo6h37945636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 18:29:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BC4620043;
	Wed, 23 Sep 2026 18:29:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEE8320040;
	Wed, 23 Sep 2026 18:29:44 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.83.254])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 18:29:44 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, nayna@linux.ibm.com, gjoyce@linux.ibm.com,
        ritesh.list@gmail.com, sshegde@linux.ibm.com,
        linux-kernel@vger.kernel.org, rnsastry@linux.ibm.com,
        ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH 08/12] pseries/plpks: fix self-reference in plpks_var initializer
Date: Wed, 23 Sep 2026 23:58:12 +0530
Message-ID: <20260923182816.151451-9-ssrish@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab41aa3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=yo0uri9pEEIi5ApSFXoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfXz8krcbR3/MPD
 x27Jp3R7tFQMCKhNIwrjZR07Druiy0pnfSMSFqkCmqNVGkiiQWbu94vEzr/FUW3XFnuwvmvrsri
 dw1CRNWIMUl/JZXmgF3J8w5UKUTQqM09sNkS+siMr3JfezCfFn2cAg5ysJuluTXsDJSHQgBFXeM
 PRvygci7yaL5wq5fbog4k2k8kWYRzK1DxdRslRcvHFzKn6TjRxRTyDTWDMi9SF/vA+XKloBHIU/
 RvwZATysAumR4H5RgsDNq9nU9EnqkWHbdbdXOmeYC1HYA9rOX2sHupcDg6I5iR+qaxBjV/pBAes
 wSRtCXqKoQRRrpLGhKjE59nklZBfCLl4ALRrQwjK2OepmSR/2PpiYJh3kIZwz3lo3KZ8+O/r7UI
 m7iDf2Kw6yaUnHkXIP+O8hO+a8K2t72vfixOzYOy1U443z5A/iGIPGNV8gOZn2BiZj5HvrZDgPU
 AXtkYLt+KVmm/TdGlZw==
X-Proofpoint-ORIG-GUID: xwLBW0TR392Uhzyl-Cs4IEPM5itDGu2c
X-Proofpoint-GUID: YVNtTcaKrZFciylE5s9l1Z8VG-lYsgOE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfX+gMMagsVD04e
 hy0oOzdzgaGAEHrlwywYUTsty1UKwhw8arBWHRWaX1L8M/T+0zfxaoGBN6f6T+hr+R/e/3wvJNO
 Ng3UXW9MEydekqjiMFsxyts0lrr6B60=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230072

In plpks_gen_wrapping_key() and plpks_wrap_object(), strlen(var.name) is
used to initialize var.namelen within the same struct initializer. This
references a member of var before initialization of var is complete.

Use the compile-time length of PLPKS_WRAPKEY_NAME instead.

Reported-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping Module")
Cc: stable@vger.kernel.org # 7.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index b057e378a6b3..896eda3eb65f 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -939,7 +939,7 @@ int plpks_gen_wrapping_key(void)
 	int rc = 0, pseries_status = 0;
 	struct plpks_var var = {
 		.name = PLPKS_WRAPKEY_NAME,
-		.namelen = strlen(var.name),
+		.namelen = sizeof(PLPKS_WRAPKEY_NAME) - 1,
 		.policy = PLPKS_WRAPPINGKEY,
 		.os = PLPKS_VAR_LINUX,
 		.component = PLPKS_WRAPKEY_COMPONENT
@@ -1034,7 +1034,7 @@ int plpks_wrap_object(u8 **input_buf, u32 input_len, u16 wrap_flags,
 	bool sb_enforce_bit = wrap_flags & BIT(1);
 	struct plpks_var var = {
 		.name = PLPKS_WRAPKEY_NAME,
-		.namelen = strlen(var.name),
+		.namelen = sizeof(PLPKS_WRAPKEY_NAME) - 1,
 		.os = PLPKS_VAR_LINUX,
 		.component = PLPKS_WRAPKEY_COMPONENT
 	};
-- 
2.52.0


