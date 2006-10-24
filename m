Return-Path: <arnd@arndb.de>
Message-Id: <20061024163816.043835000@arndb.de>
References: <20061024163113.694643000@arndb.de>
Date: Tue, 24 Oct 2006 18:31:23 +0200
From: arnd@arndb.de
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [PATCH 10/16] cell: add support for registering sysfs attributes to
	spus
Cc: Christian Krafft <krafft@de.ibm.com>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christian Krafft <krafft@de.ibm.com>

In order to add sysfs attributes to all spu's, there is a
need for a list of all available spu's. Adding the device_node
makes also sense, as it is needed for proper register access.
This patch also adds two functions to create and remove sysfs
attributes and attribute_groups to all spus.
That allows to group spu attributes in a subdirectory like:
/sys/devices/system/spu/spuX/group_name/what_ever
This will be used by cbe_thermal to group all attributes dealing with
thermal support in one directory.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/spu.h
+++ linux-2.6/include/asm-powerpc/spu.h
@@ -115,6 +115,7 @@ struct spu {
 	struct spu_priv2 __iomem *priv2;
 	struct list_head list;
 	struct list_head sched_list;
+	struct list_head full_list;
 	int number;
 	int nid;
 	unsigned int irqs[3];
@@ -143,6 +144,8 @@ struct spu {
 	char irq_c1[8];
 	char irq_c2[8];
 
+	struct device_node *devnode;
+
 	struct sys_device sysdev;
 };
 
@@ -200,6 +203,12 @@ static inline void unregister_spu_syscal
 }
 #endif /* MODULE */
 
+int spu_add_sysdev_attr(struct sysdev_attribute *attr);
+void spu_remove_sysdev_attr(struct sysdev_attribute *attr);
+
+int spu_add_sysdev_attr_group(struct attribute_group *attrs);
+void spu_remove_sysdev_attr_group(struct attribute_group *attrs);
+
 
 /*
  * Notifier blocks:
Index: linux-2.6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6/arch/powerpc/platforms/cell/spu_base.c
@@ -333,6 +333,7 @@ static void spu_free_irqs(struct spu *sp
 }
 
 static struct list_head spu_list[MAX_NUMNODES];
+static LIST_HEAD(spu_full_list);
 static DEFINE_MUTEX(spu_mutex);
 
 static void spu_init_channels(struct spu *spu)
@@ -744,6 +745,57 @@ struct sysdev_class spu_sysdev_class = {
 	set_kset_name("spu")
 };
 
+int spu_add_sysdev_attr(struct sysdev_attribute *attr)
+{
+	struct spu *spu;
+	mutex_lock(&spu_mutex);
+
+	list_for_each_entry(spu, &spu_full_list, full_list)
+		sysdev_create_file(&spu->sysdev, attr);
+
+	mutex_unlock(&spu_mutex);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spu_add_sysdev_attr);
+
+int spu_add_sysdev_attr_group(struct attribute_group *attrs)
+{
+	struct spu *spu;
+	mutex_lock(&spu_mutex);
+
+	list_for_each_entry(spu, &spu_full_list, full_list)
+		sysfs_create_group(&spu->sysdev.kobj, attrs);
+
+	mutex_unlock(&spu_mutex);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spu_add_sysdev_attr_group);
+
+
+void spu_remove_sysdev_attr(struct sysdev_attribute *attr)
+{
+	struct spu *spu;
+	mutex_lock(&spu_mutex);
+
+	list_for_each_entry(spu, &spu_full_list, full_list)
+		sysdev_remove_file(&spu->sysdev, attr);
+
+	mutex_unlock(&spu_mutex);
+}
+EXPORT_SYMBOL_GPL(spu_remove_sysdev_attr);
+
+void spu_remove_sysdev_attr_group(struct attribute_group *attrs)
+{
+	struct spu *spu;
+	mutex_lock(&spu_mutex);
+
+	list_for_each_entry(spu, &spu_full_list, full_list)
+		sysfs_remove_group(&spu->sysdev.kobj, attrs);
+
+	mutex_unlock(&spu_mutex);
+}
+EXPORT_SYMBOL_GPL(spu_remove_sysdev_attr_group);
+
 static int spu_create_sysdev(struct spu *spu)
 {
 	int ret;
@@ -817,6 +869,9 @@ static int __init create_spu(struct devi
 		goto out_free_irqs;
 
 	list_add(&spu->list, &spu_list[spu->node]);
+	list_add(&spu->full_list, &spu_full_list);
+	spu->devnode = of_node_get(spe);
+
 	mutex_unlock(&spu_mutex);
 
 	pr_debug(KERN_DEBUG "Using SPE %s %p %p %p %p %d\n",
@@ -839,6 +894,9 @@ out:
 static void destroy_spu(struct spu *spu)
 {
 	list_del_init(&spu->list);
+	list_del_init(&spu->full_list);
+
+	of_node_put(spu->devnode);
 
 	spu_destroy_sysdev(spu);
 	spu_free_irqs(spu);

--
