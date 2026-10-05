Return-Path: <linuxppc-dev+bounces-28908-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494E8CA5FE2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 06:08:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hypqC5x27z2yjw;
	Mon, 05 Oct 2026 17:08:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791180519;
	cv=none; b=StS0uSba/IYz85K5QYiEzoHHYaIZcy9lEzEoGgnLOD0GMj3IGftfH4kp9kqZ/KbfetTju8T7oB2CWsuSjSrgeY7djojHVWNeWJOLcGQI3pll43ajetAKsbHu7yzc6RcDqdU2ecsAD+Y2+iu3ehYWEzxIBDv559YCF8v1rONvgsQ0SOWajlmZEgoENqsRUgBBZiSk8NDRCmTGXHqETRFbkz/s1VBhh6LzIcsoEyRQPyIrOFPVY5lqssKDjv90aULZPmVUG9CBBEOGSN1R9fOrp9LD03D5PY1Gan+YM+q9YoiwVAV7UQCb+RcZNHoVG1ieqZL7fTvywVq72Mj02DwmJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791180519; c=relaxed/relaxed;
	bh=yY5Zy0AOMIswvDraEQovtE1WInwOnlfvewvx1gJAqUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZBVcKdECntlLPzmaV5RZU+Ttk8HnnKwL73iZFaJSc7o8FWdvIchS+9oYygrDsgrWBC9oTMc02s3HloKpSMIkXzs9Z0x8tuIVdFWJ0SgW0P7ZSq5ERMWuzRWRkrgf+Sn9MH5AiDJoQJhFDgCpfOqkm2ED+5nndfXJG4Hyx5ziO3SLOq+ry7eXWjmmm9jIgyK9jexyiKzQ5O8Z8DfsAZWzIZ37N5dQ95cq1sOALU+YNeCHLrIYJtSsrPX2+8ENHpTaKYd0zOkrfT3EA+meWrvy/Pv/rScZtQF6Lo6YsjEMCqhnkzOhjO0YsRDt0EZixnSXi7FqsfAF5tC+UDj/5SL4hQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JgFHL1sc; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JgFHL1sc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hypqB70hYz2yDm
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 17:08:38 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69516KCK2067199;
	Mon, 5 Oct 2026 06:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yY5Zy0AOMIswvDraE
	QovtE1WInwOnlfvewvx1gJAqUQ=; b=JgFHL1sc4G5x1KLDEttJYUIaI+9Eyb2re
	tPztDU/IZyj9cD2p3vccFUZGp4/EBKdo5g5Zp/4tT5gS97Xl3abOUvgN5mrAbQmK
	+zUwyRAh5aXhu9ZUsm8LcQT9QbagO7c2nTZvr4Q0lrw8nP/qMPaB8k+Sj2X68ZnC
	fMeoThvoJJSgRIwiwkyXPG8ohU573YOYYSSszKZv9odoJ/ePJRITr337PlD5ViQZ
	UtqnTJdABDlo53+zIY188VNFIta69a0Ud55yy9UAJn2eINB13vm/gwXZ7VlGy5Bs
	xgTHcSgPGTLQvOEHkYPL/4F6+Z5avh9lZq1H605if6JQe7fPGX+6Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4fr3h2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:08:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69512ojf2142366;
	Mon, 5 Oct 2026 06:08:26 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jm6eq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:08:26 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69568Oip32506602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 06:08:24 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31F345805B;
	Mon,  5 Oct 2026 06:08:24 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4528458059;
	Mon,  5 Oct 2026 06:08:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.97.222])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 06:08:20 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        Mingming Cao <mmc@linux.ibm.com>, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/8] ibmveth: disable the reset work before unregister in remove
Date: Sun,  4 Oct 2026 23:06:04 -0700
Message-Id: <219666bf36377a7b67d14281fb0b57332c3dab15.1791178212.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1791178212.git.mmc@linux.ibm.com>
References: <cover.1791178212.git.mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac33edb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=IlR5_4QjEJt1gQzRlPQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfX7hUS4Z6xagZ/
 zdz/4PALQDcY3kX0Q/aWEtLZ3Xrgs71gWYdNNfPO116TIOwONhhFh3o+ZrqI4H2VqnyWKsNBQfP
 uic3ms3xjUR1/ncdUMrEyjxWksW6lPFe05iQTE3V798sr/evNcKJ+U/kM4iQWXV+bS5J/wS/0xC
 fVC1qwFczyU3qQYrx98DqoH1y0TQT82AFkuxr6/38uIJZZNNei4HZVqeqQa2R1E4RJvwvQvB0mi
 c1pt6VaRYmoE55hyT94FtszAzWUxdHJhF/MuMBVu5pPN6FQSo4ZIWfzcfB8gflyWXE19EPkpdrr
 lojZerfSlnPqjp9xUuf7EuzggfE2BpjK9JaNnWBYIjMO2fVpdCp0Iba1/piu1Ir/A4B/FL85xYN
 7Mrzhrult5qEVKsMHDT+pUItTBiy1dqvHIA3s+TdeXIz+c2pwZlxl8N2KDNg3A356sOinycFPf9
 HhHgCWgJ3RJgR+WEzFA==
X-Proofpoint-GUID: ngPXV_Y1QdmOYgDdnk_d2xPNku-SI-XI
X-Proofpoint-ORIG-GUID: OTmDrWmKh5eVyuFEPFIzlpf7JbtiPToI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfX3q3o5206m92T
 7+bkWKzqguawcTNzf+HV5NOhd6bjjb9F3rLFhevl9Tzs9VF4aVP9Rvr6AGLBKJqPwoWFeNuMegt
 4V4KFrzv/jKpQ96/Mm6Beng/Pfhb9Ys=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050024

ibmveth_remove() cancels the reset work before unregister_netdev(),
but NAPI keeps running until unregister closes the device and can
queue the reset again, on an interrupt enable failure, a bad
free_map entry or a bad RX slot. The reset can then run on the
adapter after free_netdev(), or reopen the device during unregister.

Use disable_work_sync(), which waits for a running reset and keeps
the work from being queued again. A bad RX slot also makes poll
spin, which can stall unregister; a later patch in this series
fixes that.

Found by AI-assisted review of the ibmveth multi-queue RX series and
confirmed by code inspection; it was not reproduced. Tested on a POWER10
LPAR with unbind and bind cycles under traffic. No kernel selftests
cover ibmveth.

Fixes: 2c91e2319ed9 ("net: ibmveth: Reset the adapter when unexpected states are detected")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index dab571fe8dde..d269599f5a99 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1954,7 +1954,7 @@ static void ibmveth_remove(struct vio_dev *dev)
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	int i;
 
-	cancel_work_sync(&adapter->work);
+	disable_work_sync(&adapter->work);
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		kobject_put(&adapter->rx_buff_pool[i].kobj);
-- 
2.39.3 (Apple Git-146)


