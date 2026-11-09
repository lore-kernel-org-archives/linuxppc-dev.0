Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE81606A337
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 23:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hghoLW4P
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNmtB1Ns5z308Q;
	Tue, 10 Nov 2026 10:57:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794268642;
	cv=none; b=TumXPW6jv/2XbZ3se1BdDmECixxmPM+mo/Dc9u9wLnIvbdqEyUaLvLXGt5ekM+wv7jVs2jOBW8cXSRQdy7Q5qpwES2wuGMvRERkofsZ9aydzuBZmTjI4QdN8QYftYD3WhsqqiGYp58BNx9TdWTpbmGuwa47wrule/oTw/DAEsStjHWK7ndGs/WbonBSfavIhMZUjYOIKONSnZzoHlDEuVv+9XU2iLnQp8m21344HF/DOyaECSAVM2+qSsWMIv3U10GaeQXScYhzhGHFS58JTCUXOXsf/EdBRgZ6r2p1Y15xwSQJPKJIMvwffyLakcrm4lpUPsHXGmrQp9NuiU/aPgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794268642; c=relaxed/relaxed;
	bh=S2+N6hk6wMohwuzi0HttE0MYgLDvPlo4t3NGRwXKjq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aGNRiOINdboPODiPfoqQe39pmUlEkgrakW5R+XKvmMLqLoMwJB4p+76DE0xuwRJv6/xUwklKu2LB5ZbP6XjuYZeaM6trTsOZMTNxN6lh2Op+f91XVj/0BZakUKx81lnuMjN7lSMTUZVx3oVlp19qbVokGU+3kU36GNUYrAJeyIRJ4R7WgCCt1T2LFcVpP9XYIlFn+2dizPVXvaamNXtShq8NON1DIkt+v0CI6QvxEjyaZ34stYRg2NDCLAyRq+jjew1Nl9nsgTimH8KNpkL2eU8rhbS5JqUVzMoG8hH2NjLfeTViR07LrZh/q1MW+w+t8t9wyOVlcMM42GqMUofCIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hghoLW4P; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hghoLW4P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNmt909hPz3blc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 10:57:20 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LE8iV703463;
	Mon, 9 Nov 2026 23:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=S2+N6hk6wMohwuzi0
	HttE0MYgLDvPlo4t3NGRwXKjq0=; b=hghoLW4PFt2/1oJ9/6TDzDfd+6TmBzGiI
	QPiZl+HX4w8VyGiCelzBCYBztunmP1XCrOmzaE9EBUXVQ8CxwKCLUyiGStHf9jL1
	qt8vEReqVzgdzw5BmYOduXkQPYq+G2FbCzUvLGas8hnCv+cLoXbMRVrtl8jCjSxe
	oc4a6nXoP1tbTfuvfmOYJy2/cYzct3oQ8dUsY8ugTwQHYFIx36s9tcvGVLl3wGi+
	07jIaf0tJ7NCzYVFQExPPBe56+iixntXlOiXt1sxjKHQu0X1a9zqLJ4E3tqt+Npa
	yUdJh+GXTDMmmHUWtbhBZ6GYp7W5t4RKhvz3BayB9Qr3WRR78OGyw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug62c09-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:57:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LYr8o804996;
	Mon, 9 Nov 2026 23:57:11 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htepvvhr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:57:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9Nv9A433096198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 23:57:09 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2593558059;
	Mon,  9 Nov 2026 23:57:09 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDE1858028;
	Mon,  9 Nov 2026 23:57:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.169.223])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 23:57:05 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next v8 13/15] ibmveth: Expose per-queue buffer pool details via debugfs
Date: Mon,  9 Nov 2026 15:55:54 -0800
Message-Id: <20261109235556.60604-14-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261109235556.60604-1-mmc@linux.ibm.com>
References: <20261109235556.60604-1-mmc@linux.ibm.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: UnEOSmyi-MmVNpf-tlWf4d5xHM7ZrP5c
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af25dd8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=QbvBlcoE7WtlK0dhai0A:9
X-Proofpoint-GUID: o63SAEPWll-6tDbbK_e9UyY9PFFDncOK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfX48xUuwo5Dv4e
 CbP4aJk3d2jcta2FELPAlms67QaZHG9+jO4MRI9SlHy61UJRq8UFO9a041dD1sL7BbGy/H29N35
 I6JSOKiC29Twojqp4/UPE0mUNN7irtXfnxNnmVu0khOoW3s2iRPsZ9bLoMQusFbsDiQDsiHPz+p
 HjOseg7SnTaZJcxP9wXV/TNiVa1xVMwj8jh3d/jDXTWJiN/Oe2PWUk7Sx3oxdEhKAS+wknXuFR8
 2RHHLV689L/bY1sZKN6jPPZLeGjwAXSYYdaZz4IweqibrgeJX2WejpNc6zXyCj+0ioOkdbYfZjk
 S2MqYdZ0DRWqLSi2wUU1aj48YkV85z9UZIW0M8zqJz1SUFID/htnSMd2R5cWntdLlWlP6fwPS3z
 xE57OJygyVNvALl6bAdwi+m7wue1EQZNLgwb5WhMaLBjCR4ecfIXSxBBDYn+b9gtw7K9+Z0KRM4
 qsHFR4WNoAvzrmw7Vtg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfX1mPLzmAbSvsZ
 HXpSGp/k3aDLjNeHLgJyozFsTwxQjrLllRUsnOLNcKYIwh63KBL1yzaQOlqSEikWPn/3dmiQC/2
 m+DE3lUNp+tHqP8FmEzKpQLuuSRu/eM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090094
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With multi-queue RX each queue owns its own set of five buffer pools,
so a 16-queue adapter has 80 of them. Nothing reports their runtime
state: sysfs exposes queue 0 only, and only as configuration, and no
ethtool key is per-pool. When RX drops under load, qstats
rx-hw-drop-overruns names the queue but not which of its pools ran
dry, nor how close the others are.

