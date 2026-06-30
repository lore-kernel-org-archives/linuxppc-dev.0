Return-Path: <linuxppc-dev+bounces-23197-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099FEC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 14:53:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqR3t0D52z2yfS;
	Wed, 01 Jul 2026 00:53:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782831225;
	cv=none; b=iaNTclpzUnuvgwH6/je4vzopxFM+nvH1+uKDoppaFGi3upVMzgcd8z9IcmILVAA7I41wcumG2em2YcrNq8lwVyu/FnOvoBw013BaOsMTZzSYg68rc2E9zj36JPreYsjQ9wujwKAuKt8g/t+PzAHKtkOT9GwwN+Lx9ZrPFbro9OuH77wG5ZrUMBU0XZ/T3POn7Kx2AALY/lTQDTrju7to+e7+1DLQIaIXpkZumT8ShbC08fo+XnkRi1dVFil0ahSu9p+cRRFaTpAn+WmlrF635hYxhpLcd/tm+4piAHS1XDahZEolZSnXKPr5WLloqpuYbdfFP1ZE6hX7U+YbDsCPsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782831225; c=relaxed/relaxed;
	bh=ePbu4lf0CxuGrUrD+boUl0AdVYvqCqZlcSfMiXrD/yY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lNlkVHRz9FB+h4Iexks7KIXK9gkZEfHLWYvYQGDSsmRBy+5t7R2h0X1DgoiBw4+wHdEVApcdvl/FUZNPlnW8gtHE7KREvPhpCECsk4bXPOhAknHEjOJsNrzBDQuXix7IAgYYrByIITDQpbpqvmQQqfHbzWq+grPka0ggsCEN2riQt9krXcEgEuvuIz9muuHljM9CfKDU3BOjV+pqRIvAjctmnA8qhUpn1ALUKoB6JTge29DOInxLRtOJynCaKVwS2jQbgDHOvUwuxMJL6K8y2JI/XGT5inRCpb5Qva5kKqV1pH1waBhAyetZ1NRf+PddoEW33R/jmFN1dYPay5prww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bbku3p7s; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bbku3p7s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqR3r6XfLz2xyk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 00:53:43 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIFRN2288445;
	Tue, 30 Jun 2026 14:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=ePbu4lf0CxuGrUrD+boUl0AdVYvq
	CqZlcSfMiXrD/yY=; b=bbku3p7sv/xCrnCEKcTfg+B2BkwEh8wcyiXmcgy4P+Kv
	Qs/YfYp4DexqZVruWXxJW+B9XyWzX8thb1kjf1NNSrH7a8RX/nIWMgP7DNKmK9Je
	oIwplnPMOJr/3k0kpoc6i1ZRtoSE7N+ei+lwAU9Fc+CP2Mjg5SDHVunB6L3GBFpC
	iNnU8CA9EiMY2OGjM7J3A7n8xqs+L18lIujuDMi13qm/cHl8yQ//mZoLUbMOprYH
	H9gLIEFVJbdssRUZnsEfi4nIFc1XkP6CtNfsEUsQhuhYppFsIUewjTGsjl1hyolZ
	TukUQCOehH8FF14/+7ieoWHv15pF63nt6nGzOExmGQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pdye17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:53:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UEnapa024567;
	Tue, 30 Jun 2026 14:53:33 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gakk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:53:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UErV4B8716870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 14:53:31 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AB1F5805D;
	Tue, 30 Jun 2026 14:53:31 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59E265805C;
	Tue, 30 Jun 2026 14:53:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.117.151])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 14:53:30 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au
Subject: [PATCH v1 00/18] ibmveth: Add multi-queue RX Support
Date: Tue, 30 Jun 2026 07:53:07 -0700
Message-Id: <cover.1782758799.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: tim87rfbqAQ3dHMaUoQQRc69xa8shfEM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX7q2Ty/nOkSis
 tgMkceaDuxuV0oBjMm7/+FNlkxjQdNm14GYc3wlObtlAtud4HF9Z89zwqJ5w3dcs4jyFggiT8aY
 P1kXeUm6wsdLotWDeJIgu2lShNRRJeY=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a43d86e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=1C0YqRXPaoIq7nfLI6kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfXxamQRi10Wj2T
 /B0s9usaJ6HZ13VTPCXj7uVbDlOc8pPAhH7/kpud/1FvV/zeFyVnMioHlO+83me0mroXQ28CbRm
 nDSy/kmVVw5X4Nh4r+IwR2wmdUnZaSc0GRai+YUgbr9+gi1kHWdamsHfimFjo91QDZhNFeBbsWi
 u6EBQBRgTQPWscYPSAp3z/LgT3Tc5yu+vKo/KELS5iankF5AT7oK1CG9I1TIunVUe0FcQwWqGnl
 G3KWkKzwEtbRIIx2O3Cnkdu2qgoKIqMwC9Rj1UXcEXo3C9C42VuhpV1h7nOkSBFxsO3xntSDoWZ
 6thZHijRPzjKOMmcyT5/m/4FCF0ZUD7SxjybX8rojaS1UkOl/opivKr1AEQX/x/CaX2gq7cueds
 LDZH8Cej+9JOF/3U70bWt6dcAZ258N9NNXtmZ48ysuSkMhBc4X8rjKA4Vc7iWSqKZRhE6nLAY5M
 RIYNBxGILLAjUpW2kkg==
