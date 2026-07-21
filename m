Return-Path: <linuxppc-dev+bounces-24577-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E15C4451C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 03:39:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h435x5ppzz2xwN;
	Tue, 21 Jul 2026 13:39:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784605157;
	cv=none; b=bXBxf4gjeknRYkKcfv2SIAh0Oexye26VqwwopLih34e8RbKes6bs0f0gqaZngMfFBZ/LVO6pXoln28xmzVomXFmckpUrwhPcjAzeMSQNr0ppOVPv0OuEuAoqJiaJkLBIf7z8khfUKTOwYS3VIettZnITRp9GKaUWu/8348yjm2BeX+rOhmdeN4cPHfPlyuP0VXdC8IBof2sdzFsAX2QJbi/p1U1lCToDtJbVLLkM0K/zsQ3RQTYdP9GP83z9erBRGbqTukYUAUfqTHXMrNhkIOp7g6uD/6r9wu411TcxUDZ/P4Eltb0liSxcVPZmQa1aiSVXUKsRxLEPMMMkb/kxpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784605157; c=relaxed/relaxed;
	bh=wgRY6Aw5+uPPxoEcp6lgUbS5VYRuxw6olk/CjcYJu+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cveTncSqhwXvhJBthll+H3JLDa2tFEVfBpFueTYk/X0Obv/KaUaY/0j8L3voUVbDAU0EyEImXx7kLG8zq+2tko8Yi6asfl5u+N0j5Nh2mAcEWn/naqme6YSln4M2bw3RMtMTOnh+E5MFYkZDfFzWsJO6128ZmJOgKBWQZC6VGmYCWV8iCti5B2HaEaX0JRLWG9oqBEqJimRTMG013n9E5qvZFJQ3GUZfIK129IHnTTFt3dH2YvBL7AIbCnSQ9Nid7bCCwIUs5M5O+QBXO6ZDO+LxZe41xo4DUAIDh5uceSZ2rm/yWOd2xDNwDfWPwgW7+HqUfsXDntXG+GLYj0wxmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sagSmeYz; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sagSmeYz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h435x1KPtz3bdq
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 13:39:17 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNDkeg1678141;
	Tue, 21 Jul 2026 03:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wgRY6Aw5+uPPxoEcp
	6lgUbS5VYRuxw6olk/CjcYJu+U=; b=sagSmeYzXOLK9D/EsFgEcs7El9Q0rKMRb
	gVBCt33llSNQDfTcLZDRa7QQ7FCWnwPr6COuRSyu8UxShVUwLvyeAorXLdBVbj7J
	MDpR+MgY6x3+0I8tEM36lzft/HMAXBM+vDebxNkMPHr4kpT1PDj+QwINz2ycId4Q
	zjgHRSEAfH8MuWovPNBFIyuQc3KZw11W1Ml2H9oJAeouSP/yfXZFS/p5Q4jXkn+J
	KRa95sjx9+s96i9r2ByNLGyVbEJ3QZBjMyBY1iEtgEsJ+YkgFoU/0gqdvvy9b3Rx
	nRZdDKx+H3vygkzrz2CMi0ZiLLVv37jCPWWYk8L9wQRwE9d12K9Kw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77aap2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 03:39:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66L3Yh1n024875;
	Tue, 21 Jul 2026 03:39:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjrj8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 03:39:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66L3cwTD52625668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 03:38:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11F6320043;
	Tue, 21 Jul 2026 03:38:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B79C20040;
	Tue, 21 Jul 2026 03:38:53 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.218.117])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 03:38:53 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: mahesh@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu, gregkh@linuxfoundation.org,
        oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, sourabhjain@linux.ibm.com, haren@linux.ibm.com,
        nnmlinux@linux.ibm.com, thuth@redhat.com
Subject: [PATCH v3 5/5] powerpc/powernv/eeh: Map VFIO EEH error injection to OPAL
Date: Tue, 21 Jul 2026 09:08:05 +0530
Message-ID: <20260721033815.5300-6-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721033815.5300-1-nnmlinux@linux.ibm.com>
References: <20260721033815.5300-1-nnmlinux@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: oeChogAieUnV2sqjchYuh3XefzrNoWAi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDAzMCBTYWx0ZWRfX2Q+Pnt2IMPdm
 qxbb4akY+H+MDQ/JzgHzegSbfRrvp+HVIYXO1insC8YZZ3EMergGbuSc7oEgMk18GQFhlm2dpJM
 WofdcjA9NIbXt16A/KjCqWltbviQztw=
