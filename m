Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 33BFA1A01DA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 08:51:51 +1100 (AEDT)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 17 Nov 2014 14:51:47 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id D18FD19D8045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 14:40:24 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAHLphjX52297952
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 22:51:43 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAHLphNt027867
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 14:51:43 -0700
Message-ID: <546A6DEE.8080708@linux.vnet.ibm.com>
Date: Mon, 17 Nov 2014 15:51:42 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 3/6] pseries: Create new device hotplug entry point
References: <546A6C23.1080800@linux.vnet.ibm.com>
In-Reply-To: <546A6C23.1080800@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Create a new entry point for device hotplug on pseries that will
work for both PowerVM and PowerKVM systems.

The current process to hotplug (or dlpar) devices (generally the same
process for memory, cpu, and pci devices) on PowerVM systems is initiated
from the HMC, which communicates the request to the partitions through
the RSCT framework. The RSCT framework then invokes the drmgr command.
The drmgr command performs the hotplug operation by doing some pieces,
such as most of the rtas calls and device tree parsing, in userspace
and make requests to the kernel to online/offline the device, update the
device tree and add/remove the device.

For PowerKVM the approach for device hotplug is to follow what is currently
being done for pci hotplug. A hotplug request is initiated from the host,
QEMU then generates an EPOW interrupt to the guest which causes the guest
to make the rtas,check-exception call. In QEMU, the rtas,check-exception call
returns a rtas hotplug event to the guest.

Please note that the current pci hotplug path for PowerKVM involves the
kernel receiving the rtas hotplug event, passing it to rtas_errd in
userspace, and having rtas_errd invoke drmgr. The drmgr command then
handles the request as described above for PowerVM systems. This is to
be updated to perform pci completely in the kernel in a later patch set.

There is no need for this circuitous route, we should handle the entire
hotplug of devices in the kernel. What I am planning is to enable this
by moving the code to handle device hotplug from drmgr into the kernel to
provide a single path for both PowerVM and PowerKVM systems. This patch
provides the common entry point. For PowerKVM a future update to the kernel
rtas code will recognize rtas hotplug events returned from
rtas,check-exception calls and use the common entry point to handle device
hotplug entirely in the kernel.

For PowerVM systems, this patch creates the /sys/kernel/dlpar file that rtas
hotplug events can be written to by drmgr and passed to the common entry point.
There is no chance of updating how we receive hotplug requests on PowerVM
systems.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c          |   72 ++++++++++++++++++++++-
 arch/powerpc/platforms/pseries/hotplug-memory.c |   19 ++++++
 arch/powerpc/platforms/pseries/pseries.h        |   10 +++
 3 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index c22bb1b..ec825d3 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -10,6 +10,8 @@
  * 2 as published by the Free Software Foundation.
  */
 
+#define pr_fmt(fmt)	"dlpar: " fmt
+
 #include <linux/kernel.h>
 #include <linux/notifier.h>
 #include <linux/spinlock.h>
@@ -535,13 +537,79 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
 	return count;
 }
 
+#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
+
+static int handle_dlpar_errorlog(struct rtas_error_log *error_log)
+{
+	struct pseries_errorlog *pseries_log;
+	struct pseries_hp_errorlog *hp_elog;
+	int rc;
+
+	pseries_log = get_pseries_errorlog(error_log,
+					   PSERIES_ELOG_SECT_ID_HOTPLUG);
+	if (!pseries_log || (pseries_log->length == 0))
+		return -EINVAL;
+
+	hp_elog = (struct pseries_hp_errorlog *)pseries_log->data;
+
+	/* Go ahead and convert the hotplug type to the correct endianness
+	 * to avoid converting it everywhere we use it.
+	 */
+	switch (hp_elog->id_type) {
+	case PSERIES_HP_ELOG_ID_DRC_COUNT:
+		hp_elog->_drc_u.drc_count =
+					be32_to_cpu(hp_elog->_drc_u.drc_count);
+	case PSERIES_HP_ELOG_ID_DRC_INDEX:
+		hp_elog->_drc_u.drc_index =
+					be32_to_cpu(hp_elog->_drc_u.drc_index);
+	}
+
+	switch (hp_elog->resource) {
+	case PSERIES_HP_ELOG_RESOURCE_MEM:
+		rc = dlpar_memory(hp_elog);
+		break;
+	default:
+		pr_warn_ratelimited("Invalid resource (%d) specified\n",
+				    hp_elog->resource);
+		rc = -EINVAL;
+		break;
+	}
+
+	return rc;
+}
+
+static ssize_t dlpar_store(struct file *filp, struct kobject *kobj,
+			   struct bin_attribute *bin_attr, char *buf,
+			   loff_t pos, size_t count)
+{
+	struct rtas_error_log *error_log;
+	int rc;
+
+	error_log = kmalloc(count, GFP_KERNEL);
+	if (!error_log)
+		return -ENOMEM;
+
+	memcpy(error_log, buf, count);
+
+	rc = handle_dlpar_errorlog(error_log);
+	kfree(error_log);
+	return rc ? rc : count;
+}
+
+static BIN_ATTR(dlpar, S_IWUSR, NULL, dlpar_store, 0);
+
 static int __init pseries_dlpar_init(void)
 {
+	int rc;
+
+#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
 	ppc_md.cpu_probe = dlpar_cpu_probe;
 	ppc_md.cpu_release = dlpar_cpu_release;
+#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
 
-	return 0;
+	rc = sysfs_create_bin_file(kernel_kobj, &bin_attr_dlpar);
+
+	return rc;
 }
 machine_device_initcall(pseries, pseries_dlpar_init);
 
-#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 3cb256c..69d178b 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -9,6 +9,8 @@
  *      2 of the License, or (at your option) any later version.
  */
 
+#define pr_fmt(fmt)	"pseries-hotplug-mem: " fmt
+
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/memblock.h>
@@ -134,6 +136,23 @@ static inline int pseries_remove_mem_node(struct device_node *np)
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
+int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
+{
+	int rc = 0;
+
+	lock_device_hotplug();
+
+	switch (hp_elog->action) {
+	default:
+		pr_err("Invalid action (%d) specified\n", hp_elog->action);
+		rc = -EINVAL;
+		break;
+	}
+
+	unlock_device_hotplug();
+	return rc;
+}
+
 static int pseries_add_mem_node(struct device_node *np)
 {
 	const char *type;
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 239bee5..40e0339 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -11,6 +11,7 @@
 #define _PSERIES_PSERIES_H
 
 #include <linux/interrupt.h>
+#include <asm/rtas.h>
 
 struct device_node;
 
@@ -63,6 +64,15 @@ extern int dlpar_detach_node(struct device_node *);
 int dlpar_acquire_drc(u32 drc_index);
 int dlpar_release_drc(u32 drc_index);
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+int dlpar_memory(struct pseries_hp_errorlog *hp_elog);
+#else
+static inline int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 /* PCI root bridge prepare function override for pseries */
 struct pci_host_bridge;
 int pseries_root_bridge_prepare(struct pci_host_bridge *bridge);
