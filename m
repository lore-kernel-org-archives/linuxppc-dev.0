Return-Path: <linuxppc-dev+bounces-29153-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2B1CA601F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 18:33:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1b8y1vvCz3btj;
	Sat, 10 Oct 2026 05:33:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791570818;
	cv=none; b=JVvBB+1f0zgevg53GQEseGdPVQiE/NFuOaLYLh/YJotlDIRL0lgWl1QeGgwlX4tyEI0r7SX2Qia4QE/Ti3C0d9dd3bb0/69eIx9GCKbC3rp1ZpdYkFvK8Z3w87Q8bU1wmeYHqKbAlGiDhTOPjLu219di6+T/JmR4IzH46SdwZVbBL7hJsFQuldBTBi4NgHPaujw70ygiKX9xRuGoWzD3OH6pvC7ZpGEtj1KUG8KNZ7iabifuRueLvggVlnpNYyUmUXCdsLbLC+Itys2YguWso12bxnQHTB5UDNwsl36TVYUgsjnAR4XL7trbTR0bKh7MEgByaARZITBNNw0h4e1FBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791570818; c=relaxed/relaxed;
	bh=RgapHiZQhB+FyBulkgR5Ji7QSU1cb3+YnNv/3b5rlpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UbgcNypVCFuoKHMrQVJQdkJRWk6jR7PihmOvlN4Jov/CUQZ7wUZ1RgcGtf9OPyaDmdU9ZYv6lKHBCD/smspOTGUOt6gg/A/XWCCfNbjScIusv5uNhZWKAz0+0RHwA9gnTBKaM9THeLCeqrTUSddv5CA9WuidviGT35d0F7W+3jATHuk/SdOjm6rw+z7LkMOLb4Z5AF4uJSgeOapHXvr1XfGpTmvbsATArDQt1S3MX9TvikKwB83RBS/z85fnUM2rell+iFBMoxxgfPomgu5oR8pAYygjejgDOw3PiCbpctJypxPNE+wTJ+FrccYwxu1wBCmqhP3pCJAQH3FKq8s93A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FQtg0SCs; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FQtg0SCs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1b8x46gxz3btP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 05:33:37 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699Ha0gE806292;
	Fri, 9 Oct 2026 18:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RgapHiZQhB+FyBulk
	gR5Ji7QSU1cb3+YnNv/3b5rlpQ=; b=FQtg0SCslxhNiaSaEEU/givpJBP9OWFV9
	lf3c0nmOtPG9pt8X9Pdyuz7TjF1IuE+iQgJjiojm1WwHfzdRRRQ2DHUZCHkR4kjC
	TAuZVUITsNyMTrzK4hNt89B20e77kr23dJBjQVOCAZpR88r0P2Kqlm5Yp48f473X
	wYlF7u+auQfS2ls0ufs7wj4t6VtZ/5cYNS+qJVNiYIds0BWksBWs5I96I4vXao92
	tqGQg7QY2qbhpLugCVvV0Yp+AlgczkuEpGoKGFsOBfhustFsnkIDIrUIti5nnxJB
	6q+G/+ASAuuW6ZIFM8JayKJAmq1noAN09ydFHLLNxKfeDzVethvyA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74tdg9g4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 18:33:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699H8aKC4126128;
	Fri, 9 Oct 2026 18:33:17 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3u46fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 18:33:17 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699IXG0S21365472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 18:33:16 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3057958051;
	Fri,  9 Oct 2026 18:33:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBD0E5805A;
	Fri,  9 Oct 2026 18:33:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.110.242])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 18:33:13 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        nnac123@linux.ibm.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        horms@kernel.org, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        jeff@garzik.org
Subject: [PATCH net-next v3 2/8] ibmveth: do not close twice after a failed reopen
Date: Fri,  9 Oct 2026 11:32:52 -0700
Message-Id: <20261009183258.18624-3-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261009183258.18624-1-mmc@linux.ibm.com>
References: <20261009183258.18624-1-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=LqkHWXdc c=1 sm=1 tr=0 ts=6ac9336f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=PY5afY-jqzY7CZaCxLEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX4ERtoPZIx0Ea
 RoBKdjvf3/MKFLd6JobvE/JvFTfkL2imjb7GQuYfffmsuNM/plXZI/7jD4QsshW5e0qfxCGuaV6
 6Az7OR+/WFmdlN8BQzRtwtJagS7awikep6bn5Km+zYMxovDl/XoAv8OdIb00HlcAY4afCKSQfSI
 isLcKMy/LOtMBUOkas0wiFrskQknGd2g+koGAoEYKepwUEPx//CJCjXBRIFokkU71utflonGxTt
 LYGzE91i3jR3/EPA+PKLnpilkO0qVwJV6OSBr0xo3DCJN/kWqu5aY2zGQPH26yY23E+moX4D66C
 OD4Zx1YBT9nYY3YhM7Pvr9WvtAdzmLqY2nJA6eluxoqbqvfCfynaZo9fIFOyD+lhbQJbIMeN3ey
 rWV9h7WLZX+GvaiqmItLdVnTY0cAzHY9MoY63PXK0rYIW7Yevv5WngaG2kD2qet2nk4ZASrDG3c
 g8Y8IvqTug0B83kI1Bw==
