Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 561E9140140
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 May 2014 17:49:52 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 9 May 2014 17:49:51 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 161C32CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 May 2014 17:49:49 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s497Sabx59965580
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 May 2014 17:28:36 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s497nlHG012854
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 May 2014 17:49:48 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 10/10] powerpc/powernv: Error injection infrastructure
Date: Fri,  9 May 2014 17:49:42 +1000
Message-Id: <1399621782-23281-11-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1399621782-23281-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1399621782-23281-1-git-send-email-gwshan@linux.vnet.ibm.com>
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

The patch intends to implemdent the error injection infrastructure
for PowerNV platform. The predetermined handlers will be called
according to the type of injected error (e.g. OpalErrinjctTypeIoaBusError).
For now, we just support PCI error injection. We need support
injecting other types of errors in future.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h            |   6 +
 arch/powerpc/platforms/powernv/Makefile    |   2 +-
 arch/powerpc/platforms/powernv/errinject.c | 224 +++++++++++++++++++++++++++++
 3 files changed, 231 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/powernv/errinject.c

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 7c4ffd0..7bf86ba 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -794,6 +794,12 @@ typedef struct oppanel_line {
 	uint64_t 	line_len;
 } oppanel_line_t;
 
+enum OpalCallToken{
+	OPAL_CALL_TOKEN_MIN = 0,
+	OPAL_CALL_TOKEN_ERRINJCT,
+	OPAL_CALL_TOKEN_MAX
+};
+
 /* /sys/firmware/opal */
 extern struct kobject *opal_kobj;
 
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 2b15a03..5ae8257 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -1,7 +1,7 @@
 obj-y			+= setup.o opal-takeover.o opal-wrappers.o opal.o opal-async.o
 obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
 obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
