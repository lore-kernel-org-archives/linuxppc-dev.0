Return-Path: <reynekejunk@hotmail.com>
Received: from bay0-omc1-s36.bay0.hotmail.com (bay0-omc1-s36.bay0.hotmail.com
	[65.54.246.108]) by ozlabs.org (Postfix) with ESMTP id 68AEDDDE26
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Mar 2009 22:35:41 +1100 (EST)
Message-ID: <BAY101-W12966ECAF38C4FD6F26513BEA50@phx.gbl>
From: - Reyneke <reynekejunk@hotmail.com>
To: <linuxppc-dev@ozlabs.org>, <dbrownell@users.sourceforge.net>
Subject: [PATCH] powerpc/usb: Fix 440EPx USBH_3 & USBH_5 EHCI errata
Date: Fri, 6 Mar 2009 11:30:35 +0000
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Patch applies to 440EPx devices in USB EHCI host mode (USB 2.0).

>From the 440EPx errata:

USBH_3: Host hangs after underrun or overrun occurs
USBH_5: EHCI0_INSNREGxx registers are reset by a Soft or Light Host Control=
ler Reset

Workround for USBH_3 is to enable Break Memory Transfer (BMT) in INSNREG3. =
But the controller is reset after this fix is applied=2C and thus the curre=
nt workround is lost. The following short patch ensures INSNREG3 is correct=
ly set after reset.


Signed-off-by: Jan Reyneke=20
---
 ehci-hcd.c    |    7 +++++++
 ehci-ppc-of.c |   30 +++++++++++++++++++-----------
 ehci.h        |    5 +++++
 3 files changed=2C 31 insertions(+)=2C 11 deletions(-)

diff -uprN a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
--- a/drivers/usb/host/ehci.h    2009-03-04 01:05:22.000000000 +0000
+++ b/drivers/usb/host/ehci.h    2009-03-06 10:52:53.000000000 +0000
@@ -137=2C6 +137=2C11 @@ struct ehci_hcd {            /* one per controlle
=20
     u8            sbrn=3B        /* packed release number */
=20
+#if defined(CONFIG_440EPX)
+    #define     PPC440EPX_EHCI0_INSREG_BMT    (0x1 << 0)
+    __iomem u32 *insn_regs=3B        /* INSNREGx device memory/io */
+#endif
+
     /* irq statistics */
 #ifdef EHCI_STATS
     struct ehci_stats    stats=3B
diff -uprN a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
--- a/drivers/usb/host/ehci-hcd.c    2009-03-04 01:05:22.000000000 +0000
+++ b/drivers/usb/host/ehci-hcd.c    2009-03-06 10:54:36.000000000 +0000
@@ -217=2C6 +217=2C13 @@ static int ehci_reset (struct ehci_hcd *
     if (ehci_is_TDI(ehci))
         tdi_reset (ehci)=3B
=20
+#if defined(CONFIG_440EPX)
+    /* USBH_5: INSN values are lost on reset -> redo USBH_3.
+       See also ppc44x_enable_bmt.*/
+    if (ehci->insn_regs)
+        out_be32(ehci->insn_regs + 3=2C PPC440EPX_EHCI0_INSREG_BMT)=3B
+#endif
+
     return retval=3B
 }
=20
diff -uprN a/drivers/usb/host/ehci-ppc-of.c b/drivers/usb/host/ehci-ppc-of.=
c
--- a/drivers/usb/host/ehci-ppc-of.c    2009-03-04 01:05:22.000000000 +0000
+++ b/drivers/usb/host/ehci-ppc-of.c    2009-03-06 10:56:08.000000000 +0000
@@ -82=2C23 +82=2C24 @@ static const struct hc_driver ehci_ppc_o
=20
=20
 /*
- * 440EPx Errata USBH_3
- * Fix: Enable Break Memory Transfer (BMT) in INSNREG3
- */
-#define PPC440EPX_EHCI0_INSREG_BMT    (0x1 << 0)
+ * 440EPx Errata USBH_3 & USBH_5
+ * Fix: Enable Break Memory Transfer (BMT) in INSNREG3. Also cache
+ * the registers so we can redo the USBH_3 fix on future resets */
 static int __devinit
-ppc44x_enable_bmt(struct device_node *dn)
+ppc44x_enable_bmt(struct device_node *dn=2C struct ehci_hcd* ehci)
 {
-    __iomem u32 *insreg_virt=3B
=20
-    insreg_virt =3D of_iomap(dn=2C 1)=3B
-    if (!insreg_virt)
+#if defined(CONFIG_440EPX)
+
+    ehci->insn_regs =3D of_iomap(dn=2C 1)=3B
+    if (!ehci->insn_regs)
         return  -EINVAL=3B
=20
-    out_be32(insreg_virt + 3=2C PPC440EPX_EHCI0_INSREG_BMT)=3B
+    out_be32(ehci->insn_regs + 3=2C PPC440EPX_EHCI0_INSREG_BMT)=3B
=20
-    iounmap(insreg_virt)=3B
+#endif
     return 0=3B
+
 }
=20
=20
@@ -183=2C7 +184=2C7 @@ ehci_hcd_ppc_of_probe(struct of_device *
     ehci->hcs_params =3D ehci_readl(ehci=2C &ehci->caps->hcs_params)=3B
=20
     if (of_device_is_compatible(dn=2C "ibm=2Cusb-ehci-440epx")) {
-        rv =3D ppc44x_enable_bmt(dn)=3B
+        rv =3D ppc44x_enable_bmt(dn=2C ehci)=3B
         ehci_dbg(ehci=2C "Break Memory Transfer (BMT) is %senabled!\n"=2C
                 rv ? "NOT ": "")=3B
     }
@@ -221=2C6 +222=2C13 @@ static int ehci_hcd_ppc_of_remove(struct
=20
     usb_remove_hcd(hcd)=3B
=20
+#if defined(CONFIG_440EPX)
+    if (ehci->insn_regs) {
+        iounmap(ehci->insn_regs)=3B
+        ehci->insn_regs =3D 0=3B
+    }
+#endif
+
     iounmap(hcd->regs)=3B
     irq_dispose_mapping(hcd->irq)=3B
     release_mem_region(hcd->rsrc_start=2C hcd->rsrc_len)=3B



_________________________________________________________________
View your Twitter and Flickr updates from one place =96 Learn more!
http://clk.atdmt.com/UKM/go/137984870/direct/01/=
