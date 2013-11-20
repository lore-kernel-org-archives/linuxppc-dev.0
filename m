Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 Ulrich.Weigand@de.ibm.com, alistair@popple.id.au
Subject: [PATCH 1/9] powerpc/pseries: Fix endian issues in pseries EEH code
Date: Wed, 20 Nov 2013 22:14:58 +1100
Message-Id: <1384946106-18200-2-git-send-email-anton@samba.org>
In-Reply-To: <1384946106-18200-1-git-send-email-anton@samba.org>
References: <1384946106-18200-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/platforms/pseries/eeh_pseries.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 7fbc25b..ccb633e 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -189,8 +189,9 @@ static void *pseries_eeh_of_probe(struct device_node *dn, void *flag)
 	struct eeh_dev *edev;
 	struct eeh_pe pe;
 	struct pci_dn *pdn = PCI_DN(dn);
-	const u32 *class_code, *vendor_id, *device_id;
-	const u32 *regs;
+	const __be32 *classp, *vendorp, *devicep;
+	u32 class_code;
+	const __be32 *regs;
 	u32 pcie_flags;
 	int enable = 0;
 	int ret;
@@ -201,22 +202,24 @@ static void *pseries_eeh_of_probe(struct device_node *dn, void *flag)
 		return NULL;
 
 	/* Retrieve class/vendor/device IDs */
-	class_code = of_get_property(dn, "class-code", NULL);
-	vendor_id  = of_get_property(dn, "vendor-id", NULL);
-	device_id  = of_get_property(dn, "device-id", NULL);
+	classp = of_get_property(dn, "class-code", NULL);
+	vendorp = of_get_property(dn, "vendor-id", NULL);
+	devicep = of_get_property(dn, "device-id", NULL);
 
 	/* Skip for bad OF node or PCI-ISA bridge */
-	if (!class_code || !vendor_id || !device_id)
+	if (!classp || !vendorp || !devicep)
 		return NULL;
 	if (dn->type && !strcmp(dn->type, "isa"))
 		return NULL;
 
+	class_code = of_read_number(classp, 1);
+
 	/*
 	 * Update class code and mode of eeh device. We need
 	 * correctly reflects that current device is root port
 	 * or PCIe switch downstream port.
 	 */
-	edev->class_code = *class_code;
+	edev->class_code = class_code;
 	edev->pcie_cap = pseries_eeh_find_cap(dn, PCI_CAP_ID_EXP);
 	edev->mode &= 0xFFFFFF00;
 	if ((edev->class_code >> 8) == PCI_CLASS_BRIDGE_PCI) {
@@ -243,12 +246,12 @@ static void *pseries_eeh_of_probe(struct device_node *dn, void *flag)
 	/* Initialize the fake PE */
 	memset(&pe, 0, sizeof(struct eeh_pe));
 	pe.phb = edev->phb;
-	pe.config_addr = regs[0];
+	pe.config_addr = of_read_number(regs, 1);
 
 	/* Enable EEH on the device */
 	ret = eeh_ops->set_option(&pe, EEH_OPT_ENABLE);
 	if (!ret) {
-		edev->config_addr = regs[0];
+		edev->config_addr = of_read_number(regs, 1);
 		/* Retrieve PE address */
 		edev->pe_config_addr = eeh_ops->get_pe_addr(&pe);
 		pe.addr = edev->pe_config_addr;
-- 
1.8.3.2
