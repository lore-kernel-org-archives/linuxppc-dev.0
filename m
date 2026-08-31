Return-Path: <linuxppc-dev+bounces-26313-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548A0C624A4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 15:09:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYXTB0lxcz2ygW;
	Tue, 01 Sep 2026 01:09:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788188958;
	cv=none; b=k3sNCXrj5RVoicVomVmHk8zh3G0PddhxtioV2vpomSuSOpQstALETvf7gytFj5n/fVsWe49B1VJzs0Z3woR8qbcpkx2pTZcMPj6FnDE0nQquei3LMy3pzdSOpKcpMEf7wLc5tqxaeNDD7jM9ECVZEO6+Dvgt0wdRsaDwcxqjCWvK/zncQgdJarzbQ8gffaRTY32GI/L8CW3cSSHznLBBwCw9PH7HlgUIJqwxhmhFGGOtLO5C51+RtQoFZuU06/dI/O07DF9hItYLPBHKCtbOGI/Lb/v+AeS+vbUvqbP32Q5DS5d54DoLLYu5vEboVg8Zs+dFVHx2xYkxt6Q/FAqAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788188958; c=relaxed/relaxed;
	bh=TP0pvr8OkFpfkRnWzbX9EI/XoSTp1JSVIQKURZJXj5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PvHPL1ImpeCHEsmIFIUJ7990uBH29uP+vXPirEn8PG4v5hSnE66rExi3QVlsTYcmt868XruUR9ReDD6nHMLdRV1xlh+rsTH0VDVooAAz43J428oABoIlOpRE/6gNDTCCV3+GYleH1qbApY5ciJoPybFSZW5owsLTV/eh8h/RS7QgPZTKY5XRWqgn5Xn8diiBHtFAklUqxrO97lm0Jzbga5gVSFEWPBtAhHIQXwhDc4o9bRpOYm6PR5iEgWG8yPZ7l4Z/XeLJ0oPa3jFDh10RNwyAH4dsbCYJ6yPQ0CMlVa1iJ7shvy95C3+hvCK8oWyMbuOQ3BXe6l29pqtKchtbfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sN0CAQpm; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sN0CAQpm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYXT92B2fz2ypW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 01:09:17 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZEXb2414975;
	Mon, 31 Aug 2026 15:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TP0pvr8OkFpfkRnWz
	bX9EI/XoSTp1JSVIQKURZJXj5M=; b=sN0CAQpmrjFgoJbgjSN+VcJFwG12MqR9C
	9yl0mlrhoqQg65uHdGlnSgPQvV6i/f2rVxWDiwG6flrTP1VXT4PN+DVtgW5mE1vo
	4f0ilLMbX73/d6ZtGdGJQMAgMzEAdMuLmzG8suW/4LEAr4iRL3GeWfXtTiq5dcR8
	JBhLDtVE1gz2tjvvllVR8TMJlYtSz1NVE+qDzYoJTZrx+X4GtSw24LMvLshjeUmG
	W/YA6CDOGn0Jef1YB0yBrHMcq9JutCkv+11kGpVrHmShDkcMMyZaY+Ai5GHkzZdB
	IP3RyNM1ht15fqy4t8Gm48G2zY3mmmUVIPhQBML/uu2cSxaI5/5uQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhj91r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:09:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEuIAs020111;
	Mon, 31 Aug 2026 15:09:04 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyg6cwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:09:04 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VF92ve17433140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 15:09:02 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F14A95805A;
	Mon, 31 Aug 2026 15:09:01 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 647C158051;
	Mon, 31 Aug 2026 15:08:58 +0000 (GMT)
