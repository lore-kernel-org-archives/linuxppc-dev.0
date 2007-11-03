Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B8899DDE2B
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  4 Nov 2007 07:46:07 +1100 (EST)
Message-ID: <472CDE02.1020804@scram.de>
Date: Sat, 03 Nov 2007 21:45:54 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] [POWERPC] Fix fs_enet module build
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
	Jeff Garzik <jeff@garzik.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

If fs_enet is build as module, mii-fec/mii-bitbang should be build as
module, as well. Otherwise some symbols remain undefined.

  Building modules, stage 2.
  MODPOST 5 modules
ERROR: "fs_scc_ops" [drivers/net/fs_enet/fs_enet.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---

This can be pulled from git://git.bocc.de/dbox2.git for-2.6.24

 drivers/net/fs_enet/Makefile |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/fs_enet/Makefile b/drivers/net/fs_enet/Makefile
index 02d4dc1..2f7563a 100644
--- a/drivers/net/fs_enet/Makefile
+++ b/drivers/net/fs_enet/Makefile
@@ -4,7 +4,15 @@
 
 obj-$(CONFIG_FS_ENET) += fs_enet.o
 
-obj-$(CONFIG_8xx) += mac-fec.o mac-scc.o mii-fec.o
-obj-$(CONFIG_CPM2) += mac-fcc.o mii-bitbang.o
+fs_enet-$(CONFIG_8xx) += mac-fec.o mac-scc.o
+fs_enet-$(CONFIG_CPM2) += mac-fcc.o
+
+ifeq ($(CONFIG_8xx),y)
+        obj-$(CONFIG_FS_ENET) += mii-fec.o
+endif
+
+ifeq ($(CONFIG_CPM2),y)
+        obj-$(CONFIG_FS_ENET) += mii-bitbang.o
+endif
 
 fs_enet-objs := fs_enet-main.o
-- 
1.5.3.4
