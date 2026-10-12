Return-Path: <linuxppc-dev+bounces-29215-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D74CA9ED1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 05:05:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j355F74N0z2yYY;
	Mon, 12 Oct 2026 16:05:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791781537;
	cv=none; b=Df6DHFMZDkYXm33ffemoMsTXwPUiwFRrAwDXrRHAt/8/3AypQCMHDftyMHbnMVf2IUPJ0Va0US4LEQjSVAVwBt5yIotUckhWPDydEO9FOJGDrOeAOB497fnlcFdzWyIYlhcpaexFGF7FVu7Nfmd3kapsURTAX7z3pYP3tWRtgg+OXpy3VT7vGlN0Jl2JLeBv3SR8jKha9ty//3W9QrMTztkSG8sHNb1utZ3dPRtZN5WAu5OMuF9tbXoxD3XUOVqbFPcLMHQjnuq20RnUKZ3pXZIDN+nMPkgPdYATk/ftk6Q2UJNWD3Fxa4WHmtP/UQkG+6h+W1lX39jFkxGLnpz9GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791781537; c=relaxed/relaxed;
	bh=uexKTy0ooIKi8kGL1luf/iFi3APsAGvvJLrY6Fscpjc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nKT6JTPzY7ftp0VDyVsh4zEJ2JzINWINjJKqhTfiOfFVzMpIKNFsKEJiT8qhxRwppJC6PirSKSvN6zneQXn1YSlc3awLWp9Xr4Fv7MTefXvj7cD1eqTsYBexANqI0b1UC9KRHsbns1rsizW0y19rokfTH62i7C2c1uJxXl5XHQRyv9C1wOXE6dcOOnobxDnTn3PpGf9rWTVKU/LCJcmDwPFHlbuvEsGfKHD4PYGtR/SlvUDWlRaMat/tWuulCNcF9Uo1XIwzzKtPgJWKjTALiLCM/JPXJmNL/92dQz98k8tm9Xh73MPjo4LvawnD0ZeRfltsUsiwF30+KEyagHn9Dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rF3RMKhv; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rF3RMKhv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j355F0Ppqz2xyk
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 16:05:36 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C2F6ik3019270;
	Mon, 12 Oct 2026 05:05:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=uexKTy0ooIKi8kGL1luf/iFi3APsAGvvJLrY6Fscp
	jc=; b=rF3RMKhvix/0cSw2VOzzVtBm5OGE4sXoV932lv+6d3kmkdRPKanzlOerO
	3cBQWp1SBZsry4SXi3l+VL95cNyD7P0Gtps6T0dQUh1T8q10Z0MnpZaIgTBg7vjQ
	CswgEBTPrxFnoRFagDfQLJpiRCIuFamBZPvobqH81Q1uXdT/Bp6o4luOCAfJVF+y
	SN8kd+Ql1c0nSBowszcTShWeWGIViB3cxvy/G11LG/FE7KdlA85YIYapn0HsTlxl
	A4o+jb8Py0zkotBaiIRTuyxUE7t5ffWuecQztKZDjetuecu1Exv3AvQfTjf0+6oJ
	X0LI9dOnjVTIP9p9iGHPDf9tYXafg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv378hf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 05:05:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C251Vd563552;
	Mon, 12 Oct 2026 05:05:26 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vkw80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 05:05:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C55O1818219662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 05:05:24 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62D8558121;
	Mon, 12 Oct 2026 05:05:24 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 710C45811C;
	Mon, 12 Oct 2026 05:05:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.163.79])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 05:05:21 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, horms@kernel.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com
Subject: [PATCH net-next v4 0/9] ibmveth: fix hangs, use-after-frees and netpoll races
Date: Sun, 11 Oct 2026 22:05:09 -0700
Message-Id: <20261012050518.88858-1-mmc@linux.ibm.com>
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
X-Proofpoint-GUID: Ri8p-WSqpXVF45BnrkF2gzwdC8qn3YYL
X-Proofpoint-ORIG-GUID: 0b5a3xLivmCC4A3A8M-l8lsAGGIeVcO8
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6acc6a97 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=4F74owUcrmslnq87WGwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxOCBTYWx0ZWRfX+orb5syerSXX
 3+MJganEjhhOShY773VKy0+IQ2iUfcB08ZNQTUxzqZ1CZHyILWTALpwvb15a5XgedFj3Qkm7V20
 PaQ5fT0YnzuCv+0W7uiExPS4ikG9rRY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxOCBTYWx0ZWRfX2eLm50bA5oUd
 C8x2LO4V0gxRZjzlWWvmPZS9/N+wGOzx94fQlJFDJEjW2aJtxCLOyM/hfpoxol7Z9X5m75JiHMx
 +JDDiWuj4c/a56M2BK07wRthc5Y2bPYM18ehOFnYkNJXTkpJoCOxbT/ItE1XE3yvBjx8sTrPb6a
 UQ2IPvoR5E9kWbyLjWsP29AKY4f7oRqH5/UfIZquzpldVAHixGmcHPvAhT9ipH2tLbR1y4abDFB
 nCEfiM/qYC3gJ2V8x33Qqe3SSqGTFC16ej7oCjaAgn9btShwiTGd85M/bR1ZDEO0zyOrRYQn0lT
 7ob8L71g8Rj/gS4UEtkOZbiib/4/fYr+DfGXjI9AbrdzyVgVzYxgIQ5toM9856gFYb+xbUTe0MM
 Bzi4EBj8HK/8CARY4nvVNG7t4Wv2wmmifz4/tcSzEOcui9JfW44rzVZObLW0q28B4X/S3O1xj7o
 5RerMs5XGfcSzuIv9sA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120018

