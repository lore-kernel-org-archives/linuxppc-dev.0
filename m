Return-Path: <linuxppc-dev+bounces-28790-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE80CA5FE4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 01:58:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxTLz0FxXz3br2;
	Sat, 03 Oct 2026 11:58:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790992682;
	cv=none; b=ZB8lvJPVMRanqrQOdGRs2WeZUAJYA+Jo/6H78b4ex0IvzvU9Ey1s+O36QtIOKIf6MJdrTVPP1r9S7lULxWkYSmvzMbeLoOW0MaxM2+XXS+26xmcXZG/iFZtcv9AIacUagX4bgsi8b4ZWfwLdC8QjSs0rYZxmTdlsAyZgGhdLY9diY1ZoHE1uVmGQwuGVIvJjIcc/hgZ7HzFV+NCdCmgnC7MsZ276B1YH7xsmpj7vjlsFypNphKqAFvzbKXDI5FSERUzj/UnHI+KxrIWL79920ZpAOrWxJeysiwe22I7D1vHsNDPc9r0oJXvHt1TXc9Ng9EmVRYQ5edgXKh+jzSDeGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790992682; c=relaxed/relaxed;
	bh=0alLWs38ruoDESmBmUFoPGQeOkFPa2S0oBHyOVEoZVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mv1atK7OcM4O7/lpJ+Zh9ysS4kKRwc++goeq4Ty5lHD0siyr2ftjOEPjlJBh0F5wzvDnDZWDAEFwtJ3rsngF068iaQcpD8kQ2MvrDnH7qo9YfLUmrx9M63lAO8m0PLDaFTUxyU5m18H6Jv7qMcfPVl413mE+dYSZC/IRuLreLGO1s4O81dHOOQzjnIC2d70kd7U12ugdKslMFZjpi+E/JRMLrZAuFP7UYJKq7rZJiQMYmlevd5oQTXU7AMoW0YEHEsdoJHM3MBWyqHGtTolgDnRIHQRYYlvyEK56hHJ3HbwIwTA62w8QzllEteeyHVBGjjZLjv1wXtf3VI0NUeFSqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rgmHOqnh; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rgmHOqnh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxTLx6zCGz30DH
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 11:58:01 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6931VvrW832223;
	Sat, 3 Oct 2026 01:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0alLWs38ruoDESmBm
	UFoPGQeOkFPa2S0oBHyOVEoZVM=; b=rgmHOqnhAeLGfcVnRQYpL+dACGEB4dnKi
	AkW839Pf25YjNmmSvRzH+Bfb3hoiXA71ptZ268HBm3+VMGPjm5JzPEKDFEtZWtk1
	5RGOEcT14XVhWWUNY3O7w4Txn0nwIxGjGGCVLK/rHho6wOeSoHm+rofP0sF5KpwH
	W+yH0lDv+oDoHX2lPEKYp78uPyZxqLtQ2xaw/JLPpdy8tkezg0Y5zG0NOkPJ/q/I
	XvcRuQqoD6mWzxyismuW+NNVZLFGov4vHeB8INGDxwkibXxPaEP79apMcPkUFWrl
	FZVrEdfq+ON2lg1QsnxYwQAGUz9POtV5I/mxZh//cuZyDkmfP8COA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4fg1xn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 03 Oct 2026 01:57:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 692NlhKG1988498;
	Sat, 3 Oct 2026 01:57:48 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h2kfm8vv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Oct 2026 01:57:48 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6931v1S731392416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 3 Oct 2026 01:57:01 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 037FF5804B;
	Sat,  3 Oct 2026 01:57:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1B5458059;
	Sat,  3 Oct 2026 01:57:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.102.94])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  3 Oct 2026 01:57:43 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next 5/7] ibmveth: release the pool kobjects when probe fails
