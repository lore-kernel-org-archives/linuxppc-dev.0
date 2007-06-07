Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F3E58DDDEB
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 13:13:56 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l573DpNH013858
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Jun 2007 20:13:51 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l573DnxC021103
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Jun 2007 22:13:50 -0500 (CDT)
Subject: [PATCH]: Add 8548 pcie bus number workaround
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1181186000.10296.35.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 07 Jun 2007 11:13:21 +0800
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Zang Roy-r61911 <tie-fei.zang@freescale.com>

Remove legacy pcie support for 8641 chip.
General PCI code can fully support 8641 Rev2.0 chip.
For 8548 PEX controller, PCIE host controller configure
space can only be accessed as "bus->number = 0" in
the PCI architecture. So "bus->number == hose->bus_offset"
judgment is added.

Some minor space indentation clean up.
---
 arch/powerpc/sysdev/fsl_pcie.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pcie.c b/arch/powerpc/sysdev/fsl_pcie.c
index 041c07e..79e9546 100644
--- a/arch/powerpc/sysdev/fsl_pcie.c
+++ b/arch/powerpc/sysdev/fsl_pcie.c
@@ -47,16 +47,16 @@ indirect_read_config_pcie(struct pci_bus *bus, unsigned int devfn, int offset,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	PCIE_FIX;
-	if (bus->number == 0xff) {
+	if (bus->number == hose->bus_offset) {
 		PCI_CFG_OUT(hose->cfg_addr,
-			    (0x80000000 | ((offset & 0xf00) << 16) |
-			     ((bus->number - hose->bus_offset) << 16)
-			     | (devfn << 8) | ((offset & 0xfc) )));
+			(0x80000000 | ((offset & 0xf00) << 16) |
+			((bus->number - hose->bus_offset) << 16)
+			| (devfn << 8) | ((offset & 0xfc) )));
 	} else {
 		PCI_CFG_OUT(hose->cfg_addr,
-			    (0x80000001 | ((offset & 0xf00) << 16) |
-			     ((bus->number - hose->bus_offset) << 16)
-			     | (devfn << 8) | ((offset & 0xfc) )));
+			(0x80000000 | ((offset & 0xf00) << 16) |
+			(bus->number << 16)
+			| (devfn << 8) | ((offset & 0xfc) )));
 	}
 
 	/*
@@ -98,16 +98,16 @@ indirect_write_config_pcie(struct pci_bus *bus, unsigned int devfn, int offset,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	PCIE_FIX;
-	if (bus->number == 0xff) {
+	if (bus->number == hose->bus_offset) {
 		PCI_CFG_OUT(hose->cfg_addr,
-			    (0x80000000 | ((offset & 0xf00) << 16) |
-			     ((bus->number - hose->bus_offset) << 16)
-			     | (devfn << 8) | ((offset & 0xfc) )));
+			(0x80000000 | ((offset & 0xf00) << 16) |
+			((bus->number - hose->bus_offset) << 16)
+			| (devfn << 8) | ((offset & 0xfc) )));
 	} else {
 		PCI_CFG_OUT(hose->cfg_addr,
-			    (0x80000001 | ((offset & 0xf00) << 16) |
-			     ((bus->number - hose->bus_offset) << 16)
-			     | (devfn << 8) | ((offset & 0xfc) )));
+			(0x80000000 | ((offset & 0xf00) << 16) |
+			(bus->number << 16)
+			| (devfn << 8) | ((offset & 0xfc) )));
         }
 
 	/*
-- 
1.5.1
