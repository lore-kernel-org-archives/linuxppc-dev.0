Return-Path: <linuxppc-dev+bounces-25456-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675C5C55174
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 22:45:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFlpY3P0Zz2xnp;
	Thu, 06 Aug 2026 08:44:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785969877;
	cv=none; b=QKnXob/NI5PSVK1mZ/ZkIVPMLkqmedDFJ1m5QbbRPOMFeaSXA3fchaXirxOA5+O9TnWk38WBHJXp/9/4N5N8f1j7b/V2vz1dhB02BWSIiXUiVPlF8Inap5tkz7dzjkP2H8rewOpVJRW+z8Qr5HtM1np6Fu8sUOPEP75/n7PObAfivQGrr0iA771pg5nW0+ZFVq92H7WvvSR6S35V7udE8l8PV9NXDXcKPwBYC2pEwqo+ZQGexmlPtt25XJHaFbLBhmN24IdXrDECVfaTSYMuLmVHWWwFwHAFRR2iSzwwx8/c6G9DveP2QXF8Sk12noUw+ivnr3jwApdA7LVq3gieYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785969877; c=relaxed/relaxed;
	bh=ehEmUC7YmgNmZI//aLROybic21o28hl65gzZpo7wk+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cMEd1lxG+mUb2Jw8QpWK9WZRGvh6/QB/MauPFeXvd7jzHVcH5Pp4+Kn9KLA54aD7Rv+mhjEeC6lnH9KHPl22IU9LLMF6UjIxNS5k6V1VW8zEZHCeN6tH4mC0j81yD+WcOOPv4vOPtELRBJ15G/Ry+e0fNM8IBzynnEYZ1XHiDu4jurjt4o+QyIeGGbzkf8k4UOXiO2ddw6h6jGcFqGGP0CSPmFGdr+cI4u3tzWmk+1Kp2706WoUEiIT/S0mQO7Lhk49vQnGldpYRDwserUiLPvDQUI6i7fOUkk0SmEhaX9OfPhtqtKk7XEaPhw3s3K8b5RCQ1t6/0bvUN/RSzq10iA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=l/QqwisH; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=l/QqwisH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFlpX5d71z2xl5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 08:44:36 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675HlrjN316157;
	Wed, 5 Aug 2026 22:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ehEmUC7YmgNmZI//a
	LROybic21o28hl65gzZpo7wk+c=; b=l/QqwisH+3rN7PKl4tJ1GeWMCGkwa65E5
	uHUXlKJwR4PlHI/6CJS8eXqubJikPqIGTHUE6bat1VpSTjEmHmD64Ga7Rb29v7Bd
	E6M9g3zZUMqhCvaquq3PwP9V/pp3sJ3Z8IfaLqGIk1fQn7FmXkp1qoBguTzuezpV
	/AT9r5iXVWuoOOxCp9087Ml5u8lgdMo//AuGHQbOUFjpMi5utUU0B6FNEvUFApgh
	gR1JrVqGK0U8ypxJMEcszJUxqLKcD5k4cXQO9pmjhAbI/WhiiG3lr2YekB02myIm
	BRBo3hi3OhcBgephVd57eLL1djvM39tnk+/DB4fK4R+0yyH6PNqGQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a45d26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 22:44:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675MfJSY022281;
	Wed, 5 Aug 2026 22:44:32 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k8nf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 22:44:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675MiUKN53936464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 22:44:30 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E7EA5805C;
	Wed,  5 Aug 2026 22:44:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FCE158054;
	Wed,  5 Aug 2026 22:44:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.135.24])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 22:44:27 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, haren@linux.ibm.com,
        ricklind@linux.ibm.com, nnac123@linux.ibm.com, davemarq@linux.ibm.com,
        vaishnavi@linux.ibm.com, bjking1@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, mmc@linux.ibm.com
Subject: [PATCH net-next v1 5/6] ibmvnic: allocate a new long term buffer before freeing the old one
Date: Wed,  5 Aug 2026 15:44:00 -0700
Message-Id: <20260805224401.58791-6-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260805224401.58791-1-mmc@linux.ibm.com>
References: <20260805224401.58791-1-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a73bcd1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yp8KHkDamDrUkzBX:21 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=Jd2wlpY-SieSRpusQl4A:9
X-Proofpoint-ORIG-GUID: XGHon8NxhBVABKrYKLvE2ZZDxvM0h8PQ
X-Proofpoint-GUID: 510HcwuozjuAiZZk-pbUNzZna2fqWqgK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE4MyBTYWx0ZWRfXxvRzJ2qQehVx
 tDNtpgr5ET9gTBSfU4Oz/jJoRB5DlwqkmMOg2kJ64ZyUCWOMqILc8grvtBDi2YoDNgXI9J7Q3NZ
 pDQvdr9YD3qS/dIj/AAGuUzz5NXduHs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE4MyBTYWx0ZWRfXyrqKj17NIuta
 sVWmSiUUwSYyYZKfouicYBxqTSlXI3/+z7F3Sj+Qg6xBAqlYyLllIkBNV/ZSVpJxht+seZYUc/Q
 HJCPXs2wUvdeGpNgxtw/GnugRL32FAvt2+AJ2z2wOaxZB6bvdcARmvWWsjk5gAxoyFzkdEikDUc
 jlX3CWckSu5DHqCClcbRuy8/PempuLYe7UPO79NfyoHKsXrTc//PsUNHkWhnpx9ngA1llnietDb
 2GVFLw1+U+dnGsxHqXM+Steyi4+cEpzph6fXEDB21x16c7hbLr0gDwZVNTR5Kwfisd/CxIu7VIm
 vBiUblJTp/VgFv+CV2bSf4DlizmhtFx3/pfPfwJ0srC2T3o1rSJ2h9pHdTYnLuqjLHqJl6/Wn/c
 DiP6ObWi715GbbFCr3Stqc44mWW1isXDzewoxnVz5tFogMdU4fY9VztJLofHEkzx51cfvlUaZtI
 xvhuF5+myD/gjvJi5pQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050183

