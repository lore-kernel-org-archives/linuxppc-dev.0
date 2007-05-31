Return-Path: <mroos@ut.ee>
Received: from smtp2.it.da.ut.ee (smtp2.it.da.ut.ee [193.40.5.67])
	by ozlabs.org (Postfix) with ESMTP id 661A4DDF8C
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 20:32:47 +1000 (EST)
Received: from math.ut.ee (math.ut.ee [193.40.36.2])
	by smtp2.it.da.ut.ee (Postfix) with ESMTP id 028374C0396A
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 13:09:33 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
	by math.ut.ee (Postfix) with ESMTP id EA6AB6ADEB
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 13:09:32 +0300 (EEST)
Date: Thu, 31 May 2007 13:09:32 +0300 (EEST)
From: Meelis Roos <mroos@ut.ee>
Sender: mroos@math.ut.ee
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [ppc] fix mot_info section
Message-ID: <Pine.SOC.4.64.0705311308530.12340@math>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(resend to linuxppc-dev)

The following patch makes mot_info __initdata since it is used only in
__init functions. prep_pci.c change has been tested in real life on
Motorola Powerstack II (compiles without modpost warnings and boots
fine), pplus.c has not been tested but seems similar.

Signed-off-by: Meelis Roos <mroos@linux.ee>

diff --git a/arch/ppc/platforms/pplus.c b/arch/ppc/platforms/pplus.c
index 8a1788c..c569962 100644
--- a/arch/ppc/platforms/pplus.c
+++ b/arch/ppc/platforms/pplus.c
@@ -256,7 +256,7 @@ struct brd_info {
 	const char *name;
 	int (*map_irq) (struct pci_dev *, unsigned char, unsigned char);
 };
-struct brd_info mot_info[] = {
+struct brd_info mot_info[] __initdata = {
 	{0x300, 0x00, 0x00, "MVME 2400", Genesis2_map_irq},
 	{0x1E0, 0xE0, 0x00, "Mesquite cPCI (MCP750)", mesquite_map_irq},
 	{0x1E0, 0xE1, 0x00, "Sitka cPCI (MCPN750)", sitka_map_irq},
diff --git a/arch/ppc/platforms/prep_pci.c b/arch/ppc/platforms/prep_pci.c
index 1df3150..d8c4e28 100644
--- a/arch/ppc/platforms/prep_pci.c
+++ b/arch/ppc/platforms/prep_pci.c
@@ -803,7 +803,7 @@ struct mot_info {
 	void            (*map_non0_bus)(struct pci_dev *);      /* For boards with more than bus 0 devices. */
 	struct powerplus_irq_list *pci_irq_list; /* List of PCI MPIC inputs */
 	unsigned char   secondary_bridge_devfn; /* devfn of secondary bus transparent bridge */
-} mot_info[] = {
+} mot_info[] __initdata = {
 	{0x300, 0x00, 0x00, "MVME 2400",			Genesis2_pci_IRQ_map,	Raven_pci_IRQ_routes, Powerplus_Map_Non0, &Powerplus_pci_IRQ_list, 0xFF},
 	{0x010, 0x00, 0x00, "Genesis",				Genesis_pci_IRQ_map,	Genesis_pci_IRQ_routes, Powerplus_Map_Non0, &Powerplus_pci_IRQ_list, 0x00},
 	{0x020, 0x00, 0x00, "Powerstack (Series E)",		Comet_pci_IRQ_map,	Comet_pci_IRQ_routes, NULL, NULL, 0x00},

-- 
Meelis Roos (mroos@linux.ee)
