Return-Path: <linuxppc-dev+bounces-23323-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539B9C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 22:25:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grF2V0pHWz2xd2;
	Thu, 02 Jul 2026 08:25:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782944722;
	cv=none; b=dED2xUIqSkCplkneGz2PNEu4kH3XTH+VfkY6TxNdyJmi4lt67wIOD6f6C2WBeEwlaXmJYPOKGiBy7/e2ZF7zHT7rtIxs3r0p3WEWM0z2HSC9NuUDIpqtwSl4FoFTdjJV8YHmy0YxiGkv13O0s2pRHhdQTpZ2zdd9+mq6rWemqkh0PJWeKu9KitEBuyaZQxRWxOOd3fYhuIZ+1NeQ+rEIdjwtLEdAa1HGqNpaiz3FZV7se1g5CVzDOzqQiiB021q4JentQy5yMrXs71jfX4MXGrN3tie3CT5WULlSW0RDnq9cXBAvwbscVTxu3PM++fI1wgc0aJO2ol/lsvRB0wEc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782944722; c=relaxed/relaxed;
	bh=0fkLdttprbBe77Om5hw+qsoUsI6u6LPA68nv4ZHJj2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UM74bhP/HwvKeCHW3wgJwDUyX0y9bZO2onFPqmC41jzkiYbwJH1OOJKJASEyp1mWrmBmoeBXTxG9bwmzgwfy9BTmgvDc0LjqR0/T1nAaFiheeXK8x0HbiuQFQoAJiZzbKUW3RQNqW5T/Q4Cd3P22gOTIuB2fUNttUfT7zoidk8q5F+sJYJpGLbFofYsh3wwk2M/HLx0Ahns72njw8SIybFLIyWH9RDmPofuKfXhe5jQYPclTbuhFC2EkBW3kSyf3Xd06Jg0qEX0uQY2Heyi81RsaRxKw5KUK556Z9mVgCzLQdSbafSjk37VZgQTyY+Hayy1dBryIeM9K/3xIdgYzhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=c5oAPjwS; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=c5oAPjwS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grF2S53Ksz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 08:25:20 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661LmJhw2088530;
	Wed, 1 Jul 2026 22:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=0fkLdttprbBe77Om5hw+qsoUsI6u
	6LPA68nv4ZHJj2M=; b=c5oAPjwSX3NIfrHctp1h5UCL62LinU9xFnOTU+RAitkX
	JI0LT2NZLQhirjc/EcVVJXIFPo/h4DvbDZipB5reBKj8/Omb1Qzkh3+25gSaqrN4
	HcFE2C1Cq6lIvGDJ+nUr2JveXzYnPx+4dAkR4Gq1qLmXBu42I5SC/FK9kA+niRud
	QaUPnxp+z42jlnJlX1agJIX7gOczlN4KGVE7QG8bb3aAlkoL3NyhnNJNxGEeo900
	voBi6or6kUgdRKiqsnMJbX4P9J2L9HurRxFs8r2leeSmpdG3APnxdBr6Luy3RG3H
	7H3FN/NkSuY0ShRlayh4Z3quw7B3XOQdw5BaSmNF6A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe70ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 22:25:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661MOEBi026051;
	Wed, 1 Jul 2026 22:25:08 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqhk84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 22:25:07 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661MP6KE66650544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 22:25:06 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61EAD58055;
	Wed,  1 Jul 2026 22:25:06 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFE6E58059;
	Wed,  1 Jul 2026 22:25:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.150.53])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 22:25:04 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au
