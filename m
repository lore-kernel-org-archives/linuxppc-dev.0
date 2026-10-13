Return-Path: <linuxppc-dev+bounces-29427-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02323CC6B1A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 18:30:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j42vD3sSQz3c3g;
	Wed, 14 Oct 2026 05:30:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791916216;
	cv=none; b=NAxlYISgdWlZFuHRHq2Zz2148w42PadT917SetfrGTe0AfTPIevUG+VzaOJogW2PkbOumOiQ5fZHwXybktoHRmYAu80xP/P1ttxdQS7QfMnSX3o5jfrpAQCXG3kageYnoRYEFkKBUnOfxlAyV7meOE69ac2OTglf3r7XeVaDqkpyWpuv/CLQntM2jN2Kp7EPrD5sMRvqA9x0tEvOlXCnRWXbrMVKoaLUov/A2sP8ITUIND7YPfsrH1gFQi7amkmd//0T4k09Jb9W8msxfm0BnvZwCB6E5cgYVRR/+3tZ2IS2BotoF8e61F2UUkiFf94ZB/LwYNMOZPqvzYQqUrjXvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791916216; c=relaxed/relaxed;
	bh=mzfzEa34bjKohR6lQQYzu8XvKD1RapG8l9lY5rf66tE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DfP9dw5gLwvU+UbRzm2Zv8IwbJMg5I3ay7WNoAJQ1SThsPZH7621j7R+7DMdXQiX4cmntVXt8gk/xO+qytAVyI3EYyi/RCasAtEbKcU7JPfWFZTWmeteOGUArU/gZx1I1/njijvZ96oRjjCz01Bp09xuplZ2nKKhW45MFcGu4b8K1PPwqhophQgp67bgQJ/PdjXpVWUoKn1AcinDsGlQeXlOX7c/wfdqx3MQUMhn5VNHXHrNKMug9K0avvXIf+msFmaqZo0HE2pA8UJHZYoNxzaSkvL6L2ID0lM5xTZ4wE1EQ+2mTo76i8lEFeOSH8C1TBRzj+sgyeaOI8cdNJ6fTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=czdu4Moe; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=czdu4Moe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j42vC5drMz3bxC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 05:30:15 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DECSt32016656;
	Tue, 13 Oct 2026 18:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mzfzEa34bjKohR6lQ
	QYzu8XvKD1RapG8l9lY5rf66tE=; b=czdu4MoeJhC24QRjSNLOxjmxX8e6ZsIsR
	XbdYI+CAS2I5TH8aTm5u38DAiq+05NoXm4DixjlI/SeM6sQ9rOC9vtF53MqZ34Jf
	1byLEFHlKUbfTftGN2RXSQbu3h1Es6oSfGQe/Fi8/j5hFvVFX8qAOZq86ChAt4d6
	tXUeByGn5d5bL1sICb6QS64U5xepfymQAqeF6aDyma/tcQgHwEnw3LKOE/uuYsfl
	K44HMcTTNcbog9D9nruoo59hsiPe2UuazfPn/JHMfxEy+Ow4lZX5qQgAf5bL0Lk8
	PAtfzl/ipC/SMggkcTdy3+WiqMmnC0OeQxyCbdgXztZvwBp7mJ59Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dugg58g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 18:30:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DHCqRn3149888;
	Tue, 13 Oct 2026 18:30:04 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9pb3haa0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 18:30:04 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DIU1BJ64487760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 18:30:01 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BED2E5805A;
	Tue, 13 Oct 2026 18:30:01 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D401F5805D;
	Tue, 13 Oct 2026 18:29:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.58.174])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 18:29:58 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, horms@kernel.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, jeff@garzik.org
Subject: [PATCH net-next v5 5/9] ibmveth: release the pool kobjects when probe fails
Date: Tue, 13 Oct 2026 11:29:22 -0700
Message-Id: <20261013182926.30417-6-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261013182926.30417-1-mmc@linux.ibm.com>
References: <20261013182926.30417-1-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6ace78ad cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=9zeWAwZ5pCssfL0I92cA:9
X-Proofpoint-GUID: B6-ywuCzCzc-vakZ-UXhlkzYf5dECeIb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA3MiBTYWx0ZWRfX8NnvlWIBS/0Q
 /KP53HOTmvY3Xy2PnWEYi788pJhzBOPRBNMDD9uJJxxvBs0EzGl0nCnyum/R8s4cQC8pUpzuY4F
 ZZleE+Bb0GeGD4GSoLdCCozYohz8T+0yvof7YJtZha0e1t1ZZM+o9nPW8mS2XZZ3iGBNlW7Y65x
 FVyqR1pd2f8C2ZFfVfGg+xQZoiNn/nzLGSwynhS2UkdgeAhRWUOCjUc+EJXHBQ16CRgke6UABEl
 eCVyG/Z/MEDc6kTSCPUcNVlaILc/MHu+xElcgk6lfbAsgoDdtjZkFkxHDkM3EDNqpibVyupDcsv
 iYyKQISkaaF0xJXt1Jvo4Ylt9HyDMsNijzh5zZHMb3su+Mc6SsOyC+VBikwPV5jJo3JkZqlEvka
 wHVcVi1UQebQa80Zl/orjEaH/enP9I6VAN0FBAqrA2qxUeQaqHqSN0vbEUeFHOMZhKiYYrk8RsW
 XfiHwaFKD+CFZOvzZ3A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA3MiBTYWx0ZWRfXwjSSNKFn6p41
 gQ1Yvmd3ZvLP3C6znT3Tg9TW4kn7Z+yriiA8unxmuF69wo+eNYjGDQOJStXtF8acdmfVxlcxteO
 d+XduOnDbti596y3wpjhjomIBMaC6Ps=
