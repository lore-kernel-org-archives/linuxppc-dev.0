Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BF8C71A0148
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 01:45:19 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 17 Jun 2014 09:45:14 -0600
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 84E1338C803D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 11:45:11 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5HFjBAs28114980
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 15:45:11 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5HFjAsn008071
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 11:45:10 -0400
Received: from localhost.localdomain ([9.80.40.207])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s5HFj8uQ007838
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 11:45:09 -0400
Message-ID: <53A06284.7050504@linux.vnet.ibm.com>
Date: Tue, 17 Jun 2014 10:45:08 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 1/4] Create interface for rtas hotplug events and move
 mem hotplug to the kernel
References: <53A061EC.10403@linux.vnet.ibm.com>
In-Reply-To: <53A061EC.10403@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to support hotplug of memory, cpu and pci devices in the PowerVM
and the PowerKVM environments we will need to provide a single entry
point. To do this requires updating the way in which we handle hotplug
requests in the PowerVM environment. The idea is to have all of the hotplug
in the kernel so that a hotplug rtas event can used to initiate the hotplug
add/remove of a device.

The current method for handling a hotplug request in a PowerVM partition
is to have the HMC notify the partition of the request through the RSCT
framework which then invokes the drmgr command to hotplug add/remove the
requested devices. The drmgr command does part of this in user-space
and part in the kernel via sysfs and /proc interfaces.

This patch creates the entry point for initiating a hotplug request for
pseries with a rtas hotplug event. For PowerVM systems the drmgr command
will now create and write a hotplug rtas event to /proc/powerpc/dlpar which
will then pass the hotplug rtas event to the entry point. For PowerKVM
systems QEMU will generate an epow interrupt to the guest, which then
calls rtas-check-execption to get the hotplug rtas event and pass it to the
entry point. NOTE that the updates to handle hotplug events from epow
interrupts is not in this intial patch.

This patch also adds funtionality so that we can do memory hotplug in the
kernel. Using the updates to drmgr found below you can initiate memory
hotplug events using the new interface.

https://github.com/nfont/powerpc-utils/tree/mem_rtas_hp

---
 arch/powerpc/include/asm/rtas.h                 |  26 ++
 arch/powerpc/kernel/rtas.c                      |   7 +
 arch/powerpc/platforms/pseries/dlpar.c          |  65 ++++-
 arch/powerpc/platforms/pseries/hotplug-memory.c | 351 ++++++++++++++++++++----
 arch/powerpc/platforms/pseries/pseries.h        |   4 +
 arch/powerpc/platforms/pseries/reconfig.c       |   6 +
 6 files changed, 403 insertions(+), 56 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index b390f55..26491ae 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -254,6 +254,31 @@ inline uint32_t rtas_ext_event_company_id(struct rtas_ext_event_log_v6 *ext_log)
 	return be32_to_cpu(ext_log->company_id);
 }
 
+/* RTAS pseries hotplug elog section */ 
+struct pseries_hp_elog {
+	uint8_t		resource;
+	uint8_t		action:8;
+        uint8_t		id_type:8;
+        uint8_t		reserved;
+        union {
+		__be32	drc_index;
+		__be32	drc_count;
+		char	drc_name[1];
+        }_drc_u;
+};
+
+#define HP_ELOG_RESOURCE_CPU	1
+#define HP_ELOG_RESOURCE_MEM	2
+#define HP_ELOG_RESOURCE_SLOT	3
+#define HP_ELOG_RESOURCE_PHB	4
+
+#define HP_ELOG_ACTION_ADD	1
+#define HP_ELOG_ACTION_REMOVE	2
+
+#define HP_ELOG_ID_DRC_NAME	1
+#define HP_ELOG_ID_DRC_INDEX	2
+#define HP_ELOG_ID_DRC_COUNT	3
+
 /* pSeries event log format */
 
 /* Two bytes ASCII section IDs */
@@ -273,6 +298,7 @@ inline uint32_t rtas_ext_event_company_id(struct rtas_ext_event_log_v6 *ext_log)
 #define PSERIES_ELOG_SECT_ID_MANUFACT_INFO	(('M' << 8) | 'I')
 #define PSERIES_ELOG_SECT_ID_CALL_HOME		(('C' << 8) | 'H')
 #define PSERIES_ELOG_SECT_ID_USER_DEF		(('U' << 8) | 'D')
