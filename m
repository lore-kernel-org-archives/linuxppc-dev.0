Return-Path: <linuxppc-dev+bounces-29151-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08FFCA601F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 18:33:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1b8n2Fsqz3bSw;
	Sat, 10 Oct 2026 05:33:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791570809;
	cv=none; b=gngKrJiLerHRm3Y8fyQhqjo0KHHmWwbWsTAsXSWTDp1l6jisQa50YuwmLGSXhzBQ82dUu5uC0nGPPbFIHjM/9fTiCL+ltnuSXAPToy6PXB/s/oYda41OTbXQtQavAv6crT4Ta1nrWrnnOKAioonlZ3fpSP74bqIWxfUmWpd0yu79tnC+8s0NtZQmSQLQZPZZ5avG7f4dwkJZI8mnbSfc37AndlVhSdA93cu0NXoSj9WRe2kTdM3M0Jj2PrIjOeceWlwAFLVpLk2MHfT1sBjo8aWH/F0NNOUSbfZCktJMCEAuP6kyV34Db9sJAozbgigLDDgysHI6XWSbHguViyOfcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791570809; c=relaxed/relaxed;
	bh=ChKJeJxDq4YS458jTya3SdzWhwFomBP9jCGhHd5j/9E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FyVS1c0Ij55g4Az32HZ3KYpN/S67/EydOv7CKj3OddmnSBsDDg2y7yB18F6F3hcyZwfmA3naVhxfgKWjZ0d8prEnKnO1qVFJfHiV2CHe6QqY4vzaJPNERB4hewf14eTmDDjflcG5ayQ9MOfTtCwl1oGLE/hw6fyEbNqRHjJ+nmNlYpJe15uRCgaxtnklPwWmqCU4wmyobdeEP8dQ1nnjhAQgbIB/XAKjB83lNZAqD5AWEItMbKU08/ulQjXFFrqNM/aGfyk8h4ggPq0fC4miD6u2NFE7XEynUrMU8HpVbnYyj5qzhhKBl7lZEcDjVI//kO0SI6uCT2ap59LW07R/Yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KLoiAR1y; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KLoiAR1y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1b8m05THz3bSn
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 05:33:26 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699Ha2l93128463;
	Fri, 9 Oct 2026 18:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ChKJeJxDq4YS458jTya3SdzWhwFomBP9jCGhHd5j/
	9E=; b=KLoiAR1yoOMCxIeSm2iQW+L83pUpg9aHhydfOfvny477unTWuzMSoSBJ4
	SNtm1v9pOLntitmjH1jt+ogCoQWPg+N6YTl4Yr7Ix2+u6812IY6s3b4p7/fFrBHB
	WC1Fr9TFASOilYAcCImTuOJXvGn+vhj3Ly9iV/Pk+SLa7NixlU9wUuQthy3kuU1k
	MUOg0WwuTv0GXFXO4cGnBD4BCojhULmqwOD1PwyjSX9sBGzovo6LEFs+50WA790N
	vXGZ7CYOE8mvsx3MZRcrB5h3YMsYSY1clVCZPgO7jGybfNbgpqNGX+HVvW3d48xa
	aKQrwFOmsbAtDoXo6KZorduUjV7CA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74tcg99q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 18:33:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699H8I3k1206706;
	Fri, 9 Oct 2026 18:33:09 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsnm8de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 18:33:09 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699IX7FJ21496550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 18:33:07 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E8385805C;
	Fri,  9 Oct 2026 18:33:07 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE2A358051;
	Fri,  9 Oct 2026 18:33:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.110.242])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 18:33:04 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        nnac123@linux.ibm.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        horms@kernel.org, davemarq@linux.ibm.com, bjking1@linux.ibm.com
Subject: [PATCH net-next v3 0/8] ibmveth: fix hangs, use-after-frees and netpoll races
Date: Fri,  9 Oct 2026 11:32:50 -0700
Message-Id: <20261009183258.18624-1-mmc@linux.ibm.com>
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX1HIp8B5HWztw
 f7Ru7Q7HMmkaLCwwGbWi89eyikjpwLisGrXV+cTTSOlp2ai1ioHXQiKqcFsf6PdjFQK5gq6v38u
 aiYdjKPPFidHEYBepL/zHH01aH+uBoubzgaQqMhVS1Hnutnn6bxZM9mTowlYrg7QY1jw3h0S+aU
 LbqcjUC2wzOnOex5cFxo6abGINlBNOf6DkWsldhtlhqHQg//KclzC5TMzV8MEIbCUZVYaSHRZkV
 gJfX+T1OEXbdIS/BeqKuMNgN1oLVEKXRfYp/ctmDZHKbtPRa7kMddwtcCAwf4w4dKS+er/YUy5c
 LssuogqpccN2FtWGrn9Dth5eMCvyMS0f5o4jVb2Lctknii89CVICbJV4LTKCBoZSPF/VpUKfHlm
 3sPyuiL/UxhLy+reYncIPfq4A+z/U/R2t7ZOxyz8w+fAnQ26+A1b2OlRUavco/HMICkdVCj681E
 UzStGblDyXjuJZPCOPg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX+tHK4YNrzWYR
 Os9UAHIil6TsGlDhN4b4km7cRkvsxARNyVEjltDJMDydQSUPilg1RpA33jV4LXjTgbJ+gug+TBm
 xqVZUvVSs02xEBRAFKaLTAkT16gHWxY=
X-Proofpoint-GUID: U-hyIDaSsw9xRkly0VexmlXDDZz057La
X-Proofpoint-ORIG-GUID: MKj_hNCp3txWYL3jS70cJ02sXmWsRgT3
X-Authority-Analysis: v=2.4 cv=Yu+a1IYX c=1 sm=1 tr=0 ts=6ac93367 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=rYr2VNrAWewxvVPv618A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090072

