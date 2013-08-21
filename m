Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6BCF82C0352
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 13:03:26 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r7L33Lgf026795
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 22:03:22 -0500
Message-ID: <1377054200.25016.195.camel@pasglop>
Subject: [PATCH v2] powerpc/powernv: Return secondary CPUs to firmware on kexec
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Wed, 21 Aug 2013 13:03:20 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With OPAL v3 we can return secondary CPUs to firmware on kexec. This
allows firmware to do various cleanups making things generally more
reliable, and will enable the "new" kernel to call OPAL to perform
some reconfiguration tasks early on that can only be done while
all the CPUs are in firmware.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

v2: Actually applies on top of current kernels rather than some
obscure internal branch :-)

 arch/powerpc/include/asm/opal.h                |  2 ++
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 arch/powerpc/platforms/powernv/setup.c         | 11 +++++++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 029fe85..eebb221 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -124,6 +124,7 @@ extern int opal_enter_rtas(struct rtas_args *args,
 #define OPAL_PCI_POLL				62
 #define OPAL_PCI_MSI_EOI			63
 #define OPAL_PCI_GET_PHB_DIAG_DATA2		64
+#define OPAL_RETURN_CPU				69
 
 #ifndef __ASSEMBLY__
 
@@ -631,6 +632,7 @@ int64_t opal_set_system_attention_led(uint8_t led_action);
 int64_t opal_pci_next_error(uint64_t phb_id, uint64_t *first_frozen_pe,
 			    uint16_t *pci_error_type, uint16_t *severity);
 int64_t opal_pci_poll(uint64_t phb_id);
+int64_t opal_return_cpu(void);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname, int depth, void *data);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index e88863f..874e5ff 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -111,3 +111,4 @@ OPAL_CALL(opal_pci_next_error,			OPAL_PCI_NEXT_ERROR);
 OPAL_CALL(opal_pci_poll,			OPAL_PCI_POLL);
 OPAL_CALL(opal_pci_msi_eoi,			OPAL_PCI_MSI_EOI);
 OPAL_CALL(opal_pci_get_phb_diag_data2,		OPAL_PCI_GET_PHB_DIAG_DATA2);
+OPAL_CALL(opal_return_cpu,			OPAL_RETURN_CPU);
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 84438af..7e3b464 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -31,6 +31,7 @@
 #include <asm/xics.h>
 #include <asm/rtas.h>
 #include <asm/opal.h>
+#include <asm/kexec.h>
 
 #include "powernv.h"
 
@@ -147,6 +148,16 @@ static void pnv_shutdown(void)
 static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)
 {
 	xics_kexec_teardown_cpu(secondary);
+
+	/* Return secondary CPUs to firmware on OPAL v3 */
+	if (firmware_has_feature(FW_FEATURE_OPALv3) && secondary) {
+		mb();
+		get_paca()->kexec_state = KEXEC_STATE_REAL_MODE;
+		mb();
+
+		/* Return the CPU to OPAL */
+		opal_return_cpu();
+	}
 }
 #endif /* CONFIG_KEXEC */
 
