Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 562BFDDF10
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 02:55:52 +1000 (EST)
Date: Mon, 8 Oct 2007 20:54:36 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] USB: Add frame_no big endian OHCI quirk.
Message-ID: <20071008165436.GA19653@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071008161927.84C601915AE@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Cc: david-b@pacbell.net, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add OHCI big endian frame_no quirk.
The frame_no value stored in the HCCA is a 16 bit field 
at a specific offset, but since not all CPUs can do 16-bit
memory accesses it's used as a 32 bit field.
And that's why big-endian OHCI will shift 16 bits,
unless the spec is not followed. Currently there's one MPC52xx
platform that doesn't need the shift. This case is hanled
using big endian frame_no quirk.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 drivers/usb/host/ohci-ppc-of.c |    5 ++++-
 drivers/usb/host/ohci.h        |   13 ++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff -pruN linux-2.6.orig/drivers/usb/host/ohci.h linux-2.6/drivers/usb/host/ohci.h
--- linux-2.6.orig/drivers/usb/host/ohci.h	2007-10-08 16:30:28.000000000 +0400
+++ linux-2.6/drivers/usb/host/ohci.h	2007-10-08 20:39:28.000000000 +0400
@@ -398,6 +398,7 @@ struct ohci_hcd {
 #define	OHCI_QUIRK_BE_MMIO	0x10			/* BE registers */
 #define	OHCI_QUIRK_ZFMICRO	0x20			/* Compaq ZFMicro chipset*/
 #define	OHCI_QUIRK_NEC		0x40			/* lost interrupts */
+#define	OHCI_QUIRK_FRAME_NO	0x80			/* no big endian frame_no shift */
 	// there are also chip quirks/bugs in init logic
 
 	struct work_struct	nec_work;	/* Worker for NEC quirk */
@@ -607,15 +608,12 @@ static inline u32 hc32_to_cpup (const st
 /* HCCA frame number is 16 bits, but is accessed as 32 bits since not all
  * hardware handles 16 bit reads.  That creates a different confusion on
  * some big-endian SOC implementations.  Same thing happens with PSW access.
- *
- * FIXME: Deal with that as a runtime quirk when STB03xxx is ported over
- * to arch/powerpc
  */
 
-#ifdef CONFIG_STB03xxx
-#define OHCI_BE_FRAME_NO_SHIFT	16
+#ifdef CONFIG_PPC_MPC52xx
+#define big_endian_frame_no_quirk(ohci)	(ohci->flags & OHCI_QUIRK_FRAME_NO)
 #else
-#define OHCI_BE_FRAME_NO_SHIFT	0
+#define big_endian_frame_no_quirk(ohci)	0
 #endif
 
 static inline u16 ohci_frame_no(const struct ohci_hcd *ohci)
@@ -623,7 +621,8 @@ static inline u16 ohci_frame_no(const st
 	u32 tmp;
 	if (big_endian_desc(ohci)) {
 		tmp = be32_to_cpup((__force __be32 *)&ohci->hcca->frame_no);
-		tmp >>= OHCI_BE_FRAME_NO_SHIFT;
+		if (!big_endian_frame_no_quirk(ohci))
+			tmp >>= 16;
 	} else
 		tmp = le32_to_cpup((__force __le32 *)&ohci->hcca->frame_no);
 
diff -pruN linux-2.6.orig/drivers/usb/host/ohci-ppc-of.c linux-2.6/drivers/usb/host/ohci-ppc-of.c
--- linux-2.6.orig/drivers/usb/host/ohci-ppc-of.c	2007-10-08 16:30:28.000000000 +0400
+++ linux-2.6/drivers/usb/host/ohci-ppc-of.c	2007-10-08 20:42:53.000000000 +0400
@@ -134,8 +134,11 @@ ohci_hcd_ppc_of_probe(struct of_device *
 	}
 
 	ohci = hcd_to_ohci(hcd);
-	if (is_bigendian)
+	if (is_bigendian) {
 		ohci->flags |= OHCI_QUIRK_BE_MMIO | OHCI_QUIRK_BE_DESC;
+		if (of_device_is_compatible(dn, "mpc5200-ohci"))
+			ohci->flags |= OHCI_QUIRK_FRAME_NO;
+	}
 
 	ohci_hcd_init(ohci);
 