Hi,

Eight fixes for serious bugs in the ibmveth driver: two hang the
system, four are use-after-frees, one corrupts memory, and one makes
ethtool -L report success when it failed.

  1. Netpoll races with RX replenish (memory corruption, NULL
     dereference): remove ndo_poll_controller, as was done for
     ibmvnic, skip RX replenish in netpoll's budget-0 poll, and
     enable NAPI only once the RX resources exist.
     Fixes: 6b4223748895, bea3348eef27

  2. Hang after a failed internal reopen: the next close() waits in
     napi_disable() forever with RTNL held, and only a reboot
     recovers. Skip close() when open() did not succeed.
     Fixes: 860f242eb534

  3. Use-after-free in remove(): a reset queued from NAPI could run
     on the freed adapter. Disable the reset work first.
     Fixes: 2c91e2319ed9

  4. Fixes the RX poll when the correlator is bad. Poll spun on that
     slot until RCU stalled, and an inactive pool dereferenced NULL.
     Skipping the slot and then leaving poll could also queue the
     napi twice. A frame that does not fit its buffer was copied
     past the end. Move past the bad slot and stay in poll, and
     drop a frame that does not fit.
     Fixes: 2c91e2319ed9, 860f242eb534

  5. Use-after-free after a failed probe: the pool kobjects stay in
     sysfs after the adapter is freed. Put them, as remove() does,
     and give them a release() that probe and remove() wait for, so
     CONFIG_DEBUG_KOBJECT_RELEASE cannot free them early either.
     Fixes: 860f242eb534

  6. ethtool -L returns 0 when it cannot allocate the new TX queues.
     Return the allocation error.
     Fixes: 10c2aba89cc0

  7. Use-after-free of TX buffers: close() frees them without
     waiting for a running transmit. It is called directly for MTU,
     offload and buffer pool changes, and through dev_close(), which
     does not wait either with a noqueue qdisc. Use
     netif_tx_disable().
     Fixes: d6832ca48d8a

  8. Use-after-free of the RX queue: napi_disable() returns before
     the poll has finished, and the rest of the poll re-enables the
     interrupt and reads the RX queue that close() then frees. Wait
     with synchronize_net().
     Fixes: bea3348eef27

All were found by AI-assisted review of the ibmveth multi-queue
RX series [1]. Landing them first also shrinks that series, which
then only extends this handling per queue.

Testing: the new and extended KUnit cases in patch 4 fail on the
unfixed driver and pass on qemu pseries (ppc64le). On a POWER10
LPAR: netconsole under printk and ping floods, MTU and buffer pool
changes under traffic, a forced open() failure followed by down and
up, unbind/bind under traffic, a forced register_netdev() failure in
probe, ethtool -L with a forced TX buffer allocation failure, and
rapid link down/up and MTU cycles under a ping flood for patch 8.
The forced failures used test-only module parameters that are not
part of this series.

The triggers are rare and there are no field reports, so the series
targets net-next. It is based on net-next d8674294aefe ("Merge
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net"), which
includes the two open() error-path fixes (af0524bf4ce1,
84bec0bf0352). Patch 2 explains how it relates to them. It also
applies cleanly to net. All carry Fixes: tags; I am happy to
repost against net, or add Cc: stable, if you prefer.

Changes in v3:

From the Sashiko review of v2:
- Patch 4: on a bad RX slot, stay in the poll loop and return
  budget - 1 after napi_schedule() has queued the napi. Breaking
  out was queuing it twice.
- Patch 4: drop a frame that does not fit its buffer, instead of
  copying past the end.
- Patch 4: also drop a frame shorter than an Ethernet header, and
  take the pool for the buffer bound from the correlator that was
  validated, read once.
- Patch 2: commit message: the two open() fixes are now in net-next.

v2: https://lore.kernel.org/netdev/cover.1791178212.git.mmc@linux.ibm.com/

Changes in v2:

From the Sashiko review of v1:
- Patch 5: give the pool kobjects a release() and wait for it before
  free_netdev() in probe and remove(), which closes the
  CONFIG_DEBUG_KOBJECT_RELEASE window.
- New patch 8: wait for the poll to return before close() frees the
  RX queue (raised on patch 1 as a pre-existing bug).

Other small changes:
- Patch 1: also skip RX replenish in netpoll's budget-0 poll.
- Patch 4: count rx_dropped when recycling an invalid buffer fails.
- Commit messages: say how each bug was found and tested, with small
  clarifications in patches 2 and 7.

Rebased on current net-next.

v1: https://lore.kernel.org/netdev/cover.1790991039.git.mmc@linux.ibm.com/

[1] https://lore.kernel.org/netdev/cover.1790319558.git.mmc@linux.ibm.com/

Thanks,
Mingming

Mingming Cao (8):
  ibmveth: fix netpoll races with RX replenish
  ibmveth: do not close twice after a failed reopen
  ibmveth: disable the reset work before unregister in remove
  ibmveth: step past bad RX correlators instead of spinning or oopsing
  ibmveth: release the pool kobjects when probe fails
  ibmveth: return the error when set_channels cannot add TX queues
  ibmveth: wait for in-flight transmits in ibmveth_close()
  ibmveth: wait for the RX poll to return before freeing the RX queue

 drivers/net/ethernet/ibm/ibmveth.c | 364 +++++++++++++++++++++++------
 drivers/net/ethernet/ibm/ibmveth.h |   5 +
 2 files changed, 296 insertions(+), 73 deletions(-)


base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
-- 
2.50.1 (Apple Git-155)