X-Proofpoint-ORIG-GUID: ExobSU7QhTnYJr9uT4Rs-3UsGy59pLcM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130072

If register_netdev() fails in ibmveth_probe(), for example with -EINTR
when the binding task is killed, probe frees the netdev but leaves the
pool%d kobjects embedded in it registered in sysfs. Reading
/sys/devices/vio/<unit>/pool0/num is then a use-after-free, and the
next probe cannot add pool0.

Put the kobjects before freeing the netdev, as ibmveth_remove() does,
on this path and on the netif_set_real_num_tx_queues() one.

The kobjects also have no release(). With CONFIG_DEBUG_KOBJECT_RELEASE,
kobject_put() defers their cleanup, including removing the sysfs files,
to a work item, so free_netdev() can free them first, here and in
remove(). Add a release() that signals a per-pool completion, and wait
for it in both places before free_netdev(). Without that config,
release() runs from kobject_put() and the wait returns at once.

Found in review of the ibmveth multi-queue RX series and confirmed by
code inspection; the release() part was raised by the Sashiko review of
the first version. Tested on a POWER10 LPAR with register_netdev()
forced to fail with -EINTR by a test-only module parameter (not part of
this patch): no pool%d directories remain and the device binds again. No
kernel selftests cover ibmveth.

Fixes: 860f242eb534 ("[PATCH] ibmveth change buffer pools dynamically")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
Changes in v2:
- give the pool kobjects a release() that signals a per-pool
  completion, and wait for it before free_netdev() in probe and
  remove(); with CONFIG_DEBUG_KOBJECT_RELEASE the deferred cleanup
  could run after the free (Sashiko review of v1)
- put the kobjects through one helper, ibmveth_put_pool_kobjs(),
  and an err_put_pools label for both probe failure paths

 drivers/net/ethernet/ibm/ibmveth.c | 52 +++++++++++++++++++++++++-----
 drivers/net/ethernet/ibm/ibmveth.h |  3 ++
 2 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 919b5831d875..42aa9f7bd49d 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1890,6 +1890,40 @@ static const struct net_device_ops ibmveth_netdev_ops = {
 	.ndo_features_check	= ibmveth_features_check,
 };
 
+/**
+ * ibmveth_pool_kobj_release - Mark a pool kobject finished
+ * @kobj: kobject embedded in the pool
+ *
+ * The pool kobjects live in netdev_priv(), so the last put must wait
+ * for this before free_netdev().
+ */
+static void ibmveth_pool_kobj_release(struct kobject *kobj)
+{
+	struct ibmveth_buff_pool *pool = container_of(kobj,
+						      struct ibmveth_buff_pool,
+						      kobj);
+
+	complete(&pool->released);
+}
+
+/**
+ * ibmveth_put_pool_kobjs - Drop the pool kobjects and wait for release
+ * @adapter: ibmveth adapter
+ *
+ * With CONFIG_DEBUG_KOBJECT_RELEASE the cleanup, including removing the
+ * sysfs files, runs later from a work item in the kobject; wait for it
+ * so free_netdev() cannot free the pools first.
+ */
+static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
+		kobject_put(&adapter->rx_buff_pool[i].kobj);
+	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
+		wait_for_completion(&adapter->rx_buff_pool[i].released);
+}
+
 static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 {
 	int rc, i, mac_len;
@@ -2000,6 +2034,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[i], i,
 					 pool_count[i], pool_size[i],
 					 pool_active[i]);
+		init_completion(&adapter->rx_buff_pool[i].released);
 		error = kobject_init_and_add(kobj, &ktype_veth_pool,
 					     &dev->dev.kobj, "pool%d", i);
 		if (!error)
@@ -2011,8 +2046,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	if (rc) {
 		netdev_dbg(netdev, "failed to set number of tx queues rc=%d\n",
 			   rc);
-		free_netdev(netdev);
-		return rc;
+		goto err_put_pools;
 	}
 	adapter->tx_ltb_size = PAGE_ALIGN(IBMVETH_MAX_TX_BUF_SIZE);
 	for (i = 0; i < IBMVETH_MAX_QUEUES; i++)
@@ -2027,25 +2061,27 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
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
+	ibmveth_put_pool_kobjs(adapter);
+	free_netdev(netdev);
+	return rc;
 }
 
 static void ibmveth_remove(struct vio_dev *dev)
 {
 	struct net_device *netdev = dev_get_drvdata(&dev->dev);
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	int i;
 
 	disable_work_sync(&adapter->work);
 
-	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		kobject_put(&adapter->rx_buff_pool[i].kobj);
+	ibmveth_put_pool_kobjs(adapter);
 
 	unregister_netdev(netdev);
 
@@ -2221,7 +2257,7 @@ static const struct sysfs_ops veth_pool_ops = {
 };
 
 static struct kobj_type ktype_veth_pool = {
-	.release        = NULL,
+	.release        = ibmveth_pool_kobj_release,
 	.sysfs_ops      = &veth_pool_ops,
 	.default_groups = veth_pool_groups,
 };
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 3f2240823f6a..be0939caa328 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -14,6 +14,8 @@
 #ifndef _IBMVETH_H
 #define _IBMVETH_H
 
+#include <linux/completion.h>
+
 /* constants for H_MULTICAST_CTRL */
 #define IbmVethMcastReceptionModifyBit     0x80000UL
 #define IbmVethMcastReceptionEnableBit     0x20000UL
@@ -143,6 +145,7 @@ struct ibmveth_buff_pool {
     struct sk_buff **skbuff;
     int active;
     struct kobject kobj;
+	struct completion released;
 };
 
 struct ibmveth_rx_q {
-- 
2.50.1 (Apple Git-155)


