Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 63DC5B7020
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 17:04:37 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 28 Feb 2012 11:34:30 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1S64JDd3211452
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 11:34:19 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1S64IiH005253
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 11:34:19 +0530
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/21] Platform dependent EEH operations
Date: Tue, 28 Feb 2012 14:03:53 +0800
Message-Id: <1330409051-8941-4-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1330409051-8941-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1330409051-8941-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

EEH has been implemented on RTAS-compliant pSeries platform.
That's to say, the EEH operations will be implemented through RTAS
calls eventually. The situation limited feasible extension on EEH.
In order to support EEH on multiple platforms like pseries and powernv
simutaneously. We have to split the platform dependent EEH options
up out of current implementation.

The patch addresses supporting EEH on multiple platforms. The pseries
platform dependent EEH operations will be abstracted by struct eeh_ops.
EEH core components will be built based on the registered EEH operations.
With the mechanism, what the individual platform needs to do is implement
platform dependent EEH operations.

For now, the pseries platform is covered under the mechanism. That means
we have to think about other platforms to support EEH, like powernv.
Besides, we only have framework for the mechanism and we have to implement
it for pseries platform later.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |   32 +++++
 arch/powerpc/platforms/pseries/Makefile      |    2 +-
 arch/powerpc/platforms/pseries/eeh.c         |   53 ++++++++
 arch/powerpc/platforms/pseries/eeh_pseries.c |  183 ++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/setup.c       |    1 +
 5 files changed, 270 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/eeh_pseries.c

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 2328877..0666c52 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -31,6 +31,26 @@ struct device_node;
 
 #ifdef CONFIG_EEH
 
+/*
+ * The struct is used to trace the registered EEH operation
+ * callback functions. Actually, those operation callback
+ * functions are heavily platform dependent. That means the
+ * platform should register its own EEH operation callback
+ * functions before any EEH further operations.
+ */
+struct eeh_ops {
+	char *name;
+	int (*init)(void);
+	int (*set_option)(struct device_node *dn, int option);
+	int (*get_pe_addr)(struct device_node *dn);
+	int (*get_state)(struct device_node *dn, int *state);
+	int (*reset)(struct device_node *dn, int option);
+	int (*wait_state)(struct device_node *dn, int max_wait);
+	int (*get_log)(struct device_node *dn, int severity, char *drv_log, unsigned long len);
+	int (*configure_bridge)(struct device_node *dn);
+};
+
+extern struct eeh_ops *eeh_ops;
 extern int eeh_subsystem_enabled;
 
 /* Values for eeh_mode bits in device_node */
@@ -47,6 +67,11 @@ extern int eeh_subsystem_enabled;
 #define EEH_MAX_ALLOWED_FREEZES 5
 
 void __init eeh_init(void);
+#ifdef CONFIG_PPC_PSERIES
+int __init eeh_pseries_init(void);
+#endif
+int __init eeh_ops_register(struct eeh_ops *ops);
+int __exit eeh_ops_unregister(const char *name);
 unsigned long eeh_check_failure(const volatile void __iomem *token,
 				unsigned long val);
 int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev);
@@ -73,6 +98,13 @@ void eeh_remove_bus_device(struct pci_dev *);
 #else /* !CONFIG_EEH */
 static inline void eeh_init(void) { }
 
+#ifdef CONFIG_PPC_PSERIES
+static inline int eeh_pseries_init(void)
+{
+	return 0;
+}
+#endif /* CONFIG_PPC_PSERIES */
+
 static inline unsigned long eeh_check_failure(const volatile void __iomem *token, unsigned long val)
 {
 	return val;
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 236db46..9aa5581 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -6,7 +6,7 @@ obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
 			   firmware.o power.o dlpar.o mobility.o
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_SCANLOG)	+= scanlog.o
-obj-$(CONFIG_EEH)	+= eeh.o eeh_cache.o eeh_driver.o eeh_event.o eeh_sysfs.o
+obj-$(CONFIG_EEH)	+= eeh.o eeh_cache.o eeh_driver.o eeh_event.o eeh_sysfs.o eeh_pseries.o
 obj-$(CONFIG_KEXEC)	+= kexec.o
 obj-$(CONFIG_PCI)	+= pci.o pci_dlpar.o
 obj-$(CONFIG_PSERIES_MSI)	+= msi.o
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index fa88589..b0e3fb0 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -97,6 +97,9 @@ static int ibm_get_config_addr_info2;
 static int ibm_configure_bridge;
 static int ibm_configure_pe;
 