Received: from 192.168.1.50 (unknown [9.67.102.143])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 15:08:58 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v6 13/15] ibmveth: Expose per-queue buffer pool details via debugfs
Date: Mon, 31 Aug 2026 08:07:24 -0700
Message-Id: <b902e379c7df6d47c33c1f3024ae204f6ac395ea.1788102125.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1788102125.git.mmc@linux.ibm.com>
References: <cover.1788102125.git.mmc@linux.ibm.com>
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
X-Proofpoint-GUID: kD27WUBAjr_OULz7pYrQl6HjXIs83czO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX1Wc024Pt9cmD
 EDJwQsrw1J8Uon+6prftXgIMfXvnZ6jHNO1VXplCBK7390ySXECrziOWwBGr7QbRdHGTpa3wOND
 dGklu6Vfsmw/6Aq2tb4WJkNu0YR2LLhax7hvIPen5nMO0aJd6spyfNnguvQdpv46CBAPjtGXkeF
 QrCORpA8ZwKDdPIejLBP9Tj8QpMiZzwCmhpEqOdilerpPLpSqUTQeT9eSsSHBfeT+s7QM+sWPZe
 i5V3UpOVeaTxe+TSQ5iYfoFtP5Y3YWdFC9IVJOX8zOovPqJkVD3Merx0i3uXj0AHHVNbrMybt15
 YPKa7KBsy/e+ueECFj4q4RqTbcPY/hKe/v5ZDbpPtyBvwmmoj/GqV/E1iylMcUQuBb3csOb4g8K
 f+SnesXH93yoGOyJJ1Z/5MOs3DhneVpVwKN/7E3VK56NIvOzPQHCWj/ImjaeyLPfrG9bP3TZdzv
 d45Tt26iYR78gjLYhcA==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a959912 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Oho_uL6CWHW3JcStrLEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX2XcoTuwLYAsC
 SoPZ3h5trWHMyi8nF7sd8I4h52PHmIR8uvDgfcKwRKPc3hob/gV5zQBolkJwiGwJOO124TpWklJ
 500qO9EI6+/4aYv99XZyS4bZ2qQCNe0=
X-Proofpoint-ORIG-GUID: rGNBpiw8J6e4wFGboNcAAPKSRwNZJ-oW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310130

With multi-queue RX each queue owns its own set of five buffer pools,
so a 16-queue adapter has 80 of them. Nothing reports their runtime
state: sysfs exposes queue 0 only, and only as configuration, and no
ethtool key is per-pool. When RX drops under load, rx%d_no_buffer_drops
names the queue but not which of its pools ran dry, nor how close the
others are.

Add a read-only buffer_pools debugfs file, one row per RX queue and
buffer pool:

  /sys/kernel/debug/ibmveth/<dev_name>/buffer_pools
  (e.g. /sys/kernel/debug/ibmveth/30000002/buffer_pools)

  Queue  Pool  Count  BuffSize  Active  Available

Active is live allocation (skbuff && free_map), not the sysfs
poolN/active configuration flag.

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
index 4f2d956b4c89..954846c9ec7b 100644
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
@@ -3513,6 +3514,67 @@ static const struct net_device_ops ibmveth_netdev_ops = {
 #endif
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
 static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter,
 				   int pools_ready)
 {
@@ -3751,6 +3813,8 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	netdev_dbg(netdev, "registered\n");
 
+	ibmveth_debugfs_init(adapter);
+
 	return 0;
 }
 
@@ -3760,6 +3824,8 @@ static void ibmveth_remove(struct vio_dev *dev)
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	int i;
 
+	ibmveth_debugfs_exit(adapter);
+
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		kobject_put(&adapter->rx_buff_pool[0][i].kobj);
 
@@ -3986,15 +4052,27 @@ static struct vio_driver ibmveth_driver = {
 
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
index 0f2971c8627a..1276b3669f2c 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -381,6 +381,8 @@ struct ibmveth_adapter {
 	struct ibmveth_rx_queue_stats *rx_qstats;
 	struct ibmveth_tx_queue_stats *tx_qstats;
 
+	struct dentry *debugfs_dir;
+
 	/* Ethtool settings */
 	u8 duplex;
 	u32 speed;
-- 
2.50.1 (Apple Git-155)


