Return-Path: <linuxppc-dev+bounces-26310-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1278DC624A4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 15:09:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYXSn6wGCz2ygp;
	Tue, 01 Sep 2026 01:08:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788188937;
	cv=none; b=X907ivQbDII6uE8Rhhjc5imJ6FjQC7Yg/lkSzGc4OXyIAlwKMxgHaUhMH+td642hOEYYBx8DLzPzE4xETojOgbdfpAJp5zTSPm7kd8vTOACpQz+fspnrCxVHkAgFdpmxzvaUEbF8hRl8ONXc4ry9ifQdJ0AxNFzg131tgjO3gAD2wpPHo6p+Q8UAJSQW1mXkHgilln8EcFgBLb1Wk2cb+F0hkPDx/GTVWBWBhFU005aY8IM4CL4BysBtmbEnS4XC4DdFrTnv9TSdud4vQ5BijQZNiSu9jW045ddPyHBT+qNgwy97ZEafAr3I+xN02UG7Z5+NIU3Vox0TTUWJdmjQCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788188937; c=relaxed/relaxed;
	bh=12LuiWce1pilLLMgyakrOUu92AAzqKjgRVMRzvRw9rU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X1Ki5NrOvFJfqJo+d8zgk539lioxGDaSf+AM3O43YixoxQQnsd7ukOmDAIt6nDcYGtwGsggKFGHq0IEyGG1CgFWabXlkiAteZneewmSttRNR0HiWQrfE9jIpg+PJe2qy8ELK2w8417aH4heuow0XfImZ49nK2piirdcQoPGAa95ISMG/3NZtVz9Y82H87E8fQTDT64pzFt1UWbV4gmaozOrfTeyY4gKq03uj1uQbcWcSTHDRPe0knK02EUOY6NauaTLmxEJMmVWmEoOn7/OV4TfOOYEvzmXlyXF+jy9T5YXGaLitdFsqDhKjrOL1ymet5O51an+UcxD7GJuLQCkUfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CUv8R5Au; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CUv8R5Au;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYXSm5H20z2ygW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 01:08:56 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZ9EA2582941;
	Mon, 31 Aug 2026 15:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=12LuiWce1pilLLMgy
	akrOUu92AAzqKjgRVMRzvRw9rU=; b=CUv8R5AuVspmfvzMBZsmlSv6spfNi7KGq
	CAaQE9fL+hz9fClbN4d78zDI+cwUcAP/+7DKdwwN3LbJGmWRYJKVdfNjeEWRxvf8
	qVc9iQMwHLQz4/ggrq+rb9kqMxNclRJM2w/gtLv1OiKttxT0rPf1bCC7Y22+4XVd
	FXaLq/ylViZojTx6FUnbpvtMBM4hmuny7RdEgE1sUzLvz9arBTnBMeMu1kdGl10E
	w8xePz4uGBJmLRiXgFnG4vgWLcKYYRByWZfCfC3p/LQYfJZc09eA5nQWJBUdmH0H
	zblRxwPZgtaermw1pjpKPd+SvcSXJNJS9iZO3eAD+NcGhbC8fIvPQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2t1x5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:08:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEuHvi017137;
	Mon, 31 Aug 2026 15:08:44 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexxbbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:08:44 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VF8fw427001582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 15:08:41 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 992B25805E;
	Mon, 31 Aug 2026 15:08:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41E3B58051;
	Mon, 31 Aug 2026 15:08:37 +0000 (GMT)
Received: from 192.168.1.50 (unknown [9.67.102.143])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 15:08:37 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v6 09/15] ibmveth: Harden RX poll path with helpers
Date: Mon, 31 Aug 2026 08:07:20 -0700
Message-Id: <2c0302ff17e945a742d0f0b79265ee556e3bf66a.1788102125.git.mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a9598fd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=ZnO335mD0f2ZzhB7t6kA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfXwC4mJwdLiT2W
 CX0QwraRI3hcqEMhg/FRwLMHTNr6OwPBubIrjrGF69ZhdaQ1WYLr6Z5mtFV6LZENKesUUnuA6a8
 TxTZ8nBBe0AH7L5dCLB+N6cI7qJ4qx4=
