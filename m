Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rm4YB1cT5zDr2n
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 16:37:34 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rm4Y93qzZz9sdn
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2016 16:37:33 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/14] powerpc/powernv: Add XICS emulation APIs
Date: Fri,  8 Jul 2016 16:37:05 +1000
Message-Id: <1467959838-6900-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OPAL provides an emulated XICS interrupt controller to
use as a fallback on newer processors that don't have a
XICS. It's meant as a way to provide backward compatibility
with future processors. Add the corresponding interfaces.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/opal-api.h            | 6 +++++-
 arch/powerpc/include/asm/opal.h                | 5 +++++
 arch/powerpc/platforms/powernv/opal-wrappers.S | 4 ++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 72b5f27..170ba0c 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -162,7 +162,11 @@
 #define OPAL_PCI_GET_PRESENCE_STATE		119
 #define OPAL_PCI_GET_POWER_STATE		120
 #define OPAL_PCI_SET_POWER_STATE		121
-#define OPAL_LAST				121
+#define OPAL_INT_GET_XIRR			122
+#define	OPAL_INT_SET_CPPR			123
+#define OPAL_INT_EOI				124
+#define OPAL_INT_SET_MFRR			125
+#define OPAL_LAST				125
 
 /* Device tree flags */
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 3b369e9..42f0c95 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -218,6 +218,11 @@ int64_t opal_pci_set_power_state(uint64_t async_token, uint64_t id,
 				 uint64_t data);
 int64_t opal_pci_poll2(uint64_t id, uint64_t data);
 
+int64_t opal_int_get_xirr(uint32_t *out_xirr, bool just_poll);
+int64_t opal_int_set_cppr(uint8_t cppr);
+int64_t opal_int_eoi(uint32_t xirr);
+int64_t opal_int_set_mfrr(uint32_t cpu, uint8_t mfrr);
+
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
 				   int depth, void *data);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 7979d6d..c7764f9 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -307,3 +307,7 @@ OPAL_CALL(opal_get_device_tree,			OPAL_GET_DEVICE_TREE);
 OPAL_CALL(opal_pci_get_presence_state,		OPAL_PCI_GET_PRESENCE_STATE);
 OPAL_CALL(opal_pci_get_power_state,		OPAL_PCI_GET_POWER_STATE);
 OPAL_CALL(opal_pci_set_power_state,		OPAL_PCI_SET_POWER_STATE);
+OPAL_CALL(opal_int_get_xirr,			OPAL_INT_GET_XIRR);
+OPAL_CALL(opal_int_set_cppr,			OPAL_INT_SET_CPPR);
+OPAL_CALL(opal_int_eoi,				OPAL_INT_EOI);
+OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
-- 
2.7.4
