Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 53E6667BB9
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 05:31:18 +1000 (EST)
Date: Thu, 21 Sep 2006 14:31:13 -0500
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] demacrofy arch/powerpc/platforms/maple/pci.c
Message-ID: <20060921193113.GF630@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Noticed that the U3_*CFA macros have some typos:

#define U3_HT_CFA0(devfn, off)		\
		((((unsigned long)devfn) << 8) | offset)

(refers to offset rather than off)

#define U3_AGP_CFA0(devfn, off)	\
	((1 << (unsigned long)PCI_SLOT(dev_fn)) \
	| (((unsigned long)PCI_FUNC(dev_fn)) << 8) \

(refers to dev_fn rather than devfn)

Things happen to work, but there doesn't seem to be any reason these
shouldn't be functions.  Overall behavior should be unchanged.

Signed-off-by: Nathan Lynch <ntl@pobox.com>

--- linux-2.6.git.orig/arch/powerpc/platforms/maple/pci.c
+++ linux-2.6.git/arch/powerpc/platforms/maple/pci.c
@@ -79,16 +79,20 @@ static void __init fixup_bus_range(struc
 }
 
 
-#define U3_AGP_CFA0(devfn, off)	\
-	((1 << (unsigned long)PCI_SLOT(dev_fn)) \
-	| (((unsigned long)PCI_FUNC(dev_fn)) << 8) \
-	| (((unsigned long)(off)) & 0xFCUL))
-
-#define U3_AGP_CFA1(bus, devfn, off)	\
-	((((unsigned long)(bus)) << 16) \
-	|(((unsigned long)(devfn)) << 8) \
-	|(((unsigned long)(off)) & 0xFCUL) \
-	|1UL)
+static unsigned long u3_agp_cfa0(u8 devfn, u8 off)
+{
+	return (1 << (unsigned long)PCI_SLOT(devfn)) |
+		((unsigned long)PCI_FUNC(devfn) << 8) |
+		((unsigned long)off & 0xFCUL);
+}
+
+static unsigned long u3_agp_cfa1(u8 bus, u8 devfn, u8 off)
+{
+	return ((unsigned long)bus << 16) |
+		((unsigned long)devfn << 8) |
+		((unsigned long)off & 0xFCUL) |
+		1UL;
+}
 
 static unsigned long u3_agp_cfg_access(struct pci_controller* hose,
 				       u8 bus, u8 dev_fn, u8 offset)
@@ -98,9 +102,9 @@ static unsigned long u3_agp_cfg_access(s
 	if (bus == hose->first_busno) {
 		if (dev_fn < (11 << 3))
 			return 0;
-		caddr = U3_AGP_CFA0(dev_fn, offset);
+		caddr = u3_agp_cfa0(dev_fn, offset);
 	} else
-		caddr = U3_AGP_CFA1(bus, dev_fn, offset);
+		caddr = u3_agp_cfa1(bus, dev_fn, offset);
 
 	/* Uninorth will return garbage if we don't read back the value ! */
 	do {
@@ -182,13 +186,15 @@ static struct pci_ops u3_agp_pci_ops =
 	u3_agp_write_config
 };
 
+static unsigned long u3_ht_cfa0(u8 devfn, u8 off)
+{
+	return (devfn << 8) | off;
+}
 
-#define U3_HT_CFA0(devfn, off)		\
-		((((unsigned long)devfn) << 8) | offset)
-#define U3_HT_CFA1(bus, devfn, off)	\
-		(U3_HT_CFA0(devfn, off) \
-		+ (((unsigned long)bus) << 16) \
-		+ 0x01000000UL)
+static unsigned long u3_ht_cfa1(u8 bus, u8 devfn, u8 off)
+{
+	return u3_ht_cfa0(devfn, off) + (bus << 16) + 0x01000000UL;
+}
 
 static unsigned long u3_ht_cfg_access(struct pci_controller* hose,
 				      u8 bus, u8 devfn, u8 offset)
@@ -196,9 +202,9 @@ static unsigned long u3_ht_cfg_access(st
 	if (bus == hose->first_busno) {
 		if (PCI_SLOT(devfn) == 0)
 			return 0;
-		return ((unsigned long)hose->cfg_data) + U3_HT_CFA0(devfn, offset);
+		return ((unsigned long)hose->cfg_data) + u3_ht_cfa0(devfn, offset);
 	} else
-		return ((unsigned long)hose->cfg_data) + U3_HT_CFA1(bus, devfn, offset);
+		return ((unsigned long)hose->cfg_data) + u3_ht_cfa1(bus, devfn, offset);
 }
 
 static int u3_ht_read_config(struct pci_bus *bus, unsigned int devfn,