Add a read-only buffer_pools debugfs file, one row per RX queue and
buffer pool:

  /sys/kernel/debug/ibmveth/<dev_name>/buffer_pools
  (e.g. /sys/kernel/debug/ibmveth/30000002/buffer_pools)

  Queue  Pool  Count  BuffSize  Active  Available

Active is the poolN/active configuration flag. Active and Available
are shown only for a pool that is allocated (skbuff && free_map);
an unallocated pool shows 0 for both.

The root is driver-owned so each adapter directory can use its stable
vio name rather than the mutable netdev->name. It is created in
module_init() and unwound if vio_register_driver() fails.

A multi-line table does not belong in sysfs, so the historical queue-0
ABI is left alone:

  .../poolN/{active,num,size}

Those stay one-value configuration for queue-0 pool classes. Open
copies that geometry to queues 1..N. This series does not add
per-queue pool sysfs dirs.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---
Changes in v8:
- no code change beyond the rebase
- commit message: per-queue drops are in qstats rx-hw-drop-overruns;
  the Active column is the configured flag

Changes in v7:
- no P13 code change

Changes in v6:
- create the debugfs root in module_init() instead of lazily on
  first probe, which raced concurrent probes and could orphan the
  directory on ERR_PTR(-EEXIST)
- rename the pool buffer-count column from Size to Count, so the
  debugfs table stops reusing the word sysfs poolN/size spells as a
  byte length on the same pool object
- widen the down banner: geometry above queue 0 is only populated
  once open copies the queue-0 template
- scope the dump RTNL comment to geometry/pool->active; available is
  atomic_read

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

 drivers/net/ethernet/ibm/ibmveth.c | 80 +++++++++++++++++++++++++++++-
 drivers/net/ethernet/ibm/ibmveth.h |  2 +
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 1e2e845f8011..e805e7b1d2fe 100644
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
@@ -3811,6 +3812,67 @@ static const struct net_device_ops ibmveth_netdev_ops = {
 	.ndo_get_stats64	= ibmveth_get_stats64,
 };
 
+static int ibmveth_buffer_pools_show(struct seq_file *m, void *v)
+{
+	struct ibmveth_adapter *adapter = m->private;
+	int i, j;
+
+	/*
+	 * size / buff_size / pool->active are written under RTNL
+	 * (veth_pool_store, open template copy). Take the same lock so
+	 * those columns are not a torn snapshot. available is updated
+	 * from NAPI/softirq; only atomic_read() keeps it from tearing.
+	 * Not required for memory safety; embedded arrays only.
+	 */
+	rtnl_lock();
+
+	seq_puts(m, "Queue  Pool  Count  BuffSize  Active  Available\n");
+	seq_puts(m, "-----  ----  -----  --------  ------  ---------\n");
+	if (!adapter->opened) {
+		seq_puts(m, "# down: Active/Available 0 unless allocated\n");
+		seq_puts(m, "# down: geometry above queue 0 set at open\n");
+	}
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
+			seq_printf(m, "%5d  %4d  %5u  %8u  %6d  %9d\n",
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
 /**
  * ibmveth_pool_kobj_release - Mark a pool kobject finished
  * @kobj: kobject embedded in the pool
@@ -4069,6 +4131,8 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	netdev_dbg(netdev, "registered\n");
 
+	ibmveth_debugfs_init(adapter);
+
 	return 0;
 
 err_put_pools:
@@ -4083,6 +4147,8 @@ static void ibmveth_remove(struct vio_dev *dev)
 
 	disable_work_sync(&adapter->work);
 
+	ibmveth_debugfs_exit(adapter);
+
 	ibmveth_put_pool_kobjs(adapter, IBMVETH_NUM_BUFF_POOLS);
 
 	unregister_netdev(netdev);
@@ -4329,15 +4395,27 @@ static struct vio_driver ibmveth_driver = {
 
 static int __init ibmveth_module_init(void)
 {
+	int rc;
+
 	printk(KERN_DEBUG "%s: %s %s\n", ibmveth_driver_name,
 	       ibmveth_driver_string, ibmveth_driver_version);
 
-	return vio_register_driver(&ibmveth_driver);
+	ibmveth_dbg_root = debugfs_create_dir(ibmveth_driver_name, NULL);
+
+	rc = vio_register_driver(&ibmveth_driver);
+	if (rc) {
+		debugfs_remove_recursive(ibmveth_dbg_root);
+		ibmveth_dbg_root = NULL;
+	}
+
+	return rc;
 }
 
 static void __exit ibmveth_module_exit(void)
 {
 	vio_unregister_driver(&ibmveth_driver);
+	debugfs_remove_recursive(ibmveth_dbg_root);
+	ibmveth_dbg_root = NULL;
 }
 
 module_init(ibmveth_module_init);
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 66288f8e8349..31c2c72b2cff 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -399,6 +399,8 @@ struct ibmveth_adapter {
 	struct ibmveth_rx_queue_stats *rx_qstats;
 	struct ibmveth_tx_queue_stats *tx_qstats;
 
+	struct dentry *debugfs_dir;
+
 	/* Ethtool settings */
 	u8 duplex;
 	u32 speed;
-- 
2.50.1 (Apple Git-155)


