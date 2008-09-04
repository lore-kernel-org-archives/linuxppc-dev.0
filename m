Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 96EA6DDF0C
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 16:00:06 +1000 (EST)
Message-ID: <48BF79C2.6050902@denx.de>
Date: Thu, 04 Sep 2008 08:01:38 +0200
From: Heiko Schocher <hs@denx.de>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [FIX] fs_enet: Using mii-bitbang as module
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Vitaly,

I tried to use the mii-bitbang driver (drivers/net/fs_enet/mii-bitbang.c)
as a module and got the following error, when inserting it with insmod:

~ # insmod fs_enet
eth0: fs_enet: a6:07:11:7f:de:26
~ # insmod mii-bitbang
mii_bitbang: module license 'unspecified' taints kernel.
mii_bitbang: Unknown symbol of_address_to_resource
mii_bitbang: Unknown symbol of_irq_to_resource
insmod: cannot insert '/lib/modules/2.6.27-rc5-01144-g967b424-dirty/kernel/drivers/net/fs_enet/mii-bitbang.ko': Unknown symbol in module (-1): No such file or directory
~ #

Following patch solves this. Maybe you add the other MODULE_ macros too?

Signed-off-by: Heiko Schocher <hs@denx.de>
---
 drivers/net/fs_enet/mii-bitbang.c                  |    2 +
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/fs_enet/mii-bitbang.c b/drivers/net/fs_enet/mii-bitbang.c
index be4b72f..863ceed 100644
--- a/drivers/net/fs_enet/mii-bitbang.c
+++ b/drivers/net/fs_enet/mii-bitbang.c
@@ -26,6 +26,8 @@

 #include "fs_enet.h"

+MODULE_LICENSE("GPL");
+
 struct bb_info {
 	struct mdiobb_ctrl ctrl;
 	__be32 __iomem *dir;
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