Date: Fri,  2 Oct 2026 18:57:17 -0700
Message-Id: <f0186ae5ac4f9838b01c23fc42391abc328f814f.1790991039.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1790991039.git.mmc@linux.ibm.com>
References: <cover.1790991039.git.mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac0611d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=WQYFMZFA-6iCxkeIJq0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwNCBTYWx0ZWRfX2iA10EF2mQ4M
 rL+Hfmu6sm7WFc3rc94mr+W20vjHedwBvP/wrGRMyfavZah5vp8d1mSJ2hAB7kvHFO3r2z2+EPJ
 Uxy6bvrbcdnDxhOVgrXFWDNpuVPZnQ06nv1+H0uKgEHEGH4oPvS3HxfZU6E0CFoz+/Rb6+3bmZJ
 hc7IbOpBJZ8IIDwTT3tTEOWaGLqUXxymNdbbXtgjEohGjQNCAeUa0CgCJTfC7m/V1lGMmCd8YHW
 K4I0YNVDt22RmWJEaZsK4s0NIUewIulC6uxJTo8f1ZxyRzPhBAMH3KNrCkY6RDQzVpSL1u8gAi8
 lj1KIKDUp6geGbl2SViMtuc5WQtO5ZBeBgwkqQqKBMY0bkh7umks/v5AFrrScFoaMkDzPQeSrWr
 1CHFcS+nkAZ1FHiYDhV29kAdQaU7ha7RlJcp52dRcR7G96M2oFvzooBWksgpDjRIjOCcVHfzCRD
 ZLNkxFuw+tSKtyv466g==
X-Proofpoint-GUID: VzsX22ah7nnjXRGV6GhXt7vbu0TX_cLT
X-Proofpoint-ORIG-GUID: cKJCrIlwR06SaHSlA1N-sOErMaWSR6a4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwNCBTYWx0ZWRfXxUsOzluDRWQh
 p8iIfQ7YiWC6FTYbqCxQjS7y8484Zx3fh6A6P21iYl/VAHggOQY3TW0s5AnbfvZ72qv7zBo+QWs
 kqrz/+EXBOrM9Zj89f07QY8zd/85t0Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030004

If register_netdev() fails in ibmveth_probe(), for example with -EINTR
when the binding task is killed, probe frees the netdev but leaves the
pool%d kobjects embedded in it registered in sysfs. Reading
/sys/devices/vio/<unit>/pool0/num is then a use-after-free, and the
next probe cannot add pool0.

Put the kobjects before freeing the netdev, as ibmveth_remove() does,
on this path and on the netif_set_real_num_tx_queues() one.

As in remove(), the kobjects have no release(), so with
CONFIG_DEBUG_KOBJECT_RELEASE their deferred cleanup, including
removing the sysfs files, can still run after the free.

Tested on a POWER10 LPAR with register_netdev() forced to fail with
-EINTR: no pool%d directories remain and the device binds again.

Fixes: 860f242eb534 ("[PATCH] ibmveth change buffer pools dynamically")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index b89ce389d951..d5ba2f2650d0 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1965,8 +1965,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	if (rc) {
 		netdev_dbg(netdev, "failed to set number of tx queues rc=%d\n",
 			   rc);
-		free_netdev(netdev);
-		return rc;
+		goto err_put_pools;
 	}
 	adapter->tx_ltb_size = PAGE_ALIGN(IBMVETH_MAX_TX_BUF_SIZE);
 	for (i = 0; i < IBMVETH_MAX_QUEUES; i++)
@@ -1981,13 +1980,18 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	if (rc) {
 		netdev_dbg(netdev, "failed to register netdev rc=%d\n", rc);
-		free_netdev(netdev);
-		return rc;
+		goto err_put_pools;
 	}
 
 	netdev_dbg(netdev, "registered\n");
 
 	return 0;
+
+err_put_pools:
+	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
+		kobject_put(&adapter->rx_buff_pool[i].kobj);
+	free_netdev(netdev);
+	return rc;
 }
 
 static void ibmveth_remove(struct vio_dev *dev)
-- 
2.39.3 (Apple Git-146)


