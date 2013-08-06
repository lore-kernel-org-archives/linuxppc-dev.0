Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 25/63] powerpc: Make PCI device node device tree accesses
 endian safe
Date: Wed,  7 Aug 2013 02:01:42 +1000
Message-Id: <1375804940-22050-26-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
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
 arch/powerpc/kernel/pci_dn.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index df03844..1f61fab 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -47,9 +47,8 @@ struct pci_dn *pci_get_pdn(struct pci_dev *pdev)
 void *update_dn_pci_info(struct device_node *dn, void *data)
 {
 	struct pci_controller *phb = data;
-	const int *type =
-		of_get_property(dn, "ibm,pci-config-space-type", NULL);
-	const u32 *regs;
+	const __be32 *type = of_get_property(dn, "ibm,pci-config-space-type", NULL);
+	const __be32 *regs;
 	struct pci_dn *pdn;
 
 	pdn = zalloc_maybe_bootmem(sizeof(*pdn), GFP_KERNEL);
@@ -63,12 +62,14 @@ void *update_dn_pci_info(struct device_node *dn, void *data)
 #endif
 	regs = of_get_property(dn, "reg", NULL);
 	if (regs) {
+		u32 addr = of_read_number(regs, 1);
+
 		/* First register entry is addr (00BBSS00)  */
-		pdn->busno = (regs[0] >> 16) & 0xff;
-		pdn->devfn = (regs[0] >> 8) & 0xff;
+		pdn->busno = (addr >> 16) & 0xff;
+		pdn->devfn = (addr >> 8) & 0xff;
 	}
 
-	pdn->pci_ext_config_space = (type && *type == 1);
+	pdn->pci_ext_config_space = (type && of_read_number(type, 1) == 1);
 	return NULL;
 }
 
@@ -98,12 +99,13 @@ void *traverse_pci_devices(struct device_node *start, traverse_func pre,
 
 	/* We started with a phb, iterate all childs */
 	for (dn = start->child; dn; dn = nextdn) {
-		const u32 *classp;
-		u32 class;
+		const __be32 *classp;
+		u32 class = 0;
 
 		nextdn = NULL;
 		classp = of_get_property(dn, "class-code", NULL);
-		class = classp ? *classp : 0;
+		if (classp)
+			class = of_read_number(classp, 1);
 
 		if (pre && ((ret = pre(dn, data)) != NULL))
 			return ret;
-- 
1.8.1.2
