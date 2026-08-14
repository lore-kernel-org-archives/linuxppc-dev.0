Return-Path: <linuxppc-dev+bounces-25851-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7967C5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 07:39:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLvH26Dnhz3cMV;
	Fri, 14 Aug 2026 17:38:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786693118;
	cv=none; b=mlyKz1CnSorXKG9E1NLufpHSP0fdeR+C2lZcrl74zgpCpT95hyzplclDkQ+Ct7fFTBdiXasJ6ADyZj5XE0+qGo8k7rZCAhhWza09A1Yl4nMIF4y/jBcUaemPP/QQmLusmX4yMK6YbacAvk4zpTVCL8OG++ad805DYJfnCbMsLT9NZRWa41Jq5U0+LWhyl5wA9PdDeKAWseZbmkwlY5X56J2LRHNICoGPgVg13JQ10vFkPJAJEweunE9yUHgEzuG2ZjezxK3rirsgh6zgt89+fSwVgkSD7DXkA6ko+UEmC+DKk8yPNTufY9tmJ1cR7610nyVt8WWBEicBOCCbmJ8+CA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786693118; c=relaxed/relaxed;
	bh=mybhAPVWk3CE1qcKccKk4St5ozcEMoWgSJIf+sQq0vE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ydxm2uJq5N5Fhoqb5qMCT7zTteZpJkEty3gEH8GFEpsi0wXVlMRsLMe4P6HzMpz6+nLYc3eguCwIT3LezSJfAuD95ybGRmq4ipUkQ/oqvcS57bXD5OygJtW+Oogaa8+DmYCjw4arGWNSmrJCnoiI1CPLJvtS777OQZ1kNzuozmpxVWkeQGaHKYJlKBcHT46lVJbRzn4+AxBR5YY5pstycSnqzeee1mgVgQ2iSNM2FGn1v3QDai3VDTKXyIMeuK3FjCyaaFxXlfrjCCfGwM3jpoEuSumyHi3O4c7CkDHgA5W5eJsZqrBG9BgCIYTgX2fl/rHGbvkYs+HW1oOyC9yA3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QkybJNob; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QkybJNob;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLvH15lVpz2ysb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 17:38:37 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4VZcU2471424;
	Fri, 14 Aug 2026 07:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mybhAP
	VWk3CE1qcKccKk4St5ozcEMoWgSJIf+sQq0vE=; b=QkybJNobGUsHG9y7GMezMF
	CuAn7NZZeFbITZon+y3YTpc2b/3LrdA5sNG+dg3iKWwKXRaB02v48LFr7Uwfldp2
	S2yPnuq/Y3TtQtj4Ic6KmQICtpnMGLJkiyx1K39cBlnHQ4jyi6mwa6UxqocEwBb1
	IIOQ6RFTMuknCGgq32aMmlthpLOILKY9/+KrlX/N+CIjdP3j88XiTOAq/ziruw5p
	BfuUSbOGqW9Q7zrsMhzGQgIFblqG8Q9INVO9jQuzCg0HWgFUG3ETPY1rFqSWuaeK
	SX2gTYVotWhy/KyABsX1gLisRndFybB14x+XELjcILOicVAW0yOu8xotX2K1rBTA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk0bqvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:38:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E7QRAl001607;
	Fri, 14 Aug 2026 07:38:27 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9heb3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:38:27 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E7cOCJ33555020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 07:38:24 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3161858058;
	Fri, 14 Aug 2026 07:38:24 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28E9058057;
	Fri, 14 Aug 2026 07:38:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.89.186])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 07:38:22 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com,
        Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v5 13/15] ibmveth: Expose per-queue buffer pool details via debugfs
