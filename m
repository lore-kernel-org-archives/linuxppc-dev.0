Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzX2K0vFHzDqL4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 14:54:33 +1100 (AEDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: Russell Currey <ruscur@russell.cc>
Subject: [PATCH] powerpc: Use octal numbers for file permissions
Date: Thu, 12 Jan 2017 14:54:13 +1100
Message-Id: <20170112035413.26544-1-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Symbolic macros are unintuitive and hard to read, whereas octal constants
are much easier to interpret.  Replace macros for the basic permission
flags (user/group/other read/write/execute) with numeric constants
instead, across the whole powerpc tree.

Introducing a significant number of changes across the tree for no runtime
benefit isn't exactly desirable, but so long as these macros are still
used in the tree people will keep sending patches that add them.  Not only
are they hard to parse at a glance, there are multiple ways of coming to
the same value (as you can see with 0444 and 0644 in this patch) which
hurts readability.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
I wondered what a "S_IRUGO" was and subsequently found the following:
	https://lwn.net/Articles/696229/
so I figured making numeric constants standard across the tree was a good
idea instead of the mix we currently have.

For new patches that come in, checkpatch warns when using something like
S_IRUGO and tells you to use something like 0444 instead.
---
 arch/powerpc/kernel/eeh_sysfs.c                |  2 +-
 arch/powerpc/kernel/iommu.c                    |  2 +-
 arch/powerpc/kernel/proc_powerpc.c             |  2 +-
 arch/powerpc/kernel/rtas-proc.c                | 14 +++++++-------
 arch/powerpc/kernel/rtas_flash.c               |  2 +-
 arch/powerpc/kernel/rtasd.c                    |  2 +-
 arch/powerpc/kernel/traps.c                    |  4 ++--
 arch/powerpc/kvm/book3s_hv.c                   | 10 ++++------
 arch/powerpc/kvm/book3s_xics.c                 |  2 +-
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c |  2 +-
 arch/powerpc/platforms/cell/spufs/inode.c      |  4 ++--
 arch/powerpc/platforms/powernv/opal-dump.c     |  4 ++--
 arch/powerpc/platforms/powernv/opal-elog.c     |  4 ++--
 arch/powerpc/platforms/powernv/opal-sysparam.c |  6 +++---
 arch/powerpc/platforms/pseries/cmm.c           | 16 ++++++++--------
 arch/powerpc/platforms/pseries/dlpar.c         |  2 +-
 arch/powerpc/platforms/pseries/hvCall_inst.c   |  2 +-
 arch/powerpc/platforms/pseries/ibmebus.c       |  4 ++--
 arch/powerpc/platforms/pseries/lparcfg.c       |  4 ++--
 arch/powerpc/platforms/pseries/mobility.c      |  4 ++--
 arch/powerpc/platforms/pseries/reconfig.c      |  2 +-
 arch/powerpc/platforms/pseries/scanlog.c       |  2 +-
 arch/powerpc/platforms/pseries/suspend.c       |  3 +--
 arch/powerpc/platforms/pseries/vio.c           |  8 ++++----
 arch/powerpc/sysdev/axonram.c                  |  2 +-
 arch/powerpc/sysdev/mv64x60_pci.c              |  2 +-
 26 files changed, 54 insertions(+), 57 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_sysfs.c b/arch/powerpc/kernel/eeh_sysfs.c
index 1ceecdda810b..f6d2d5b66907 100644
--- a/arch/powerpc/kernel/eeh_sysfs.c
+++ b/arch/powerpc/kernel/eeh_sysfs.c
@@ -48,7 +48,7 @@ static ssize_t eeh_show_##_name(struct device *dev,      \
 	                                                      \
 	return sprintf(buf, _format "\n", edev->_memb);       \
 }                                                        \
