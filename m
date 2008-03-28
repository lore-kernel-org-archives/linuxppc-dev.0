Return-Path: <michael@ozlabs.org>
To: Jeff Garzik <jeff@garzik.org>
Message-Id: <c9b4b088d00e37e33907b15ac59450c04ef36112.1206666963.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] Make pasemi_mac.c depend on PPC_PASEMI to prevent link errors
Date: Fri, 28 Mar 2008 12:17:33 +1100 (EST)
Cc: Olof Johannsson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

drivers/net/pasemi_mac.c is enabled by CONFIG_PASEMI_MAC, which depends on
PPC64 && PCI. However pasemi_mac.c uses several routines that are only
built when PPC_PASEMI is selected. This can lead to an unbuildable config:

 ERROR: ".pasemi_dma_start_chan" [drivers/net/pasemi_mac.ko] undefined!

So make CONFIG_PASEMI_MAC depend on PPC_PASEMI instead of PPC64.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 drivers/net/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)



Jeff, pending Olof's ack, this would be nice for 25, but is obviously
not super important.

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index fe7b5ec..3a0b20a 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2635,7 +2635,7 @@ config NIU
 
 config PASEMI_MAC
 	tristate "PA Semi 1/10Gbit MAC"
-	depends on PPC64 && PCI
+	depends on PPC_PASEMI && PCI
 	select PHYLIB
 	select INET_LRO
 	help
-- 
1.5.2.rc1.1884.g59b20