Date: Fri, 14 Aug 2026 00:36:40 -0700
Message-Id: <20260814073642.24630-14-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260814073642.24630-1-mmc@linux.ibm.com>
References: <20260814073642.24630-1-mmc@linux.ibm.com>
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
Content-Type: text/plain; charset=true
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfXwhOuZBXszpxK
 Mn4+COLCQKM2A0Xdhy6Q46k+5SV2mSoboAzayrOXGh40HPr3O+4SczyVZzD6AMIowcFCkFYvz58
 lrpKqDICvq96aJvOwcGy5tMYLZm26zCpLb+QK0zrIppRYZBlofqqu2jP0WT0+dztbJu8/ApfqfH
 TiJEnBRQ2i4k6aZaDLZ3nF+BbLYl3jgDk34JnfOK3fNVO1Ot3OQj33TxkznPPDAOSgLxoyZFCyn
 Z7VRONobib2/LwC37OHNLG8h1pb4fWVqY7z1eKNuXil7fq8TPa0K9U1tMDwJT5e6EO/ZkI8YSMr
 W/2ikmagk9bYXdeS1CWSrVIzKecMys8Pqq3pOtMJR3LjMj6Gb1YeELAuTch2gRWdtqh7GNY1S3R
 JHYOdQzlX06jvABFKgA8SO9GQNJV4P8O9BhETs5oDUErMGCN35bzOLGZDDNpEEzeS9UifaNZkgI
 leY4XEGqz1Ssyy4Q9dw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfXxYh+bMAeGm5O
 bCH8NnjLbbGriZ6+gJ/PUg55CnnAIwXs8EMOPKebZK+6bn4o4H3w57HleQXnelPPs7QO+592zqZ
 iw2ksPOHpHNdWkx/Y9VAvy7vCG9+kQo=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7ec5f5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=9GrW9DZCARAA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=jUfSrZ0QlCeJWHBOPV4A:9 a=3ZKOabzyN94A:10 a=47kamO7So9gA:10
X-Proofpoint-GUID: FzaXOr2PaNrdiGmz2ECFt4l3fXV5RPJb
X-Proofpoint-ORIG-GUID: qhhl8OlwWbB2Utls_hdje6wGh6HNFm5c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140058

Add a read-only buffer_pools debugfs file that lists size, buff_size,
active, and available for every RX queue and buffer pool. That is the
MQ diagnostic view (multi-line table), which does not belong in sysfs.

Keep the historical queue-0 poolN sysfs ABI unchanged:

  .../poolN/{active,num,size}

Those are one-value-per-file *configuration* knobs for buffer-pool
classes on queue 0, not one directory per RX queue. With MQ, queue 0
pool geometry remains the shared template: open copies it to queues
1..N. Per-queue runtime pressure is what debugfs shows; this series
does not add per-queue pool sysfs dirs.

Unlike ibmvnic (one RX pool per RX queue, sized from firmware, almost
no pool sysfs), ibmveth historically has multiple size-class pools and
already exported poolN via sysfs. Moving only the new all-queue dump
to debugfs matches sysfs "one value per file" review feedback without
breaking that config ABI.

Path: /sys/kernel/debug/ibmveth/<dev_name>/buffer_pools
  (e.g. /sys/kernel/debug/ibmveth/30000002/buffer_pools)

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v5:
- debugfs buffer_pools_show walks get_num_rx_queues()
- Series renumber: mailed v4 11/14 debugfs -> tip P13 (14->15)
- Path uses stable vio dev_name under a driver-owned root (not netdev
  name - avoids rename/collide)
- rtnl_lock around dump (writers are under RTNL)
- Show Active/Available as 0 when pool !live (debugfs view; free-path
  available clear already in the buffer-submit patch)

Changes in v4:
- Move the all-queue buffer_pools diagnostic from sysfs to debugfs;
  subject updated to match.
- Keep historical queue-0 poolN/{active,num,size} sysfs as one-value
  config (template for MQ); do not add per-queue pool sysfs dirs.

 drivers/net/ethernet/ibm/ibmveth.c | 69 ++++++++++++++++++++++++++++++
 drivers/net/ethernet/ibm/ibmveth.h |  2 +
 2 files changed, 71 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 5d4ca4b3d3d0..1b58a3c6ce77 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -31,6 +31,7 @@
 #include <linux/ipv6.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/debugfs.h>
 #include <asm/hvcall.h>
 #include <linux/atomic.h>
 #include <asm/vio.h>
