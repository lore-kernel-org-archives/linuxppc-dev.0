Return-Path: <SRS0=ZqAX=PD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC13C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 22:52:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0AEC21741
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 22:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQXyhyyL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0AEC21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Q7Xd3PwTzDqHn
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 09:52:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZQXyhyyL";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZQXyhyyL"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Q7B15PlyzDqKw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Dec 2018 09:36:41 +1100 (AEDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5C2A1218EA;
 Wed, 26 Dec 2018 22:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545863800;
 bh=AKAwVgYCWrmn0jf2dUo/OJhNSsq6Dn+dFmMe6MvOsC0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZQXyhyyLRsd6/9jvYSHpVCE0iXmoDxoRPnWjkP0AxZy0gScUe2DmfbaokmLlE2/XV
 tJ3ddN8ZS/WIgIF4LxCDcT8vsh+ZV/0E9+OCPdqTfZbptBdZDJtk7bT0S4EiMvo/1b
 8u0CTwpyvILrmzLXGusKb0doUW7qC2Yu06n4b6tI=
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 27/97] ibmvnic: Fix non-atomic memory allocation
 in IRQ context
Date: Wed, 26 Dec 2018 17:34:47 -0500
Message-Id: <20181226223557.149329-27-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
 Thomas Falcon <tlfalcon@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Thomas Falcon <tlfalcon@linux.ibm.com>

[ Upstream commit 1d1bbc37f89b0559c9e913682f2489d89cfde6b8 ]

ibmvnic_reset allocated new reset work item objects in a non-atomic
context. This can be called from a tasklet, generating the output below.
Allocate work items with the GFP_ATOMIC flag instead.

BUG: sleeping function called from invalid context at mm/slab.h:421
in_atomic(): 1, irqs_disabled(): 1, pid: 93, name: kworker/0:2
INFO: lockdep is turned off.
irq event stamp: 66049
hardirqs last  enabled at (66048): [<c000000000122468>] tasklet_action_common.isra.12+0x78/0x1c0
hardirqs last disabled at (66049): [<c000000000befce8>] _raw_spin_lock_irqsave+0x48/0xf0
softirqs last  enabled at (66044): [<c000000000a8ac78>] dev_deactivate_queue.constprop.28+0xc8/0x160
softirqs last disabled at (66045): [<c0000000000306e0>] call_do_softirq+0x14/0x24
CPU: 0 PID: 93 Comm: kworker/0:2 Kdump: loaded Not tainted 4.20.0-rc6-00001-g1b50a8f03706 #7
Workqueue: events linkwatch_event
Call Trace:
[c0000003fffe7ae0] [c000000000bc83e4] dump_stack+0xe8/0x164 (unreliable)
[c0000003fffe7b30] [c00000000015ba0c] ___might_sleep+0x2dc/0x320
[c0000003fffe7bb0] [c000000000391514] kmem_cache_alloc_trace+0x3e4/0x440
[c0000003fffe7c30] [d000000005b2309c] ibmvnic_reset+0x16c/0x360 [ibmvnic]
[c0000003fffe7cc0] [d000000005b29834] ibmvnic_tasklet+0x1054/0x2010 [ibmvnic]
[c0000003fffe7e00] [c0000000001224c8] tasklet_action_common.isra.12+0xd8/0x1c0
[c0000003fffe7e60] [c000000000bf1238] __do_softirq+0x1a8/0x64c
[c0000003fffe7f90] [c0000000000306e0] call_do_softirq+0x14/0x24
[c0000003f3967980] [c00000000001ba50] do_softirq_own_stack+0x60/0xb0
[c0000003f39679c0] [c0000000001218a8] do_softirq+0xa8/0x100
[c0000003f39679f0] [c000000000121a74] __local_bh_enable_ip+0x174/0x180
[c0000003f3967a60] [c000000000bf003c] _raw_spin_unlock_bh+0x5c/0x80
[c0000003f3967a90] [c000000000a8ac78] dev_deactivate_queue.constprop.28+0xc8/0x160
[c0000003f3967ad0] [c000000000a8c8b0] dev_deactivate_many+0xd0/0x520
[c0000003f3967b70] [c000000000a8cd40] dev_deactivate+0x40/0x60
[c0000003f3967ba0] [c000000000a5e0c4] linkwatch_do_dev+0x74/0xd0
[c0000003f3967bd0] [c000000000a5e694] __linkwatch_run_queue+0x1a4/0x1f0
[c0000003f3967c30] [c000000000a5e728] linkwatch_event+0x48/0x60
[c0000003f3967c50] [c0000000001444e8] process_one_work+0x238/0x710
[c0000003f3967d20] [c000000000144a48] worker_thread+0x88/0x4e0
[c0000003f3967db0] [c00000000014e3a8] kthread+0x178/0x1c0
[c0000003f3967e20] [c00000000000bfd0] ret_from_kernel_thread+0x5c/0x6c

Signed-off-by: Thomas Falcon <tlfalcon@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 5058bd83bdd6..c8704b1690eb 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2055,7 +2055,7 @@ static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
 		}
 	}
 
-	rwi = kzalloc(sizeof(*rwi), GFP_KERNEL);
+	rwi = kzalloc(sizeof(*rwi), GFP_ATOMIC);
 	if (!rwi) {
 		spin_unlock_irqrestore(&adapter->rwi_lock, flags);
 		ibmvnic_close(netdev);
-- 
2.19.1