X-Proofpoint-GUID: ZLm47XVCNNWmJaiebDStIB4kK4FchIOo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX330OawjP8ET/
 uMH9c3qBPttHq6rY1MLlflNHVOx4jXhnIPG3BZwzlSDieQ4iin3QKnQ5TRws+qucPtiIp/TsGzr
 xfvjQ/o+bWq7bMCzlKPa57xpMB52Csc=
X-Proofpoint-ORIG-GUID: GbWDEmMUf8nt7mstkSoi-QBtL9vutoCW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090072

ibmveth_change_mtu(), veth_pool_store(), ibmveth_set_csum_offload()
and ibmveth_set_tso() call close() and open() directly. If open() fails,
NAPI is left disabled while IFF_UP stays set, so the next close()
(ifdown, unregister or another reconfiguration) calls napi_disable()
again and waits forever with RTNL held. Networking and shutdown
hang; only a reboot recovers. ethtool -L in that state also wakes
queues that have no TX buffer and dereferences NULL in
ibmveth_start_xmit().

Any open() failure on those paths triggers it, for example an
allocation failure on an MTU change to jumbo frames.

Track a successful open in adapter->opened. close() returns early
when it is clear, and set_channels() checks it instead of IFF_UP.

The open() error-path leaks were fixed separately in net by
commit af0524bf4ce1 ("ibmveth: h_free logical LAN on open-fail after
register") and commit 84bec0bf0352 ("ibmveth: fix TX LTB and filter
unwind on open-fail"), which are now in net-next too, so a failed
open() no longer leaves TX buffers or the logical LAN registration
behind for the early return to skip.

Found by AI-assisted review of the ibmveth multi-queue RX series and
confirmed by code inspection. Tested on a POWER10 LPAR with
ibmveth_open() forced to fail by a test-only module parameter (not part
of this patch): 'ip link set dev eth1 mtu 9000' fails, then 'ip link set
dev eth1 down' returns at once and 'ip link set dev eth1 up' recovers
the interface. No kernel selftests cover ibmveth.

Fixes: 860f242eb534 ("[PATCH] ibmveth change buffer pools dynamically")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
Changes in v3:
- commit message: the two open() fixes are now in net-next

Changes in v2:
- commit message: say what a failed open() leaves behind without the
  two net fixes

 drivers/net/ethernet/ibm/ibmveth.c | 24 +++++++++++++++++-------
 drivers/net/ethernet/ibm/ibmveth.h |  2 ++
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 4a5869183be6..4665447997ea 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -739,6 +739,7 @@ static int ibmveth_open(struct net_device *netdev)
 
 	netif_tx_start_all_queues(netdev);
 
+	adapter->opened = true;
 	netdev_dbg(netdev, "open complete\n");
 
 	return 0;
@@ -781,6 +782,14 @@ static int ibmveth_close(struct net_device *netdev)
 	long lpar_rc;
 	int i;
 
+	/* change_mtu, pool sysfs, set_csum and set_tso call close() and
+	 * open() directly. If that open() fails, IFF_UP stays set and
+	 * NAPI is disabled; a second close() would hang in napi_disable().
+	 */
+	if (!adapter->opened)
+		return 0;
+	adapter->opened = false;
+
 	netdev_dbg(netdev, "close starting\n");
 
 	napi_disable(&adapter->napi);
@@ -832,10 +841,10 @@ static int ibmveth_close(struct net_device *netdev)
  *
  * @w: pointer to work_struct embedded in adapter structure
  *
- * Context: This routine acquires rtnl_mutex and disables its NAPI through
- *          ibmveth_close. It can't be called directly in a context that has
- *          already acquired rtnl_mutex or disabled its NAPI, or directly from
- *          a poll routine.
+ * Context: This routine acquires rtnl_mutex and, if the device is open,
+ *          disables its NAPI through ibmveth_close. It can't be called
+ *          directly in a context that has already acquired rtnl_mutex or
+ *          disabled its NAPI, or directly from a poll routine.
  *
  * Return: void
  */
@@ -1129,10 +1138,11 @@ static int ibmveth_set_channels(struct net_device *netdev,
 		     goal = channels->tx_count;
 	int rc, i;
 
-	/* If ndo_open has not been called yet then don't allocate, just set
-	 * desired netdev_queue's and return
+	/* If the device is not open (including a failed close/open with
+	 * IFF_UP still set) then don't allocate, just set desired
+	 * netdev_queue's and return
 	 */
-	if (!(netdev->flags & IFF_UP))
+	if (!adapter->opened)
 		return netif_set_real_num_tx_queues(netdev, goal);
 
 	/* We have IBMVETH_MAX_QUEUES netdev_queue's allocated
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index d87713668ed3..3f2240823f6a 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -172,6 +172,8 @@ struct ibmveth_adapter {
 	int rx_csum;
 	int large_send;
 	bool is_active_trunk;
+	/* Set by a successful ibmveth_open(), cleared by ibmveth_close(). */
+	bool opened;
 	unsigned int rx_buffers_per_hcall;
 
 	u64 fw_ipv6_csum_support;
-- 
2.50.1 (Apple Git-155)


