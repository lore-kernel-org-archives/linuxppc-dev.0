Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B8917DE102
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 06:49:14 +1100 (EST)
Date: Thu, 21 Feb 2008 22:49:13 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [USB POWERPC] ehci: fix ppc build
Message-ID: <20080221194913.GB12896@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: dbrownell@users.sourceforge.net, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, this setup:
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_HCD_PPC_OF=y

Will fail to build:
  CC      drivers/usb/host/ehci-hcd.o
drivers/usb/host/ehci-hcd.c:1018:2: error: #error "missing bus glue for ehci-hcd"
make[3]: *** [drivers/usb/host/ehci-hcd.o] Error 1

ehci-hcd.c actually contains OF_PLATFORM_DRIVER glue, so error is bogus.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/usb/host/ehci-hcd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 4caa6a8..3a19b1a 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1014,7 +1014,7 @@ MODULE_LICENSE ("GPL");
 #endif
 
 #if !defined(PCI_DRIVER) && !defined(PLATFORM_DRIVER) && \
-    !defined(PS3_SYSTEM_BUS_DRIVER)
+    !defined(PS3_SYSTEM_BUS_DRIVER) && !defined(OF_PLATFORM_DRIVER)
 #error "missing bus glue for ehci-hcd"
 #endif
 
-- 
1.5.2.2