+#define PSERIES_ELOG_SECT_ID_HP			(('H' << 8) | 'P')
 
 /* Vendor specific Platform Event Log Format, Version 6, section header */
 struct pseries_errorlog {
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 8cd5ed0..b738b1b 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -997,6 +997,13 @@ struct pseries_errorlog *get_pseries_errorlog(struct rtas_error_log *log,
 	uint8_t log_format = rtas_ext_event_log_format(ext_log);
 	uint32_t company_id = rtas_ext_event_company_id(ext_log);
 
+	printk(KERN_EMERG "Validation: %x : %lx\n%x : %x\n%x : %x\n",
+		log->extended_log_length, sizeof(struct rtas_ext_event_log_v6),
+		rtas_ext_event_log_format(ext_log),
+		RTAS_V6EXT_LOG_FORMAT_EVENT_LOG,
+		rtas_ext_event_company_id(ext_log),
+		RTAS_V6EXT_COMPANY_ID_IBM);
+		
 	/* Check that we understand the format */
 	if (ext_log_length < sizeof(struct rtas_ext_event_log_v6) ||
 	    log_format != RTAS_V6EXT_LOG_FORMAT_EVENT_LOG ||
diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 022b38e..dfca23b 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -16,9 +16,13 @@
 #include <linux/cpu.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/proc_fs.h>
+#include <linux/memory.h>
+#include <linux/memblock.h>
+#include <linux/mutex.h>
 #include "offline_states.h"
+#include "pseries.h"
 
-#include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/uaccess.h>
 #include <asm/rtas.h>
@@ -529,13 +533,68 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
 	return count;
 }
 
+#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
+
+static int handle_dlpar_errorlog(struct rtas_error_log *error_log)
+{
+	struct pseries_errorlog *pseries_log;
+	struct pseries_hp_elog *hp_elog;
+	int rc = -EINVAL;
+
+	pseries_log = get_pseries_errorlog(error_log, PSERIES_ELOG_SECT_ID_HP);
+	if (!pseries_log)
+		return rc; 
+
+	hp_elog = (struct pseries_hp_elog *)pseries_log->data;
+	switch (hp_elog->resource) {
+	case HP_ELOG_RESOURCE_MEM:
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
+	return rc;
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
+
 
 	return 0;
 }
 machine_device_initcall(pseries, pseries_dlpar_init);
-
-#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 7f75c94..af479eb 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -15,11 +15,17 @@
 #include <linux/vmalloc.h>
 #include <linux/memory.h>
 #include <linux/memory_hotplug.h>
+#include <linux/slab.h>
 
 #include <asm/firmware.h>
 #include <asm/machdep.h>
-#include <asm/prom.h>
 #include <asm/sparsemem.h>
+#include <asm/prom.h>
+#include <asm/rtas.h>
+
+#include "pseries.h"
+
+DEFINE_MUTEX(dlpar_mem_mutex);
 
 static unsigned long get_memblock_size(void)
 {
@@ -75,6 +81,186 @@ unsigned long memory_block_size_bytes(void)
 	return get_memblock_size();
 }
 
+static struct property *dlpar_clone_drconf_property(struct device_node *dn)
+{
+	struct property *prop, *new_prop;
+
+	prop = of_find_property(dn, "ibm,dynamic-memory", NULL);
+	if (!prop)
+		return NULL;
+
+	new_prop = kzalloc(sizeof(*new_prop), GFP_KERNEL);
+	if (!new_prop)
+		return NULL;
+
+	new_prop->name = kstrdup(prop->name, GFP_KERNEL);
+	new_prop->value = kmalloc(prop->length + 1, GFP_KERNEL);
+	if (!new_prop->name || !new_prop->value) {
+		kfree(new_prop->name);
+		kfree(new_prop->value);
+		kfree(new_prop);
+		return NULL;
+	}
+
+	memcpy(new_prop->value, prop->value, prop->length);
+	new_prop->length = prop->length;
+	*(((char *)new_prop->value) + new_prop->length) = 0;
+
+	return new_prop;
+}
+
+static int lmb_is_removable(struct of_drconf_cell *lmb)
+{
+	int i, scns_per_block;
+	int rc = 1;
+	unsigned long pfn, block_sz;
+	uint64_t base_addr;
+
+	base_addr = lmb->base_addr;
+	block_sz = memory_block_size_bytes();
+	scns_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
+
+	for (i = 0; i < scns_per_block; i++) {
+		pfn = PFN_DOWN(base_addr);
+		if (!pfn_present(pfn))
+			continue;
+	
+		rc &= is_mem_section_removable(pfn, PAGES_PER_SECTION);
+		base_addr += MIN_MEMORY_BLOCK_SIZE;
+	}
+
+	return rc;
+}
+
+static int lmb_is_usable(struct pseries_hp_elog *hp_elog,
+			 struct of_drconf_cell *lmb)
+{
+	if (hp_elog->id_type == HP_ELOG_ID_DRC_INDEX
+	    && hp_elog->_drc_u.drc_index == lmb->drc_index) {
+		return 1;
+	} else {
+		if (hp_elog->action == HP_ELOG_ACTION_ADD
+		    && !(lmb->flags & DRCONF_MEM_ASSIGNED))
+			return 1;
+
+		if (hp_elog->action == HP_ELOG_ACTION_REMOVE
+		    && lmb->flags & DRCONF_MEM_ASSIGNED)
+			return lmb_is_removable(lmb);
+	}
+
+	return 0;
+}
+
+static struct memory_block *lmb_to_memblock(struct of_drconf_cell *lmb)
+{
+	unsigned long section_nr;
+	struct mem_section *mem_sect;
+	struct memory_block *mem_block;
+
+	section_nr = pfn_to_section_nr(PFN_DOWN(lmb->base_addr));
+	mem_sect = __nr_to_section(section_nr);
+
+	mem_block = find_memory_block(mem_sect);
+	return mem_block;
+}
+
+static int dlpar_add_one_lmb(struct of_drconf_cell *lmb)
+{
+	struct memory_block *mem_block;
+	u64 phys_addr;
+	unsigned long pages_per_block;
+	unsigned long block_sz;
+	int nid, sections_per_block;
+	int rc;
+
+	phys_addr = lmb->base_addr;
+	block_sz = memory_block_size_bytes();
+	sections_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
+	pages_per_block = PAGES_PER_SECTION * sections_per_block;
+
+	if (phys_addr & ((pages_per_block << PAGE_SHIFT) - 1))
+		return -EINVAL;
+
+	nid = memory_add_physaddr_to_nid(phys_addr);
+	rc = add_memory(nid, phys_addr, block_sz);
+	if (rc)
+		return rc;
+
+	rc = memblock_add(lmb->base_addr, block_sz);
+	if (rc) {
+		remove_memory(nid, phys_addr, block_sz);
+		return rc;
+	}
+
+	mem_block = lmb_to_memblock(lmb);
+	if (!mem_block) {
+		remove_memory(nid, phys_addr, block_sz);
+		return -EINVAL;
+	}
+
+	rc = device_online(&mem_block->dev);
+	put_device(&mem_block->dev);
+	if (rc)
+		remove_memory(nid, phys_addr, block_sz);
+
+	return rc;
+}
+
+static int dlpar_memory_add(struct pseries_hp_elog *hp_elog)
+{
+	struct of_drconf_cell *lmb;
+	struct device_node *dn;
+	struct property *prop;
+	uint32_t *p, entries;
+	int i, lmbs_to_add;
+	int lmbs_added = 0;
+	int rc = -EINVAL;
+
+	if (hp_elog->id_type == HP_ELOG_ID_DRC_COUNT)
+		lmbs_to_add = hp_elog->_drc_u.drc_count;
+	else
+		lmbs_to_add = 1;
+
+	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (!dn)
+		return -EINVAL;
+
+	prop = dlpar_clone_drconf_property(dn);
+	if (!prop) {
+		of_node_put(dn);
+		return -EINVAL;
+	}
+
+        p = prop->value;
+        entries = *p++;
+        lmb = (struct of_drconf_cell *)p;
+
+	for (i = 0; i < entries; i++, lmb++) {
+		if (lmbs_to_add == lmbs_added)
+			break;
+
+		if (!lmb_is_usable(hp_elog, lmb))
+			continue;
+
+		rc = dlpar_acquire_drc(lmb->drc_index);
+		if (rc)
+			continue;
+
+		rc = dlpar_add_one_lmb(lmb);
+
+		lmb->flags |= DRCONF_MEM_ASSIGNED;
+		lmbs_added++;
+	}
+
+	if (lmbs_added)
+		rc = of_update_property(dn, prop);
+	else
+		kfree(prop);
+
+	of_node_put(dn);
+	return rc ? rc : lmbs_added;
+}
+
 #ifdef CONFIG_MEMORY_HOTREMOVE
 static int pseries_remove_memory(u64 start, u64 size)
 {
@@ -92,6 +278,93 @@ static int pseries_remove_memory(u64 start, u64 size)
 	return ret;
 }
 
+static int dlpar_remove_one_lmb(struct of_drconf_cell *lmb)
+{
+	struct memory_block *mem_block;
+	unsigned long block_sz;
+	int nid, rc;
+
+	block_sz = memory_block_size_bytes();
+	nid = memory_add_physaddr_to_nid(lmb->base_addr);
+
+	if (!pfn_valid(lmb->base_addr >> PAGE_SHIFT)) {
+		memblock_remove(lmb->base_addr, block_sz);
+		return 0;
+	}
+
+	mem_block = lmb_to_memblock(lmb);
+	if (!mem_block)
+		return -EINVAL;
+
+	rc = device_offline(&mem_block->dev);
+	put_device(&mem_block->dev);
+	if (rc)
+		return rc;
+
+	remove_memory(nid, lmb->base_addr, block_sz);
+	memblock_remove(lmb->base_addr, block_sz);
+
+	return 0;
+}
+
+static int dlpar_memory_remove(struct pseries_hp_elog *hp_elog)
+{
+	struct of_drconf_cell *lmb;
+	struct device_node *dn;
+	struct property *prop;
+	int lmbs_to_remove, lmbs_removed = 0;
+	int i, rc, entries;
+	uint32_t *p;
+
+	if (hp_elog->id_type == HP_ELOG_ID_DRC_COUNT)
+		lmbs_to_remove = hp_elog->_drc_u.drc_count;
+	else
+		lmbs_to_remove = 1;
+
+	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (!dn)
+		return -EINVAL;
+
+	prop = dlpar_clone_drconf_property(dn);
+	if (!prop) {
+		of_node_put(dn);
+		return -EINVAL;
+	}
+
+        p = prop->value;
+        entries = *p++;
+        lmb = (struct of_drconf_cell *)p;
+
+	for (i = 0; i < entries; i++, lmb++) {
+		if (lmbs_to_remove == lmbs_removed)
+			break;
+
+		if (!lmb_is_usable(hp_elog, lmb))
+			continue;
+
+		rc = dlpar_remove_one_lmb(lmb);
+		if (rc)
+			continue;
+
+		rc = dlpar_release_drc(lmb->drc_index);
+		if (rc) {
+			dlpar_add_one_lmb(lmb);
+			continue;
+		}
+
+		lmb->flags &= ~DRCONF_MEM_ASSIGNED;
+		lmbs_removed++;
+	}
+
+	if (lmbs_removed)
+		rc = of_update_property(dn, prop);
+	else
+		kfree(prop);
+
+	of_node_put(dn);
+	return rc;
+}
+
 static int pseries_remove_memblock(unsigned long base, unsigned int memblock_size)
 {
 	unsigned long block_sz, start_pfn;
@@ -150,6 +423,10 @@ static int pseries_remove_mem_node(struct device_node *np)
 	return 0;
 }
 #else
+static inline int dlpar_memory_remove(struct pseries_hp_elog *hp_elog)
+{
+	return -EOPNOTSUPP;
+}
 static inline int pseries_remove_memblock(unsigned long base,
 					  unsigned int memblock_size)
 {
@@ -161,6 +438,25 @@ static inline int pseries_remove_mem_node(struct device_node *np)
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
+int dlpar_memory(struct pseries_hp_elog *hp_elog)
+{
+	int rc = 0;
+
+	mutex_lock(&dlpar_mem_mutex);
+
+	switch (hp_elog->action) {
+	case HP_ELOG_ACTION_ADD:
+		rc = dlpar_memory_add(hp_elog);
+		break;
+	case HP_ELOG_ACTION_REMOVE:
+		rc = dlpar_memory_remove(hp_elog);
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
@@ -193,56 +489,9 @@ static int pseries_add_mem_node(struct device_node *np)
 	return (ret < 0) ? -EINVAL : 0;
 }
 
-static int pseries_update_drconf_memory(struct of_prop_reconfig *pr)
-{
-	struct of_drconf_cell *new_drmem, *old_drmem;
-	unsigned long memblock_size;
-	u32 entries;
-	u32 *p;
-	int i, rc = -EINVAL;
-
-	memblock_size = get_memblock_size();
-	if (!memblock_size)
-		return -EINVAL;
-
-	p = (u32 *)of_get_property(pr->dn, "ibm,dynamic-memory", NULL);
-	if (!p)
-		return -EINVAL;
-
-	/* The first int of the property is the number of lmb's described
-	 * by the property. This is followed by an array of of_drconf_cell
-	 * entries. Get the niumber of entries and skip to the array of
-	 * of_drconf_cell's.
-	 */
-	entries = *p++;
-	old_drmem = (struct of_drconf_cell *)p;
-
-	p = (u32 *)pr->prop->value;
-	p++;
-	new_drmem = (struct of_drconf_cell *)p;
-
-	for (i = 0; i < entries; i++) {
-		if ((old_drmem[i].flags & DRCONF_MEM_ASSIGNED) &&
-		    (!(new_drmem[i].flags & DRCONF_MEM_ASSIGNED))) {
-			rc = pseries_remove_memblock(old_drmem[i].base_addr,
-						     memblock_size);
-			break;
-		} else if ((!(old_drmem[i].flags & DRCONF_MEM_ASSIGNED)) &&
-			   (new_drmem[i].flags & DRCONF_MEM_ASSIGNED)) {
-			rc = memblock_add(old_drmem[i].base_addr,
-					  memblock_size);
-			rc = (rc < 0) ? -EINVAL : 0;
-			break;
-		}
-	}
-
-	return rc;
-}
-
 static int pseries_memory_notifier(struct notifier_block *nb,
 				   unsigned long action, void *node)
 {
-	struct of_prop_reconfig *pr;
 	int err = 0;
 
 	switch (action) {
@@ -252,12 +501,8 @@ static int pseries_memory_notifier(struct notifier_block *nb,
 	case OF_RECONFIG_DETACH_NODE:
 		err = pseries_remove_mem_node(node);
 		break;
-	case OF_RECONFIG_UPDATE_PROPERTY:
-		pr = (struct of_prop_reconfig *)node;
-		if (!strcmp(pr->prop->name, "ibm,dynamic-memory"))
-			err = pseries_update_drconf_memory(pr);
-		break;
 	}
+
 	return notifier_from_errno(err);
 }
 
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 9921953..89c25769 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -11,6 +11,7 @@
 #define _PSERIES_PSERIES_H
 
 #include <linux/interrupt.h>
+#include <asm/rtas.h>
 
 struct device_node;
 
@@ -59,6 +60,9 @@ extern void dlpar_free_cc_property(struct property *);
 extern struct device_node *dlpar_configure_connector(u32, struct device_node *);
 extern int dlpar_attach_node(struct device_node *);
 extern int dlpar_detach_node(struct device_node *);
+extern int dlpar_acquire_drc(u32);
+extern int dlpar_release_drc(u32);
+extern int dlpar_memory(struct pseries_hp_elog *);
 
 /* PCI root bridge prepare function override for pseries */
 struct pci_host_bridge;
diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
index 0435bb6..8a1f3cf4 100644
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -370,6 +370,12 @@ static int do_update_property(char *buf, size_t bufsize)
 	if (!strlen(name))
 		return -ENODEV;
 
+	/* updating the ibm,dynamic-memory property is no longer
+	 * supported through this interface.
+	 */
+	if (!strcmp(name, "ibm,dynamic-memory"))
+		return -EINVAL;
+
 	newprop = new_property(name, length, value, NULL);
 	if (!newprop)
 		return -ENOMEM;
-- 
2.0.0.rc3.2.g998f840
