Return-Path: <linuxppc-dev+bounces-18288-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C520FB5EA5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 04:04:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZddh4dm6z2yVP;
	Tue, 17 Mar 2026 15:04:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773720296;
	cv=none; b=Pfa0wOeVsgM+AHMepOfV5PmbLp/S+UQusaod1heMGezmCrxtY5eoy50psiglsbwuFMWH4EnghmrEFLr9FiToSxXiHLZm0fKjby92G7y/U3OUSf1O59vlDWODo912UI2N/JhYD8u/UsLpzuEt+ChfpnsuC33WawlV4Rt5avxicbTx/uPnIFwTNN/6ijl3TX8iJC9VhWWbmhlGEILNr4mqCxyH166Q+Xr+otbUz65QE313ptoHavyWJa1ce17x+ufCBzsEq03yKlMgE2VIfBQs2t4qQ0y+LULJh8AfZiF2K2HNJ6+3O1v0ln/Z+P0KpqFJmCV8XEw10N/elqrPS8lY6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773720296; c=relaxed/relaxed;
	bh=1UxM0GTbu4QPeNsMu1/x8o49ICeSGApJ5XK6IMTdTrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EfCevfOpr9BdkczKqpvdqpWN91mNFZYSfFi/MVOywXDPW2D2fb8xXN+7cd5Z6C7kEGzS0FloKYjPGW37dn/f0NRptas6RjyAyoMpSCvzLiq6Elr41eekY9oh7mTbD2nsQIxRZ80QD1o+HyD7dcgUL5pHK13X8RUqPYRlRbGSphpYM3eDAKZIXuiPhs1WxslGkiwvUmnbvCD/w+JUbp/RslpTorX5ZJgYteZ/kg6uUbqPGYsHcO2+RNzuudEJkBX8fXbHWx1QFei9VlcXw2IgYfYA2WdlRL4eJBbKfvLc5n8JEzayFvcNLIhP0eESQjIO8QPN4NQUim2XoAMcTKbT7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eQVc5AHo; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=haren@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eQVc5AHo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=haren@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZddg3jtsz2xb3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 15:04:54 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GEr4uu708076;
	Tue, 17 Mar 2026 04:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=1UxM0GTbu4QPeNsMu1/x8o49ICeSGApJ5XK6IMTdT
	rc=; b=eQVc5AHojSCGnuAA54E+bV7JDzriGjeN794cezCk8AE+g0AIKWrAcxM6y
	VYBF8p1/JLmXLd1p3I2JkqsPhlv0veVyYmRIMnPnsvs9fUj+P1NVHYInk+A4XUuZ
	GDJsFKGwJT4ny1pIQoPu2iW252djuc6cZAxVC0/xQjUeFl0TykyVB1IMYb3ozDG8
	aOK7TaW2dwOIDAmFuKw22HzVpbMy/gtxtMsFf+s4BlG0TYF1swl8S+idM9uQM3IF
	eWKPEfQOeFe6LjyONCIDDOgAdR+o9Ali6cfzeZ2pNVqNKkhP+QNmDgrYUiWWB29D
	mYrgjzuobQs8iDPRsY+x7nlPteDFg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs2xa7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 04:04:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62H1PaM7013987;
	Tue, 17 Mar 2026 04:04:50 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcxyknk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 04:04:50 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62H44lw019923638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 04:04:47 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CD745805C;
	Tue, 17 Mar 2026 04:04:47 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B98E858054;
	Tue, 17 Mar 2026 04:04:46 +0000 (GMT)
Received: from li-4c4c4544-0038-3410-8038-c4c04f423534.ibm.com.com (unknown [9.61.190.127])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 04:04:46 +0000 (GMT)
From: Haren Myneni <haren@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, brauner@kernel.org, hbabu@us.ibm.com,
        haren@linux.ibm.com
Subject: [PATCH] powerpc/pseries: Fix UAF reference for src_info after list_add
Date: Mon, 16 Mar 2026 21:04:44 -0700
Message-ID: <20260317040444.2785741-1-haren@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b8d2e3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=fkcf8siyGy-vGtCwvIAA:9
X-Proofpoint-ORIG-GUID: -G-KilzOlCrL-_zmd2-CfIBgpb7f3Tz8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDAyOCBTYWx0ZWRfX8zQPqIl46DjS
 e2FXcgwwTnbT9glWS0F0qBRIMkWpV2DOrWPnWKHpZ5b9r6HXa+IHsrE0gggc5DxRuk7tzE+93ne
 WNfHgu5P/sbQRsmlNGnIlzB2Ykg0IGnWZskKaWr9cYn83UP0/772BjE8BGRwr7waMft8DII0/oA
 NR6b32fnwpHs/eW8TfVpBGnSxuU1a3RLtiHJEX2A1XCrhu11Uh2XKdORMKLv91KWVzKkle4aUT6
 ynZlHc0QFjZ47gmFTi8aqtk9cRe/gOapKbXhVs2xOtxq7Fb0v1m8wQh/9NUz7Hn2GNpzMPCihUY
 5j1GIFbZHBOD15n/BRMeIUk1VqFhlkCSO0JCJ/8v3X9+EB3D0QXmr6GqCbNpFt+6rHVKRC9lyzm
 yDXvSbjN5aBjS/QdPoE93BuWFBQIihCbjtLvUoBT+DwXmZPo3QASC9xBfpdVvX1yqTyAcUEZ2wq
 rcpH7fUKrNb//plKI6w==
X-Proofpoint-GUID: -G-KilzOlCrL-_zmd2-CfIBgpb7f3Tz8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170028

Getting the following kernel panic in papr_hvpipe_dev_create_handle()
when trying to add src_info to the list.
 Kernel attempted to write user page (0) - exploit attempt? (uid: 0)
 BUG: Kernel NULL pointer dereference on write at 0x00000000
 Faulting instruction address: 0xc0000000001b44a0
 Oops: Kernel access of bad area, sig: 11 [#1]
 ...
 Call Trace:
 papr_hvpipe_dev_ioctl+0x1f4/0x48c (unreliable)
 sys_ioctl+0x528/0x1064
 system_call_exception+0x128/0x360
 system_call_vectored_common+0x15c/0x2ec

The current code adds src_info to the list after UAF for src_info.
So move the retain_and_null_ptr(src_info) after this list add.

Fixes: 6d3789d347a7 ("papr-hvpipe: convert papr_hvpipe_dev_create_handle() to FD_PREPARE()")
Signed-off-by: Haren Myneni <haren@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 14ae480d060a..5121c87d1fad 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -509,7 +509,6 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 	if (fdf.err)
 		return fdf.err;
 
-	retain_and_null_ptr(src_info);
 	spin_lock(&hvpipe_src_list_lock);
 	/*
 	 * If two processes are executing ioctl() for the same
@@ -522,6 +521,7 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 	}
 	list_add(&src_info->list, &hvpipe_src_list);
 	spin_unlock(&hvpipe_src_list_lock);
+	retain_and_null_ptr(src_info);
 	return fd_publish(fdf);
 }
 
-- 
2.50.1


