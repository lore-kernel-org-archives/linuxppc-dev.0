Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id F2430DDEC9
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2007 16:08:32 +1000 (EST)
Date: Mon, 16 Apr 2007 01:26:34 -0500
To: paulus@sambaorg
Subject: [PATCH] [1/5] pasemi: allow 8KB config space for I/O bridge
Message-ID: <20070416062634.GB20196@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Device 0 function 0 on the root bus is really a two-function bus agent,
but only the first function is visible. Because of this, we need to
allow config accesses into the second range. Modify the check for valid
offsets accordingly.

Signed-off-by: Olof Johansson <olof@lixom.net>

Index: linux-2.6/arch/powerpc/platforms/pasemi/pci.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pasemi/pci.c
+++ linux-2.6/arch/powerpc/platforms/pasemi/pci.c
@@ -33,7 +33,17 @@
 
 #define PA_PXP_CFA(bus, devfn, off) (((bus) << 20) | ((devfn) << 12) | (off))
 
-#define CONFIG_OFFSET_VALID(off) ((off) < 4096)
+static inline int pa_pxp_offset_valid(u8 bus, u8 devfn, int offset)
+{
+	/* Device 0 Function 0 is special: It's config space spans function 1 as
+	 * well, so allow larger offset. It's really a two-function device but the
+	 * second function does not probe.
+	 */
+	if (bus == 0 && devfn == 0)
+		return offset < 8192;
+	else
+		return offset < 4096;
+}
 
 static void volatile __iomem *pa_pxp_cfg_addr(struct pci_controller *hose,
 				       u8 bus, u8 devfn, int offset)
@@ -51,7 +61,7 @@ static int pa_pxp_read_config(struct pci
 	if (!hose)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	if (!CONFIG_OFFSET_VALID(offset))
+	if (!pa_pxp_offset_valid(bus->number, devfn, offset))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	addr = pa_pxp_cfg_addr(hose, bus->number, devfn, offset);
@@ -85,7 +95,7 @@ static int pa_pxp_write_config(struct pc
 	if (!hose)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	if (!CONFIG_OFFSET_VALID(offset))
+	if (!pa_pxp_offset_valid(bus->number, devfn, offset))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	addr = pa_pxp_cfg_addr(hose, bus->number, devfn, offset);
