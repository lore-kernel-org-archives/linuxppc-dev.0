Subject: [PATCH] Set _IO_BASE on 8260 PCI.
From: David Woodhouse <dwmw2@infradead.org>
To: trini@kernel.crashing.org
Cc: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1092227652.15466.18.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Wed, 11 Aug 2004 13:34:12 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We weren't including <syslib/m8260_pci.h> from <asm/mpc8260.h>, so
_IO_BASE was defined to zero instead of isa_io_base.

===== arch/ppc/syslib/m8260_pci.h 1.2 vs edited =====
--- 1.2/arch/ppc/syslib/m8260_pci.h	2004-06-17 13:57:15 +01:00
+++ edited/arch/ppc/syslib/m8260_pci.h	2004-08-04 11:56:49 +01:00
@@ -66,6 +66,7 @@
 #endif

 #ifdef CONFIG_8260_PCI9
+struct pci_controller;
 extern void setup_m8260_indirect_pci(struct pci_controller* hose,
 				     u32 cfg_addr, u32 cfg_data);
 #else
===== include/asm-ppc/mpc8260.h 1.9 vs edited =====
--- 1.9/include/asm-ppc/mpc8260.h	2004-07-27 22:46:37 +01:00
+++ edited/include/asm-ppc/mpc8260.h	2004-08-03 13:16:22 +01:00
@@ -40,6 +40,10 @@
 #include <platforms/pq2ads.h>
 #endif

+#ifdef CONFIG_PCI_8260
+#include <syslib/m8260_pci.h>
+#endif
+
 /* Make sure the memory translation stuff is there if PCI not used.
  */
 #ifndef _IO_BASE


--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
