Return-Path: <linuxppc-dev+bounces-28791-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF07ACA5FE3
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 01:58:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxTM10FTcz30T9;
	Sat, 03 Oct 2026 11:58:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790992684;
	cv=none; b=d+rVwYi/uMWh/DY2/prFdr64bGPA/6dK1h+pSz/Bg7tAqHkBObaEL5CKOxPOPmTzcCG+8XuidBSMA+Qn7SFO9pzc05JETKotSJ9JnQ0/1FCwU3T7NFPhFpIyUeOCjcEytonP67XOS3hC1C0lvsQkVgWfVmVaLP8Hkn7mRoWnFcF7hKGKwzJjBThhsku2+dzX/lWsJprkfaCTzIFjMpKzVgijpVmv8wbammQLxfYNsuKwk4k0RxQt87tGq2aAG5/QUzCZeYu0biiXn6eceaCa1R1tp9BeAzVzQSKmytQ9s0aXPqbacC9GXTYgmr+mQI74tTpNWe6bK1Z6pRl/WmDknw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790992684; c=relaxed/relaxed;
	bh=VPCUaZsjBszWyKgm092w9w4GJ9G5XjYAhM511zRh3ck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YG/K9lNXku6ZfX446jI/E8IbJmbHUyxT9XVLiuDMHrIRO69cTqjANUSI5WJQaKqrlY+ly08QRNkuf4b4Pv7HIkEdpqy31raa271IJSFyLPoMBcAj5HAown2L18JtdkIBzga4U6+HOsiWJMaxd63Zb+yHbnijp3WIwNRVcOscuT3DIfooiQTY+1TWwYICACdtQcRH1sdzTck0TSUts5XNRajEQnZnWDYbpXbAyniaYZpCsopTUiM72UtVEMqiYKmfqXpMbuieVELe0ay0hBidLdKtyma+bDszvIqxpQI0q2NDzHl07rWr/P3666J/qgLSRrH/AcjZ+y4e1ApSotN6dg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sCDNa1tH; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sCDNa1tH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxTLz6dWnz3btS
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 11:58:03 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6930NsBb1778367;
	Sat, 3 Oct 2026 01:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VPCUaZsjBszWyKgm0
	92w9w4GJ9G5XjYAhM511zRh3ck=; b=sCDNa1tH/C9syjz8eLYD3dZgsMPQau5FP
	bDbkJF5rtHrMEZDmSKjfpQbcaYs0RijlMfPeN7WAcDdTP+BhJzW6aoea926mPeZ/
	KnVmVBgsJipDLUe4nTuRefW837EkmHmuHXFUAV8ggu8a+4KsocjD2mcBA86M5mCN
	RIiGSohRJzT+qJmuMeM4JzGsTtqQHYZf56PHb1RqOaF+6lNgrbXsdfAUzYBIEC+Y
	qmj9LqlfNQ8lQAZ29ATZa21RYIbb3B0WLVqkLYfRA+RXh8SVVpjwwxgnxaXOFx3m
	rS0y+uZsP59AKBZdoZVkhwDeU64agWxW/aMerRTcHcSY8Vl/e5I1A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4j87mu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 03 Oct 2026 01:57:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 692NlwbZ3233087;
	Sat, 3 Oct 2026 01:57:45 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1y2dn71r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Oct 2026 01:57:45 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6931vh1826411652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 3 Oct 2026 01:57:43 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D83EE58055;
	Sat,  3 Oct 2026 01:57:42 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98C2C5804B;
	Sat,  3 Oct 2026 01:57:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.102.94])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  3 Oct 2026 01:57:40 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next 4/7] ibmveth: step past bad RX correlators instead of spinning or oopsing