X-Proofpoint-ORIG-GUID: 7-nf8Y2BmWiZFPMEgcX2m76aR0QqA7yG
X-Proofpoint-GUID: GN_2_UZQ3_PktTedT9GUFrJ_j7AMWv7p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX4keKL+qDqFpm
 Kua+hWeoHt71XRkJVSwuKfNwN7co7HmehgltJ9fWK8vvZqO7WNtncy9UMIZ2tlL+U4d2lxIq9wV
 vYrsJLJpcv/fVh7WfRDzn7bo+WQg1YPsaNrduvIGu3zOIhIvxxL0AFod7dYtXmSh6wUuJYrj4Uf
 uZrQpF8S16+ueAD86gWwb7fAXgS59r/zTvLbjhTGRltH5FUvE37BzLzcphukLBFkXBzB/HFloc8
 4b/q/PjVm3yUF5aKqwcxv4wTnujm0ytpmwLYWdygrBW3T29sKbqA60aHxgBL35HOCFswe7ThkNi
 /sadDy24+k7i14zlIbMKh91mUOKF5BCrpImcGNHJQal0wo6c7qOKQvtLMVycGxPAFRWX5qVoJZs
 /AvETqCq5/z4O9gNlWw98sIdkNPXdlLRmlvqxB/guQwaJwog8HE+Q9hg9Bf3pfJx9wT4HrlXuhK
 gwhPna9t7E0f3HRyueg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310130

ibmveth_poll() must handle several distinct skip/fail outcomes on each
RX slot, not only the happy path:

  - interface close / napi_disable must not re-arm PHYP delivery
  - bad correlators and harvest errors must not look like successful GRO
  - oversize or wrap-around offset+length must not skb_put() past the
    buffer
  - an out-of-range queue index must napi_complete_done rather than
    fall through and keep polling

Doing all of that inline turns the NAPI callback into a deeply nested
switchyard. Split each outcome into a small helper so ibmveth_poll()
stays a thin budget loop:

  ibmveth_poll_stopping()
  ibmveth_poll_harvest_slot() / recycle_invalid / skip_bad_correlator
  ibmveth_poll_drop_oversize()
  ibmveth_poll_deliver_frame()
  ibmveth_poll_bump_invalid()

Not pure motion: ibmveth_poll_bump_invalid() also counts oversize
frames and skipped slots (intentional). skip_bad_correlator escalates
a valid correlator with a NULL skb (-EFAULT) to reset, not only an
out-of-range correlator. Deliver also rejects a PHYP offset+length
that would skb_put() past the buffer. Skipped and dropped slots do not
count against the NAPI budget; only a delivered frame does.

Two further behaviour changes come with the split. On the rx_copybreak
path a harvest failure, after the frame has already been copied into
new_skb, used to break out of the loop and leak that skb;
deliver_frame() kfree_skb()s it before returning an error. And mss
becomes a local of deliver_frame() rather than living across
ibmveth_poll()'s whole budget loop; it was never read stale, because
ibmveth_rx_mss_helper() only uses it under lrg_pkt, so that part is
scoping hygiene and not a fix.

Drop schedule_work from rxq_get_buffer() (skip_bad_correlator owns
reset escalation). ibmveth_poll_stopping() ensures close/napi_disable
does not re-arm PHYP. Runtime is still single-queue: helpers are defined
and called from the existing SQ poll path in this same patch (first
use). The next patch turns on MQ and reuses this loop; subordinate
register helpers stay there.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v6:
- read the IPv4 header check through skb->data, as mainline does.
  v5 used ip_hdr(), which reads the network header offset that
  eth_type_trans() does not set on this path
- do not complete NAPI or consume budget when budget is 0. That is
  the netpoll case, where v5 completed and returned budget - 1,
  underflowing to -1
- noted: the split is not pure motion; the body lists what changed

Changes in v5:
- Wrap poll_stopping return after complete so it stays under 80 cols
- On poll_stopping after the budget loop: return < budget after
  napi_complete_done (was frames_processed-1 even when under budget)
