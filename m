Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 03E53DDDDB
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 20:39:11 +1100 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 497ED213548
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 10:41:25 +0100 (CET)
Received: from localhost (unknown [192.168.1.157])
	by mail.m-online.net (Postfix) with ESMTP id 7D52990195
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 10:39:09 +0100 (CET)
Received: from localhost ([192.168.3.149])
	by localhost (scanner1.m-online.net [192.168.1.157]) (amavisd-new,
	port 10024) with ESMTP id tK3-lD2FXlNO for <linuxppc-dev@ozlabs.org>;
	Mon, 21 Jan 2008 10:39:08 +0100 (CET)
Received: from ibook.aepfle.de (DSL01.83.171.173.38.ip-pool.NEFkom.net
	[83.171.173.38]) by mail.mnet-online.de (Postfix) with ESMTP
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 10:39:08 +0100 (CET)
Date: Mon, 21 Jan 2008 10:39:30 +0100
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] revert chrp_pci_fixup_vt8231_ata devinit to fix libata on
	pegasos
Message-ID: <20080121093930.GA7762@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


commit 6d98bda79bea0e1be26c0767d0e9923ad3b72f2e changed the init order
for chrp_pci_fixup_vt8231_ata()
It can not work anymore because either the irq is not yet set to 14 or
pci_get_device() returns nothing. At least the printk() in
chrp_pci_fixup_vt8231_ata() does not trigger anymore.
pata_via works again on Pegasos with the change below.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

--- a/arch/powerpc/platforms/chrp/pci.c
+++ b/arch/powerpc/platforms/chrp/pci.c
@@ -354,7 +354,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_WI
  * mode as well. The same fixup must be done to the class-code property in
  * the IDE node /pci@80000000/ide@C,1
  */
-static void __devinit chrp_pci_fixup_vt8231_ata(struct pci_dev *viaide)
+static void chrp_pci_fixup_vt8231_ata(struct pci_dev *viaide)
 {
 	u8 progif;
 	struct pci_dev *viaisa;
@@ -375,4 +375,4 @@ static void __devinit chrp_pci_fixup_vt8
 
 	pci_dev_put(viaisa);
 }
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, chrp_pci_fixup_vt8231_ata);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, chrp_pci_fixup_vt8231_ata);