-obj-y			+= opal-msglog.o
+obj-y			+= opal-msglog.o errinject.o
 
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
diff --git a/arch/powerpc/platforms/powernv/errinject.c b/arch/powerpc/platforms/powernv/errinject.c
new file mode 100644
index 0000000..aa892d4
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/errinject.c
@@ -0,0 +1,224 @@
+/*
+ * The file intends to support error injection requests from host OS
+ * owned utility (e.g. errinjct) or VM. We need parse the information
+ * passed from user space and call to appropriate OPAL API accordingly.
+ *
+ * Copyright Benjamin Herrenschmidt & Gavin Shan, IBM Corporation 2014.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/msi.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include <asm/eeh.h>
+#include <asm/eeh_event.h>
+#include <asm/io.h>
+#include <asm/iommu.h>
+#include <asm/msi_bitmap.h>
+#include <asm/opal.h>
+#include <asm/pci-bridge.h>
+#include <asm/ppc-pci.h>
+#include <asm/rtas.h>
+#include <asm/tce.h>
+#include <asm/uaccess.h>
+
+#include "powernv.h"
+#include "pci.h"
+
+static int powernv_errinjct_ioa(struct rtas_args *args)
+{
+	return -ENXIO;
+}
+
+static int powernv_errinjct_ioa64(struct rtas_args *args)
+{
+	return -ENXIO;
+}
+
+#ifdef CONFIG_VFIO_EEH
+static int powernv_errinjct_ioa_virt(struct rtas_args *args)
+{
+	uint32_t addr, mask, cfg_addr;
+	uint32_t buid_hi, buid_lo, op;
+	uint64_t buf_addr = ((uint64_t)(args->args[3])) << 32 |
+			    args->args[4];
+	void __user *buf = (void __user *)buf_addr;
+	struct eeh_vfio_pci_addr vfio_addr;
+	struct pnv_phb *phb;
+	struct eeh_pe *pe;
+	struct OpalErrinjct ej;
+
+	/* Extract parameters */
+	if (get_user(addr, (uint32_t __user *)buf) ||
+	    get_user(mask, (uint32_t __user *)(buf + 4)) ||
+	    get_user(cfg_addr, (uint32_t __user *)(buf + 8)) ||
+	    get_user(buid_hi, (uint32_t __user *)(buf + 12)) ||
+	    get_user(buid_lo, (uint32_t __user *)(buf + 16)) ||
+	    get_user(op, (uint32_t __user *)(buf + 20)))
+		return -EFAULT;
+
+	/* Check opcode */
+	if (op < OpalEjtIoaLoadMemAddr ||
+	    op > OpalEjtIoaDmaWriteMemTarget)
+		return -EINVAL;
+
+	/* Find PE */
+	vfio_addr.buid = ((((uint64_t)buid_hi) << 32) | buid_lo);
+	vfio_addr.pe_addr = cfg_addr;
+	pe = eeh_vfio_pe_get(&vfio_addr);
+	if (!pe)
+		return -ENODEV;
+	phb = pe->phb->private_data;
+
+	/* OPAL call */
+	ej.type = OpalErrinjctTypeIoaBusError;
+	ej.ioa.addr = addr;
+	ej.ioa.mask = mask;
+	ej.ioa.phb_id = phb->opal_id;
+	ej.ioa.pe = pe->addr;
+	ej.ioa.function = op;
+	if (opal_err_injct(&ej) != OPAL_SUCCESS)
+		return -EIO;
+
+	return 0;
+}
+
+static int powernv_errinjct_ioa64_virt(struct rtas_args *args)
+{
+	uint32_t addr_hi, addr_lo, mask_hi, mask_lo;
+	uint32_t cfg_addr, buid_hi, buid_lo, op;
+	uint64_t buf_addr = ((uint64_t)(args->args[3])) << 32 |
+			    args->args[4];
+	void __user *buf = (void __user *)buf_addr;
+	struct eeh_vfio_pci_addr vfio_addr;
+	struct pnv_phb *phb;
+	struct eeh_pe *pe;
+	struct OpalErrinjct ej;
+
+	/* Extract parameters */
+	if (get_user(addr_hi, (uint32_t __user *)buf) ||
+	    get_user(addr_lo, (uint32_t __user *)(buf + 4)) ||
+	    get_user(mask_hi, (uint32_t __user *)(buf + 8)) ||
+	    get_user(mask_lo, (uint32_t __user *)(buf + 12)) ||
+	    get_user(cfg_addr, (uint32_t __user *)(buf + 16)) ||
+	    get_user(buid_hi, (uint32_t __user *)(buf + 20)) ||
+	    get_user(buid_lo, (uint32_t __user *)(buf + 24)) ||
+	    get_user(op, (uint32_t __user *)(buf + 28)))
+		return -EFAULT;
+
+	/* Check opcode */
+	if (op < OpalEjtIoaLoadMemAddr ||
+	    op > OpalEjtIoaDmaWriteMemTarget)
+		return -EINVAL;
+
+	/* Find PE */
+	vfio_addr.buid = ((((uint64_t)buid_hi) << 32) | buid_lo);
+	vfio_addr.pe_addr = (cfg_addr >> 8) & 0xffff;
+	pe = eeh_vfio_pe_get(&vfio_addr);
+	if (!pe)
+		return -ENODEV;
+	phb = pe->phb->private_data;
+
+	/* OPAL call */
+	ej.type = OpalErrinjctTypeIoaBusError64;
+	ej.ioa.addr = (((uint64_t)addr_hi) << 32) | addr_lo;
+	ej.ioa.mask = (((uint64_t)mask_hi) << 32) | mask_lo;
+	ej.ioa.phb_id = phb->opal_id;
+	ej.ioa.pe = pe->addr;
+	ej.ioa.function = op;
+	if (opal_err_injct(&ej) != OPAL_SUCCESS)
+		return -EIO;
+
+	return 0;
+}
+#endif /* CONFIG_VFIO_EEH */
+
+struct errinjct_handler {
+	bool virt;
+	int token;
+	int (*fn)(struct rtas_args *arg);
+};
+
+static struct errinjct_handler handlers[] = {
+#ifdef CONFIG_EEH
+	{ false,
+	  OpalErrinjctTypeIoaBusError,
+	  powernv_errinjct_ioa
+	},
+	{ false,
+	  OpalErrinjctTypeIoaBusError64,
+          powernv_errinjct_ioa64
+	},
+#endif
+#ifdef CONFIG_VFIO_EEH
+	{ true,
+	  OpalErrinjctTypeIoaBusError,
+	  powernv_errinjct_ioa_virt
+	},
+	{ true,
+	  OpalErrinjctTypeIoaBusError64,
+	  powernv_errinjct_ioa64_virt
+	},
+#endif
+};
+
+static int powernv_errinjct(struct rtas_args *args)
+{
+	struct errinjct_handler *h;
+	int token, ej_token, i;
+	bool virt;
+
+	/* Sanity check */
+	if (args->nargs != 5 || args->nret != 1)
+		return -EINVAL;
+
+	token = args->token;
+	virt = !!args->args[0];
+	if (!virt || token != OPAL_CALL_TOKEN_ERRINJCT)
+		return -EINVAL;
+
+	/* Call into specific handler */
+	ej_token = args->args[1];
+	for (i = 0; i < ARRAY_SIZE(handlers); i++) {
+		h = &handlers[i];
+		if (h->virt == virt &&
+		    h->token == ej_token &&
+		    h->fn)
+			return h->fn(args);
+	}
+
+	return -ENXIO;
+}
+
+static int __init powernv_errinjct_init(void)
+{
+	int ret;
+
+	ret = opal_call_handler_register(false, OPAL_CALL_TOKEN_ERRINJCT,
+					 powernv_errinjct);
+	if (ret) {
+		pr_warn("%s: Cannot register errinjct handler\n",
+			__func__);
+		return ret;
+	}
+
+	ret = opal_call_handler_register(true, OPAL_CALL_TOKEN_ERRINJCT,
+					 powernv_errinjct);
+	if (ret) {
+		pr_warn("%s: Cannot register errinjct virtual handler\n",
+			__func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+module_init(powernv_errinjct_init);
-- 
1.8.3.2
