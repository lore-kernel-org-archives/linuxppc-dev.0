Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8129BDDEE8
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 03:19:43 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc: 85xx: Add PHY fixup to socrates board code
Date: Tue, 21 Apr 2009 19:19:38 +0200
Message-Id: <1240334378-1643-1-git-send-email-agust@denx.de>
In-Reply-To: <1239113988-4579-1-git-send-email-agust@denx.de>
References: <1239113988-4579-1-git-send-email-agust@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If the firmware missed to initialize the PHY correctly,
Linux may hang up on socrates while eth0/eth1 interface
startup (caused by continuous unacknowledged PHY interrupt).

This patch adds PHY fixup to socrates platform code to
ensure the PHY is pre-initialized correctly. It is needed
to be compatible with older firmware.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
Changes since first version:
	use macros instead of register numbers as
	suggested by Anton

Kumar, could you please consider this patch for
inclusion into 2.6.30? Thanks!

 arch/powerpc/platforms/85xx/socrates.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/socrates.c b/arch/powerpc/platforms/85xx/socrates.c
index d0e8443..bde0a97 100644
--- a/arch/powerpc/platforms/85xx/socrates.c
+++ b/arch/powerpc/platforms/85xx/socrates.c
@@ -28,6 +28,7 @@
 #include <linux/delay.h>
 #include <linux/seq_file.h>
 #include <linux/of_platform.h>
+#include <linux/phy.h>
 
 #include <asm/system.h>
 #include <asm/time.h>
@@ -78,6 +79,23 @@ static void __init socrates_pic_init(void)
 	of_node_put(np);
 }
 
+#define MII_M1011_IMASK		0x12
+#define MII_M1011_IEVENT	0x13
+static int socrates_m88e1121_fixup(struct phy_device *phydev)
+{
+	int err;
+
+	err = phy_write(phydev, MII_M1011_IMASK, 0);
+	if (err < 0)
+		return err;
+
+	err = phy_read(phydev, MII_M1011_IEVENT);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
 /*
  * Setup the architecture
  */
@@ -105,6 +123,8 @@ static struct of_device_id __initdata socrates_of_bus_ids[] = {
 static void __init socrates_init(void)
 {
 	of_platform_bus_probe(NULL, socrates_of_bus_ids, NULL);
+	phy_register_fixup_for_uid(0x1410cb0, 0xffffff0,
+				   socrates_m88e1121_fixup);
 }
 
 /*
-- 
1.5.6.3
