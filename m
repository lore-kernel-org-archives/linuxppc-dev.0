Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 36A40DDF18
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 00:46:26 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5BEkOXN029380
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 10:46:24 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5BEkNqw162602
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 10:46:24 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5BEkNhO028029
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 10:46:23 -0400
Date: Wed, 11 Jun 2008 10:45:49 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/4xx: Workaround for PPC440EPx/GRx PCI_28 Errata
Message-ID: <20080611104549.45836929@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: sr@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 440EPx/GRx chips don't support PCI MRM commands.  Drivers determine this
by looking for a zero value in the PCI cache line size register.  However,
some drivers write to this register upon initialization.  This can cause
MRMs to be used on these chips, which may cause deadlocks on PLB4.

The workaround implemented here introduces a new indirect_type flag, called
PPC_INDIRECT_TYPE_BROKEN_MRM.  This is set in the pci_controller structure in
the pci fixup function for 4xx PCI bridges by determining if the bridge is
compatible with 440EPx/GRx.  The flag is checked in the indirect_write_config
function, and forces any writes to the PCI_CACHE_LINE_SIZE register to be
zero, which will disable MRMs for these chips.

A similar workaround has been tested by AMCC on various PCI cards, such as
the Silicon Image ATA card and Intel E1000 GIGE card.  Hangs were seen with
the Silicon Image card, and MRMs were seen on the bus with a PCI analyzer.
With the workaround in place, the card functioned properly and only Memory
Reads were seen on the bus with the analyzer.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/sysdev/indirect_pci.c |    6 ++++++
 arch/powerpc/sysdev/ppc4xx_pci.c   |    5 +++++
 include/asm-powerpc/pci-bridge.h   |    3 +++
 3 files changed, 14 insertions(+)

--- linux-2.6.orig/arch/powerpc/sysdev/indirect_pci.c
+++ linux-2.6/arch/powerpc/sysdev/indirect_pci.c
@@ -123,6 +123,12 @@ indirect_write_config(struct pci_bus *bu
 			(bus->number == hose->first_busno))
 		val &= 0xffffff00;
 
+	/* Workaround for PCI_28 Errata in 440EPx/GRx */
+	if ((hose->indirect_type & PPC_INDIRECT_TYPE_BROKEN_MRM) &&
+			offset == PCI_CACHE_LINE_SIZE) {
+		val = 0;
+	}
+
 	/*
 	 * Note: the caller has already checked that offset is
 	 * suitably aligned and that len is 1, 2 or 4.
--- linux-2.6.orig/arch/powerpc/sysdev/ppc4xx_pci.c
+++ linux-2.6/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -75,6 +75,11 @@ static void fixup_ppc4xx_pci_bridge(stru
 	    !of_device_is_compatible(hose->dn, "ibm,plb-pci"))
 		return;
 
+	if (of_device_is_compatible(hose->dn, "ibm,plb440epx-pci") ||
+		of_device_is_compatible(hose->dn, "ibm,plb440grx-pci")) {
+		hose->indirect_type |= PPC_INDIRECT_TYPE_BROKEN_MRM;
+	}
+
 	/* Hide the PCI host BARs from the kernel as their content doesn't
 	 * fit well in the resource management
 	 */
--- linux-2.6.orig/include/asm-powerpc/pci-bridge.h
+++ linux-2.6/include/asm-powerpc/pci-bridge.h
@@ -92,12 +92,15 @@ struct pci_controller {
 	 *   anything but the PHB.  Only allow talking to the PHB if this is
 	 *   set.
 	 *  BIG_ENDIAN - cfg_addr is a big endian register
+	 *  BROKEN_MRM - the 440EPx/GRx chips have an errata that causes hangs on
+	 *   the PLB4.  Effectively disable MRM commands by setting this.
 	 */
 #define PPC_INDIRECT_TYPE_SET_CFG_TYPE		0x00000001
 #define PPC_INDIRECT_TYPE_EXT_REG		0x00000002
 #define PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS	0x00000004
 #define PPC_INDIRECT_TYPE_NO_PCIE_LINK		0x00000008
 #define PPC_INDIRECT_TYPE_BIG_ENDIAN		0x00000010
+#define PPC_INDIRECT_TYPE_BROKEN_MRM		0x00000020
 	u32 indirect_type;
 #endif	/* !CONFIG_PPC64 */
 	/* Currently, we limit ourselves to 1 IO range 
