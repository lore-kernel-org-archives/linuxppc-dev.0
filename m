Return-Path: <okaya@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhyM91YwMzDr6C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 09:49:40 +1100 (AEDT)
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Sinan Kaya <okaya@codeaurora.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Rob Herring <robh@kernel.org>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Bhumika Goyal <bhumirks@gmail.com>,
 linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND
 64-BIT)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 02/29] powerpc/PCI: deprecate pci_get_bus_and_slot()
Date: Wed, 22 Nov 2017 17:48:57 -0500
Message-Id: <1511390964-9979-3-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
References: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function in favor of
pci_get_domain_bus_and_slot().

Use pci_get_domain_bus_and_slot() with a domain number of 0 as the code
is not ready to consume multiple domains and existing code used domain
number 0.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/powerpc/kernel/pci_32.c              | 3 ++-
 arch/powerpc/platforms/powermac/feature.c | 2 +-
 arch/powerpc/sysdev/mv64x60_pci.c         | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 1d817f4..85ad2f7 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -96,7 +96,8 @@
 		reg = of_get_property(node, "reg", NULL);
 		if (!reg)
 			continue;
-		dev = pci_get_bus_and_slot(pci_bus, ((reg[0] >> 8) & 0xff));
+		dev = pci_get_domain_bus_and_slot(0, pci_bus,
+						  ((reg[0] >> 8) & 0xff));
 		if (!dev || !dev->subordinate) {
 			pci_dev_put(dev);
 			continue;
diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index 9e3f39d..ed8b166 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -829,7 +829,7 @@ static long core99_scc_enable(struct device_node *node, long param, long value)
 
 	if (value) {
 		if (pci_device_from_OF_node(node, &pbus, &pid) == 0)
-			pdev = pci_get_bus_and_slot(pbus, pid);
+			pdev = pci_get_domain_bus_and_slot(0, pbus, pid);
 		if (pdev == NULL)
 			return 0;
 		rc = pci_enable_device(pdev);
diff --git a/arch/powerpc/sysdev/mv64x60_pci.c b/arch/powerpc/sysdev/mv64x60_pci.c
index d52b3b8..6fe9104 100644
--- a/arch/powerpc/sysdev/mv64x60_pci.c
+++ b/arch/powerpc/sysdev/mv64x60_pci.c
@@ -37,7 +37,7 @@ static ssize_t mv64x60_hs_reg_read(struct file *filp, struct kobject *kobj,
 	if (count < MV64X60_VAL_LEN_MAX)
 		return -EINVAL;
 
-	phb = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
+	phb = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
 	if (!phb)
 		return -ENODEV;
 	pci_read_config_dword(phb, MV64X60_PCICFG_CPCI_HOTSWAP, &v);
@@ -61,7 +61,7 @@ static ssize_t mv64x60_hs_reg_write(struct file *filp, struct kobject *kobj,
 	if (sscanf(buf, "%i", &v) != 1)
 		return -EINVAL;
 
-	phb = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
+	phb = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
 	if (!phb)
 		return -ENODEV;
 	pci_write_config_dword(phb, MV64X60_PCICFG_CPCI_HOTSWAP, v);
-- 
1.9.1