Date: Fri,  2 Oct 2026 18:57:16 -0700
Message-Id: <14aa52f296c474726c049efc6b5a045187c45868.1790991039.git.mmc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: GYGqmxF07dIE89jS9SG0v4oNUKYBwO23
X-Proofpoint-GUID: KIbeYlAYtUMBdn8gtbzzSSSgIvzuNRiK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwNSBTYWx0ZWRfX9t4DKqyKu95e
 NQW7MsxgC7nm9Nea8Ep3UWnnDTzZx6+pN2gispVXY6KcGDuX4/cR+QkTbEY6q+ER8le2FpRIm5d
 G1bQxwLUM8+PvxKY90tV4KtA7tGrhak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwNSBTYWx0ZWRfX/p4htR2V/2cz
 gHfCHKszrSDBIWPavCH/gueqYRV3MTxsXa5RZ1AawbvNjbpMzMFIB80qQeKHRftWu6HQZJgtMVp
 KDPgy7FcQwSatqgkkJUpJqkKuYtlOrylyBAJFoTYhbSaZz33mkxpo/Rzer2WYOnSd+/pzX6aW/b
 1A+QLeW29W3Lpv+3aofmBkAf5m+fP6AK4Hf78wRztgzdKHKWs+JoT3Pcnp2gtudvt9vcVjhc21P
 7TFi1h5Y+dQ1XuYzhgw+PxnQ/Pv9ryi7TnOm9gNN59KkAm1sSbMlZGKMGpj9exoxnp+Tc2Zqs59
 gAQtqfRuzk4CDJc4k87l6+yTF6BLa+Um7375kwUBGdU/256jsWhzJ9yX2GEUBPh0MZvwdVjpy2r
 YZLt/ruUNsf9B84jhq0pV/OkreP4CY5XtF2Jrg/5j8k6E8TLgTJHg+fPvORXTohQ0ivmqkI6/cx
 apNeUmHa6mVH507Qoeg==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac0611a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=o7Lj9WSxMYmEPoeJ8j0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030005

ibmveth_poll() mishandles a bad RX correlator from PHYP in two ways.

If harvest fails or ibmveth_rxq_get_buffer() returns NULL, poll
breaks out without advancing the ring and restarts on the same slot
forever. For an out-of-range correlator it also fires a WARN_ON() and
schedules a reset each pass, but the reset is queued on that CPU and
never runs, and the CPU stalls RCU, so RTNL holders hang too. This
dates from the first commit in Fixes:, which turned the BUG_ON()s
here into WARN_ON() plus a reset.

The range check also accepts a correlator naming an inactive buffer
pool (pools 2 and 3 by default), whose skbuff array is NULL, so the
lookup dereferences NULL in softirq. Pools became inactive with the
second commit in Fixes:.

Validate the correlator in one helper that also rejects a pool with
no skbuff array. On a bad slot, advance the ring, count the drop in
rx_dropped and still schedule the reset, which rebuilds the pools.
The correlator comes from PHYP, and with the ring advancing a burst
of bad slots would WARN once per slot (and panic with
panic_on_warn), so use a ratelimited netdev_err() instead. Also free
the rx_copybreak skb if harvest fails there.

Add a KUnit case for harvest advancing on errors and extend the
existing cases to an inactive pool; on the unfixed driver the first
fails and the others oops.

Hitting either bug needs PHYP to return a bad correlator, so neither was
reproduced on hardware. Tested with KUnit on qemu pseries (ppc64le), and
on a POWER10 LPAR with a ping flood and MTU changes under traffic.

Fixes: 2c91e2319ed9 ("net: ibmveth: Reset the adapter when unexpected states are detected")
Fixes: 860f242eb534 ("[PATCH] ibmveth change buffer pools dynamically")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 171 ++++++++++++++++++++++++-----
 1 file changed, 143 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 77d3740cc52a..b89ce389d951 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -443,6 +443,37 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
 	}
 }
 