Hi,

Nine fixes for serious bugs in the ibmveth driver: two hang the
system, four are use-after-frees, one corrupts memory, one lets a
frame from another partition stall or oops the receiver, and one makes
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

  4. Hang or NULL dereference on a bad RX correlator from PHYP: poll
     spun on that slot until RCU stalled, and a correlator naming an
     inactive pool dereferenced NULL. A frame that does not fit its
     buffer was copied past the end. Move past the bad slot and stay
     in poll, and drop a frame that does not fit.
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

  9. Stall or oops from a frame sent by another partition: the RX
     checksum helper passes the IPv4 ihl to ip_fast_csum(), which on
     ppc64 reads up to 16 GiB for ihl 0, and both RX offload helpers
     trust the IP and TCP header lengths. Check the headers before
     use, with KUnit cases.
     Fixes: 9c7e8bc584f5, 7b5967389f5a, 66aa0678efc2

Patches 1-8 were found by AI-assisted review of the ibmveth
multi-queue RX series [1] (the patch 4 frame bound by the Sashiko
review of v2), and patch 9 by the Sashiko review of v3 and the review
that followed it. Landing them first also shrinks that
series, which then only extends this handling per queue.

Testing: the new and extended KUnit cases in patches 4 and 9 fail or
oops on the unfixed driver and pass on qemu pseries (ppc64le). On a
POWER10 LPAR: the v3 suite (netconsole under printk and ping floods,
MTU and buffer pool changes under traffic, a forced open() failure
followed by down and up, unbind/bind under traffic, a forced
register_netdev() failure in probe, ethtool -L with a forced TX
buffer allocation failure, and rapid link down/up and MTU cycles under
a ping flood for patch 8) and, for v4, patch 9 large-send regression
(iperf3 over IPv4 and IPv6 at MTU 1500 and 9000, threaded NAPI and
busy polling; no new drops or InCsumErrors). The forced failures used
test-only module parameters that are not part of this series.

The triggers are rare and there are no field reports, so the series
targets net-next. It is based on net-next d8674294aefe ("Merge
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net"), which
includes the two open() error-path fixes (af0524bf4ce1,
84bec0bf0352). Patch 2 explains how it relates to them. It also
applies cleanly to net. All carry Fixes: tags; I am happy to
repost against net, or add Cc: stable, if you prefer.

Changes in v4:

Patches 1-3 and 5-8 are unchanged.

Patch 4: the poll tail queues the NAPI instead of polling again, so
it cannot race a threaded NAPI under busy polling, and harvest uses
the correlator poll already read (Sashiko review of v3). The message
no longer claims the frame bound protects the offload helpers.

New patch 9: the RX offload helpers' header checks that the review of
v3 patch 4 asked for, as their own patch with their own Fixes: tags
and KUnit cases.

v3: https://lore.kernel.org/netdev/20261009183258.18624-1-mmc@linux.ibm.com/

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

Mingming Cao (9):
  ibmveth: fix netpoll races with RX replenish
  ibmveth: do not close twice after a failed reopen
  ibmveth: disable the reset work before unregister in remove
  ibmveth: step past bad RX correlators instead of spinning or oopsing
  ibmveth: release the pool kobjects when probe fails
  ibmveth: return the error when set_channels cannot add TX queues
  ibmveth: wait for in-flight transmits in ibmveth_close()
  ibmveth: wait for the RX poll to return before freeing the RX queue
  ibmveth: check headers in the RX large send and checksum helpers

 drivers/net/ethernet/ibm/ibmveth.c | 647 +++++++++++++++++++++++++----
 drivers/net/ethernet/ibm/ibmveth.h |   5 +
 2 files changed, 561 insertions(+), 91 deletions(-)


base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
-- 
2.50.1 (Apple Git-155)