@@ -3421,6 +3422,68 @@ static const struct net_device_ops ibmveth_netdev_ops = {
 #endif
 };
 
+static int ibmveth_buffer_pools_show(struct seq_file *m, void *v)
+{
+	struct ibmveth_adapter *adapter = m->private;
+	int i, j;
+
+	/*
+	 * Writers (veth_pool_store, open template copy, reset close/open)
+	 * update these fields under RTNL. Take the same lock so the dump
+	 * is not a torn scalar snapshot. Not required for
+	 * memory safety — embedded arrays only.
+	 */
+	rtnl_lock();
+
+	seq_puts(m, "Queue  Pool  Size  BuffSize  Active  Available\n");
+	seq_puts(m, "-----  ----  ----  --------  ------  ---------\n");
+	if (!adapter->opened)
+		seq_puts(m, "# down: Active/Available 0 unless allocated\n");
+
+	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++) {
+		for (j = 0; j < IBMVETH_NUM_BUFF_POOLS; j++) {
+			struct ibmveth_buff_pool *pool =
+				&adapter->rx_buff_pool[i][j];
+			bool live = pool->skbuff && pool->free_map;
+			int active = live ? pool->active : 0;
+			int available = live ? atomic_read(&pool->available)
+					     : 0;
+
+			seq_printf(m, "%5d  %4d  %4u  %8u  %6d  %9d\n",
+				   i, j, pool->size, pool->buff_size,
+				   active, available);
+		}
+	}
+
+	rtnl_unlock();
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ibmveth_buffer_pools);
+
+/* Driver-owned root so per-adapter dirs use a stable vio name, not the
+ * mutable netdev->name (avoids stale names / eth0 collisions after rename).
+ */
+static struct dentry *ibmveth_dbg_root;
+
+static void ibmveth_debugfs_init(struct ibmveth_adapter *adapter)
+{
+	if (!ibmveth_dbg_root)
+		ibmveth_dbg_root =
+			debugfs_create_dir(ibmveth_driver_name, NULL);
+
+	adapter->debugfs_dir =
+		debugfs_create_dir(dev_name(&adapter->vdev->dev),
+				   ibmveth_dbg_root);
+	debugfs_create_file("buffer_pools", 0400, adapter->debugfs_dir,
+			    adapter, &ibmveth_buffer_pools_fops);
+}
+
+static void ibmveth_debugfs_exit(struct ibmveth_adapter *adapter)
+{
+	debugfs_remove_recursive(adapter->debugfs_dir);
+	adapter->debugfs_dir = NULL;
+}
+
 static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter,
 				   int pools_ready)
 {
@@ -3647,6 +3710,8 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	netdev_dbg(netdev, "registered\n");
 
+	ibmveth_debugfs_init(adapter);
+
 	return 0;
 }
 
@@ -3656,6 +3721,8 @@ static void ibmveth_remove(struct vio_dev *dev)
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	int i;
 
+	ibmveth_debugfs_exit(adapter);
+
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		kobject_put(&adapter->rx_buff_pool[0][i].kobj);
 
@@ -3891,6 +3958,8 @@ static int __init ibmveth_module_init(void)
 static void __exit ibmveth_module_exit(void)
 {
 	vio_unregister_driver(&ibmveth_driver);
+	debugfs_remove_recursive(ibmveth_dbg_root);
+	ibmveth_dbg_root = NULL;
 }
 
 module_init(ibmveth_module_init);
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 0960448f53ea..8c826d23ddf4 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -392,6 +392,8 @@ struct ibmveth_adapter {
 	struct ibmveth_rx_queue_stats *rx_qstats;
 	struct ibmveth_tx_queue_stats *tx_qstats;
 
+	struct dentry *debugfs_dir;
+
 	/* Ethtool settings */
 	u8 duplex;
 	u32 speed;
-- 
2.50.1 (Apple Git-155)


