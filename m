Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D4A77DDF10
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 03:05:31 +1100 (EST)
To: torvalds@linux-foundation.org
Subject: [PATCH] ps3: missing exports
Message-Id: <E1HFYFb-0004rm-0y@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Fri, 09 Feb 2007 16:05:27 +0000
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
 arch/powerpc/platforms/ps3/interrupt.c  |    2 ++
 arch/powerpc/platforms/ps3/system-bus.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index bb17283..631c300 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -194,6 +194,7 @@ int ps3_alloc_io_irq(enum ps3_cpu_binding cpu, unsigned int interrupt_id,
 
 	return result;
 }
+EXPORT_SYMBOL_GPL(ps3_alloc_io_irq);
 
 int ps3_free_io_irq(unsigned int virq)
 {
@@ -209,6 +210,7 @@ int ps3_free_io_irq(unsigned int virq)
 
 	return result;
 }
+EXPORT_SYMBOL_GPL(ps3_free_io_irq);
 
 /**
  * ps3_alloc_event_irq - Allocate a virq for use with a system event.
diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index bce6136..a9f7e4a 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -57,6 +57,7 @@ int ps3_mmio_region_create(struct ps3_mmio_region *r)
 	dump_mmio_region(r);
 	return result;
 }
+EXPORT_SYMBOL_GPL(ps3_mmio_region_create);
 
 int ps3_free_mmio_region(struct ps3_mmio_region *r)
 {
@@ -72,6 +73,7 @@ int ps3_free_mmio_region(struct ps3_mmio_region *r)
 	r->lpar_addr = 0;
 	return result;
 }
+EXPORT_SYMBOL_GPL(ps3_free_mmio_region);
 
 static int ps3_system_bus_match(struct device *_dev,
 	struct device_driver *_drv)
-- 
1.5.0-rc2.GIT
