Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFmTL6HBGzDvjR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2016 04:03:34 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tFmTL2Ygpz9t2D
 for <linuxppc-dev@ozlabs.org>; Sat, 12 Nov 2016 04:03:34 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uABGx86Q002277
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2016 12:03:32 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26nbwngv9x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2016 12:03:32 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 11 Nov 2016 10:03:31 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 09/11] VAS: Define/use vas_print_regs()
Date: Fri, 11 Nov 2016 09:02:54 -0800
In-Reply-To: <1478883776-11121-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1478883776-11121-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1478883776-11121-10-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define an interface to read and print the VAS error/debug registers.

Currently this interface only prints the Fault Isolation Registers
(FIR). It needs to make OPAL call(s) to read the registers since
they are only available via the SCOM interface.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h            |  3 +-
 arch/powerpc/include/asm/opal.h                |  1 +
 arch/powerpc/include/asm/vas.h                 |  5 ++++
 arch/powerpc/kernel/process.c                  |  3 ++
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 drivers/misc/vas/vas.c                         | 38 ++++++++++++++++++++++++++
 6 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 0e2e57b..eabe07e 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -167,7 +167,8 @@
 #define OPAL_INT_EOI				124
 #define OPAL_INT_SET_MFRR			125
 #define OPAL_PCI_TCE_KILL			126
-#define OPAL_LAST				126
+#define OPAL_VAS_READ_FIR			128
+#define OPAL_LAST				128
 
 /* Device tree flags */
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index ee05bd2..b20ec10 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -228,6 +228,7 @@ int64_t opal_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
 int64_t opal_rm_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
 			     uint32_t pe_num, uint32_t tce_size,
 			     uint64_t dma_addr, uint32_t npages);
+int64_t opal_vas_read_fir(uint32_t chip_id, int32_t idx, __be64 *fir);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
index 5ed3357..ca5a3b0 100644
--- a/arch/powerpc/include/asm/vas.h
+++ b/arch/powerpc/include/asm/vas.h
@@ -131,4 +131,9 @@ extern int vas_copy_crb(void *crb, int offset, bool first);
  */
 extern int vas_paste_crb(struct vas_window *win, int off, bool last, bool re);
 
+/*
+ * Print the VAS Fault Isolation Registers (FIR) for the chip @chip.
+ * Used when we encounter an error/exception in VAS.
+ */
+void vas_print_regs(int chip);
 #endif
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 9ee2623..1dbc8a8 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -62,6 +62,7 @@
 
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
+#include <asm/vas.h>
 
 /* Transactional Memory debug */
 #ifdef TM_DEBUG_SW
@@ -1339,6 +1340,8 @@ void show_regs(struct pt_regs * regs)
 			break;
 	}
 	printk("\n");
+
+	vas_print_regs(0);
 #ifdef CONFIG_KALLSYMS
 	/*
 	 * Lookup NIP late so we have the best change of getting the
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 3d29d40..acb6396 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -308,3 +308,4 @@ OPAL_CALL(opal_int_eoi,				OPAL_INT_EOI);
 OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
 OPAL_CALL(opal_pci_tce_kill,			OPAL_PCI_TCE_KILL);
 OPAL_CALL_REAL(opal_rm_pci_tce_kill,		OPAL_PCI_TCE_KILL);
+OPAL_CALL(opal_vas_read_fir,			OPAL_VAS_READ_FIR);
diff --git a/drivers/misc/vas/vas.c b/drivers/misc/vas/vas.c
index 51f9c70..785e7a1 100644
--- a/drivers/misc/vas/vas.c
+++ b/drivers/misc/vas/vas.c
@@ -15,10 +15,48 @@
 #include <linux/io.h>
 #include <asm/vas.h>
 #include "vas-internal.h"
+#include <asm/opal-api.h>
+#include <asm/opal.h>
 
 int vas_initialized;
 struct vas_instance *vas_instances;
 
+/*
+ * Read the Fault Isolation Registers (FIR) from skiboot into @fir.
+ */
+static void read_fault_regs(int chip, uint64_t *fir)
+{
+	int i;
+	int64_t rc;
+
+	for (i = 0; i < 8; i++)
+		rc = opal_vas_read_fir(chip, i, &fir[i]);
+}
+
+/*
+ * Print the VAS Fault Isolation Registers (FIR) for the chip @chip.
+ * Used when we encounter an error/exception in VAS.
+ *
+ * TODO: Find the chip id where the exception occurred. Hard coding to
+ *	 chip 0 for now.
+ */
+void vas_print_regs(int chip)
+{
+	int i;
+	uint64_t firs[8];
+
+	/* TODO: Only dump FIRs for first chip for now */
+	if (chip == -1)
+		chip = 0;
+
+	read_fault_regs(chip, firs);
+	for (i = 0; i < 8; i += 4) {
+		pr_err("FIR%d: 0x%llx    0x%llx    0x%llx    0x%llx\n", i,
+				firs[i], firs[i+1], firs[i+2], firs[i+3]);
+	}
+}
+
+
 static void init_vas_chip(struct vas_instance *vinst)
 {
 	int i;
-- 
1.8.3.1
