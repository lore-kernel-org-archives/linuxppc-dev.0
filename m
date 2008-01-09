Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id B4DB7DDFAD
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 16:18:36 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/5] sbc85xx: remove PCI exclude device for sbc8548/sbc8560
Date: Wed,  9 Jan 2008 00:18:30 -0500
Message-Id: <11998559142028-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <11998559133555-git-send-email-paul.gortmaker@windriver.com>
References: <1199855910574-git-send-email-paul.gortmaker@windriver.com>
	<11998559111835-git-send-email-paul.gortmaker@windriver.com>
	<11998559121892-git-send-email-paul.gortmaker@windriver.com>
	<11998559133433-git-send-email-paul.gortmaker@windriver.com>
	<11998559133555-git-send-email-paul.gortmaker@windriver.com>
Message-Id: <c5cc1c9274b620f983c70674b957c9d558689591.1199854466.git.paul.gortmaker@windriver.com>
In-Reply-To: <93a0b006474cd6884392682c82b232fc2aea7794.1199854466.git.paul.gortmaker@windriver.com>
References: <93a0b006474cd6884392682c82b232fc2aea7794.1199854466.git.paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PCI exclude device for the sbc85xx boards was only filtering out
the PHB and nothing else.  This functionality is no longer required
at a board specific level -- it is handled as a more global quirk now.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/platforms/85xx/sbc8548.c |   13 -------------
 arch/powerpc/platforms/85xx/sbc8560.c |   13 -------------
 2 files changed, 0 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/platforms/85xx/sbc8548.c
index f3ab271..de27b57 100644
--- a/arch/powerpc/platforms/85xx/sbc8548.c
+++ b/arch/powerpc/platforms/85xx/sbc8548.c
@@ -49,17 +49,6 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
-#ifdef CONFIG_PCI
-static int sbc8548_exclude_device(struct pci_controller *hose,
-				  u_char bus, u_char devfn)
-{
-	if (bus == 0 && PCI_SLOT(devfn) == 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	else
-		return PCIBIOS_SUCCESSFUL;
-}
-#endif
-
 static void __init sbc8548_pic_init(void)
 {
 	struct mpic *mpic;
@@ -114,8 +103,6 @@ static void __init sbc8548_setup_arch(void)
 				fsl_add_bridge(np, 0);
 		}
 	}
-
-	ppc_md.pci_exclude_device = sbc8548_exclude_device;
 #endif
 }
 
diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/platforms/85xx/sbc8560.c
index 6aef38b..2030e87 100644
--- a/arch/powerpc/platforms/85xx/sbc8560.c
+++ b/arch/powerpc/platforms/85xx/sbc8560.c
@@ -37,17 +37,6 @@
 #include <sysdev/cpm2_pic.h>
 #endif
 
-#ifdef CONFIG_PCI
-static int sbc8560_exclude_device(struct pci_controller *hose,
-				   u_char bus, u_char devfn)
-{
-	if (bus == 0 && PCI_SLOT(devfn) == 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	else
-		return PCIBIOS_SUCCESSFUL;
-}
-#endif /* CONFIG_PCI */
-
 #ifdef CONFIG_CPM2
 
 static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
@@ -199,8 +188,6 @@ static void __init sbc8560_setup_arch(void)
 #ifdef CONFIG_PCI
 	for_each_compatible_node(np, "pci", "fsl,mpc8540-pci")
 		fsl_add_bridge(np, 1);
-
-	ppc_md.pci_exclude_device = sbc8560_exclude_device;
 #endif
 }
 
-- 
1.5.0.rc1.gf4b6c
