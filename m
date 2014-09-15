Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4E27C1A0077
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 06:31:55 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 15 Sep 2014 14:31:53 -0600
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id B168338C8041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 16:31:51 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8FKVpYK2949398
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 20:31:51 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8FKVpIA023247
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 16:31:51 -0400
Received: from localhost.localdomain (dhcp-9-41-149-95.austin.ibm.com
 [9.41.149.95])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s8FKVpU3023226
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 16:31:51 -0400
Message-ID: <54174CB7.2080704@linux.vnet.ibm.com>
Date: Mon, 15 Sep 2014 15:31:51 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/5] pseries: Create device hotplug entry point
References: <54174B81.50504@linux.vnet.ibm.com>
In-Reply-To: <54174B81.50504@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For pseries system the kernel will be notified of hotplug requests in
the form of rtas hotplug events. This patch creates a common routine that
can handle these requests in both the PowerVM anbd PowerKVM environments,
handle_dlpar_errorlog(). This also creates the initial memory hotplug
request handling stub.

For PowerVM this patch also creates a new /proc file that the drmgr
command will use to write rtas hotplug events to.

For future PowerKVM handling the rtas check-exception code can pass
any rtas hotplug events received to handle_dlpar_errorlog().

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c          |   63 +++++++++++++++++++++++
 arch/powerpc/platforms/pseries/hotplug-memory.c |   22 ++++++++
 arch/powerpc/platforms/pseries/pseries.h        |   10 ++++
 3 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index a2450b8..574ec73 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -16,7 +16,9 @@
 #include <linux/cpu.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/proc_fs.h>
 #include "offline_states.h"
+#include "pseries.h"
 
 #include <asm/prom.h>
 #include <asm/machdep.h>
@@ -530,13 +532,72 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
 	return count;
 }
 
+#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
+
+static int handle_dlpar_errorlog(struct rtas_error_log *error_log)
+{
+	struct pseries_errorlog *pseries_log;
+	struct pseries_hp_errorlog *hp_elog;
+	int rc = -EINVAL;
+
+	pseries_log = get_pseries_errorlog(error_log,
+					   PSERIES_ELOG_SECT_ID_HOTPLUG);
+	if (!pseries_log)
+		return rc;
+
+	hp_elog = (struct pseries_hp_errorlog *)pseries_log->data;
+	if (!hp_elog)
+		return rc;
+
+	switch (hp_elog->resource) {
+	case PSERIES_HP_ELOG_RESOURCE_MEM:
+		rc = dlpar_memory(hp_elog);
+		break;
+	}
+
+	return rc;
+}
+
+static ssize_t dlpar_write(struct file *file, const char __user *buf,
+			   size_t count, loff_t *offset)
+{
+	char *event_buf;
+	int rc;
+
+	event_buf = kmalloc(count + 1, GFP_KERNEL);
+	if (!event_buf)
+		return -ENOMEM;
+
+	rc = copy_from_user(event_buf, buf, count);
+	if (rc) {
+		kfree(event_buf);
+		return rc;
+	}
+
+	rc = handle_dlpar_errorlog((struct rtas_error_log *)event_buf);
+	kfree(event_buf);
+	return rc ? rc : count;
+}
+
+static const struct file_operations dlpar_fops = {
+	.write = dlpar_write,
+	.llseek = noop_llseek,
+};
+
 static int __init pseries_dlpar_init(void)
 {
+	struct proc_dir_entry *proc_ent;
+
+	proc_ent = proc_create("powerpc/dlpar", S_IWUSR, NULL, &dlpar_fops);
+	if (proc_ent)
+		proc_set_size(proc_ent, 0);
+
+#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
 	ppc_md.cpu_probe = dlpar_cpu_probe;
 	ppc_md.cpu_release = dlpar_cpu_release;
+#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
 
 	return 0;
 }
 machine_device_initcall(pseries, pseries_dlpar_init);
 
-#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 24abc5c..0e60e15 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -9,6 +9,8 @@
  *      2 of the License, or (at your option) any later version.
  */
 
+#define pr_fmt(fmt)	"pseries-hotplug: " fmt
+
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/memblock.h>
@@ -20,6 +22,9 @@
 #include <asm/machdep.h>
 #include <asm/prom.h>
 #include <asm/sparsemem.h>
+#include <asm/rtas.h>
+
+DEFINE_MUTEX(dlpar_mem_mutex);
 
 unsigned long pseries_memory_block_size(void)
 {
@@ -150,6 +155,23 @@ static inline int pseries_remove_mem_node(struct device_node *np)
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
+int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
+{
+	int rc = 0;
+
+	mutex_lock(&dlpar_mem_mutex);
+
+	switch (hp_elog->action) {
+	default:
+		pr_err("Invalid action (%d) specified\n", hp_elog->action);
+		rc = -EINVAL;
+		break;
+	}
+
+	mutex_unlock(&dlpar_mem_mutex);
+	return rc;
+}
+
 static int pseries_add_mem_node(struct device_node *np)
 {
 	const char *type;
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index b94516b..28bd994 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -11,6 +11,7 @@
 #define _PSERIES_PSERIES_H
 
 #include <linux/interrupt.h>
+#include <asm/rtas.h>
 
 struct device_node;
 
@@ -62,6 +63,15 @@ extern int dlpar_detach_node(struct device_node *);
 extern int dlpar_acquire_drc(u32);
 extern int dlpar_release_drc(u32);
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+extern int dlpar_memory(struct pseries_hp_errorlog *);
+#else
+static inline int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
+{
+	return -ENOTSUPP;
+}
+#endif
+
 /* PCI root bridge prepare function override for pseries */
 struct pci_host_bridge;
 int pseries_root_bridge_prepare(struct pci_host_bridge *bridge);
