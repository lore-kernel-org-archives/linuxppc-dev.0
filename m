Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (fire.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A412967A80
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Feb 2005 18:28:22 +1100 (EST)
Date: Tue, 22 Feb 2005 23:28:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: linuxppc-dev@ozlabs.org
Message-Id: <20050222232803.2c621a1b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Greg KH <greg@kroah.com>
Subject: [patch] make ppc build with 64-bit resource.start, end
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Could someone please double-check that this is an equivalent
transformation?

(wtf is that code doing, btw?)




Greg's tree changes resource.start and resource.end to u64.  So ppc fails to
link due to missing 64-bit divide helpers.  Fix.


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc/kernel/pci.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff -puN arch/ppc/kernel/pci.c~ppc32-64-bit-resource-fix arch/ppc/kernel/pci.c
--- 25/arch/ppc/kernel/pci.c~ppc32-64-bit-resource-fix	2005-02-22 23:27:09.000000000 -0800
+++ 25-akpm/arch/ppc/kernel/pci.c	2005-02-22 23:27:33.000000000 -0800
@@ -21,6 +21,7 @@
 #include <asm/byteorder.h>
 #include <asm/irq.h>
 #include <asm/uaccess.h>
+#include <asm/div64.h>
 
 #undef DEBUG
 
@@ -1088,6 +1089,18 @@ do_update_p2p_io_resource(struct pci_bus
 #endif
 }
 
+
+static u64 push_end(struct resource *res, u64 size)
+{
+	u64 end;
+
+	end = res->end + size;
+	do_div(end, size + 1);
+	end *= size + 1;
+	end += size;
+	return end;
+}
+
 /* This function is pretty basic and actually quite broken for the
  * general case, it's enough for us right now though. It's supposed
  * to tell us if we need to open an IO range at all or not and what
@@ -1100,10 +1113,6 @@ check_for_io_childs(struct pci_bus *bus,
 	int	i;
 	int	rc = 0;
 
-#define push_end(res, size) do { unsigned long __sz = (size) ; \
-	res->end = ((res->end + __sz) / (__sz + 1)) * (__sz + 1) + __sz; \
-    } while (0)
-
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		u16 class = dev->class >> 8;
 
@@ -1117,7 +1126,7 @@ check_for_io_childs(struct pci_bus *bus,
 
 		for (i=0; i<PCI_NUM_RESOURCES; i++) {
 			struct resource *r;
-			unsigned long r_size;
+			u64 r_size;
 
 			if (dev->class >> 8 == PCI_CLASS_BRIDGE_PCI
 			    && i >= PCI_BRIDGE_RESOURCES)
_