+/* The correlator comes back from PHYP; a bad one schedules a reset. */
+static bool ibmveth_rxq_correlator_valid(struct ibmveth_adapter *adapter,
+					 u64 correlator)
+{
+	unsigned int index = correlator & 0xffffffffUL;
+	unsigned int pool = correlator >> 32;
+
+	/* An inactive pool keeps its size but has no skbuff array. */
+	if (pool < IBMVETH_NUM_BUFF_POOLS &&
+	    index < adapter->rx_buff_pool[pool].size &&
+	    adapter->rx_buff_pool[pool].skbuff)
+		return true;
+
+	if (net_ratelimit())
+		netdev_err(adapter->netdev,
+			   "invalid RX correlator %llx, resetting\n",
+			   correlator);
+	schedule_work(&adapter->work);
+	return false;
+}
+
+static void ibmveth_rxq_no_skb(struct ibmveth_adapter *adapter,
+			       u64 correlator)
+{
+	if (net_ratelimit())
+		netdev_err(adapter->netdev,
+			   "no buffer for RX correlator %llx, resetting\n",
+			   correlator);
+	schedule_work(&adapter->work);
+}
+
 /**
  * ibmveth_remove_buffer_from_pool - remove a buffer from a pool
  * @adapter: adapter instance
@@ -451,7 +482,8 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
  *
  * Return:
  * * %0       - success
- * * %-EINVAL - correlator maps to pool or index out of range
+ * * %-EINVAL - correlator maps to pool or index out of range, or to an
+ *              inactive pool
  * * %-EFAULT - pool and index map to null skb
  */
 static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
@@ -462,15 +494,12 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
 	unsigned int free_index;
 	struct sk_buff *skb;
 
-	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
-	    WARN_ON(index >= adapter->rx_buff_pool[pool].size)) {
-		schedule_work(&adapter->work);
+	if (!ibmveth_rxq_correlator_valid(adapter, correlator))
 		return -EINVAL;
-	}
 
 	skb = adapter->rx_buff_pool[pool].skbuff[index];
-	if (WARN_ON(!skb)) {
-		schedule_work(&adapter->work);
+	if (!skb) {
+		ibmveth_rxq_no_skb(adapter, correlator);
 		return -EFAULT;
 	}
 
@@ -510,14 +539,23 @@ static inline struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *ada
 	u64 correlator = adapter->rx_queue.queue_addr[adapter->rx_queue.index].correlator;
 	unsigned int pool = correlator >> 32;
 	unsigned int index = correlator & 0xffffffffUL;
+	struct sk_buff *skb;
 
-	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
-	    WARN_ON(index >= adapter->rx_buff_pool[pool].size)) {
-		schedule_work(&adapter->work);
+	if (!ibmveth_rxq_correlator_valid(adapter, correlator))
 		return NULL;
-	}
 