Subject: [PATCH net-next v2 00/15] ibmveth: Add multi-queue RX support
Date: Wed,  1 Jul 2026 15:23:12 -0700
Message-Id: <20260701222327.61325-1-mmc@linux.ibm.com>
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
X-Proofpoint-GUID: 9lO4ofEvRTrPGz0AdSPQFmLxuM_5IJFq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIzOSBTYWx0ZWRfX80mg0i5RU80u
 31Wo0F9JY2jFrmTsyB92fq+hfeUU861KBY4lrxR9X7NQHfT6Tvs1Rw3KpfJp+97UquwfHAju2ov
 DNeH9yMnvWtjaQyk06h7dG8f9p3vWe8=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a4593c5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=W5LMyInF-Pr_ibXwEbYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIzOSBTYWx0ZWRfX7F0+HLtELjt3
 RtdVvNrgGyyuY/FgUF6dSPTBF+Ve4yloBmT9HnOWcWgTTYGczpV0rQHNpG6eVpRjsaRovmGCBU2
 NvX0k6eHXS8aCPlY9dMBzUgMnaEIHG4ujuPkIMVE646pFQznCaCwY1Pkx2i98qA2QqsNYZHgxPD
 bfaSOLXFT7FBpl7BFMijEf7QBxDeRi3ZfDUa0YPus0Jt0YeiAgNQ4K5v8ejhR/WUWDVtdbhN27P
 +3yENow8vnVLYnAjVaxepI2DBPTV1eKmfAWkIaK3cNmXNZNWwE63uTOF78h2HTvwSOr7+nifX9B
 SI3Ijwb7bVRCS1OTFAE1Owkcpr2Rb7Y3obJpeWXD/sc8zlbSVShzRR3qj+nazi0BMDsZfJYalMx
 bHt8AdxdhxdDIsNiJM4l73s9epFCkBIm28diroU6YF7KRwLj1XLSk5Zr0ZEsfWIyXOPwXf2sgez
 /QNXlkrLh9aWhbVI1ZA==
X-Proofpoint-ORIG-GUID: zgsVb830IFifhpKEsqtM7UxwMyoypamQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010239

Hi,

Power11 PHYP firmware adds Virtual Ethernet multi-queue (MQ) RX for
the ibmveth device: multiple logical-LAN RX queues, per-queue buffer
posting, and completion delivery. Guest Linux did not use that
platform support; ibmveth still registered one RX queue even when
PHYP was MQ-capable.

This series adds the ibmveth MQ client. When PHYP advertises the
capability through H_ILLAN_ATTRIBUTES, the driver registers
multiple RX queues, receives on per-queue NAPI, and exposes queue
count through ethtool. Older firmware without the bit is unchanged.
Please apply to net-next.

Background
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
  1. Hypercall definitions and MQ data structures (patches 1-2)
  2. Refactor open/close into helpers - RX, per-queue pools,
     IRQ, TX, PHYP (3-9)
  3. Turn on the MQ datapath at probe/open (10)
  4. Per-queue RX/TX stats and sysfs pool readout (11-12)
  5. Runtime RX queue resize via ethtool -L (13-14)
  6. LPAR stability fix (15)

- Helper patches (3-9) reshape ibmveth_open()/close() into
queue-aware helpers. Runtime behaviour is unchanged through that
block: num_rx_queues stays 1 and multi_queue is false until patch 10.
- Patch 10 is the switch: probe sets multi_queue from firmware, raises
num_rx_queues, registers subordinates, and replenishes every active
queue.
- Patch 15 fixes poll hangs after aggressive ethtool -L cycling and
NAPI/close deadlocks on ip link down.

Testing
Tested on ppc64le PowerVM LPAR with MQ-capable firmware:
* Aggressive ethtool -L cycling (16/1/8/11/1/3/16/8/1) with ping
* MQ path: ethtool -L under iperf3 load, link down/up during traffic
* Legacy firmware (no MQ bit): full open/close/stress on the
  refactored helper path to confirm single-queue behaviour is
  unchanged

Changes in v2
v1 resubmit as 15 patches (Patchwork limit): same code and LPAR testing;
squashed split plus checkpatch fixes in patch 15 only.
v1: https://lore.kernel.org/r/cover.1782758799.git.mmc@linux.ibm.com
Patchwork: https://patchwork.kernel.org/project/netdevbpf/list/?series=1119106

Future work
* IRQ affinity hints for subordinate queue IRQs returned by PHYP
* Summed global no_buffer drop counter across all RX queues in MQ mode

Comments and suggestions on patch split, design, and testing are
welcome.

Mingming Cao <mmc@linux.ibm.com>

Mingming Cao (15):
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

 drivers/net/ethernet/ibm/ibmveth.c | 2350 +++++++++++++++++++++++-----
 drivers/net/ethernet/ibm/ibmveth.h |   25 +-
 2 files changed, 2014 insertions(+), 361 deletions(-)