+/* Platform dependent EEH operations */
+struct eeh_ops *eeh_ops = NULL;
+
 int eeh_subsystem_enabled;
 EXPORT_SYMBOL(eeh_subsystem_enabled);
 
@@ -1208,6 +1211,56 @@ static void *eeh_early_enable(struct device_node *dn, void *data)
 }
 
 /**
+ * eeh_ops_register - Register platform dependent EEH operations
+ * @ops: platform dependent EEH operations
+ *
+ * Register the platform dependent EEH operation callback
+ * functions. The platform should call this function before
+ * any other EEH operations.
+ */
+int __init eeh_ops_register(struct eeh_ops *ops)
+{
+	if (!ops->name) {
+		pr_warning("%s: Invalid EEH ops name for %p\n",
+			__func__, ops);
+		return -EINVAL;
+	}
+
+	if (eeh_ops && eeh_ops != ops) {
+		pr_warning("%s: EEH ops of platform %s already existing (%s)\n",
+			__func__, eeh_ops->name, ops->name);
+		return -EEXIST;
+	}
+
+	eeh_ops = ops;
+
+	return 0;
+}
+
+/**
+ * eeh_ops_unregister - Unreigster platform dependent EEH operations
+ * @name: name of EEH platform operations
+ *
+ * Unregister the platform dependent EEH operation callback
+ * functions.
+ */
+int __exit eeh_ops_unregister(const char *name)
+{
+	if (!name || !strlen(name)) {
+		pr_warning("%s: Invalid EEH ops name\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	if (eeh_ops && !strcmp(eeh_ops->name, name)) {
+		eeh_ops = NULL;
+		return 0;
+	}
+
+	return -EEXIST;
+}
+
+/**
  * eeh_init - EEH initialization
  *
  * Initialize EEH by trying to enable it for all of the adapters in the system.
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
new file mode 100644
index 0000000..61a9050
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -0,0 +1,183 @@
+/*
+ * The file intends to implement the platform dependent EEH operations on pseries.
+ * Actually, the pseries platform is built based on RTAS heavily. That means the
+ * pseries platform dependent EEH operations will be built on RTAS calls. The functions
+ * are devired from arch/powerpc/platforms/pseries/eeh.c and necessary cleanup has
+ * been done.
+ *
+ * Copyright Benjamin Herrenschmidt & Gavin Shan, IBM Corporation 2011.
+ * Copyright IBM Corporation 2001, 2005, 2006
+ * Copyright Dave Engebretsen & Todd Inglett 2001
+ * Copyright Linas Vepstas 2005, 2006
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/atomic.h>
+#include <linux/delay.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/of.h>
+#include <linux/pci.h>
+#include <linux/proc_fs.h>
+#include <linux/rbtree.h>
+#include <linux/sched.h>
+#include <linux/seq_file.h>
+#include <linux/spinlock.h>
+
+#include <asm/eeh.h>
+#include <asm/eeh_event.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/ppc-pci.h>
+#include <asm/rtas.h>
+
+/**
+ * pseries_eeh_init - EEH platform dependent initialization
+ *
+ * EEH platform dependent initialization on pseries.
+ */
+static int pseries_eeh_init(void)
+{
+	return 0;
+}
+
+/**
+ * pseries_eeh_set_option - Initialize EEH or MMIO/DMA reenable
+ * @dn: device node
+ * @option: operation to be issued
+ *
+ * The function is used to control the EEH functionality globally.
+ * Currently, following options are support according to PAPR:
+ * Enable EEH, Disable EEH, Enable MMIO and Enable DMA
+ */
+static int pseries_eeh_set_option(struct device_node *dn, int option)
+{
+	return 0;
+}
+
+/**
+ * pseries_eeh_get_pe_addr - Retrieve PE address
+ * @dn: device node
+ *
+ * Retrieve the assocated PE address. Actually, there're 2 RTAS
+ * function calls dedicated for the purpose. We need implement
+ * it through the new function and then the old one. Besides,
+ * you should make sure the config address is figured out from
+ * FDT node before calling the function.
+ *
+ * It's notable that zero'ed return value means invalid PE config
+ * address.
+ */
+static int pseries_eeh_get_pe_addr(struct device_node *dn)
+{
+	return 0;
+}
+
+/**
+ * pseries_eeh_get_state - Retrieve PE state
+ * @dn: PE associated device node
+ * @state: return value
+ *
+ * Retrieve the state of the specified PE. On RTAS compliant
+ * pseries platform, there already has one dedicated RTAS function
+ * for the purpose. It's notable that the associated PE config address
+ * might be ready when calling the function. Therefore, endeavour to
+ * use the PE config address if possible. Further more, there're 2
+ * RTAS calls for the purpose, we need to try the new one and back
+ * to the old one if the new one couldn't work properly.
+ */
+static int pseries_eeh_get_state(struct device_node *dn, int *state)
+{
+	return 0;
+}
+
+/**
+ * pseries_eeh_reset - Reset the specified PE
+ * @dn: PE associated device node
+ * @option: reset option
+ *
+ * Reset the specified PE
+ */
+static int pseries_eeh_reset(struct device_node *dn, int option)
+{
+	return 0;
+}
+
+/**
+ * pseries_eeh_wait_state - Wait for PE state
+ * @dn: PE associated device node
+ * @max_wait: maximal period in microsecond
+ *
+ * Wait for the state of associated PE. It might take some time
+ * to retrieve the PE's state.
+ */
+static int pseries_eeh_wait_state(struct device_node *dn, int max_wait)
+{
+	return 0;
+}
+
+/**
+ * pseries_eeh_get_log - Retrieve error log
+ * @dn: device node
+ * @severity: temporary or permanent error log
+ * @drv_log: driver log to be combined with retrieved error log
+ * @len: length of driver log
+ *
+ * Retrieve the temporary or permanent error from the PE.
+ * Actually, the error will be retrieved through the dedicated
+ * RTAS call.
+ */
+static int pseries_eeh_get_log(struct device_node *dn, int severity, char *drv_log, unsigned long len)
+{
+	return 0;
+}
+
+/**
+ * pseries_eeh_configure_bridge - Configure PCI bridges in the indicated PE
+ * @dn: PE associated device node
+ *
+ * The function will be called to reconfigure the bridges included
+ * in the specified PE so that the mulfunctional PE would be recovered
+ * again.
+ */
+static int pseries_eeh_configure_bridge(struct device_node *dn)
+{
+	return 0;
+}
+
+static struct eeh_ops pseries_eeh_ops = {
+	.name			= "pseries",
+	.init			= pseries_eeh_init,
+	.set_option		= pseries_eeh_set_option,
+	.get_pe_addr		= pseries_eeh_get_pe_addr,
+	.get_state		= pseries_eeh_get_state,
+	.reset			= pseries_eeh_reset,
+	.wait_state		= pseries_eeh_wait_state,
+	.get_log		= pseries_eeh_get_log,
+	.configure_bridge	= pseries_eeh_configure_bridge
+};
+
+/**
+ * eeh_pseries_init - Register platform dependent EEH operations
+ *
+ * EEH initialization on pseries platform. This function should be
+ * called before any EEH related functions.
+ */
+int __init eeh_pseries_init(void)
+{
+	return eeh_ops_register(&pseries_eeh_ops);
+}
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index f79f127..809d9d9 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -382,6 +382,7 @@ static void __init pSeries_setup_arch(void)
 
 	/* Find and initialize PCI host bridges */
 	init_pci_config_tokens();
+	eeh_pseries_init();
 	find_and_init_phbs();
 	pSeries_reconfig_notifier_register(&pci_dn_reconfig_nb);
 	eeh_init();
-- 
1.7.5.4
