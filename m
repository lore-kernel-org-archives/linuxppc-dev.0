Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id B1BE0DDF58
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 00:20:47 +1000 (EST)
Date: Thu, 8 May 2008 18:20:45 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/3] [POWERPC] implement machine specific PCI fixup calls
Message-ID: <20080508142045.GA7172@polina.dev.rtsoft.ru>
References: <20080508142005.GA6749@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080508142005.GA6749@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These are similar to machine_initcalls, but works for the PCI fixups.
We need this to apply machine specific fixups for the same PCI devices.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 include/asm-powerpc/pci.h |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/pci.h b/include/asm-powerpc/pci.h
index a05a942..03fdc58 100644
--- a/include/asm-powerpc/pci.h
+++ b/include/asm-powerpc/pci.h
@@ -224,5 +224,21 @@ extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
 extern void pcibios_do_bus_setup(struct pci_bus *bus);
 extern void pcibios_fixup_of_probed_bus(struct pci_bus *bus);
 
+#define DEFINE_MACHINE_PCIFIXUP(type, mach, vendor, device, hook)        \
+	static void __devinit                                            \
+	__machine_pcifixup_##mach##_##hook(struct pci_dev *dev) {        \
+		if (machine_is(mach))                                    \
+			hook(dev);                                       \
+	}                                                                \
+	DECLARE_PCI_FIXUP_##type(vendor, device,                         \
+				 __machine_pcifixup_##mach##_##hook)
+
+#define MACH_PCI_FIXUP_EARLY(mach, vendor, device, hook) \
+	DEFINE_MACHINE_PCIFIXUP(EARLY, mach, vendor, device, hook)
+#define MACH_PCI_FIXUP_FINAL(mach, vendor, device, hook) \
+	DEFINE_MACHINE_PCIFIXUP(FINAL, mach, vendor, device, hook)
+#define MACH_PCI_FIXUP_HEADER(mach, vendor, device, hook) \
+	DEFINE_MACHINE_PCIFIXUP(HEADER, mach, vendor, device, hook)
+
 #endif	/* __KERNEL__ */
 #endif /* __ASM_POWERPC_PCI_H */
-- 
1.5.5.1
