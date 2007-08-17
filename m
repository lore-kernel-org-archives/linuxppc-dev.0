Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 5B1CDDDE29
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2007 04:27:06 +1000 (EST)
Date: Fri, 17 Aug 2007 20:27:17 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org,
	Paul Mackeras <paulus@samba.org>
Subject: [PATCH] advertise correct IDE mode on Pegasos2
Message-ID: <20070817182717.GA656@aepfle.de>
References: <20070404111635.GA1855@aepfle.de>
	<20070817131048.GA31192@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20070817131048.GA31192@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The built-in IDE controller is configured in legacy mode,
but the PCI registers advertise native mode.
Force the PCI class into legacy mode. This allows pata_via to access
two drives.
The Pegasos specific irq enforcement in the via82cxxx driver
must stay because there is aparently no generic way to setup irq per channel.

Tested on Pegasos2 with firmware version 20040810, and two IDE disks.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 arch/powerpc/kernel/prom_init.c   |   11 ++++++++---
 arch/powerpc/platforms/chrp/pci.c |   29 +++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 3 deletions(-)

--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2044,6 +2044,7 @@ static void __init fixup_device_tree_map
 /*
  * Pegasos and BriQ lacks the "ranges" property in the isa node
  * Pegasos needs decimal IRQ 14/15, not hexadecimal
+ * Pegasos has the IDE configured in legacy mode, but advertised as native
  */
 static void __init fixup_device_tree_chrp(void)
 {
@@ -2081,9 +2082,13 @@ static void __init fixup_device_tree_chr
 		prom_printf("Fixing up IDE interrupt on Pegasos...\n");
 		prop[0] = 14;
 		prop[1] = 0x0;
-		prop[2] = 15;
-		prop[3] = 0x0;
-		prom_setprop(ph, name, "interrupts", prop, 4*sizeof(u32));
+		prom_setprop(ph, name, "interrupts", prop, 2*sizeof(u32));
+		prom_printf("Fixing up IDE class-code on Pegasos...\n");
+		rc = prom_getprop(ph, "class-code", prop, sizeof(u32));
+		if (rc == sizeof(u32)) {
+			prop[0] &= ~0x5;
+			prom_setprop(ph, name, "class-code", prop, sizeof(u32));
+		}
 	}
 }
 #else
--- a/arch/powerpc/platforms/chrp/pci.c
+++ b/arch/powerpc/platforms/chrp/pci.c
@@ -338,3 +338,32 @@ void chrp_pci_fixup_winbond_ata(struct p
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,
 		chrp_pci_fixup_winbond_ata);
+
+/* Pegasos2 firmware version 20040810 configures the built-in IDE controller
+ * in legacy mode, but sets the PCI registers to PCI native mode.
+ * The chip can only operate in legacy mode, so force the PCI class into legacy
+ * mode as well. The same fixup must be done to the class-code property in
+ * the IDE node /pci@80000000/ide@C,1
+ */
+static void chrp_pci_fixup_vt8231_ata(struct pci_dev *viaide)
+{
+	u8 progif;
+	struct pci_dev *viaisa;
+
+	if (!machine_is(chrp) || _chrp_type != _CHRP_Pegasos)
+		return;
+	if (viaide->irq != 14)
+		return;
+
+	viaisa = pci_get_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8231, NULL);
+	if (!viaisa)
+		return;
+	printk("Fixing VIA IDE, force legacy mode on '%s'\n", viaide->dev.bus_id);
+
+	pci_read_config_byte(viaide, PCI_CLASS_PROG, &progif);
+	pci_write_config_byte(viaide, PCI_CLASS_PROG, progif & ~0x5);
+	viaide->class &= ~0x5;
+
+	pci_dev_put(viaisa);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, chrp_pci_fixup_vt8231_ata);
