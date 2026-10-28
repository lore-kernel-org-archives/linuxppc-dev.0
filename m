Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6093A606A320
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 04:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NlsE5S/g
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDv8X4GnHz2xwL;
	Wed, 28 Oct 2026 15:12:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793160748;
	cv=none; b=UPaZQNop51FxTV26wR1Ge7vfIlYkNVV/0tEMEGcD5LhpmGTWQO8XtbHKptDpl4W1SblKRQyudKQggHuewjeNREmAHet0lp2/1YxikdS/fX9/Eo+P4ZxXTjQBzrx39xEf8uQkQgIYpYZuamAn+AdoTvjeA+cbjAz+K0vZhptvV9cIjyDK2mMi+0EJjEQ7Kpqu+a1ispXpcjkwP56Bdsm1wAVBt9hSakPEXGUqbH42D5pYOXUmyHl5asrCHnhVUc8TNBqpbCqZwRwVtp8r22AFMLK1VIqspSVhHFWtQMypdcWUOoDtBuNQNY9PtRZIcDM/Ce3pif75WAhBb8sxIqZiSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793160748; c=relaxed/relaxed;
	bh=MpDlwjuRFgwBHHvnjINiRA7cF+LE+auMwtdlBgg5/l4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iuk7tCklzEqZ6/K/45pRuKjGwPjL+4vfuXsX4mOJRxlmtwYO0pdOoi20Q+HTrddJGm3sE8OOuCUPx6XGW2XfDYhq6Fo7UUxUFb2YNnZePmAqO7+cqobiFk35BQw9k3nDa/3riF/ag2yRTQXbfSuFI2T+tvc/uEOi5We0We8NwDREiZHRI5rYLBZqe+hrZuh1tx5+JDy3dlfgQ/p7gGO8+vTHD6pmFThTt0lpLiMHM/B3ZiA+uR4KjeX4Xr35ew0XiK6yBfqwZ6cT40cT0cCyM2ema7MjhO4WXDJsTWAMHZoJ5qzwU0AOyS6OwNFLoh+yuVU/3lF69IrweJziHFCWDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NlsE5S/g; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NlsE5S/g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDv8W1N0Pz2xnv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 15:12:26 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S0j3pH3957940;
	Wed, 28 Oct 2026 04:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=MpDlwjuRFgwBHHvnjINiRA7cF+LE+auMwtdlBgg5/
	l4=; b=NlsE5S/gCL5/QtJD8e1i/Q3/PcpVW06RtWqXykHYXXPffgOnFqzdfC2W+
	O7t5Pmlq8ej0vSRTh1aYHp38SK8hcbtdRv77KXhrxzAjdVdcn6+w/OPHAQT1FnLr
	S417kOXQgwdRwrDkVr+prkSXPm1iZGzs7Qa7QPxyjqo0kyl1Cc5I38tHXQ0GmEIT
	z2GO1Fb9/PGFYwi9VxlkO68dYuNlGdQ5yLoIMCMK1E2i8WUYIH8myh2m4VWBZFgB
	ofs3ueeNUD7eszzZlLRWrllzjvKWSqyt46u/RvVjiolvlSGM6SGmJM+Xb2iGiiGp
	kYmFJmUXDzUnn0vhx/tX4yM/4MBKg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3mb0jt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 04:12:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69S0o7Dj736333;
	Wed, 28 Oct 2026 04:12:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hjtnnbggk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 04:12:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69S4CKkf30802208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 04:12:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1953C20043;
	Wed, 28 Oct 2026 04:12:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE39620040;
	Wed, 28 Oct 2026 04:12:18 +0000 (GMT)
Received: from jupiter.bl1-in.ibm.com (unknown [9.123.6.78])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 04:12:18 +0000 (GMT)
From: Mahesh Salgaonkar <mahesh@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Andrew Donnellan <andrew+kernel@donnellan.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] MAINTAINERS: Update OCXL maintainer details
Date: Wed, 28 Oct 2026 09:42:17 +0530
Message-ID: <20261028041217.499673-1-mahesh@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAxNCBTYWx0ZWRfX2VmK41fDm6B3
 pMOmLOAQppV4IdtRRsTIrvwIonbLOHsxJFbn68uSrKKdw1zoQLBCD/1ugQL010Ii0MuBxwh/rB7
 9Z/5TuGaRMFK4OAv37Qtc0N6H6D5S2w=
X-Proofpoint-ORIG-GUID: 2pk3XT-co2aNojj1OPwRvG3pFBb8pDrF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAxNCBTYWx0ZWRfX+r0SRFozpAn9
 0M/am6MMW4bKcqL/TIpni9IphyLhSG7Rk4kP9FJu2jruISxPpg5/E0JIFHgI+CMu1QPRc1hJkkO
 g3CMcB0xhCGEfusFaoJ5xuCrpnHiuLNv4LXJM7fFlQjNqfpZwiWMfy4JIhAcEC3wxEyfiGfzD7S
 2UJj1W5sxaiC0cCaS3A87Dv4cL8jEG2Pg0jYF7XiaEBQQ9U4aut9AI3tgGsmJiC9SjKfEHilXBd
 hDQZg1g8+OsujJDNG0jnbF+n3O0SqhGsjY8rsns8h8yBkGqrTgkWIW6L9G3w1pGkOzDlxWovDWA
 nGNmx+HTiVlmPDpq80laAaOZNthk3rFuRKY6+revVPd9hyAPV4GWBF2ePes7vXy4sjq+BJJzgwq
 r7JTR6Oz2iE7dQxJQuTNub+vTxb3AmhYAMbhKaoJjU2CVHPM8GW+gu++SHmt96QM+H0c88XuSDF
 EZYbS2KKElycHInhUhg==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6ae17626 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8
 a=Zu9sFVggB4hjnozgOzMA:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-GUID: 2pk3XT-co2aNojj1OPwRvG3pFBb8pDrF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280014
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I no longer have the bandwidth to maintain OCXL. The powerpc maintainer,
Madhavan Srinivasan, has kindly agreed to take over.

- Add Madhavan Srinivasan as the OCXL maintainer
- Remove myself from the OCXL maintainer role

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e7bc0bb7353d..aeac4300e0b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19967,7 +19967,7 @@ F:	drivers/net/dsa/ocelot/ocelot_ext.c
 F:	include/linux/mfd/ocelot.h
 
 OCXL (Open Coherent Accelerator Processor Interface OpenCAPI) DRIVER
-M:	Mahesh J Salgaonkar <mahesh@linux.ibm.com>
+M:	Madhavan Srinivasan <maddy@linux.ibm.com>
 R:	Andrew Donnellan <andrew+kernel@donnellan.id.au>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Odd Fixes
-- 
2.56.0