X-Proofpoint-GUID: dBgdRTxulCZbEq7nEBLESHm7Poei_CHk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDAzMCBTYWx0ZWRfXwPyJJeiOziLn
 bdss8LlLrwPIZtObnmGbJx7oEwDNdIOoH3Sx+4FtTIVUYyqarBAEzhmrmOIDu6K69Vzm8dBmbyq
 1sTu93w1N2gDobIbHWoVN7Y54d8069cVQM6jZullASDSf4ETbsFeXsrWIqds1rg+ygHvF4yPnv6
 Nm9P6Bh49UsLNV+yu9Ax/KInQrhT2NPtAmF/M1QrCwKliDjpIAjtnB/MUd/Vy/RbMuS/SghvtS1
 8kwZXvrrUaDl5aBvgyjIjTC4UB4i5MHNg1H8+OcBitONEuweVZsdcuxYcTId5feFQkHSFdqUlpz
 q+7IJpYwZK6e0rWjqMncULrwmnmS+sSBoKXQ/rcNqL36rO3ze/1BjtG7wa7yJxnXUNGJ1ybk3XN
 JH+LjLIDkKkExbb4q6Dp+Eq7xzQpq+0+zrSO7GColubgDySH0aA86DD/HKlaEdv4Q8qsa5/yv0V
 l0ku5BA07FEp8u6Uecw==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a5ee9d9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=N5Vdv9O42okQTFM43-cA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210030

The EEH error-injection interface passes the generic userspace ABI
values EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64 to the platform backend.

The PowerNV backend currently compares those generic values directly
with OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR and
OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64. Although the corresponding values
are currently numerically identical, this implicitly couples the
generic EEH ABI to the OPAL firmware encoding.

Explicitly translate the generic EEH error types to their OPAL
equivalents in pnv_eeh_err_inject(). Keep the platform-specific
encoding within the PowerNV backend and reject unsupported generic
types with -EINVAL.

No userspace ABI values are changed.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 36 +++++++++++++++++---
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index db3370d1673c..b0bcd014a133 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1169,11 +1169,39 @@ static int pnv_eeh_err_inject(struct eeh_pe *pe, int type, int func,
 	struct pnv_phb *phb = hose->private_data;
 	s64 rc;
 
-	if (type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR &&
-	    type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64) {
-		pr_warn("%s: Invalid error type %d\n",
+	/*
+	 * Map generic EEH error-type ABI values to OPAL-specific type codes.
+	 * EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64 are the only types supported by
+	 * OPAL.  Additional generic types defined in the UAPI header are valid
+	 * for pSeries RTAS but unsupported here; return -EOPNOTSUPP for those.
+	 * Unknown or invalid values return -EINVAL.
+	 *
+	 * Note: currently OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR  == 0 ==
+	 * EEH_ERR_TYPE_32 and OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64 == 1 ==
+	 * EEH_ERR_TYPE_64, but the explicit switch makes the coupling
+	 * visible and allows the values to diverge independently.
+	 */
+	switch (type) {
+	case EEH_ERR_TYPE_32:
+		type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR;
+		break;
+	case EEH_ERR_TYPE_64:
+		type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64;
+		break;
+	case EEH_ERR_TYPE_RECOVERED_SPECIAL_EVENT:
+	case EEH_ERR_TYPE_CORRUPTED_PAGE:
+	case EEH_ERR_TYPE_CORRUPTED_DCACHE_START:
+	case EEH_ERR_TYPE_CORRUPTED_DCACHE_END:
+	case EEH_ERR_TYPE_CORRUPTED_ICACHE_START:
+	case EEH_ERR_TYPE_CORRUPTED_ICACHE_END:
+	case EEH_ERR_TYPE_CORRUPTED_TLB_START:
+	case EEH_ERR_TYPE_CORRUPTED_TLB_END:
+		pr_warn("%s: EEH error type %d not supported by OPAL\n",
 			__func__, type);
-		return -ERANGE;
+		return -EOPNOTSUPP;
+	default:
+		pr_warn("%s: unsupported EEH error type %d\n", __func__, type);
+		return -EINVAL;
 	}
 
 	if (func < OPAL_ERR_INJECT_FUNC_IOA_LD_MEM_ADDR ||
-- 
2.54.0


