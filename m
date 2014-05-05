Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E77F61401DA
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:28:04 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 5 May 2014 11:28:03 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1813E2CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:28:02 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4516soJ3408242
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:06:55 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s451S1Kl011827
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:28:01 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 22/22] powerpc/powernv: Support PCI error injection
Date: Mon,  5 May 2014 11:28:11 +1000
Message-Id: <1399253291-3975-23-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1399253291-3975-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1399253291-3975-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch introduces the infrastructure of error injection backend
for PowerNV platform. For now, we just implement logic to inject
PCI errors. We need support injecting other types of errors in
future.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s_errinjct.h |  19 +++
 arch/powerpc/platforms/powernv/Makefile    |   1 +
 arch/powerpc/platforms/powernv/errinjct.c  | 215 +++++++++++++++++++++++++++++
 3 files changed, 235 insertions(+)
 create mode 100644 arch/powerpc/platforms/powernv/errinjct.c

diff --git a/arch/powerpc/include/asm/book3s_errinjct.h b/arch/powerpc/include/asm/book3s_errinjct.h
index 35712be..75443ad 100644
--- a/arch/powerpc/include/asm/book3s_errinjct.h
+++ b/arch/powerpc/include/asm/book3s_errinjct.h
@@ -56,6 +56,25 @@ struct kvm_errinjct_token {
 	struct list_head list;
 };
 
