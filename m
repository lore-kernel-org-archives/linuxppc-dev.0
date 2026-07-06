Return-Path: <linuxppc-dev+bounces-23648-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF80C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 19:36:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvF3K5hltz2yVZ;
	Tue, 07 Jul 2026 05:36:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783366589;
	cv=none; b=n70RUaVvV/ba7orQ3XYfwInUgediyUkaFErD68KR49HUUwybCKhQdGxVp1a8FX544PyXdBc5oaqjdqPF3soIyFeilfnagrtyM+s2cqATx0Uywvgv96WZ7kMyhYrNptWYBcMXoUALJXoIGty1vz8VNlSmAQV56SAcmmxtbA+v/ooZdMXa7Ueovn+URnVabASndEsZGiCkBIfXDbCFOlneqoXc7lktQfSi/IpjpNeoglnFv0XdHLBDJSezGbrT8puPFAOC1azWazA264PK9Z8sN7XsvDHRtlqIG9L/5cWlTIwvzDIzMSijy7rWDyP9QKTnsDa5CD0E9m8e27qyxxDkZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783366589; c=relaxed/relaxed;
	bh=fmYxoG7bBR6Y15f0kHgtZIjEYDR5x4dK8RpPpcOSZb4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ToSVVn7FSUvbKF9xLGEwRLs3a3MHxLkfzH22/dps36HvKInQhQr+Y7kAaHXHCnX396NBROVyTFtGEGes6hgyGLQxjwelfuouf08cBTUy4J9+PeKLPApID7YsPqPJpViALT9Yz/GI03vMrcF7n3uoq29hpfyc5zNCohxQHaActglpajNFmmUaKiYcwV7jvjaW1FGaUWJBqOi8cBObgzBixkZPIZFbCY2b218/Di34U9QF1h5K7D82Dac7AaUjpfntYWfEKO1o0RLtJLLpcm2poovc1DItiwKLTT37ZNH51HuFDimi8qPjIgWUB/4RGYkGXhLoRSC9gaCzvlvZXfhHzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PKfn2+L4; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PKfn2+L4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvF3J5jd2z2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 05:36:28 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FIE7J611241;
	Mon, 6 Jul 2026 19:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=fmYxoG7bBR6Y15f0kHgtZIjEYDR5
	x4dK8RpPpcOSZb4=; b=PKfn2+L4ZDhhFSPZ88wdxtuX5CtfTBCGUkWgNcZFUNsc
	UhF7y6p0CcBGbgdEKc4umRXqB6ACtE6AxuHN3g3ObYBDzqO8beD97lnH/Cb9shhA
	eqrLP+T/ajZZrS8l9+kdhODoG6IIg6Q+GJHHDLHaA+UN/9FaIDIY1mF7hnNYbv4B
	o66CPbyY0uowERmSE4splWCTkM8AkUpuWhbJTwae/HaPLpPcIuhgI1s7+6LWiJzB
	zabCZALsv9IWnJCJfRqd+jHvbjJ4ellq/pV058kLlJRs3AnvBXaGfeOQZp2Wy/xy
	ZrJ6XYd1WlrPISib0hQ3ekRWiZYu0M/iHG8keJC2BA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3k596-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:36:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666JYbAb018729;
	Mon, 6 Jul 2026 19:36:16 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h6uyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:36:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666JaFx32163264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 19:36:15 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30A555805A;
	Mon,  6 Jul 2026 19:36:15 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B77558051;
	Mon,  6 Jul 2026 19:36:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.26.177])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 19:36:13 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au
Subject: [PATCH net-next v3 00/15] ibmveth: Add multi-queue RX support
Date: Mon,  6 Jul 2026 12:35:48 -0700
Message-Id: <20260706193603.8039-1-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4c03b2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=W5LMyInF-Pr_ibXwEbYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfXxeBOgtbB7rkQ
 J5w157WZa6uLrCXCYKbLsj510QomqPENRJMLgGPrMkufEx+o0xDFGwUfSFxih+BwM9+bwVl6/1i
 qZMxCwVW2oOLC+tqXldPYBMxebnYBZk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfX/2yDxzQ8OKq4
 UK/x7NVekyDILpFeOW/mA7tpN9NhEPkFtqKu7+4mgUY+OJqC1c4vyGE9ErlBKmYKHfcH2w9XUgR
 stFr2aYyIBXz+RQx60D5XkPtWomu8tzK4E/0gIEem91jvtJ6iTwpVvYnRmphz4B/F9/ZmqGWdLu
 iednVMQgkgb9IRUjkvvWWS/DX5lURbdfD8oAV4vcP73xCplGhnCoB+K3gWZgIfJtzv337CypFsC
 8pjZ1KJ4Rz57btfa3YIyxTYdZbYjqKi7XVB6HAQsPfdsdsPMRqTn/Qvta5Krd6XIq9Pth8bCE2T
 2uZlfQxSYQlVnbYV5cYeSiUhLqEPX04WlrvG38wnggWIH7goEud0ZzmJE7ZBXgXv5sZkZ/GRlHK
 HbXSYhWow46LZdKZXBy5Ys9sV9iF/fLwpe9TI1EfnYrK/gptyCFbh7Mvy0OygMCFm8Kg0e1pkKX
 7+yc7myBeUOi+GuIokw==
X-Proofpoint-ORIG-GUID: 393L4oTKwJMAD1oMnG438WFF6E9hfYCh
X-Proofpoint-GUID: wvUI-ZUNqd50VhKQ-K7cFrmcZCt5Zwir
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060195

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

Changes in v3
v2 resubmit with complete patch series: v2 accidentally omitted patches
1-2 (hypercall definitions and MQ structures). This v3 includes all 15
patches in correct order. No code changes from v2; same LPAR testing
results. v2: https://lore.kernel.org/r/20260701222327.61325-1-mmc@linux.ibm.com

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
  ibmveth: Add MQ RX hypercall wrappers and call definitions
  ibmveth: Prepare MQ RX adapter and statistics structures
  ibmveth: Refactor RX resource allocation for MQ RX bring-up
  ibmveth: Refactor buffer pool management for per-queue MQ RX
  ibmveth: Refactor RX interrupt control for MQ RX queues
  ibmveth: Refactor TX resource allocation in open/close paths
  ibmveth: Add RX queue register/deregister helpers for MQ
  ibmveth: Refactor open/close into MQ-ready resource pipeline
  ibmveth: Add queue-aware RX buffer submit helper for MQ
  ibmveth: Enable multi-queue RX receive path
  ibmveth: Add per-queue RX and TX statistics collection and reporting
  ibmveth: Expose per-queue buffer pool details via sysfs
  ibmveth: Implement incremental MQ RX queue resize
  ibmveth: Wire ethtool set_channels to MQ RX queue resize
  ibmveth: Fix MQ RX poll and shutdown hangs after queue resize

 arch/powerpc/include/asm/hvcall.h  |    6 +-
 drivers/net/ethernet/ibm/ibmveth.c | 2452 +++++++++++++++++++++++-----
 drivers/net/ethernet/ibm/ibmveth.h |  226 ++-
 3 files changed, 2285 insertions(+), 399 deletions(-)

--
2.39.3 (Apple Git-146)

# Made with Bob

