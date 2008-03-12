Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 5FFC7DE1A8
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 10:45:59 +1100 (EST)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B01FE197D
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 19:45:50 -0400 (EDT)
Received: from thinkcentre (24-155-246-53.dyn.grandenetworks.net
	[24.155.246.53]) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
	ESMTP id 5614A197C for <linuxppc-dev@ozlabs.org>;
	Wed, 12 Mar 2008 19:45:46 -0400 (EDT)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] maple: kill fixup_maple_ide
Date: Wed, 12 Mar 2008 18:43:04 -0500
Message-Id: <1205365385-28315-3-git-send-email-ntl@pobox.com>
In-Reply-To: <1205365385-28315-1-git-send-email-ntl@pobox.com>
References: <1205365385-28315-1-git-send-email-ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This function has been a no-op for about 18 months; it's there in
the history should anyone need to resurrect it.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/platforms/maple/pci.c |   47 ------------------------------------
 1 files changed, 0 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index 3ffa0ac..3018552 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -592,50 +592,3 @@ int maple_pci_get_legacy_ide_irq(struct pci_dev *pdev, int channel)
 	}
 	return irq;
 }
-
-/* XXX: To remove once all firmwares are ok */
-static void fixup_maple_ide(struct pci_dev* dev)
-{
-	if (!machine_is(maple))
-		return;
-
-#if 0 /* Enable this to enable IDE port 0 */
-	{
-		u8 v;
-
-		pci_read_config_byte(dev, 0x40, &v);
-		v |= 2;
-		pci_write_config_byte(dev, 0x40, v);
-	}
-#endif
-#if 0 /* fix bus master base */
-	pci_write_config_dword(dev, 0x20, 0xcc01);
-	printk("old ide resource: %lx -> %lx \n",
-	       dev->resource[4].start, dev->resource[4].end);
-	dev->resource[4].start = 0xcc00;
-	dev->resource[4].end = 0xcc10;
-#endif
-#if 0 /* Enable this to fixup IDE sense/polarity of irqs in IO-APICs */
-	{
-		struct pci_dev *apicdev;
-		u32 v;
-
-		apicdev = pci_get_slot (dev->bus, PCI_DEVFN(5,0));
-		if (apicdev == NULL)
-			printk("IDE Fixup IRQ: Can't find IO-APIC !\n");
-		else {
-			pci_write_config_byte(apicdev, 0xf2, 0x10 + 2*14);
-			pci_read_config_dword(apicdev, 0xf4, &v);
-			v &= ~0x00000022;
-			pci_write_config_dword(apicdev, 0xf4, v);
-			pci_write_config_byte(apicdev, 0xf2, 0x10 + 2*15);
-			pci_read_config_dword(apicdev, 0xf4, &v);
-			v &= ~0x00000022;
-			pci_write_config_dword(apicdev, 0xf4, v);
-			pci_dev_put(apicdev);
-		}
-	}
-#endif
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_IDE,
-			 fixup_maple_ide);
-- 
1.5.4.4