-static DEVICE_ATTR(_name, S_IRUGO, eeh_show_##_name, NULL);
+static DEVICE_ATTR(_name, 0444, eeh_show_##_name, NULL);
 
 EEH_SHOW_ATTR(eeh_mode,            mode,            "0x%x");
 EEH_SHOW_ATTR(eeh_config_addr,     config_addr,     "0x%x");
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 5f202a566ec5..7ef279a0888e 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -127,7 +127,7 @@ static ssize_t fail_iommu_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(fail_iommu, S_IRUGO|S_IWUSR, fail_iommu_show,
+static DEVICE_ATTR(fail_iommu, 0644, fail_iommu_show,
 		   fail_iommu_store);
 
 static int fail_iommu_bus_notify(struct notifier_block *nb,
diff --git a/arch/powerpc/kernel/proc_powerpc.c b/arch/powerpc/kernel/proc_powerpc.c
index 56548bf6231f..9bfbd800d32f 100644
--- a/arch/powerpc/kernel/proc_powerpc.c
+++ b/arch/powerpc/kernel/proc_powerpc.c
@@ -63,7 +63,7 @@ static int __init proc_ppc64_init(void)
 {
 	struct proc_dir_entry *pde;
 
-	pde = proc_create_data("powerpc/systemcfg", S_IFREG|S_IRUGO, NULL,
+	pde = proc_create_data("powerpc/systemcfg", S_IFREG | 0444, NULL,
 			       &page_map_fops, vdso_data);
 	if (!pde)
 		return 1;
diff --git a/arch/powerpc/kernel/rtas-proc.c b/arch/powerpc/kernel/rtas-proc.c
index df56dfc4b681..bb5e8cbcc553 100644
--- a/arch/powerpc/kernel/rtas-proc.c
+++ b/arch/powerpc/kernel/rtas-proc.c
@@ -260,19 +260,19 @@ static int __init proc_rtas_init(void)
 	if (rtas_node == NULL)
 		return -ENODEV;
 
-	proc_create("powerpc/rtas/progress", S_IRUGO|S_IWUSR, NULL,
+	proc_create("powerpc/rtas/progress", 0644, NULL,
 		    &ppc_rtas_progress_operations);
-	proc_create("powerpc/rtas/clock", S_IRUGO|S_IWUSR, NULL,
+	proc_create("powerpc/rtas/clock", 0644, NULL,
 		    &ppc_rtas_clock_operations);
-	proc_create("powerpc/rtas/poweron", S_IWUSR|S_IRUGO, NULL,
+	proc_create("powerpc/rtas/poweron", 0644, NULL,
 		    &ppc_rtas_poweron_operations);
-	proc_create("powerpc/rtas/sensors", S_IRUGO, NULL,
+	proc_create("powerpc/rtas/sensors", 0444, NULL,
 		    &ppc_rtas_sensors_operations);
-	proc_create("powerpc/rtas/frequency", S_IWUSR|S_IRUGO, NULL,
+	proc_create("powerpc/rtas/frequency", 0644, NULL,
 		    &ppc_rtas_tone_freq_operations);
-	proc_create("powerpc/rtas/volume", S_IWUSR|S_IRUGO, NULL,
+	proc_create("powerpc/rtas/volume", 0644, NULL,
 		    &ppc_rtas_tone_volume_operations);
-	proc_create("powerpc/rtas/rmo_buffer", S_IRUSR, NULL,
+	proc_create("powerpc/rtas/rmo_buffer", 0400, NULL,
 		    &ppc_rtas_rmo_buf_ops);
 	return 0;
 }
diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index f6f6a8a5103a..10fabae2574d 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -727,7 +727,7 @@ static int __init rtas_flash_init(void)
 		const struct rtas_flash_file *f = &rtas_flash_files[i];
 		int token;
 
-		if (!proc_create(f->filename, S_IRUSR | S_IWUSR, NULL, &f->fops))
+		if (!proc_create(f->filename, 0600, NULL, &f->fops))
 			goto enomem;
 
 		/*
diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
index 2bf1f9b5b34b..e144bd563929 100644
--- a/arch/powerpc/kernel/rtasd.c
+++ b/arch/powerpc/kernel/rtasd.c
@@ -576,7 +576,7 @@ static int __init rtas_init(void)
 	if (!rtas_log_buf)
 		return -ENODEV;
 
-	entry = proc_create("powerpc/rtas/error_log", S_IRUSR, NULL,
+	entry = proc_create("powerpc/rtas/error_log", 0400, NULL,
 			    &proc_rtas_log_operations);
 	if (!entry)
 		printk(KERN_ERR "Failed to create error_log proc entry\n");
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index e6cc56b61d01..4b9240e4571f 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -2039,13 +2039,13 @@ static int __init ppc_warn_emulated_init(void)
 	if (!dir)
 		return -ENOMEM;
 
-	d = debugfs_create_u32("do_warn", S_IRUGO | S_IWUSR, dir,
+	d = debugfs_create_u32("do_warn", 0644, dir,
 			       &ppc_warn_emulated);
 	if (!d)
 		goto fail;
 
 	for (i = 0; i < sizeof(ppc_emulated)/sizeof(*entries); i++) {
-		d = debugfs_create_u32(entries[i].name, S_IRUGO | S_IWUSR, dir,
+		d = debugfs_create_u32(entries[i].name, 0644, dir,
 				       (u32 *)&entries[i].val.counter);
 		if (!d)
 			goto fail;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index ec34e39471a7..2da1501cc25f 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -87,10 +87,10 @@
 static DECLARE_BITMAP(default_enabled_hcalls, MAX_HCALL_OPCODE/4 + 1);
 
 static int dynamic_mt_modes = 6;
-module_param(dynamic_mt_modes, int, S_IRUGO | S_IWUSR);
+module_param(dynamic_mt_modes, int, 0644);
 MODULE_PARM_DESC(dynamic_mt_modes, "Set of allowed dynamic micro-threading modes: 0 (= none), 2, 4, or 6 (= 2 or 4)");
 static int target_smt_mode;
-module_param(target_smt_mode, int, S_IRUGO | S_IWUSR);
+module_param(target_smt_mode, int, 0644);
 MODULE_PARM_DESC(target_smt_mode, "Target threads per core (0 = max)");
 
 #ifdef CONFIG_KVM_XICS
@@ -99,12 +99,10 @@ static struct kernel_param_ops module_param_ops = {
 	.get = param_get_int,
 };
 
-module_param_cb(kvm_irq_bypass, &module_param_ops, &kvm_irq_bypass,
-							S_IRUGO | S_IWUSR);
+module_param_cb(kvm_irq_bypass, &module_param_ops, &kvm_irq_bypass, 0644);
 MODULE_PARM_DESC(kvm_irq_bypass, "Bypass passthrough interrupt optimization");
 
-module_param_cb(h_ipi_redirect, &module_param_ops, &h_ipi_redirect,
-							S_IRUGO | S_IWUSR);
+module_param_cb(h_ipi_redirect, &module_param_ops, &h_ipi_redirect, 0644);
 MODULE_PARM_DESC(h_ipi_redirect, "Redirect H_IPI wakeup to a free host core");
 #endif
 
diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index 20dff102a06f..d30b6130b8ff 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -1011,7 +1011,7 @@ static void xics_debugfs_init(struct kvmppc_xics *xics)
 		return;
 	}
 
-	xics->dentry = debugfs_create_file(name, S_IRUGO, powerpc_debugfs_root,
+	xics->dentry = debugfs_create_file(name, 0444, powerpc_debugfs_root,
 					   xics, &xics_debug_fops);
 
 	pr_debug("%s: created %s\n", __func__, name);
diff --git a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
index 63c5ab6489c9..c5c709e484c7 100644
--- a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
+++ b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
@@ -84,7 +84,7 @@ static ssize_t show_status(struct device *d,
 
 	return sprintf(buf, "%02x\n", ret);
 }
-static DEVICE_ATTR(status, S_IRUGO, show_status, NULL);
+static DEVICE_ATTR(status, 0444, show_status, NULL);
 
 static void mcu_power_off(void)
 {
diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index d8af9bc0489f..f682be2a48e6 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -455,7 +455,7 @@ spufs_create_context(struct inode *inode, struct dentry *dentry,
 		}
 	}
 
-	ret = spufs_mkdir(inode, dentry, flags, mode & S_IRWXUGO);
+	ret = spufs_mkdir(inode, dentry, flags, mode & 0777);
 	if (ret)
 		goto out_aff_unlock;
 
@@ -546,7 +546,7 @@ static int spufs_create_gang(struct inode *inode,
 	struct path path = {.mnt = mnt, .dentry = dentry};
 	int ret;
 
-	ret = spufs_mkgang(inode, dentry, mode & S_IRWXUGO);
+	ret = spufs_mkgang(inode, dentry, mode & 0777);
 	if (!ret) {
 		ret = spufs_gang_open(&path);
 		if (ret < 0) {
diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
index 4c827826c05e..0dc8fa4e0af2 100644
--- a/arch/powerpc/platforms/powernv/opal-dump.c
+++ b/arch/powerpc/platforms/powernv/opal-dump.c
@@ -103,9 +103,9 @@ static ssize_t dump_ack_store(struct dump_obj *dump_obj,
  * due to the dynamic size of the dump
  */
 static struct dump_attribute id_attribute =
-	__ATTR(id, S_IRUGO, dump_id_show, NULL);
+	__ATTR(id, 0444, dump_id_show, NULL);
 static struct dump_attribute type_attribute =
-	__ATTR(type, S_IRUGO, dump_type_show, NULL);
+	__ATTR(type, 0444, dump_type_show, NULL);
 static struct dump_attribute ack_attribute =
 	__ATTR(acknowledge, 0660, dump_ack_show, dump_ack_store);
 
diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
index ecd6d9177d13..ba6e437abb4b 100644
--- a/arch/powerpc/platforms/powernv/opal-elog.c
+++ b/arch/powerpc/platforms/powernv/opal-elog.c
@@ -83,9 +83,9 @@ static ssize_t elog_ack_store(struct elog_obj *elog_obj,
 }
 
 static struct elog_attribute id_attribute =
-	__ATTR(id, S_IRUGO, elog_id_show, NULL);
+	__ATTR(id, 0444, elog_id_show, NULL);
 static struct elog_attribute type_attribute =
-	__ATTR(type, S_IRUGO, elog_type_show, NULL);
+	__ATTR(type, 0444, elog_type_show, NULL);
 static struct elog_attribute ack_attribute =
 	__ATTR(acknowledge, 0660, elog_ack_show, elog_ack_store);
 
diff --git a/arch/powerpc/platforms/powernv/opal-sysparam.c b/arch/powerpc/platforms/powernv/opal-sysparam.c
index 23fb6647dced..6fd4092798d5 100644
--- a/arch/powerpc/platforms/powernv/opal-sysparam.c
+++ b/arch/powerpc/platforms/powernv/opal-sysparam.c
@@ -260,13 +260,13 @@ void __init opal_sys_param_init(void)
 		/* If the parameter is read-only or read-write */
 		switch (perm[i] & 3) {
 		case OPAL_SYSPARAM_READ:
-			attr[i].kobj_attr.attr.mode = S_IRUGO;
+			attr[i].kobj_attr.attr.mode = 0444;
 			break;
 		case OPAL_SYSPARAM_WRITE:
-			attr[i].kobj_attr.attr.mode = S_IWUSR;
+			attr[i].kobj_attr.attr.mode = 0200;
 			break;
 		case OPAL_SYSPARAM_RW:
-			attr[i].kobj_attr.attr.mode = S_IRUGO | S_IWUSR;
+			attr[i].kobj_attr.attr.mode = 0644;
 			break;
 		default:
 			break;
diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 4839db385bb0..6406c61a6f5e 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -72,20 +72,20 @@ MODULE_DESCRIPTION("IBM System p Collaborative Memory Manager");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(CMM_DRIVER_VERSION);
 
-module_param_named(delay, delay, uint, S_IRUGO | S_IWUSR);
+module_param_named(delay, delay, uint, 0644);
 MODULE_PARM_DESC(delay, "Delay (in seconds) between polls to query hypervisor paging requests. "
 		 "[Default=" __stringify(CMM_DEFAULT_DELAY) "]");
-module_param_named(hotplug_delay, hotplug_delay, uint, S_IRUGO | S_IWUSR);
+module_param_named(hotplug_delay, hotplug_delay, uint, 0644);
 MODULE_PARM_DESC(delay, "Delay (in seconds) after memory hotplug remove "
 		 "before loaning resumes. "
 		 "[Default=" __stringify(CMM_HOTPLUG_DELAY) "]");
-module_param_named(oom_kb, oom_kb, uint, S_IRUGO | S_IWUSR);
+module_param_named(oom_kb, oom_kb, uint, 0644);
 MODULE_PARM_DESC(oom_kb, "Amount of memory in kb to free on OOM. "
 		 "[Default=" __stringify(CMM_OOM_KB) "]");
-module_param_named(min_mem_mb, min_mem_mb, ulong, S_IRUGO | S_IWUSR);
+module_param_named(min_mem_mb, min_mem_mb, ulong, 0644);
 MODULE_PARM_DESC(min_mem_mb, "Minimum amount of memory (in MB) to not balloon. "
 		 "[Default=" __stringify(CMM_MIN_MEM_MB) "]");
-module_param_named(debug, cmm_debug, uint, S_IRUGO | S_IWUSR);
+module_param_named(debug, cmm_debug, uint, 0644);
 MODULE_PARM_DESC(debug, "Enable module debugging logging. Set to 1 to enable. "
 		 "[Default=" __stringify(CMM_DEBUG) "]");
 
@@ -385,7 +385,7 @@ static int cmm_thread(void *dummy)
 	{							\
 		return sprintf(buf, format, ##args);		\
 	}							\
-	static DEVICE_ATTR(name, S_IRUGO, show_##name, NULL)
+	static DEVICE_ATTR(name, 0444, show_##name, NULL)
 
 CMM_SHOW(loaned_kb, "%lu\n", PAGES2KB(loaned_pages));
 CMM_SHOW(loaned_target_kb, "%lu\n", PAGES2KB(loaned_pages_target));
@@ -411,7 +411,7 @@ static ssize_t store_oom_pages(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(oom_freed_kb, S_IWUSR | S_IRUGO,
+static DEVICE_ATTR(oom_freed_kb, 0644,
 		   show_oom_pages, store_oom_pages);
 
 static struct device_attribute *cmm_attrs[] = {
@@ -765,7 +765,7 @@ static int cmm_set_disable(const char *val, struct kernel_param *kp)
 }
 
 module_param_call(disable, cmm_set_disable, param_get_uint,
-		  &cmm_disabled, S_IRUGO | S_IWUSR);
+		  &cmm_disabled, 0644);
 MODULE_PARM_DESC(disable, "Disable CMM. Set to 1 to disable. "
 		 "[Default=" __stringify(CMM_DISABLE) "]");
 
diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 5cb2e4beffc5..fc0b1b80972d 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -551,7 +551,7 @@ static ssize_t dlpar_store(struct class *class, struct class_attribute *attr,
 	return rc ? rc : count;
 }
 
-static CLASS_ATTR(dlpar, S_IWUSR, NULL, dlpar_store);
+static CLASS_ATTR(dlpar, 0200, NULL, dlpar_store);
 
 static int __init pseries_dlpar_init(void)
 {
diff --git a/arch/powerpc/platforms/pseries/hvCall_inst.c b/arch/powerpc/platforms/pseries/hvCall_inst.c
index f02ec3ab428c..fea432d88cad 100644
--- a/arch/powerpc/platforms/pseries/hvCall_inst.c
+++ b/arch/powerpc/platforms/pseries/hvCall_inst.c
@@ -153,7 +153,7 @@ static int __init hcall_inst_init(void)
 
 	for_each_possible_cpu(cpu) {
 		snprintf(cpu_name_buf, CPU_NAME_BUF_SIZE, "cpu%d", cpu);
-		hcall_file = debugfs_create_file(cpu_name_buf, S_IRUGO,
+		hcall_file = debugfs_create_file(cpu_name_buf, 0444,
 						 hcall_root,
 						 per_cpu(hcall_stats, cpu),
 						 &hcall_inst_seq_fops);
diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index 614c28537141..f67f5aa71653 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -299,7 +299,7 @@ static ssize_t ibmebus_store_probe(struct bus_type *bus,
 		return rc;
 	return count;
 }
-static BUS_ATTR(probe, S_IWUSR, NULL, ibmebus_store_probe);
+static BUS_ATTR(probe, 0200, NULL, ibmebus_store_probe);
 
 static ssize_t ibmebus_store_remove(struct bus_type *bus,
 				    const char *buf, size_t count)
@@ -326,7 +326,7 @@ static ssize_t ibmebus_store_remove(struct bus_type *bus,
 		return -ENODEV;
 	}
 }
-static BUS_ATTR(remove, S_IWUSR, NULL, ibmebus_store_remove);
+static BUS_ATTR(remove, 0200, NULL, ibmebus_store_remove);
 
 static struct attribute *ibmbus_bus_attrs[] = {
 	&bus_attr_probe.attr,
diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index 779fc2a1c8f7..aea4ce11a9eb 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -697,11 +697,11 @@ static const struct file_operations lparcfg_fops = {
 
 static int __init lparcfg_init(void)
 {
-	umode_t mode = S_IRUSR | S_IRGRP | S_IROTH;
+	umode_t mode = 0444;
 
 	/* Allow writing if we have FW_FEATURE_SPLPAR */
 	if (firmware_has_feature(FW_FEATURE_SPLPAR))
-		mode |= S_IWUSR;
+		mode |= 0200;
 
 	if (!proc_create("powerpc/lparcfg", mode, NULL, &lparcfg_fops)) {
 		printk(KERN_ERR "Failed to create powerpc/lparcfg\n");
diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index a560a98bcf3b..6a5f140bb8b8 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -346,8 +346,8 @@ static ssize_t migrate_store(struct class *class, struct class_attribute *attr,
  */
 #define MIGRATION_API_VERSION	1
 
-static CLASS_ATTR(migration, S_IWUSR, NULL, migrate_store);
-static CLASS_ATTR_STRING(api_version, S_IRUGO, __stringify(MIGRATION_API_VERSION));
+static CLASS_ATTR(migration, 0200, NULL, migrate_store);
+static CLASS_ATTR_STRING(api_version, 0444, __stringify(MIGRATION_API_VERSION));
 
 static int __init mobility_sysfs_init(void)
 {
diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
index e5bf1e84047f..f926da2a7116 100644
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -413,7 +413,7 @@ static int proc_ppc64_create_ofdt(void)
 {
 	struct proc_dir_entry *ent;
 
-	ent = proc_create("powerpc/ofdt", S_IWUSR, NULL, &ofdt_fops);
+	ent = proc_create("powerpc/ofdt", 0200, NULL, &ofdt_fops);
 	if (ent)
 		proc_set_size(ent, 0);
 
diff --git a/arch/powerpc/platforms/pseries/scanlog.c b/arch/powerpc/platforms/pseries/scanlog.c
index c47585a78b69..054ce7a16fc3 100644
--- a/arch/powerpc/platforms/pseries/scanlog.c
+++ b/arch/powerpc/platforms/pseries/scanlog.c
@@ -179,7 +179,7 @@ static int __init scanlog_init(void)
 	if (!scanlog_buffer)
 		goto err;
 
-	ent = proc_create("powerpc/rtas/scan-log-dump", S_IRUSR, NULL,
+	ent = proc_create("powerpc/rtas/scan-log-dump", 0400, NULL,
 			  &scanlog_fops);
 	if (!ent)
 		goto err;
diff --git a/arch/powerpc/platforms/pseries/suspend.c b/arch/powerpc/platforms/pseries/suspend.c
index e76aefae2aa2..6dfa2eacba49 100644
--- a/arch/powerpc/platforms/pseries/suspend.c
+++ b/arch/powerpc/platforms/pseries/suspend.c
@@ -214,8 +214,7 @@ static ssize_t show_hibernate(struct device *dev,
 	return sprintf(buf, "%d\n", KERN_DT_UPDATE);
 }
 
-static DEVICE_ATTR(hibernate, S_IWUSR | S_IRUGO,
-		   show_hibernate, store_hibernate);
+static DEVICE_ATTR(hibernate, 0644, show_hibernate, store_hibernate);
 
 static struct bus_type suspend_subsys = {
 	.name = "power",
diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 2c8fb3ec989e..bc25c2cbc17e 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -997,11 +997,11 @@ static struct device_attribute vio_cmo_dev_attrs[] = {
 	__ATTR_RO(name),
 	__ATTR_RO(devspec),
 	__ATTR_RO(modalias),
-	__ATTR(cmo_desired,       S_IWUSR|S_IRUSR|S_IWGRP|S_IRGRP|S_IROTH,
+	__ATTR(cmo_desired,       0664,
 	       viodev_cmo_desired_show, viodev_cmo_desired_set),
-	__ATTR(cmo_entitled,      S_IRUGO, viodev_cmo_entitled_show,      NULL),
-	__ATTR(cmo_allocated,     S_IRUGO, viodev_cmo_allocated_show,     NULL),
-	__ATTR(cmo_allocs_failed, S_IWUSR|S_IRUSR|S_IWGRP|S_IRGRP|S_IROTH,
+	__ATTR(cmo_entitled,      0444, viodev_cmo_entitled_show,      NULL),
+	__ATTR(cmo_allocated,     0444, viodev_cmo_allocated_show,     NULL),
+	__ATTR(cmo_allocs_failed, 0664,
 	       viodev_cmo_allocs_failed_show, viodev_cmo_allocs_failed_reset),
 	__ATTR_NULL
 };
diff --git a/arch/powerpc/sysdev/axonram.c b/arch/powerpc/sysdev/axonram.c
index ada29eaed6e2..0cff5c8478cd 100644
--- a/arch/powerpc/sysdev/axonram.c
+++ b/arch/powerpc/sysdev/axonram.c
@@ -80,7 +80,7 @@ axon_ram_sysfs_ecc(struct device *dev, struct device_attribute *attr, char *buf)
 	return sprintf(buf, "%ld\n", bank->ecc_counter);
 }
 
-static DEVICE_ATTR(ecc, S_IRUGO, axon_ram_sysfs_ecc, NULL);
+static DEVICE_ATTR(ecc, 0444, axon_ram_sysfs_ecc, NULL);
 
 /**
  * axon_ram_irq_handler - interrupt handler for Axon RAM ECC
diff --git a/arch/powerpc/sysdev/mv64x60_pci.c b/arch/powerpc/sysdev/mv64x60_pci.c
index 330d56613c5a..b06d1b7c262f 100644
--- a/arch/powerpc/sysdev/mv64x60_pci.c
+++ b/arch/powerpc/sysdev/mv64x60_pci.c
@@ -73,7 +73,7 @@ static ssize_t mv64x60_hs_reg_write(struct file *filp, struct kobject *kobj,
 static struct bin_attribute mv64x60_hs_reg_attr = { /* Hotswap register */
 	.attr = {
 		.name = "hs_reg",
-		.mode = S_IRUGO | S_IWUSR,
+		.mode = 0644,
 	},
 	.size  = MV64X60_VAL_LEN_MAX,
 	.read  = mv64x60_hs_reg_read,
-- 
2.11.0