-	return adapter->rx_buff_pool[pool].skbuff[index];
+	skb = adapter->rx_buff_pool[pool].skbuff[index];
+	if (!skb)
+		ibmveth_rxq_no_skb(adapter, correlator);
+	return skb;
+}
+
+static void ibmveth_rxq_advance(struct ibmveth_adapter *adapter)
+{
+	if (++adapter->rx_queue.index == adapter->rx_queue.num_slots) {
+		adapter->rx_queue.index = 0;
+		adapter->rx_queue.toggle = !adapter->rx_queue.toggle;
+	}
 }
 
 /**
@@ -528,6 +566,9 @@ static inline struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *ada
  *
  * Context: called from ibmveth_poll
  *
+ * The ring advances even on error, so poll does not return to a bad
+ * slot before the scheduled reset can run.
+ *
  * Return:
  * * %0    - success
  * * other - non-zero return from ibmveth_remove_buffer_from_pool
@@ -540,15 +581,9 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
 
 	cor = adapter->rx_queue.queue_addr[adapter->rx_queue.index].correlator;
 	rc = ibmveth_remove_buffer_from_pool(adapter, cor, reuse);
-	if (unlikely(rc))
-		return rc;
+	ibmveth_rxq_advance(adapter);
 
-	if (++adapter->rx_queue.index == adapter->rx_queue.num_slots) {
-		adapter->rx_queue.index = 0;
-		adapter->rx_queue.toggle = !adapter->rx_queue.toggle;
-	}
-
-	return 0;
+	return rc;
 }
 
 static void ibmveth_free_tx_ltb(struct ibmveth_adapter *adapter, int idx)
@@ -1468,6 +1503,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	int frames_processed = 0;
 	unsigned long lpar_rc;
 	u16 mss = 0;
+	int rc;
 
 restart_poll:
 	while (frames_processed < budget) {
@@ -1490,8 +1526,11 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 			__sum16 iph_check = 0;
 
 			skb = ibmveth_rxq_get_buffer(adapter);
-			if (unlikely(!skb))
+			if (unlikely(!skb)) {
+				ibmveth_rxq_advance(adapter);
+				netdev->stats.rx_dropped++;
 				break;
+			}
 
 			/* if the large packet bit is set in the rx queue
 			 * descriptor, the mss will be written by PHYP eight
@@ -1515,12 +1554,19 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 				if (rx_flush)
 					ibmveth_flush_buffer(skb->data,
 						length + offset);
-				if (unlikely(ibmveth_rxq_harvest_buffer(adapter, true)))
+				rc = ibmveth_rxq_harvest_buffer(adapter, true);
+				if (unlikely(rc)) {
+					dev_kfree_skb_any(new_skb);
+					netdev->stats.rx_dropped++;
 					break;
+				}
 				skb = new_skb;
 			} else {
-				if (unlikely(ibmveth_rxq_harvest_buffer(adapter, false)))
+				rc = ibmveth_rxq_harvest_buffer(adapter, false);
+				if (unlikely(rc)) {
+					netdev->stats.rx_dropped++;
 					break;
+				}
 				skb_reserve(skb, offset);
 			}
 
@@ -2200,8 +2246,7 @@ static void ibmveth_reset_kunit(struct work_struct *w)
  * @test: pointer to kunit structure
  *
  * Tests the error returns from ibmveth_remove_buffer_from_pool.
- * ibmveth_remove_buffer_from_pool also calls WARN_ON, so dmesg should be
- * checked to see that these warnings happened.
+ * Each error also logs a ratelimited netdev_err.
  *
  * Return: void
  */
@@ -2210,6 +2255,7 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
 	struct ibmveth_adapter *adapter = kunit_kzalloc(test, sizeof(*adapter), GFP_KERNEL);
 	struct ibmveth_buff_pool *pool;
 	u64 correlator;
+	int ret;
 
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adapter);
 
@@ -2233,6 +2279,13 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, false));
 	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, true));
 
+	/* Pool 2 is in range but has no skbuff array, like an inactive pool. */
+	correlator = ((u64)2 << 32) | 0;
+	ret = ibmveth_remove_buffer_from_pool(adapter, correlator, false);
+	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
+	ret = ibmveth_remove_buffer_from_pool(adapter, correlator, true);
+	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
+
 	correlator = (u64)0 | 0;
 	pool->skbuff[0] = NULL;
 	KUNIT_EXPECT_EQ(test, -EFAULT, ibmveth_remove_buffer_from_pool(adapter, correlator, false));
@@ -2245,9 +2298,8 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
  * ibmveth_rxq_get_buffer_test - unit test for ibmveth_rxq_get_buffer
  * @test: pointer to kunit structure
  *
- * Tests ibmveth_rxq_get_buffer. ibmveth_rxq_get_buffer also calls WARN_ON for
- * the NULL returns, so dmesg should be checked to see that these warnings
- * happened.
+ * Tests ibmveth_rxq_get_buffer. Each NULL return also logs a ratelimited
+ * netdev_err.
  *
  * Return: void
  */
