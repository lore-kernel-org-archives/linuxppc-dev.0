Return-Path: <linuxppc-dev+bounces-20693-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841C3CD37B5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 08:04:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDXM00zsyz2xnQ;
	Mon, 11 May 2026 18:04:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778486684;
	cv=none; b=Gf5BXS8h7HATPgS/N2XvXZD5HecFtFg2RnDJIKwE/jW06awAq7wLPPM3W/cuUgTRsv8on2iKpwPpI0SzcWD2fqArOooutAuje0qnMHTR31jecuvVp4CkggQ75q078N1lSVtpB1saG6zESPSd4MwB0kqBHln8+3Y2ZBxK6J+aZ9LA/eXdhwTXDF58nS37yh767CCgQL/Xsr5wFRrQzW4TW5VzClOYgxY8enUbbOU1Yb6iJMHP+jJv3C9FIhVz5Uh+DRxvci3Y7vZ92/4NVloSJQxzwdzw9+nBkJUqoBNDW6x3mm75zrCOVcupRoN+alAcOA+JbbTusS2SaQp+e7FQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778486684; c=relaxed/relaxed;
	bh=KGSXSACYvhhup+ZvkSb0cVBnYlxI2LFhA2ZZQJs7CmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SEwwDYpYLu33A+wRy5aCs/xVrGB00AzfmE+p4nCWlJTOPC0BHeCHiL+g+/ahsOvx9hoehdha2ciqHvhGi9wLZUA7PZuE60KKSFMuzRc+CZrtTieNzTL/f2seLnUgJvy4tf8xLM3AG+3mIpo3IiXTXG7vDM9PX2/k+s4kQS8VN0B0+m3mCQaIc5/bSLEtkH5W7sj73FP0Uv62nTql8iQXCb8uap3KEI4Df1f8g4O4mfBVYyvipg6PekvefklFHfvH3uahTcGDI30VqbUaAuXxGJyazrRmV0wiOSk+FFTgepDoerv3LATJSdVWlK+AsEoSMV/MmoR54Tfi6pp8eQS3SA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NY6vZ3gL; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam.menghani@ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NY6vZ3gL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam.menghani@ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDXLy3Xx2z2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 18:04:41 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64AFKaO8151140;
	Mon, 11 May 2026 08:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=KGSXSACYvhhup+ZvkSb0cVBnYlxI2LFhA2ZZQJs7C
	mA=; b=NY6vZ3gLoxAvEdcAzJevJtwvCZp96G08tHUZ/8Sf+4Kr7Mv18mEkaJMN3
	5hh675SIuPBmh5ORAAW+8PonfNHmD3ZCUrzvEEfU4ThTROcMUfrz+qzNCKOBkm1O
	mBTNqB7HLELho/irqPjqveH5S/X8GD0axKiVfzeHsBBagPdrfHlMTs2gYZypyjNs
	96JXQHqh7W5mlS2yurlwyXRD6Jg0yDV2XgJpYMKjLflGjnesSHdxs8dom5iEWTSq
	meZhRMhKxhQzTbdcrn3yGFfsggA8SxuSU46PgqX3RkaMBKU5XTaVH+zg2FPzVDZE
	Vs2VYr5W55APFRjz9ICVCwYYcL/WA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1ubdpudw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 08:04:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B7sV45016011;
	Mon, 11 May 2026 08:04:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2grh48rg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 08:04:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64B84Pqh51970336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 08:04:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BC632004B;
	Mon, 11 May 2026 08:04:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D818820040;
	Mon, 11 May 2026 08:04:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.41.100])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 08:04:23 +0000 (GMT)
From: Gautam Menghani <Gautam.Menghani@ibm.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/64s: Fix the vector number in comments for h_facility_unavailable
Date: Mon, 11 May 2026 13:34:10 +0530
Message-ID: <20260511080412.50722-1-Gautam.Menghani@ibm.com>
X-Mailer: git-send-email 2.50.1
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
X-Authority-Analysis: v=2.4 cv=BezoFLt2 c=1 sm=1 tr=0 ts=6a018d8e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=1dck67ijtU4NSIF0_iAA:9
 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: 90uCNM44MRyWpZVtUQKQKk_hfrG-01u5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA4MyBTYWx0ZWRfXyxHgrEAk/npi
 gzSABjtlHV0k7eo9ZniZ7R3+xeY2PfRGXCb6SOrVTLbgjZyK8vPyzjcMhrhdJ4gSnbBPpfNWyWQ
 wtU0kqtDfgmxMB1ZBAA09h4QAyxq0nBM8GWQMLvDapWSqQ2A33De9eyyYgHFkJ+Nr2FA5K0N9X3
 a0c55oyaaxt+DDCnwXWdo8k8qohVYpnmTTmWR5RdQ/o0IJEMHKNqh5NomkrtWiXg3369rtiXJn9
 8tupyrXkWob6qrqy3DMFK9+gN9zVs8pSlGkLzxlPtZ8Ez7pTK0Ek47OcW5gCSb9u3FuN0Bq5M1z
 ASnvhI+c2OpZlxqHxh425P8/mk4fye8vmZ3M/oyLJrkGcy3bQdo4MFgXdnu/oW8ashH43T6hFLL
 fpyodDITobIA/DBTvp3c5hkQcJh78rpXxFrgR+tGfndEGfUvG/P6Y2Klj7+OH77/nnP6dhHFTZR
 uUy5zdP7CLVwd1do7aw==
X-Proofpoint-ORIG-GUID: IBYxc4b8OON4HWLOQF7q95hSriCG5hPK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110083

From: Gautam Menghani <gautam@linux.ibm.com>

The comments explaining the h_facility_unavailable interrupt have mentioned
the vector number as 0xf60 instead of 0xf80. Fix this typo.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index b7229430ca94..2696fbbca3b6 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -2498,7 +2498,7 @@ EXC_COMMON_BEGIN(facility_unavailable_common)
 
 
 /**
- * Interrupt 0xf60 - Hypervisor Facility Unavailable Interrupt.
+ * Interrupt 0xf80 - Hypervisor Facility Unavailable Interrupt.
  * This is a synchronous interrupt in response to
  * executing an instruction without access to the facility that can only
  * be resolved in HV mode (e.g., HFSCR).
-- 
2.53.0


