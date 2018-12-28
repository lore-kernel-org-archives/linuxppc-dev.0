Return-Path: <SRS0=XWqB=PF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A688C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Dec 2018 00:33:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D00DF2148E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Dec 2018 00:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00DF2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Qnjj5X6XzDqDm
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Dec 2018 11:32:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43QndS5MvJzDqHK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2018 11:29:16 +1100 (AEDT)
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
 (helo=home.buserror.net)
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1gcg1X-000880-GI; Thu, 27 Dec 2018 18:29:12 -0600
Date: Thu, 27 Dec 2018 18:29:09 -0600
From: Scott Wood <oss@buserror.net>
To: Madalin Bucur <madalin.bucur@nxp.com>
Message-ID: <20181228002909.GA24228@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: madalin.bucur@nxp.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: [PATCH] fsl/fman: Use GFP_ATOMIC in
 {memac,tgec}_add_hash_mac_address()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
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
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

These functions are called from atomic context:

[    9.150239] BUG: sleeping function called from invalid context at /home/scott/git/linux/mm/slab.h:421
[    9.158159] in_atomic(): 1, irqs_disabled(): 0, pid: 4432, name: ip
[    9.163128] CPU: 8 PID: 4432 Comm: ip Not tainted 4.20.0-rc2-00169-g63d86876f324 #29
[    9.163130] Call Trace:
[    9.170701] [c0000002e899a980] [c0000000009c1068] .dump_stack+0xa8/0xec (unreliable)
[    9.177140] [c0000002e899aa10] [c00000000007a7b4] .___might_sleep+0x138/0x164
[    9.184440] [c0000002e899aa80] [c0000000001d5bac] .kmem_cache_alloc_trace+0x238/0x30c
[    9.191216] [c0000002e899ab40] [c00000000065ea1c] .memac_add_hash_mac_address+0x104/0x198
[    9.199464] [c0000002e899abd0] [c00000000065a788] .set_multi+0x1c8/0x218
[    9.206242] [c0000002e899ac80] [c0000000006615ec] .dpaa_set_rx_mode+0xdc/0x17c
[    9.213544] [c0000002e899ad00] [c00000000083d2b0] .__dev_set_rx_mode+0x80/0xd4
[    9.219535] [c0000002e899ad90] [c00000000083d334] .dev_set_rx_mode+0x30/0x54
[    9.225271] [c0000002e899ae10] [c00000000083d4a0] .__dev_open+0x148/0x1c8
[    9.230751] [c0000002e899aeb0] [c00000000083d934] .__dev_change_flags+0x19c/0x1e0
[    9.230755] [c0000002e899af60] [c00000000083d9a4] .dev_change_flags+0x2c/0x80
[    9.242752] [c0000002e899aff0] [c0000000008554ec] .do_setlink+0x350/0xf08
[    9.248228] [c0000002e899b170] [c000000000857ad0] .rtnl_newlink+0x588/0x7e0
[    9.253965] [c0000002e899b740] [c000000000852424] .rtnetlink_rcv_msg+0x3e0/0x498
[    9.261440] [c0000002e899b820] [c000000000884790] .netlink_rcv_skb+0x134/0x14c
[    9.267607] [c0000002e899b8e0] [c000000000851840] .rtnetlink_rcv+0x18/0x2c
[    9.274558] [c0000002e899b950] [c000000000883c8c] .netlink_unicast+0x214/0x318
[    9.281163] [c0000002e899ba00] [c000000000884220] .netlink_sendmsg+0x348/0x444
[    9.287076] [c0000002e899bae0] [c00000000080d13c] .sock_sendmsg+0x2c/0x54
[    9.287080] [c0000002e899bb50] [c0000000008106c0] .___sys_sendmsg+0x2d0/0x2d8
[    9.298375] [c0000002e899bd30] [c000000000811a80] .__sys_sendmsg+0x5c/0xb0
[    9.303939] [c0000002e899be20] [c0000000000006b0] system_call+0x60/0x6c

Signed-off-by: Scott Wood <oss@buserror.net>
---
 drivers/net/ethernet/freescale/fman/fman_memac.c | 2 +-
 drivers/net/ethernet/freescale/fman/fman_tgec.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
index bc6eb30aa20f..41c6fa200e74 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.c
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
@@ -928,7 +928,7 @@ int memac_add_hash_mac_address(struct fman_mac *memac, enet_addr_t *eth_addr)
 	hash = get_mac_addr_hash_code(addr) & HASH_CTRL_ADDR_MASK;
 
 	/* Create element to be added to the driver hash table */
-	hash_entry = kmalloc(sizeof(*hash_entry), GFP_KERNEL);
+	hash_entry = kmalloc(sizeof(*hash_entry), GFP_ATOMIC);
 	if (!hash_entry)
 		return -ENOMEM;
 	hash_entry->addr = addr;
diff --git a/drivers/net/ethernet/freescale/fman/fman_tgec.c b/drivers/net/ethernet/freescale/fman/fman_tgec.c
index 40705938eecc..f75b9c11b2d2 100644
--- a/drivers/net/ethernet/freescale/fman/fman_tgec.c
+++ b/drivers/net/ethernet/freescale/fman/fman_tgec.c
@@ -553,7 +553,7 @@ int tgec_add_hash_mac_address(struct fman_mac *tgec, enet_addr_t *eth_addr)
 	hash = (crc >> TGEC_HASH_MCAST_SHIFT) & TGEC_HASH_ADR_MSK;
 
 	/* Create element to be added to the driver hash table */
-	hash_entry = kmalloc(sizeof(*hash_entry), GFP_KERNEL);
+	hash_entry = kmalloc(sizeof(*hash_entry), GFP_ATOMIC);
 	if (!hash_entry)
 		return -ENOMEM;
 	hash_entry->addr = addr;
-- 
2.17.1