When an mtu change grows the pools, alloc_long_term_buff() releases the
existing buffer as soon as it knows the size has changed, and only then
asks for the replacement:

  if (!reuse_ltb(ltb, size)) {
          prev = ltb->size;
          free_long_term_buff(adapter, ltb);
  }

  if (ltb->buff) {
          ...
  } else {
          ltb->buff = dma_alloc_coherent(dev, size, &ltb->addr,
                                         GFP_KERNEL);
          if (!ltb->buff) {
                  dev_err(dev, "Couldn't alloc long term buffer\n");
                  return -ENOMEM;
          }

This one is megabytes of physically contiguous memory, so it can fail
while there is plenty free. By then the old buffer is gone and the pool
it belongs to has nothing, which takes the interface down.

Allocate into a local buffer and only commit it once the allocation has
succeeded. A failure now returns with the old buffer still in place, so
the mtu change is refused and the interface keeps running at the size
it had.

Both buffers are live across the swap, so an mtu increase now needs the
old and the new at once. That makes the allocation somewhat more likely
to fail in the low memory conditions this is meant to survive, but
failing with the old buffer intact is still the better outcome: the
caller can decline the change instead of losing the interface.

The new map id is taken before the old one is released, so the two
differ across the swap. That is harmless with 255 of them.

Fixes: f8ac0bfa7d7a ("ibmvnic: Reuse LTB when possible")
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Vaishnavi Bhat <vaishnavi@linux.ibm.com>
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 24c8acc42a93..88d0c231a74f 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -455,6 +455,7 @@ static bool reuse_ltb(struct ibmvnic_long_term_buff *ltb, int size)
 static int alloc_long_term_buff(struct ibmvnic_adapter *adapter,
 				struct ibmvnic_long_term_buff *ltb, int size)
 {
+	struct ibmvnic_long_term_buff new_ltb = {};
 	struct device *dev = &adapter->vdev->dev;
 	u64 prev = 0;
 	int rc;
@@ -464,28 +465,29 @@ static int alloc_long_term_buff(struct ibmvnic_adapter *adapter,
 			"LTB size changed from 0x%llx to 0x%x, reallocating\n",
 			 ltb->size, size);
 		prev = ltb->size;
-		free_long_term_buff(adapter, ltb);
-	}
 
-	if (ltb->buff) {
-		dev_dbg(dev, "Reusing LTB [map %d, size 0x%llx]\n",
-			ltb->map_id, ltb->size);
-	} else {
-		ltb->buff = dma_alloc_coherent(dev, size, &ltb->addr,
-					       GFP_KERNEL);
-		if (!ltb->buff) {
+		/* Allocate first so failure leaves the old buffer in place. */
+		new_ltb.buff = dma_alloc_coherent(dev, size, &new_ltb.addr,
+						  GFP_KERNEL);
+		if (!new_ltb.buff) {
 			dev_err(dev, "Couldn't alloc long term buffer\n");
 			return -ENOMEM;
 		}
-		ltb->size = size;
+		new_ltb.size = size;
 
-		ltb->map_id = find_first_zero_bit(adapter->map_ids,
-						  MAX_MAP_ID);
-		bitmap_set(adapter->map_ids, ltb->map_id, 1);
+		new_ltb.map_id = find_first_zero_bit(adapter->map_ids,
+						     MAX_MAP_ID);
+		bitmap_set(adapter->map_ids, new_ltb.map_id, 1);
 
 		dev_dbg(dev,
 			"Allocated new LTB [map %d, size 0x%llx was 0x%llx]\n",
-			 ltb->map_id, ltb->size, prev);
+			 new_ltb.map_id, new_ltb.size, prev);
+
+		free_long_term_buff(adapter, ltb);
+		*ltb = new_ltb;
+	} else {
+		dev_dbg(dev, "Reusing LTB [map %d, size 0x%llx]\n",
+			ltb->map_id, ltb->size);
 	}
 
 	/* Ensure ltb is zeroed - specially when reusing it. */
-- 
2.50.1 (Apple Git-155)


