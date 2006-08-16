Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 16 Aug 2006 22:04:14 +1000
Subject: [PATCH] Add a helper for calculating RTAS "config_addr" parameters
Message-Id: <20060816120416.E285467B69@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Several RTAS calls take a "config_addr" parameter, which is a particular
way of specifying a PCI busno, devfn and register number into a 32-bit word.
Currently these are open-coded, and I'll be adding another soon, replace
them with a helper that encapsulates the logic. Be more strict about masking
the busno too, just in case.

Booted on P5 LPAR.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/rtas_pci.c |    6 ++----
 include/asm-powerpc/rtas.h     |   16 ++++++++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

Index: git/arch/powerpc/kernel/rtas_pci.c
===================================================================
--- git.orig/arch/powerpc/kernel/rtas_pci.c
+++ git/arch/powerpc/kernel/rtas_pci.c
@@ -81,8 +81,7 @@ int rtas_read_config(struct pci_dn *pdn,
 	if (!config_access_valid(pdn, where))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	addr = ((where & 0xf00) << 20) | (pdn->busno << 16) |
-		(pdn->devfn << 8) | (where & 0xff);
+	addr = rtas_config_addr(pdn->busno, pdn->devfn, where);
 	buid = pdn->phb->buid;
 	if (buid) {
 		ret = rtas_call(ibm_read_pci_config, 4, 2, &returnval,
@@ -134,8 +133,7 @@ int rtas_write_config(struct pci_dn *pdn
 	if (!config_access_valid(pdn, where))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	addr = ((where & 0xf00) << 20) | (pdn->busno << 16) |
-		(pdn->devfn << 8) | (where & 0xff);
+	addr = rtas_config_addr(pdn->busno, pdn->devfn, where);
 	buid = pdn->phb->buid;
 	if (buid) {
 		ret = rtas_call(ibm_write_pci_config, 5, 1, NULL, addr,
Index: git/include/asm-powerpc/rtas.h
===================================================================
--- git.orig/include/asm-powerpc/rtas.h
+++ git/include/asm-powerpc/rtas.h
@@ -230,5 +230,21 @@ extern unsigned long rtas_rmo_buf;
 
 #define GLOBAL_INTERRUPT_QUEUE 9005
 
+/**
+ * rtas_config_addr - Format a busno, devfn and reg for RTAS.
+ * @busno: The bus number.
+ * @devfn: The device and function number as encoded by PCI_DEVFN().
+ * @reg: The register number.
+ *
+ * This function encodes the given busno, devfn and register number as
+ * required for RTAS calls that take a "config_addr" parameter.
+ * See PAPR requirement 7.3.4-1 for more info.
+ */
+static inline u32 rtas_config_addr(int busno, int devfn, int reg)
+{
+	return ((reg & 0xf00) << 20) | ((busno & 0xff) << 16) |
+			(devfn << 8) | (reg & 0xff);
+}
+
 #endif /* __KERNEL__ */
 #endif /* _POWERPC_RTAS_H */
