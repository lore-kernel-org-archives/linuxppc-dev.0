Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D4CB5DDF2E
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 03:05:36 +1100 (EST)
To: torvalds@linux-foundation.org
Subject: [PATCH] ps3 usb missed the addition of new argument to
	ps3_alloc_io_irq()
Message-Id: <E1HFYFg-0004rz-19@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Fri, 09 Feb 2007 16:05:32 +0000
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/usb/host/ehci-ps3.c |    2 +-
 drivers/usb/host/ohci-ps3.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-ps3.c b/drivers/usb/host/ehci-ps3.c
index 371f194..4d781a2 100644
--- a/drivers/usb/host/ehci-ps3.c
+++ b/drivers/usb/host/ehci-ps3.c
@@ -104,7 +104,7 @@ static int ps3_ehci_sb_probe(struct ps3_system_bus_device *dev)
 	dev_dbg(&dev->core, "%s:%d: mmio mapped_addr %lxh\n", __func__,
 		__LINE__, dev->m_region->lpar_addr);
 
-	result = ps3_alloc_io_irq(dev->interrupt_id, &virq);
+	result = ps3_alloc_io_irq(PS3_BINDING_CPU_ANY, dev->interrupt_id, &virq);
 
 	if (result) {
 		dev_dbg(&dev->core, "%s:%d: ps3_construct_io_irq(%d) failed.\n",
diff --git a/drivers/usb/host/ohci-ps3.c b/drivers/usb/host/ohci-ps3.c
index 69d948b..62283a3 100644
--- a/drivers/usb/host/ohci-ps3.c
+++ b/drivers/usb/host/ohci-ps3.c
@@ -107,7 +107,7 @@ static int ps3_ohci_sb_probe(struct ps3_system_bus_device *dev)
 	dev_dbg(&dev->core, "%s:%d: mmio mapped_addr %lxh\n", __func__,
 		__LINE__, dev->m_region->lpar_addr);
 
-	result = ps3_alloc_io_irq(dev->interrupt_id, &virq);
+	result = ps3_alloc_io_irq(PS3_BINDING_CPU_ANY, dev->interrupt_id, &virq);
 
 	if (result) {
 		dev_dbg(&dev->core, "%s:%d: ps3_construct_io_irq(%d) failed.\n",
-- 
1.5.0-rc2.GIT
