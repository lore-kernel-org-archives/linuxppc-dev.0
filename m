Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 49990DE82B
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 04:30:33 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6NIUTjx012558
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 14:30:29 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6NIUT21229874
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 14:30:29 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6NIUSFQ001129
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 14:30:29 -0400
Date: Wed, 23 Jul 2008 13:30:29 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH 07/16 v4] powerpc: Add collaborative memory manager
Message-ID: <20080723183028.GJ12905@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080723181932.GC12905@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=46rom: Brian King <brking@linux.vnet.ibm.com>

Adds a collaborative memory manager, which acts as a simple balloon driver
for System p machines that support cooperative memory overcommitment
(CMO).

Adds a platform configuration option for CMO called PPC_SMLPAR.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---
Added a config option PPC_SMLPAR ("Support for shared-memory logical
partitions") to the platform.  This will select LPARCFG and address the
issue where h_get_mpp() may not have been present when compiling.  This
new config option is now used to #ifdef out code in the vio bus patch that
follows and the arch vector patch that enables the code for firmware.

---
 arch/powerpc/platforms/pseries/Kconfig  |   23 ++
 arch/powerpc/platforms/pseries/Makefile |    1 +
 arch/powerpc/platforms/pseries/cmm.c    |  468 +++++++++++++++++++++++++++=
+++++
 3 files changed, 492 insertions(+)

Index: b/arch/powerpc/platforms/pseries/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -40,3 +40,26 @@ config PPC_PSERIES_DEBUG
 	depends on PPC_PSERIES && PPC_EARLY_DEBUG
 	bool "Enable extra debug logging in platforms/pseries"
 	default y
+
+config PPC_SMLPAR
+	bool "Support for shared-memory logical partitions"
+	depends on PPC_PSERIES
+	select LPARCFG
+	default y
+	help
+	  Select this option to enable shared memory partition support.
+	  With this option a system running in an LPAR can be given more
+	  memory than physically available and will allow firmware to
+	  balance memory across many LPARs.
+
+config CMM
+	tristate "Collaborative memory management"
+	depends on PPC_SMLPAR
+	default y
+	help
+	  Select this option, if you want to enable the kernel interface
+	  to reduce the memory size of the system. This is accomplished
+	  by allocating pages of memory and put them "on hold". This only
+	  makes sense for a system running in an LPAR where the unused pages
+	  will be reused for other LPARs. The interface allows firmware to
+	  balance memory across many LPARs.
Index: b/arch/powerpc/platforms/pseries/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_HVC_CONSOLE)	+=3D hvconsole.o
 obj-$(CONFIG_HVCS)		+=3D hvcserver.o
 obj-$(CONFIG_HCALL_STATS)	+=3D hvCall_inst.o
 obj-$(CONFIG_PHYP_DUMP)	+=3D phyp_dump.o