X-Proofpoint-ORIG-GUID: 5dQ6Xz5_7S5wOagLl7dJ8k1ymD95PTY_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300139

Power11 PHYP firmware adds Virtual Ethernet multi-queue (MQ) RX for
the ibmveth device: multiple logical-LAN RX queues, per-queue buffer
posting, and completion delivery. Guest Linux did not use that
platform support; ibmveth still registered one RX queue even when
PHYP was MQ-capable.

This series adds the ibmveth MQ client. When PHYP advertises the
capability through H_ILLAN_ATTRIBUTES, the driver registers
multiple RX queues, receives on per-queue NAPI, and exposes queue
count through ethtool. Older firmware without the bit is unchanged.


ibmveth today registers one logical LAN, one set of buffer pools, and
one NAPI context. PHYP MQ mode gives each RX queue its own handle:
buffers are posted with H_ADD_LOGICAL_LAN_BUFFERS_QUEUE, subordinate
queues register through H_REG_LOGICAL_LAN_QUEUE, and traffic can
land on any active queue. Queue selection is firmware-defined; v1
does not program RSS or hash tables. The driver needs per-queue
pools, IRQs, and poll state to match.

Queue-aware hcalls are selected only when probe sets multi_queue
from H_ILLAN_ATTRIBUTES; legacy firmware keeps the original hcall
path unchanged through the entire series.

This splits the work so review follows the actual bring-up sequence:

 1. Hypercall definitions and MQ data structures (patches 1-3)
 2. Refactor open/close into helpers - RX, per-queue pools,
    IRQ, TX, PHYP (4-10)
 3. Turn on the MQ datapath at probe/open (11)
 4. Per-queue RX/TX stats, get_stats64, and sysfs pool readout
    (12-14)
 5. Runtime RX queue resize via ethtool -L (15-17)
 6. Runtime stability fixes from LPAR testing (18)


 - Helper patches (4-10) reshape ibmveth_open()/close() into
queue-aware helpers. Runtime behaviour is unchanged through that
block: num_rx_queues stays 1 and multi_queue is false until patch 11.

- Patch 11 is the switch: probe sets multi_queue from firmware, raises
num_rx_queues, registers subordinates, and replenishes every active
queue.

- Patch 18 fixes poll hangs after aggressive ethtool -L cycling,
NAPI/close deadlocks on ip link down, and preserves probe-time
pool->active across close/open so RX works after link down/up.


Design notes
* Per-queue buffer pools (rx_buff_pool[queue][pool]) - PHYP ties
 posted buffers to a queue handle; a shared pool set does not work.
 Patch 5 also disables the 64 KiB pool at standard MTU to save
 per-queue memory in MQ.
* Legacy mode keeps queue 0 on h_register_logical_lan(); MQ uses
 handles for all queues (subordinates via H_REG_LOGICAL_LAN_QUEUE).
 Close uses H_FREE_LOGICAL_LAN for the whole adapter.
* ethtool -L resizes incrementally while the netdev stays up so
 surviving queues keep PHYP handles, pools, and IRQ state. A
 close/open cycle would drop traffic and force full LAN
 re-registration for every queue.


Tested on ppc64le PowerVM LPAR with MQ-capable firmware:
* MQ path: ethtool -L under iperf3 load, link down/up during traffic
* Legacy firmware (no MQ bit): full open/close/stress on the
 refactored helper path to confirm single-queue behaviour is
 unchanged
* ethtool -L resize while all RX queues are receiving traffic, not
 only a single-flow iperf session
* ip link down/up and ping after reopen (patch 18)


Future work
* IRQ affinity hints for subordinate queue IRQs returned by PHYP
* Summed global no_buffer drop counter across all RX queues in MQ mode
Comments and suggestions on patch split, design, and testing are
welcome.

Mingming Cao <mmc@linux.ibm.com>

Mingming Cao (18):
  ibmveth: Add MQ RX hypercall wrappers and call definitions
  ibmveth: Prepare adapter data structures for MQ RX
  ibmveth: Add MQ-ready RX statistics structures
  ibmveth: Refactor RX resource allocation for MQ RX bring-up
  ibmveth: Refactor buffer pool management for per-queue MQ RX
  ibmveth: Refactor RX interrupt control for MQ RX queues
  ibmveth: Refactor TX resource allocation in open/close paths
  ibmveth: Add RX queue register/deregister helpers for MQ
  ibmveth: Refactor open/close into MQ-ready resource pipeline
  ibmveth: Add queue-aware RX buffer submit helper for MQ
  ibmveth: Enable multi-queue RX receive path
  ibmveth: Add per-queue RX statistics collection and reporting
  ibmveth: Add per-queue TX statistics reporting
  ibmveth: Expose per-queue buffer pool details via sysfs
  ibmveth: Add helpers for incremental MQ RX queue resize
  ibmveth: Implement incremental MQ RX queue resize
  ibmveth: Wire ethtool set_channels to MQ RX queue resize
  ibmveth: Fix MQ RX poll and shutdown hangs after queue resize

 arch/powerpc/include/asm/hvcall.h  |    6 +-
 drivers/net/ethernet/ibm/ibmveth.c | 2451 +++++++++++++++++++++++-----
 drivers/net/ethernet/ibm/ibmveth.h |  226 ++-
 3 files changed, 2284 insertions(+), 399 deletions(-)

-- 
2.39.3 (Apple Git-146)


