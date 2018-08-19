Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41tqkg2YgqzF2Dc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 07:26:34 +1000 (AEST)
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
CC: Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Sun, 19 Aug 2018 21:26:28 +0100 (BST)
Message-ID: <4c6da168591.7567d73b@auth.smtp.1and1.co.uk>
Subject: [PATCH NEXT v2 4/4] powerpc/pasemi: Connect Nemo boot code.
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="--=_BOUNDARY.6c124c601c8edb48.f1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Warning: This is a message in MIME format. Your mail reader does
not support MIME. Some parts of this message will be readable as
plain text. To see the rest, you will need to upgrade your mail
reader. Following are some URLs where you can find MIME-capable
mail programs for common platforms:

  AmigaOS...........: http://yam.ch/
  Unix/MacOS/Windows: http://www.mozilla.com/thunderbird/

General information about MIME can be found at:
http://en.wikipedia.org/wiki/MIME

----=_BOUNDARY.6c124c601c8edb48.f1
Content-Type: text/plain

The previous 3 commits added support code for the Nemo motherbard
as used in the Amigaone X1000, now wire them up so the board can
be detected and initalised at boot time.
    
Signed-off-by: Darren Stevens <Darren@stevens-zone.net>

---

Changes made:

v2: Changed init code to be empty when NEMO=n rather than using
    #ifdefs
----=_BOUNDARY.6c124c601c8edb48.f1
Content-Type: text/plain;
	name="link.patch"
Content-Disposition: attachment;
	filename="link.patch";
	size=2437

diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
index c230acc..3ed0ff6 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -27,6 +27,7 @@
 #include <linux/pci.h>
 
 #include <asm/pci-bridge.h>
+#include <asm/isa-bridge.h>
 #include <asm/machdep.h>
 
 #include <asm/ppc-pci.h>
@@ -182,6 +183,8 @@ static int pa_pxp_read_config(struct pci_bus *bus, unsigned int devfn,
 
 	addr = pa_pxp_cfg_addr(hose, bus->number, devfn, offset);
 
+	sb600_set_flag(bus->number);
+
 	/*
 	 * Note: the caller has already checked that offset is
 	 * suitably aligned and that len is 1, 2 or 4.
@@ -216,6 +219,8 @@ static int pa_pxp_write_config(struct pci_bus *bus, unsigned int devfn,
 
 	addr = pa_pxp_cfg_addr(hose, bus->number, devfn, offset);
 
+	sb600_set_flag(bus->number);
+
 	/*
 	 * Note: the caller has already checked that offset is
 	 * suitably aligned and that len is 1, 2 or 4.
@@ -266,6 +271,11 @@ static int __init pas_add_bridge(struct device_node *dev)
 	/* Interpret the "ranges" property */
 	pci_process_bridge_OF_ranges(hose, dev, 1);
 
+	/* Scan for an isa bridge. This is needed to find the SB600
+	   on the nemo and does nothing on machines without one
+	 */
+	isa_bridge_find_early(hose);
+
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 98bf2f7..49e67cf 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -314,6 +314,8 @@ static __init void pas_init_IRQ(void)
 		mpic_unmask_irq(irq_get_irq_data(nmi_virq));
 	}
 
+	nemo_init_IRQ(mpic);
+
 	of_node_put(mpic_node);
 	of_node_put(root);
 }
@@ -475,6 +477,8 @@ static int __init pasemi_publish_devices(void)
 	/* Publish OF platform devices for SDC and other non-PCI devices */
 	of_platform_bus_probe(NULL, pasemi_bus_ids, NULL);
 
+	nemo_init_rtc();
+
 	return 0;
 }
 machine_device_initcall(pasemi, pasemi_publish_devices);
@@ -489,6 +493,17 @@ static int __init pas_probe(void)
 	    !of_machine_is_compatible("pasemi,pwrficient"))
 		return 0;
 
+#ifdef CONFIG_PPC_PASEMI_NEMO
+	/*
+	 * Check for the Nemo motherboard here, if we are running on one
+	 * change the machine definition to fit
+	 */
+	if (of_machine_is_compatible("pasemi,nemo")) {
+		pm_power_off		= pas_shutdown;
+		ppc_md.name		= "A-EON Amigaone X1000";
+	}
+#endif
+
 	iommu_init_early_pasemi();
 
 	return 1;

----=_BOUNDARY.6c124c601c8edb48.f1--