+obj-$(CONFIG_CMM)		+=3D cmm.o
Index: b/arch/powerpc/platforms/pseries/cmm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -0,0 +1,468 @@
+/*
+ * Collaborative memory management interface.
+ *
+ * Copyright (C) 2008 IBM Corporation
+ * Author(s): Brian King (brking@linux.vnet.ibm.com),
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  U=
SA
+ *
+ */
+
+#include <linux/ctype.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/oom.h>
+#include <linux/sched.h>
+#include <linux/stringify.h>
+#include <linux/swap.h>
+#include <linux/sysdev.h>
+#include <asm/firmware.h>
+#include <asm/hvcall.h>
+#include <asm/mmu.h>
+#include <asm/pgalloc.h>
+#include <asm/uaccess.h>
+
+#include "plpar_wrappers.h"
+
+#define CMM_DRIVER_VERSION	"1.0.0"
+#define CMM_DEFAULT_DELAY	1
+#define CMM_DEBUG			0
+#define CMM_DISABLE		0
+#define CMM_OOM_KB		1024
+#define CMM_MIN_MEM_MB		256
+#define KB2PAGES(_p)		((_p)>>(PAGE_SHIFT-10))
+#define PAGES2KB(_p)		((_p)<<(PAGE_SHIFT-10))
+
+static unsigned int delay =3D CMM_DEFAULT_DELAY;
+static unsigned int oom_kb =3D CMM_OOM_KB;
+static unsigned int cmm_debug =3D CMM_DEBUG;
+static unsigned int cmm_disabled =3D CMM_DISABLE;
+static unsigned long min_mem_mb =3D CMM_MIN_MEM_MB;
+static struct sys_device cmm_sysdev;
+
+MODULE_AUTHOR("Brian King <brking@linux.vnet.ibm.com>");
+MODULE_DESCRIPTION("IBM System p Collaborative Memory Manager");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(CMM_DRIVER_VERSION);
+
+module_param_named(delay, delay, uint, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(delay, "Delay (in seconds) between polls to query hypervi=
sor paging requests. "
+		 "[Default=3D" __stringify(CMM_DEFAULT_DELAY) "]");
+module_param_named(oom_kb, oom_kb, uint, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(oom_kb, "Amount of memory in kb to free on OOM. "
+		 "[Default=3D" __stringify(CMM_OOM_KB) "]");
+module_param_named(min_mem_mb, min_mem_mb, ulong, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(min_mem_mb, "Minimum amount of memory (in MB) to not ball=
oon. "
+		 "[Default=3D" __stringify(CMM_MIN_MEM_MB) "]");
+module_param_named(debug, cmm_debug, uint, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(debug, "Enable module debugging logging. Set to 1 to enab=
le. "
+		 "[Default=3D" __stringify(CMM_DEBUG) "]");
+
+#define CMM_NR_PAGES ((PAGE_SIZE - sizeof(void *) - sizeof(unsigned long))=
 / sizeof(unsigned long))
+
+#define cmm_dbg(...) if (cmm_debug) { printk(KERN_INFO "cmm: "__VA_ARGS__)=
; }
+
+struct cmm_page_array {
+	struct cmm_page_array *next;
+	unsigned long index;
+	unsigned long page[CMM_NR_PAGES];
+};
+
+static unsigned long loaned_pages;
+static unsigned long loaned_pages_target;
+static unsigned long oom_freed_pages;
+
+static struct cmm_page_array *cmm_page_list;
+static DEFINE_SPINLOCK(cmm_lock);
+
+static struct task_struct *cmm_thread_ptr;
+
+/**
+ * cmm_alloc_pages - Allocate pages and mark them as loaned
+ * @nr:	number of pages to allocate
+ *
+ * Return value:
+ * 	number of pages requested to be allocated which were not
+ **/
+static long cmm_alloc_pages(long nr)
+{
+	struct cmm_page_array *pa, *npa;
+	unsigned long addr;
+	long rc;
+
+	cmm_dbg("Begin request for %ld pages\n", nr);
+
+	while (nr) {
+		addr =3D __get_free_page(GFP_NOIO | __GFP_NOWARN |
+				       __GFP_NORETRY | __GFP_NOMEMALLOC);
+		if (!addr)
+			break;
+		spin_lock(&cmm_lock);
+		pa =3D cmm_page_list;
+		if (!pa || pa->index >=3D CMM_NR_PAGES) {
+			/* Need a new page for the page list. */
+			spin_unlock(&cmm_lock);
+			npa =3D (struct cmm_page_array *)__get_free_page(GFP_NOIO | __GFP_NOWAR=
N |
+								       __GFP_NORETRY | __GFP_NOMEMALLOC);
+			if (!npa) {
+				pr_info("%s: Can not allocate new page list\n", __FUNCTION__);
+				free_page(addr);
+				break;
+			}
+			spin_lock(&cmm_lock);
+			pa =3D cmm_page_list;
+
+			if (!pa || pa->index >=3D CMM_NR_PAGES) {
+				npa->next =3D pa;
+				npa->index =3D 0;
+				pa =3D npa;
+				cmm_page_list =3D pa;
+			} else
+				free_page((unsigned long) npa);
+		}
+
+		if ((rc =3D plpar_page_set_loaned(__pa(addr)))) {
+			pr_err("%s: Can not set page to loaned. rc=3D%ld\n", __FUNCTION__, rc);
+			spin_unlock(&cmm_lock);
+			free_page(addr);
+			break;
+		}
+
+		pa->page[pa->index++] =3D addr;
+		loaned_pages++;
+		totalram_pages--;
+		spin_unlock(&cmm_lock);
+		nr--;
+	}
+
+	cmm_dbg("End request with %ld pages unfulfilled\n", nr);
+	return nr;
+}
+
+/**
+ * cmm_free_pages - Free pages and mark them as active
+ * @nr:	number of pages to free
+ *
+ * Return value:
+ * 	number of pages requested to be freed which were not
+ **/
+static long cmm_free_pages(long nr)
+{
+	struct cmm_page_array *pa;
+	unsigned long addr;
+
+	cmm_dbg("Begin free of %ld pages.\n", nr);
+	spin_lock(&cmm_lock);
+	pa =3D cmm_page_list;
+	while (nr) {
+		if (!pa || pa->index <=3D 0)
+			break;
+		addr =3D pa->page[--pa->index];
+
+		if (pa->index =3D=3D 0) {
+			pa =3D pa->next;
+			free_page((unsigned long) cmm_page_list);
+			cmm_page_list =3D pa;
+		}
+
+		plpar_page_set_active(__pa(addr));
+		free_page(addr);
+		loaned_pages--;
+		nr--;
+		totalram_pages++;
+	}
+	spin_unlock(&cmm_lock);
+	cmm_dbg("End request with %ld pages unfulfilled\n", nr);
+	return nr;
+}
+
+/**
+ * cmm_oom_notify - OOM notifier
+ * @self:	notifier block struct
+ * @dummy:	not used
+ * @parm:	returned - number of pages freed
+ *
+ * Return value:
+ * 	NOTIFY_OK
+ **/
+static int cmm_oom_notify(struct notifier_block *self,
+			  unsigned long dummy, void *parm)
+{
+	unsigned long *freed =3D parm;
+	long nr =3D KB2PAGES(oom_kb);
+
+	cmm_dbg("OOM processing started\n");
+	nr =3D cmm_free_pages(nr);
+	loaned_pages_target =3D loaned_pages;
+	*freed +=3D KB2PAGES(oom_kb) - nr;
+	oom_freed_pages +=3D KB2PAGES(oom_kb) - nr;
+	cmm_dbg("OOM processing complete\n");
+	return NOTIFY_OK;
+}
+
+/**
+ * cmm_get_mpp - Read memory performance parameters
+ *
+ * Makes hcall to query the current page loan request from the hypervisor.
+ *
+ * Return value:
+ * 	nothing
+ **/
+static void cmm_get_mpp(void)
+{
+	int rc;
+	struct hvcall_mpp_data mpp_data;
+	unsigned long active_pages_target;
+	signed long page_loan_request;
+
+	rc =3D h_get_mpp(&mpp_data);
+
+	if (rc !=3D H_SUCCESS)
+		return;
+
+	page_loan_request =3D div_s64((s64)mpp_data.loan_request, PAGE_SIZE);
+	loaned_pages_target =3D page_loan_request + loaned_pages;
+	if (loaned_pages_target > oom_freed_pages)
+		loaned_pages_target -=3D oom_freed_pages;
+	else
+		loaned_pages_target =3D 0;
+
+	active_pages_target =3D totalram_pages + loaned_pages - loaned_pages_targ=
et;
+
+	if ((min_mem_mb * 1024 * 1024) > (active_pages_target * PAGE_SIZE))
+		loaned_pages_target =3D totalram_pages + loaned_pages -
+			((min_mem_mb * 1024 * 1024) / PAGE_SIZE);
+
+	cmm_dbg("delta =3D %ld, loaned =3D %lu, target =3D %lu, oom =3D %lu, tota=
lram =3D %lu\n",
+		page_loan_request, loaned_pages, loaned_pages_target,
+		oom_freed_pages, totalram_pages);
+}
+
+static struct notifier_block cmm_oom_nb =3D {
+	.notifier_call =3D cmm_oom_notify
+};
+
+/**
+ * cmm_thread - CMM task thread
+ * @dummy:	not used
+ *
+ * Return value:
+ * 	0
+ **/
+static int cmm_thread(void *dummy)
+{
+	unsigned long timeleft;
+
+	while (1) {
+		timeleft =3D msleep_interruptible(delay * 1000);
+
+		if (kthread_should_stop() || timeleft) {
+			loaned_pages_target =3D loaned_pages;
+			break;
+		}
+
+		cmm_get_mpp();
+
+		if (loaned_pages_target > loaned_pages) {
+			if (cmm_alloc_pages(loaned_pages_target - loaned_pages))
+				loaned_pages_target =3D loaned_pages;
+		} else if (loaned_pages_target < loaned_pages)
+			cmm_free_pages(loaned_pages - loaned_pages_target);
+	}
+	return 0;
+}
+
+#define CMM_SHOW(name, format, args...)			\
+	static ssize_t show_##name(struct sys_device *dev, char *buf)	\
+	{							\
+		return sprintf(buf, format, ##args);		\
+	}							\
+	static SYSDEV_ATTR(name, S_IRUGO, show_##name, NULL)
+
+CMM_SHOW(loaned_kb, "%lu\n", PAGES2KB(loaned_pages));
+CMM_SHOW(loaned_target_kb, "%lu\n", PAGES2KB(loaned_pages_target));
+
+static ssize_t show_oom_pages(struct sys_device *dev, char *buf)
+{
+	return sprintf(buf, "%lu\n", PAGES2KB(oom_freed_pages));
+}
+
+static ssize_t store_oom_pages(struct sys_device *dev,
+			       const char *buf, size_t count)
+{
+	unsigned long val =3D simple_strtoul (buf, NULL, 10);
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	if (val !=3D 0)
+		return -EBADMSG;
+
+	oom_freed_pages =3D 0;
+	return count;
+}
+
+static SYSDEV_ATTR(oom_freed_kb, S_IWUSR| S_IRUGO,
+		   show_oom_pages, store_oom_pages);
+
+static struct sysdev_attribute *cmm_attrs[] =3D {
+	&attr_loaned_kb,
+	&attr_loaned_target_kb,
+	&attr_oom_freed_kb,
+};
+
+static struct sysdev_class cmm_sysdev_class =3D {
+	.name =3D "cmm",
+};
+
+/**
+ * cmm_sysfs_register - Register with sysfs
+ *
+ * Return value:
+ * 	0 on success / other on failure
+ **/
+static int cmm_sysfs_register(struct sys_device *sysdev)
+{
+	int i, rc;
+
+	if ((rc =3D sysdev_class_register(&cmm_sysdev_class)))
+		return rc;
+
+	sysdev->id =3D 0;
+	sysdev->cls =3D &cmm_sysdev_class;
+
+	if ((rc =3D sysdev_register(sysdev)))
+		goto class_unregister;
+
+	for (i =3D 0; i < ARRAY_SIZE(cmm_attrs); i++) {
+		if ((rc =3D sysdev_create_file(sysdev, cmm_attrs[i])))
+			goto fail;
+	}
+
+	return 0;
+
+fail:
+	while (--i >=3D 0)
+		sysdev_remove_file(sysdev, cmm_attrs[i]);
+	sysdev_unregister(sysdev);
+class_unregister:
+	sysdev_class_unregister(&cmm_sysdev_class);
+	return rc;
+}
+
+/**
+ * cmm_unregister_sysfs - Unregister from sysfs
+ *
+ **/
+static void cmm_unregister_sysfs(struct sys_device *sysdev)
+{
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(cmm_attrs); i++)
+		sysdev_remove_file(sysdev, cmm_attrs[i]);
+	sysdev_unregister(sysdev);
+	sysdev_class_unregister(&cmm_sysdev_class);
+}
+
+/**
+ * cmm_init - Module initialization
+ *
+ * Return value:
+ * 	0 on success / other on failure
+ **/
+static int cmm_init(void)
+{
+	int rc =3D -ENOMEM;
+
+	if (!firmware_has_feature(FW_FEATURE_CMO))
+		return -EOPNOTSUPP;
+
+	if ((rc =3D register_oom_notifier(&cmm_oom_nb)) < 0)
+		return rc;
+
+	if ((rc =3D cmm_sysfs_register(&cmm_sysdev)))
+		goto out_oom_notifier;
+
+	if (cmm_disabled)
+		return rc;
+
+	cmm_thread_ptr =3D kthread_run(cmm_thread, NULL, "cmmthread");
+	if (IS_ERR(cmm_thread_ptr)) {
+		rc =3D PTR_ERR(cmm_thread_ptr);
+		goto out_unregister_sysfs;
+	}
+
+	return rc;
+
+out_unregister_sysfs:
+	cmm_unregister_sysfs(&cmm_sysdev);
+out_oom_notifier:
+	unregister_oom_notifier(&cmm_oom_nb);
+	return rc;
+}
+
+/**
+ * cmm_exit - Module exit
+ *
+ * Return value:
+ * 	nothing
+ **/
+static void cmm_exit(void)
+{
+	if (cmm_thread_ptr)
+		kthread_stop(cmm_thread_ptr);
+	unregister_oom_notifier(&cmm_oom_nb);
+	cmm_free_pages(loaned_pages);
+	cmm_unregister_sysfs(&cmm_sysdev);
+}
+
+/**
+ * cmm_set_disable - Disable/Enable CMM
+ *
+ * Return value:
+ * 	0 on success / other on failure
+ **/
+static int cmm_set_disable(const char *val, struct kernel_param *kp)
+{
+	int disable =3D simple_strtoul(val, NULL, 10);
+
+	if (disable !=3D 0 && disable !=3D 1)
+		return -EINVAL;
+
+	if (disable && !cmm_disabled) {
+		if (cmm_thread_ptr)
+			kthread_stop(cmm_thread_ptr);
+		cmm_thread_ptr =3D NULL;
+		cmm_free_pages(loaned_pages);
+	} else if (!disable && cmm_disabled) {
+		cmm_thread_ptr =3D kthread_run(cmm_thread, NULL, "cmmthread");
+		if (IS_ERR(cmm_thread_ptr))
+			return PTR_ERR(cmm_thread_ptr);
+	}
+
+	cmm_disabled =3D disable;
+	return 0;
+}
+
+module_param_call(disable, cmm_set_disable, param_get_uint,
+		  &cmm_disabled, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(disable, "Disable CMM. Set to 1 to disable. "
+		 "[Default=3D" __stringify(CMM_DISABLE) "]");
+
+module_init(cmm_init);
+module_exit(cmm_exit);
