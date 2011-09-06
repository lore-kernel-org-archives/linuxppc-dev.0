Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5507BB6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  7 Sep 2011 05:09:20 +1000 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] RapidIO, rionet: Fix ethernet address macros for LE platforms
Date: Tue,  6 Sep 2011 15:07:39 -0400
Message-Id: <1315336059-16156-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>, Chul Kim <chul.kim@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Modify Ethernet addess macros to be compatible with BE/LE platforms
(applicable to kernel versions starting from 2.6.39).

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Cc: Chul Kim <chul.kim@idt.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Li Yang <leoli@freescale.com>
---
 drivers/net/rionet.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/rionet.c b/drivers/net/rionet.c
index 3bb1311..7145714 100644
--- a/drivers/net/rionet.c
+++ b/drivers/net/rionet.c
@@ -88,8 +88,8 @@ static struct rio_dev **rionet_active;
 #define dev_rionet_capable(dev) \
 	is_rionet_capable(dev->src_ops, dev->dst_ops)
 
-#define RIONET_MAC_MATCH(x)	(*(u32 *)x == 0x00010001)
-#define RIONET_GET_DESTID(x)	(*(u16 *)(x + 4))
+#define RIONET_MAC_MATCH(x)	(!memcmp((x), "\00\01\00\01", 4))
+#define RIONET_GET_DESTID(x)	((*((u8 *)x + 4) << 8) | *((u8 *)x + 5))
 
 static int rionet_rx_clean(struct net_device *ndev)
 {
-- 
1.7.6
