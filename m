Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 141161401AA
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:28:00 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 5 May 2014 11:27:58 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 082623578048
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:56 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4516n8W21037262
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:06:49 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s451RtcO011512
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:27:55 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 09/22] powerpc/powernv: EEH RTAS emulation backend
Date: Mon,  5 May 2014 11:27:58 +1000
Message-Id: <1399253291-3975-10-git-send-email-gwshan@linux.vnet.ibm.com>
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

The implementation of EEH RTAS emulation is split up into 2 layers:
kvm and powernv platform layer. The KVM layer is quite simple to
dispatch RTAS requests from guest to powernv platform layer. After
that, the powernv platform layer takes care of the details, process
the request and return result to kvm layer.

The patch implements the infrastructure of powernv platform layer
for EEH RTAS emulation.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h            | 18 +++++++++
 arch/powerpc/platforms/powernv/Makefile   |  1 +
 arch/powerpc/platforms/powernv/eeh-rtas.c | 64 +++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)
 create mode 100644 arch/powerpc/platforms/powernv/eeh-rtas.c

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 677c719..7384dee 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -49,6 +49,24 @@ struct device_node;
 #define EEH_PE_RST_SETTLE_TIME		1800
 
 #ifdef CONFIG_KVM_EEH
+
+/*
+ * Those EEH RTAS operations are going to be emulated.
+ * According to PAPR specification, there're much more
+ * operations. However, the following RTAS operations
+ * are enough for EEH in guest to work properly.
+ */
+enum {
+	eeh_rtas_first			= 0,
+	eeh_rtas_set_option		= 0,
+	eeh_rtas_set_slot_reset		= 1,
+	eeh_rtas_read_slot_reset_state2	= 2,
+	eeh_rtas_get_config_addr_info2	= 3,
+	eeh_rtas_slot_error_detail	= 4,
+	eeh_rtas_configure_pe		= 5,
+	eeh_rtas_last			= 5
+};
+
 struct eeh_vfio_pci_addr {
 	struct kvm	*kvm;		/* KVM identifier		*/
 	unsigned int	buid_hi;	/* PHB BUID high		*/
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 63cebb9..d8ea670 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -6,5 +6,6 @@ obj-y			+= opal-msglog.o
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
 obj-$(CONFIG_EEH)	+= eeh-ioda.o eeh-powernv.o
+obj-$(CONFIG_KVM_EEH)	+= eeh-rtas.o
 obj-$(CONFIG_PPC_SCOM)	+= opal-xscom.o
 obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
diff --git a/arch/powerpc/platforms/powernv/eeh-rtas.c b/arch/powerpc/platforms/powernv/eeh-rtas.c
new file mode 100644
index 0000000..fded461
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/eeh-rtas.c
@@ -0,0 +1,64 @@
+/*
+ * The file intends to implement emulation for EEH related RTAS services,
+ * which is expected to be done inside hypervisor. The specific RTAS
+ * service is identified by its unique token. Currently, the tokens
+ * are assigned by QEMU in a dynamic way and the dedicated hcall (0xf000)
+ * was introduced for the purpose of RTAS emulation either in hypervisor
+ * or QEMU.
+ *
+ * Copyright Benjamin Herrenschmidt & Gavin Shan, IBM Corporation 2014.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/bootmem.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/kvm_host.h>
+#include <linux/msi.h>
+#include <linux/pci.h>
+#include <linux/string.h>
+
+#include <asm/rtas.h>
+#include <asm/eeh.h>
+#include <asm/eeh_event.h>
+#include <asm/io.h>
+#include <asm/iommu.h>
+#include <asm/opal.h>
+#include <asm/msi_bitmap.h>
+#include <asm/pci-bridge.h>
+#include <asm/ppc-pci.h>
+#include <asm/tce.h>
+
+#include "powernv.h"
+#include "pci.h"
+
+/**
+ * kvmppc_eeh_rtas - Backend for EEH RTAS emulation
+ * @vcpu: KVM virtual CPU
+ * @args: RTAS parameter
+ * @op: identifier of the specific EEH RTAS service
+ *
+ * The function will be called when the hypervisor receives emulation
+ * request on EEH RTAS from guest. Accordingly, it will dispatch to
+ * specific functions to handle the request.
+ */
+void kvmppc_eeh_rtas(struct kvm_vcpu *vcpu, struct rtas_args *args, int op)
+{
+	int ret = -3;
+
+	/* Parse the requested service */
+	switch (op) {
+	default:
+		pr_warn("%s: Unsupported EEH RTAS service#%d\n",
+			__func__, op);
+	}
+
+	args->rets[0] = ret;
+}
-- 
1.8.3.2
