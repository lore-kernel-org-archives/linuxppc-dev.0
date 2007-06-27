Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DC01BDDE10
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 11:16:44 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/15] [POWERPC] Remove set_cfg_type for PCI indirect users
	that don't need it
Date: Tue, 26 Jun 2007 20:16:31 -0500
Message-Id: <11829070063989-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11829070051484-git-send-email-galak@kernel.crashing.org>
References: <11829070051484-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Freescale and Marvell PCI controllers dont require explicit setting for
type 1 config cycles.  They handle producing them by implicitly looking at the
bus, devfn.

The TSI108 and 52xx don't use the generic PCI indirect code and thus don't
bother with set_cfg_type.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/52xx/mpc52xx_pci.c |    1 -
 arch/powerpc/platforms/82xx/mpc82xx_ads.c |    3 ---
 arch/powerpc/platforms/83xx/pci.c         |    1 -
 arch/powerpc/platforms/85xx/pci.c         |    1 -
 arch/powerpc/platforms/86xx/pci.c         |    1 -
 arch/powerpc/sysdev/mv64x60_pci.c         |    1 -
 arch/powerpc/sysdev/tsi108_pci.c          |    1 -
 7 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pci.c b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
index 34d34a2..51164c8 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
@@ -390,7 +390,6 @@ mpc52xx_add_bridge(struct device_node *node)
 		return -ENOMEM;
 
 	hose->arch_data = node;
-	hose->set_cfg_type = 1;
 
 	hose->first_busno = bus_range ? bus_range[0] : 0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
diff --git a/arch/powerpc/platforms/82xx/mpc82xx_ads.c b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
index 081c0ab..04bf570 100644
--- a/arch/powerpc/platforms/82xx/mpc82xx_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
@@ -548,14 +548,11 @@ static void __init mpc82xx_add_bridge(struct device_node *np)
 		return;
 
 	hose->arch_data = np;
-	hose->set_cfg_type = 1;
 
 	hose->first_busno = bus_range ? bus_range[0] : 0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
 	hose->bus_offset = 0;
 
-	hose->set_cfg_type = 1;
-
 	setup_indirect_pci(hose,
 			   r.start + offsetof(pci_cpm2_t, pci_cfg_addr),
 			   r.start + offsetof(pci_cpm2_t, pci_cfg_data));
diff --git a/arch/powerpc/platforms/83xx/pci.c b/arch/powerpc/platforms/83xx/pci.c
index 1752d45..3471602 100644
--- a/arch/powerpc/platforms/83xx/pci.c
+++ b/arch/powerpc/platforms/83xx/pci.c
@@ -70,7 +70,6 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 	if (!hose)
 		return -ENOMEM;
 	hose->arch_data = dev;
-	hose->set_cfg_type = 1;
 
 	hose->first_busno = bus_range ? bus_range[0] : 0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
diff --git a/arch/powerpc/platforms/85xx/pci.c b/arch/powerpc/platforms/85xx/pci.c
index 3c38ae4..72a1bc5 100644
--- a/arch/powerpc/platforms/85xx/pci.c
+++ b/arch/powerpc/platforms/85xx/pci.c
@@ -61,7 +61,6 @@ int __init mpc85xx_add_bridge(struct device_node *dev)
 	if (!hose)
 		return -ENOMEM;
 	hose->arch_data = dev;
-	hose->set_cfg_type = 1;
 
 	hose->first_busno = bus_range ? bus_range[0] : 0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
diff --git a/arch/powerpc/platforms/86xx/pci.c b/arch/powerpc/platforms/86xx/pci.c
index c1d65fa..1e47c14 100644
--- a/arch/powerpc/platforms/86xx/pci.c
+++ b/arch/powerpc/platforms/86xx/pci.c
@@ -172,7 +172,6 @@ int __init mpc86xx_add_bridge(struct device_node *dev)
 	if (!hose)
 		return -ENOMEM;
 	hose->arch_data = dev;
-	hose->set_cfg_type = 1;
 
 	/* last_busno = 0xfe cause by MPC8641 PCIE bug */
 	hose->first_busno = bus_range ? bus_range[0] : 0x0;
diff --git a/arch/powerpc/sysdev/mv64x60_pci.c b/arch/powerpc/sysdev/mv64x60_pci.c
index b5aef4c..6b08e76 100644
--- a/arch/powerpc/sysdev/mv64x60_pci.c
+++ b/arch/powerpc/sysdev/mv64x60_pci.c
@@ -142,7 +142,6 @@ static int __init mv64x60_add_bridge(struct device_node *dev)
 		return -ENOMEM;
 
 	hose->arch_data = dev;
-	hose->set_cfg_type = 1;
 
 	hose->first_busno = bus_range ? bus_range[0] : 0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index 2153163..33177b6 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -226,7 +226,6 @@ int __init tsi108_setup_pci(struct device_node *dev, u32 cfg_phys, int primary)
 		return -ENOMEM;
 	}
 	hose->arch_data = dev;
-	hose->set_cfg_type = 1;
 
 	hose->first_busno = bus_range ? bus_range[0] : 0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
-- 
1.5.2.1