- New in v5: peel SQ poll harden + helpers before MQ enable so tip P10
  stays bring-up focused (mailed v4 09/14 MQ enable -> tip P10; also
  14->15). Kitchen-sink / enable-path poll fixes land here on the live
  single-queue path first.
- After napi_complete_done, check poll_stopping again before enable_irq
  (avoid re-arm while resize/close waits on napi_disable)

 drivers/net/ethernet/ibm/ibmveth.c | 289 ++++++++++++++++++++---------
 1 file changed, 199 insertions(+), 90 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 46f68f5b52e7..f726d1e3f0b1 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1374,10 +1374,8 @@ ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter,
 	unsigned int pool = correlator >> 32;
 	unsigned int index = correlator & 0xffffffffUL;
 
-	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator)) {
-		schedule_work(&adapter->work);
+	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator))
 		return NULL;
-	}
 
 	return adapter->rx_buff_pool[queue_index][pool].skbuff[index];
 }
@@ -2382,125 +2380,236 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 	}
 }
 
+static void ibmveth_poll_bump_invalid(struct ibmveth_adapter *adapter,
+				      int queue_index)
+{
+	adapter->rx_invalid_buffer++;
+}
+
+static bool ibmveth_poll_stopping(struct net_device *netdev,
+				  struct napi_struct *napi)
+{
+	return !netif_running(netdev) || napi_disable_pending(napi);
+}
+
+static bool ibmveth_poll_harvest_slot(struct ibmveth_adapter *adapter,
+				      int queue_index, bool reuse)
+{
+	int rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, reuse);
+
+	return !rc || rc == -EINVAL || rc == -EFAULT;
+}
+
+static bool ibmveth_poll_recycle_invalid(struct net_device *netdev,
+					 struct ibmveth_adapter *adapter,
+					 int queue_index)
+{
+	netdev_dbg(netdev, "recycling invalid buffer\n");
+	ibmveth_poll_bump_invalid(adapter, queue_index);
+	return ibmveth_poll_harvest_slot(adapter, queue_index, true);
+}
+
+static bool ibmveth_poll_skip_bad_correlator(struct net_device *netdev,
+					     struct ibmveth_adapter *adapter,
+					     int queue_index)
+{
+	if (net_ratelimit())
+		netdev_err(netdev,
+			   "bad correlator on queue %d, skipping slot\n",
+			   queue_index);
+	/* Residual stale slot after resize: recover via reset rather
+	 * than spinning forever. Always escalate; only the log is
+	 * rate-limited.
+	 */
+	schedule_work(&adapter->work);
+	ibmveth_poll_bump_invalid(adapter, queue_index);
+	return ibmveth_poll_harvest_slot(adapter, queue_index, true);
+}
+
+static bool ibmveth_poll_drop_oversize(struct net_device *netdev,
+				       struct ibmveth_adapter *adapter,
+				     int queue_index, unsigned int off,
+				     unsigned int len, unsigned int room)
+{
+	if (net_ratelimit())
+		netdev_err(netdev,
+			   "RX frame %u+%u exceeds buffer %u on queue %d, dropping\n",
+			   off, len, room, queue_index);
+	ibmveth_poll_bump_invalid(adapter, queue_index);
+	return ibmveth_poll_harvest_slot(adapter, queue_index, true);
+}
+
+/**
+ * ibmveth_poll_deliver_frame - Build SKB from one valid RX slot and GRO it
+ * @napi: NAPI context for this RX queue
+ * @adapter: ibmveth adapter
+ * @netdev: net_device for @adapter
+ * @queue_index: RX queue index
+ *
+ * Return: 1 frame delivered, 0 if the slot was skipped cleanly, -1 on error.
+ */
+static int ibmveth_poll_deliver_frame(struct napi_struct *napi,
+				      struct ibmveth_adapter *adapter,
+				      struct net_device *netdev,
+				      int queue_index)
+{
+	struct sk_buff *skb, *new_skb;
+	unsigned int room, off, len;
+	int length, offset, csum_good, lrg_pkt;
+	__sum16 iph_check = 0;
+	u16 mss = 0;
+	int rc;
+
+	length = ibmveth_rxq_frame_length(adapter, queue_index);
+	offset = ibmveth_rxq_frame_offset(adapter, queue_index);
+	csum_good = ibmveth_rxq_csum_good(adapter, queue_index);
+	lrg_pkt = ibmveth_rxq_large_packet(adapter, queue_index);
+
+	skb = ibmveth_rxq_get_buffer(adapter, queue_index);
+	if (unlikely(!skb)) {
+		if (!ibmveth_poll_skip_bad_correlator(netdev, adapter,
+						      queue_index))
+			return -1;
+		return 0;
+	}
+
+	room = skb_tailroom(skb);
+	off = offset;
+	len = length;
+	if (unlikely(off >= room || len > room - off)) {
+		if (!ibmveth_poll_drop_oversize(netdev, adapter, queue_index,
+						off, len, room))
+			return -1;
+		return 0;
+	}
+
+	if (lrg_pkt) {
+		__be64 *rxmss = (__be64 *)(skb->data + 8);
+
+		mss = (u16)be64_to_cpu(*rxmss);
+	}
+
+	new_skb = NULL;
+	if (length < rx_copybreak)
+		new_skb = netdev_alloc_skb(netdev, length);
+
+	if (new_skb) {
+		skb_copy_to_linear_data(new_skb, skb->data + offset, length);
+		if (rx_flush)
+			ibmveth_flush_buffer(skb->data, length + offset);
+		rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, true);
+		if (unlikely(rc)) {
+			kfree_skb(new_skb);
+			return -1;
+		}
+		skb = new_skb;
+	} else {
+		rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, false);
+		if (unlikely(rc))
+			return -1;
+		skb_reserve(skb, offset);
+	}
+
+	skb_put(skb, length);
+	skb->protocol = eth_type_trans(skb, netdev);
+
+	if (skb->protocol == cpu_to_be16(ETH_P_IP))
+		iph_check = ((struct iphdr *)skb->data)->check;
+
+	if ((length > netdev->mtu + ETH_HLEN) || lrg_pkt ||
+	    iph_check == 0xffff) {
+		ibmveth_rx_mss_helper(skb, mss, lrg_pkt);
+		adapter->rx_large_packets++;
+	}
+
+	if (csum_good) {
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		ibmveth_rx_csum_helper(skb, adapter);
+	}
+
+	napi_gro_receive(napi, skb);
+
+	netdev->stats.rx_packets++;
+	netdev->stats.rx_bytes += length;
+
+	return 1;
+}
+
 static int ibmveth_poll(struct napi_struct *napi, int budget)
 {
 	struct net_device *netdev = napi->dev;
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	int frames_processed = 0;
 	int queue_index, rc;
-	u16 mss = 0;
 
 	queue_index = napi - adapter->napi;
 
+	if (WARN_ON(queue_index < 0 ||
+		    queue_index >= adapter->num_rx_queues)) {
+		if (budget)
+			napi_complete_done(napi, 0);
+		return 0;
+	}
+
+	if (ibmveth_poll_stopping(netdev, napi)) {
+		if (budget)
+			napi_complete_done(napi, 0);
+		return 0;
+	}
+
 restart_poll:
 	while (frames_processed < budget) {
+		if (ibmveth_poll_stopping(netdev, napi))
+			break;
+
 		if (!ibmveth_rxq_pending_buffer(adapter, queue_index))
 			break;
 
 		smp_rmb();
 		if (!ibmveth_rxq_buffer_valid(adapter, queue_index)) {
 			wmb(); /* suggested by larson1 */
-			adapter->rx_invalid_buffer++;
-			netdev_dbg(netdev, "recycling invalid buffer\n");
-			rc = ibmveth_rxq_harvest_buffer(adapter,
-							queue_index, true);
-			if (unlikely(rc))
+			if (!ibmveth_poll_recycle_invalid(netdev, adapter,
+							  queue_index))
 				break;
 		} else {
-			struct sk_buff *skb, *new_skb;
-			int length = ibmveth_rxq_frame_length(adapter,
-							      queue_index);
-			int offset = ibmveth_rxq_frame_offset(adapter,
-							      queue_index);
-			int csum_good = ibmveth_rxq_csum_good(adapter,
-							      queue_index);
-			int lrg_pkt = ibmveth_rxq_large_packet(adapter,
-							       queue_index);
-			__sum16 iph_check = 0;
-
-			skb = ibmveth_rxq_get_buffer(adapter, queue_index);
-			if (unlikely(!skb))
+			rc = ibmveth_poll_deliver_frame(napi, adapter, netdev,
+							queue_index);
+			if (rc < 0)
 				break;
-
-			/* if the large packet bit is set in the rx queue
-			 * descriptor, the mss will be written by PHYP eight
-			 * bytes from the start of the rx buffer, which is
-			 * skb->data at this stage
-			 */
-			if (lrg_pkt) {
-				__be64 *rxmss = (__be64 *)(skb->data + 8);
-
-				mss = (u16)be64_to_cpu(*rxmss);
-			}
-
-			new_skb = NULL;
-			if (length < rx_copybreak)
-				new_skb = netdev_alloc_skb(netdev, length);
-
-			if (new_skb) {
-				skb_copy_to_linear_data(new_skb,
-							skb->data + offset,
-							length);
-				if (rx_flush)
-					ibmveth_flush_buffer(skb->data,
-							     length + offset);
-				rc = ibmveth_rxq_harvest_buffer(adapter,
-								queue_index,
-								true);
-				if (unlikely(rc))
-					break;
-				skb = new_skb;
-			} else {
-				rc = ibmveth_rxq_harvest_buffer(adapter,
-								queue_index,
-								false);
-				if (unlikely(rc))
-					break;
-				skb_reserve(skb, offset);
-			}
-
-			skb_put(skb, length);
-			skb->protocol = eth_type_trans(skb, netdev);
-
-			/* PHYP without PLSO support places a -1 in the ip
-			 * checksum for large send frames.
-			 */
-			if (skb->protocol == cpu_to_be16(ETH_P_IP)) {
-				struct iphdr *iph = (struct iphdr *)skb->data;
-
-				iph_check = iph->check;
-			}
-
-			if ((length > netdev->mtu + ETH_HLEN) ||
-			    lrg_pkt || iph_check == 0xffff) {
-				ibmveth_rx_mss_helper(skb, mss, lrg_pkt);
-				adapter->rx_large_packets++;
-			}
-
-			if (csum_good) {
-				skb->ip_summed = CHECKSUM_UNNECESSARY;
-				ibmveth_rx_csum_helper(skb, adapter);
-			}
-
-			napi_gro_receive(napi, skb);	/* send it up */
-
-			netdev->stats.rx_packets++;
-			netdev->stats.rx_bytes += length;
-			frames_processed++;
+			if (rc > 0)
+				frames_processed++;
 		}
 	}
 
 	ibmveth_replenish_task(adapter, queue_index);
 
+	if (ibmveth_poll_stopping(netdev, napi)) {
+		/* budget 0 is netpoll, which must not complete NAPI.
+		 * Otherwise returning budget after completing would ask
+		 * NAPI to reschedule, so cap the return at budget - 1.
+		 */
+		if (budget) {
+			napi_complete_done(napi, frames_processed);
+			return min(frames_processed, budget - 1);
+		}
+		return 0;
+	}
+
 	if (frames_processed == budget)
 		goto out;
 
 	if (!napi_complete_done(napi, frames_processed))
 		goto out;
 
-	/* We think we are done - reenable interrupts,
-	 * then check once more to make sure we are done.
+	/*
+	 * napi_disable() sets DISABLE then waits for this poll. Without a
+	 * second stopping check here, enable_irq() can re-arm PHYP after
+	 * resize already masked the queue; late IRQs then hit the handler
+	 * after num_rx_queues was published lower (lab WARN at interrupt).
 	 */
+	if (ibmveth_poll_stopping(netdev, napi))
+		goto out;
+
 	rc = ibmveth_enable_irq(adapter, queue_index);
 	if (rc) {
 		netdev_err(netdev,
-- 
2.50.1 (Apple Git-155)


