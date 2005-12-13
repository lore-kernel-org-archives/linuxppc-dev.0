Return-Path: <galak@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7464368888
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Dec 2005 07:49:56 +1100 (EST)
Date: Tue, 13 Dec 2005 14:45:40 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.44.0512131444520.6332-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Provide PCI OF functions even if we dont have true
 OF
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If we are building an arch/powerpc kernel we dont neccesarily
have a full OF implementation (and thus dont set CONFIG_PPC_OF)
but can use the OF PCI functions

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 761e102769add7e86d510f7605c06f4a82575015
tree e62bfa889a1789289e9fc031d8f883cb2291c6a4
parent 5ce33c8a0b8087f0c554a417efb907d35892e58b
author Kumar Gala <galak@kernel.crashing.org> Tue, 13 Dec 2005 14:40:11 -0600
committer Kumar Gala <galak@kernel.crashing.org> Tue, 13 Dec 2005 14:40:11 -0600

 arch/ppc/kernel/pci.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/ppc/kernel/pci.c b/arch/ppc/kernel/pci.c
index af36400..df4b11c 100644
--- a/arch/ppc/kernel/pci.c
+++ b/arch/ppc/kernel/pci.c
@@ -46,7 +46,7 @@ static void pcibios_fixup_resources(stru
 static void fixup_broken_pcnet32(struct pci_dev* dev);
 static int reparent_resources(struct resource *parent, struct resource *res);
 static void fixup_cpc710_pci64(struct pci_dev* dev);
-#ifdef CONFIG_PPC_OF
+#if defined(CONFIG_PPC_OF) || defined(CONFIG_PPC_MERGE)
 static u8* pci_to_OF_bus_map;
 #endif
 
@@ -626,7 +626,7 @@ pcibios_alloc_controller(void)
 	return hose;
 }
 
-#ifdef CONFIG_PPC_OF
+#if defined(CONFIG_PPC_OF) || defined(CONFIG_PPC_MERGE)
 /*
  * Functions below are used on OpenFirmware machines.
  */
@@ -1027,7 +1027,7 @@ void pcibios_make_OF_bus_map(void)
 /* Add sysfs properties */
 void pcibios_add_platform_entries(struct pci_dev *pdev)
 {
-#ifdef CONFIG_PPC_OF
+#if defined(CONFIG_PPC_OF) || defined(CONFIG_PPC_MERGE)
 	device_create_file(&pdev->dev, &dev_attr_devspec);
 #endif /* CONFIG_PPC_OF */
 }
