Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 68B2D1A1082
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 06:47:09 +1100 (AEDT)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 10 Feb 2015 14:47:06 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id A67366E8041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 14:38:55 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1AJl3NC27525310
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 19:47:03 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1AJl39L027984
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 14:47:03 -0500
Received: from [9.41.149.215] (dhcp-9-41-149-215.austin.ibm.com [9.41.149.215])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t1AJl3fV027950
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 14:47:03 -0500
Message-ID: <54DA6036.4040400@linux.vnet.ibm.com>
Date: Tue, 10 Feb 2015 13:47:02 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 3/5] pseries: Create new device hotplug entry point
References: <54DA5EC1.2060403@linux.vnet.ibm.com>
In-Reply-To: <54DA5EC1.2060403@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current hotplug (or dlpar) of devices (the process is generally the
same for memory, cpu, and pci) on PowerVM systems is initiated
from the HMC, which communicates the request to the partitions through
the RSCT framework. The RSCT framework then invokes the drmgr command.
The drmgr command performs the hotplug operation by doing some pieces,
such as most of the rtas calls and device tree parsing, in userspace
and make requests to the kernel to online/offline the device, update the
device tree and add/remove the device.

For PowerKVM the approach for device hotplug is to follow what is currently
being done for pci hotplug. A hotplug request is initiated from the host.
QEMU then generates an EPOW interrupt to the guest which causes the guest
to make the rtas,check-exception call. In QEMU, the rtas,check-exception call
returns a rtas hotplug event to the guest.

Please note that the current pci hotplug path for PowerKVM involves the
kernel receiving the rtas hotplug event, passing it to rtas_errd in
userspace, and having rtas_errd invoke drmgr. The drmgr command then
handles the request as described above for PowerVM systems.

There is no need for this circuitous route, we should just handle the entire
hotplug of devices in the kernel. What I am planning is to enable this
by moving the code to handle hotplug from drmgr into the kernel to
provide a single path for handling device hotplug for both PowerVM and
PowerKVM systems. This patch provides the common iframework and entry point.
For PowerKVM a future update to the kernel rtas code will recognize rtas
hotplug events returned from rtas,check-exception calls and use the common
entry point to handle hotplug of the device.

For PowerVM systems, This patch creates /sys/kernel/dlpar that can be
used by the drmgr command to initiate hotplug requests. In order to do
this a string of the format "<resource> <action> <id_type> <id>" is
written to this file. The string consists of a resource (cpu, memory, pci,
phb), an action (add or remove), an id_type (count, drc index, drc name),
and the corresponding id. The kernel will parse the string and create a
rtas hotplug section that can be passed to the common entry point for
handling hotplug requests.

It should be noted that there is no chance of updating how we receive
hotplug (dlpar) requests from the HMC on PowerVM systems.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
Changes from previous version:
- The interface between user-space and the kernel is a text command
  instead of a binary blob written to the sysfs file. The file created
  is stil /sys/kernel/dlpar.
- Corrected extraneous and missing "break"'s.
- Converted the rtas hotplug section to cpu format before attempting
  hotplug operations instead of converting as needed.

 arch/powerpc/platforms/pseries/dlpar.c          |  118 +++++++++++++++++++++++
 arch/powerpc/platforms/pseries/hotplug-memory.c |   19 ++++
 arch/powerpc/platforms/pseries/pseries.h        |   10 ++
 3 files changed, 145 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index c22bb1b..b4b1109 100644
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
@@ -535,13 +537,125 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
 	return count;
 }
 
+#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
+
+static int handle_dlpar_errorlog(struct pseries_hp_errorlog *hp_elog)
+{
+	int rc;
+
+	/* pseries error logs are in BE format, convert to cpu type */
+	switch (hp_elog->id_type) {
+	case PSERIES_HP_ELOG_ID_DRC_COUNT:
+		hp_elog->_drc_u.drc_count =
+					be32_to_cpu(hp_elog->_drc_u.drc_count);
+		break;
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
+	}
+
+	return rc;
+}
+
+static ssize_t dlpar_store(struct class *class, struct class_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct pseries_hp_errorlog *hp_elog;
+	const char *arg;
+	int rc;
+
+	hp_elog = kzalloc(sizeof(*hp_elog), GFP_KERNEL);
+	if (!hp_elog) {
+		rc = -ENOMEM;
+		goto dlpar_store_out;
+	}
+
+	/* Parse out the request from the user, this will be in the form
+	 * <resource> <action> <id_type> <id>
+	 */
+	arg = buf;
+	if (!strncmp(arg, "memory", 6)) {
+		hp_elog->resource = PSERIES_HP_ELOG_RESOURCE_MEM;
+		arg += strlen("memory ");
+	} else {
+		pr_err("Invalid resource specified: \"%s\"\n", buf);
+		rc = -EINVAL;
+		goto dlpar_store_out;
+	}
+
+	if (!strncmp(arg, "add", 3)) {
+		hp_elog->action = PSERIES_HP_ELOG_ACTION_ADD;
+		arg += strlen("add ");
+	} else if (!strncmp(arg, "remove", 6)) {
+		hp_elog->action = PSERIES_HP_ELOG_ACTION_REMOVE;
+		arg += strlen("remove ");
+	} else {
+		pr_err("Invalid action specified: \"%s\"\n", buf);
+		rc = -EINVAL;
+		goto dlpar_store_out;
+	}
+
+	if (!strncmp(arg, "index", 5)) {
+		u32 index;
+
+		hp_elog->id_type = PSERIES_HP_ELOG_ID_DRC_INDEX;
+		arg += strlen("index ");
+		if (kstrtou32(arg, 0, &index)) {
+			rc = -EINVAL;
+			pr_err("Invalid drc_index specified: \"%s\"\n", buf);
+			goto dlpar_store_out;
+		}
+
+		hp_elog->_drc_u.drc_index = cpu_to_be32(index);
+	} else if (!strncmp(arg, "count", 5)) {
+		u32 count;
+
+		hp_elog->id_type = PSERIES_HP_ELOG_ID_DRC_COUNT;
+		arg += strlen("count ");
+		if (kstrtou32(arg, 0, &count)) {
+			rc = -EINVAL;
+			pr_err("Invalid count specified: \"%s\"\n", buf);
+			goto dlpar_store_out;
+		}
+
+		hp_elog->_drc_u.drc_count = cpu_to_be32(count);
+	} else {
+		pr_err("Invalid id_type specified: \"%s\"\n", buf);
+		rc = -EINVAL;
+		goto dlpar_store_out;
+	}
+
+	rc = handle_dlpar_errorlog(hp_elog);
+
+dlpar_store_out:
+	kfree(hp_elog);
+	return rc ? rc : count;
+}
+
+static CLASS_ATTR(dlpar, S_IWUSR, NULL, dlpar_store);
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
+	rc = sysfs_create_file(kernel_kobj, &class_attr_dlpar.attr);
+
+	return rc;
 }
 machine_device_initcall(pseries, pseries_dlpar_init);
 
-#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index fa41f0d..211d0bf 100644
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