@@ -2284,6 +2336,10 @@ static void ibmveth_rxq_get_buffer_test(struct kunit *test)
 	adapter->rx_queue.queue_addr[0].correlator = (u64)0 << 32 | adapter->rx_buff_pool[0].size;
 	KUNIT_EXPECT_PTR_EQ(test, NULL, ibmveth_rxq_get_buffer(adapter));
 
+	/* Pool 2 is in range but has no skbuff array, like an inactive pool. */
+	adapter->rx_queue.queue_addr[0].correlator = (u64)2 << 32 | 0;
+	KUNIT_EXPECT_PTR_EQ(test, NULL, ibmveth_rxq_get_buffer(adapter));
+
 	pool->skbuff[0] = skb;
 	adapter->rx_queue.queue_addr[0].correlator = (u64)0 << 32 | 0;
 	KUNIT_EXPECT_PTR_EQ(test, skb, ibmveth_rxq_get_buffer(adapter));
@@ -2291,9 +2347,68 @@ static void ibmveth_rxq_get_buffer_test(struct kunit *test)
 	flush_work(&adapter->work);
 }
 
+/**
+ * ibmveth_rxq_harvest_buffer_test - unit test for ibmveth_rxq_harvest_buffer
+ * @test: pointer to kunit structure
+ *
+ * A bad correlator must still advance the RX ring, wrapping and flipping
+ * the toggle at the end. This covers the harvest path; the advance after
+ * ibmveth_rxq_get_buffer() fails in ibmveth_poll() is not tested here.
+ *
+ * Return: void
+ */
+static void ibmveth_rxq_harvest_buffer_test(struct kunit *test)
+{
+	struct ibmveth_adapter *adapter;
+	struct ibmveth_buff_pool *pool;
+	int ret;
+
+	adapter = kunit_kzalloc(test, sizeof(*adapter), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adapter);
+
+	INIT_WORK(&adapter->work, ibmveth_reset_kunit);
+
+	adapter->rx_queue.num_slots = 2;
+	adapter->rx_queue.index = 0;
+	adapter->rx_queue.toggle = 1;
+	adapter->rx_queue.queue_addr =
+		kunit_kcalloc(test, 2, sizeof(struct ibmveth_rx_q_entry),
+			      GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adapter->rx_queue.queue_addr);
+
+	/* Set sane values for buffer pools */
+	for (int i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
+		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[i], i,
+					 pool_count[i], pool_size[i],
+					 pool_active[i]);
+
+	pool = &adapter->rx_buff_pool[0];
+	pool->skbuff = kunit_kcalloc(test, pool->size, sizeof(void *),
+				     GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pool->skbuff);
+
+	/* Slot 0: pool out of range. Slot 1: valid, but no skb. */
+	adapter->rx_queue.queue_addr[0].correlator =
+		(u64)IBMVETH_NUM_BUFF_POOLS << 32 | 0;
+	adapter->rx_queue.queue_addr[1].correlator = (u64)0 << 32 | 0;
+
+	ret = ibmveth_rxq_harvest_buffer(adapter, true);
+	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
+	KUNIT_EXPECT_EQ(test, 1ULL, adapter->rx_queue.index);
+	KUNIT_EXPECT_EQ(test, 1ULL, adapter->rx_queue.toggle);
+
+	ret = ibmveth_rxq_harvest_buffer(adapter, true);
+	KUNIT_EXPECT_EQ(test, -EFAULT, ret);
+	KUNIT_EXPECT_EQ(test, 0ULL, adapter->rx_queue.index);
+	KUNIT_EXPECT_EQ(test, 0ULL, adapter->rx_queue.toggle);
+
+	flush_work(&adapter->work);
+}
+
 static struct kunit_case ibmveth_test_cases[] = {
 	KUNIT_CASE(ibmveth_remove_buffer_from_pool_test),
 	KUNIT_CASE(ibmveth_rxq_get_buffer_test),
+	KUNIT_CASE(ibmveth_rxq_harvest_buffer_test),
 	{}
 };
 
-- 
2.39.3 (Apple Git-146)