+/* Argument buffer for various operations */
+struct kvm_errinjct_ioa_bus {
+	uint32_t addr;
+	uint32_t mask;
+	uint32_t cfg_addr;
+	uint32_t buid_hi;
+	uint32_t buid_lo;
+	uint32_t op;
+};
+
+struct kvm_errinjct_ioa_bus64 {
+	uint64_t addr;
+	uint64_t mask;
+	uint32_t cfg_addr;
+	uint32_t buid_hi;
+	uint32_t buid_lo;
+	uint32_t op;
+};
+
 int kvm_errinjct_register(int opcode, kvm_errinjct_func handler);
 int kvm_errinjct_unregister(int opcode);
 void kvmppc_errinjct_rtas(struct kvm_vcpu *vcpu,
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index d8ea670..d096b18 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -7,5 +7,6 @@ obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
 obj-$(CONFIG_EEH)	+= eeh-ioda.o eeh-powernv.o
 obj-$(CONFIG_KVM_EEH)	+= eeh-rtas.o
+obj-$(CONFIG_KVM_ERRINJCT)	+= errinjct.o
 obj-$(CONFIG_PPC_SCOM)	+= opal-xscom.o
 obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
diff --git a/arch/powerpc/platforms/powernv/errinjct.c b/arch/powerpc/platforms/powernv/errinjct.c
new file mode 100644
index 0000000..ccc7853
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/errinjct.c
@@ -0,0 +1,215 @@
+/*
+ * Backend for error injection implemented on PowerNV platform.
+ *
+ * Copyright Benjamin Herrenschmidt & Gavin Shan, IBM Corporation 2014.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/kvm_host.h>
+#include <linux/kvm.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+
+
+#include <asm/uaccess.h>
+#include <asm/pci-bridge.h>
+#include <asm/iommu.h>
+#include <asm/eeh.h>
+#include <asm/kvm_book3s.h>
+#include <asm/kvm_ppc.h>
+#include <asm/book3s_errinjct.h>
+#include <asm/hvcall.h>
+#include <asm/msi_bitmap.h>
+#include <asm/opal.h>
+
+#include "powernv.h"
+#include "pci.h"
+
+static int powernv_errinjct_ioa(struct kvm_vcpu *vcpu, rtas_arg_t buf)
+{
+	struct OpalErrinjct ej;
+	struct kvm_errinjct_ioa_bus args;
+	struct eeh_vfio_pci_addr addr;
+	struct eeh_pe *pe;
+	struct pnv_phb *phb;
+	long rc;
+	int ret = 0;
+
+	/* Word aligned buffer */
+	if (buf & 0x3) {
+		ret = -3;
+		goto out;
+	}
+
+	/* Copy over argument */
+	ret = kvm_read_guest(vcpu->kvm, buf, &args, sizeof(args));
+	if (ret) {
+		pr_warn("%s: Can't copyover arguments (%d)\n",
+			__func__, ret);
+		ret = -3;
+		goto out;
+	}
+
+	/*
+	 * Sanity check on operation. We don't support optional
+	 * operation (20) and last one (21) for now.
+	 */
+	if (args.op < 0 || args.op > 21) {
+		ret = -3;
+		goto out;
+	} else if (args.op >= 20) {
+		ret = -1;
+		goto out;
+	}
+
+	/*
+	 * Only do error injection on passthrou PE. It's notable
+	 * the "cfg_addr" is guest PE address
+	 */
+	addr.kvm = vcpu->kvm;
+	addr.buid_hi = args.buid_hi;
+	addr.buid_lo = args.buid_lo;
+	addr.pe_addr = args.cfg_addr;
+	pe = eeh_vfio_pe_get(&addr);
+	if (!pe) {
+		pr_warn("%s: Can't find passed PE (%08x-%08x-%08x)\n",
+			__func__, args.buid_hi, args.buid_lo, args.cfg_addr);
+		ret = -3;
+		goto out;
+	}
+
+	/*
+	 * Calling to OPAL API. We need host PE address
+	 * and PHB host BUID.
+	 */
+	phb = pe->phb->private_data;
+
+	ej.type		= OpalErrinjctTypeIoaBusError;
+	ej.ioa.addr	= args.addr;
+	ej.ioa.mask	= args.mask;
+	ej.ioa.phb_id	= phb->opal_id;
+	ej.ioa.pe	= pe->addr;
+	ej.ioa.function	=  args.op;
+	rc = opal_err_injct(&ej);
+	if (rc != OPAL_SUCCESS) {
+		pr_warn("%s: OPAL API returns %ld\n", __func__, rc);
+		ret = -1;
+		goto out;
+	}
+
+	ret = 0;
+out:
+	return ret;
+}
+
+static int powernv_errinjct_ioa64(struct kvm_vcpu *vcpu, rtas_arg_t buf)
+{
+	struct OpalErrinjct ej;
+	struct kvm_errinjct_ioa_bus64 args;
+	struct eeh_vfio_pci_addr addr;
+	struct eeh_pe *pe;
+	struct pnv_phb *phb;
+	long rc;
+	int ret = 0;
+
+	/* Double word aligned buffer */
+	if (buf & 0x7) {
+		ret = -3;
+		goto out;
+	}
+
+	/* Copy over argument */
+	ret = kvm_read_guest(vcpu->kvm, buf, &args, sizeof(args));
+	if (ret) {
+		pr_warn("%s: Can't copyover arguments (%d)\n",
+			__func__, ret);
+		ret = -3;
+		goto out;
+	}
+
+	/*
+	 * Sanity check on operation. We don't support optional
+	 * operation (20) and last one (21) for now.
+	 */
+	if (args.op < 0 || args.op > 21) {
+		ret = -3;
+		goto out;
+	} else if (args.op >= 20) {
+		ret = -1;
+		goto out;
+	}
+
+	/*
+	 * Only do error injection on passthrou PE. It's notable
+	 * that "cfg_addr" is guest PE address
+	 */
+	addr.kvm = vcpu->kvm;
+	addr.buid_hi = args.buid_hi;
+	addr.buid_lo = args.buid_lo;
+	addr.pe_addr = args.cfg_addr;
+	pe = eeh_vfio_pe_get(&addr);
+	if (!pe) {
+		pr_warn("%s: Can't find passed PE (%08x-%08x-%08x)\n",
+			__func__, args.buid_hi, args.buid_lo, args.cfg_addr);
+		ret = -3;
+		goto out;
+	}
+
+	/*
+	 * Calling to OPAL API. We need host PE address
+	 * and PHB host BUID.
+	 */
+	phb = pe->phb->private_data;
+
+	ej.type		  = OpalErrinjctTypeIoaBusError64;
+	ej.ioa64.addr	  = args.addr;
+	ej.ioa64.mask	  = args.mask;
+	ej.ioa64.phb_id	  = phb->opal_id;
+	ej.ioa64.pe	  = pe->addr;
+	ej.ioa64.function =  args.op;
+	rc = opal_err_injct(&ej);
+	if (rc != OPAL_SUCCESS) {
+		pr_warn("%s: OPAL API returns %ld\n", __func__, rc);
+		ret = -1;
+		goto out;
+	}
+
+	/* Success */
+	ret = 0;
+out:
+	return ret;
+}
+
+static struct kvm_errinjct_handler handlers[] = {
+	{ .opcode  = kvm_errinjct_ioa_bus_error,
+	  .handler = powernv_errinjct_ioa
+	},
+	{ .opcode  = kvm_errinjct_ioa_bus_error_64,
+	  .handler = powernv_errinjct_ioa64
+	}
+};
+
+static int __init powernv_errinjct_init(void)
+{
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(handlers); i++) {
+		ret = kvm_errinjct_register(handlers[i].opcode,
+					    handlers[i].handler);
+		if (ret) {
+			pr_warn("%s: Failure registering handler %d (%d)\n",
+				__func__, handlers[i].opcode, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+module_init(powernv_errinjct_init);
-- 
1.8.3.2
