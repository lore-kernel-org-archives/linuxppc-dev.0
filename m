Date: Tue, 23 Sep 2003 11:37:43 +0200
From: Lorenzo Pivetta <lorenzo.pivetta@elettra.trieste.it>
To: ppc <linuxppc-embedded@lists.linuxppc.org>
Cc: me <lorenzo.pivetta@elettra.trieste.it>
Subject: MVME5100 patch
Message-Id: <20030923113743.5458916f.lorenzo.pivetta@elettra.trieste.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This simple patch to make the IRQ lines work with the PMCSpan PMC
carriers on the MVME51xx. (works with 2.4.21 too).
Thanks and regards,
Lorenzo.

--
Ing. Lorenzo Pivetta   \ e-mail: lorenzo.pivetta@elettra.trieste.it
                        \ tel.:  040 - 3758361 - fax: 040 - 9380902
Sincrotrone Trieste SCpA \ url:  http://www.elettra.trieste.it



>diff -Naur linuxppc-2.4.18-devel/arch/ppc/platforms/mvme5100_pci.c linuxppc-2.4.18-work/arch/ppc/platforms/mvme5100_pci.c
--- linuxppc-2.4.18-devel/arch/ppc/platforms/mvme5100_pci.c     Fri Feb 15 01:52:34 2002
+++ linuxppc-2.4.18-work/arch/ppc/platforms/mvme5100_pci.c      Tue Sep 23 11:13:11 2003
@@ -26,6 +26,13 @@
 #include <platforms/mvme5100.h>
 #include <asm/pplus.h>

+#define DEBUG_CONFIG    0
+#if DEBUG_CONFIG
+# define DBGC(args)     printk args
+#else
+# define DBGC(args)
+#endif
+
 static inline int
 mvme5100_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
 {
@@ -46,10 +53,15 @@
                { 28, 25, 26, 27 },     /* IDSEL 17 - PMC Slot 2 */
                {  0,  0,  0,  0 },     /* IDSEL 18 - unused */
                { 29,  0,  0,  0 },     /* IDSEL 19 - Enet 2 */
-               {  0,  0,  0,  0 },     /* IDSEL 20 - PMCSPAN */
+               { 25, 26, 27, 28 },     /* IDSEL 20 - PMCSPAN */
        };

        const long min_idsel = 11, max_idsel = 20, irqs_per_slot = 4;
+
+       DBGC((KERN_INFO "PCI mvme5100 map irq: <bus>:<slot> %02d:%02d, \
+               pin %d, idsel %d\n", dev->bus->number, \
+               PCI_SLOT(dev->devfn), pin, idsel));
+
        irq = PCI_IRQ_TABLE_LOOKUP;
        /* If lookup is zero, always return 0 */
        if (!irq)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
