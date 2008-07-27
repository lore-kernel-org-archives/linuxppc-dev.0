Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 1C405DDF69
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 15:25:19 +1000 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 6/6] show processor cache information in sysfs
Date: Sun, 27 Jul 2008 00:24:55 -0500
Message-Id: <1217136295-18693-7-git-send-email-ntl@pobox.com>
In-Reply-To: <1217136295-18693-1-git-send-email-ntl@pobox.com>
References: <1217136295-18693-1-git-send-email-ntl@pobox.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Collect cache information from the OF device tree and display it in
the cpu hierarchy in sysfs.  This is intended to be compatible at the
userspace level with x86's implementation[1], hence some of the funny
attribute names.  The arrangement of cache info is not immediately
intuitive, but (again) it's for compatibility's sake.

The cache attributes exposed are:

type (Data, Instruction, or Unified)
level (1, 2, 3...)
size
coherency_line_size
number_of_sets
ways_of_associativity

All of these can be derived on platforms that follow the OF PowerPC
Processor binding.  The code "publishes" only those attributes for
which it is able to determine values; attributes for values which
cannot be determined are not created at all.

[1] arch/x86/kernel/cpu/intel_cacheinfo.c

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/kernel/sysfs.c |  308 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 308 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 1568080..7f56cc8 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -22,6 +22,8 @@
 
 static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
+static DEFINE_PER_CPU(struct kobject *, cache_toplevel);
+
 /* SMT stuff */
 
 #ifdef CONFIG_PPC_MULTIPLATFORM
@@ -297,6 +299,286 @@ static struct sysdev_attribute pa6t_attrs[] = {
 #endif /* CONFIG_DEBUG_KERNEL */
 };
 
+struct cache_desc {
+	struct kobject kobj;
+	struct cache_desc *next;
+	const char *type;	/* Instruction, Data, or Unified */
+	u32 size;		/* total cache size in KB */
+	u32 line_size;		/* in bytes */
+	u32 nr_sets;		/* number of sets */
+	u32 level;		/* e.g. 1, 2, 3... */
+	u32 associativity;	/* e.g. 8-way... 0 is fully associative */
+};
+
+DEFINE_PER_CPU(struct cache_desc *, cache_desc);
+
+static struct cache_desc *kobj_to_cache_desc(struct kobject *k)
+{
+	return container_of(k, struct cache_desc, kobj);
+}
+
+static void cache_desc_release(struct kobject *k)
+{
+	struct cache_desc *desc = kobj_to_cache_desc(k);
+
+	printk("releasing %s\n", kobject_name(k));
+
+	if (desc->next)
+		kobject_put(&desc->next->kobj);
+
+	kfree(kobj_to_cache_desc(k));
+}
+
+static ssize_t cache_desc_show(struct kobject *k, struct attribute *attr, char *buf)
+{
+	struct kobj_attribute *kobj_attr;
+
+	kobj_attr = container_of(attr, struct kobj_attribute, attr);
+
+	return kobj_attr->show(k, kobj_attr, buf);
+}
+
+static struct sysfs_ops cache_desc_sysfs_ops = {
+	.show = cache_desc_show,
+};
+
+static struct kobj_type cache_desc_type = {
+	.release = cache_desc_release,
+	.sysfs_ops = &cache_desc_sysfs_ops,
+};
+
+static ssize_t cache_size_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
+{
+	struct cache_desc *cache = kobj_to_cache_desc(k);
+
+	return sprintf(buf, "%uK\n", cache->size);
+}
+
+static struct kobj_attribute cache_size_attr =
+	__ATTR(size, 0444, cache_size_show, NULL);
+
+static ssize_t cache_line_size_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
+{
+	struct cache_desc *cache = kobj_to_cache_desc(k);
+
+	return sprintf(buf, "%u\n", cache->line_size);
+}
+
+static struct kobj_attribute cache_line_size_attr =
+	__ATTR(coherency_line_size, 0444, cache_line_size_show, NULL);
+
+static ssize_t cache_nr_sets_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
+{
+	struct cache_desc *cache = kobj_to_cache_desc(k);
+
+	return sprintf(buf, "%u\n", cache->nr_sets);
+}
+
+static struct kobj_attribute cache_nr_sets_attr =
+	__ATTR(number_of_sets, 0444, cache_nr_sets_show, NULL);
+
+static ssize_t cache_type_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
+{
+	struct cache_desc *cache = kobj_to_cache_desc(k);
+
+	return sprintf(buf, "%s\n", cache->type);
+}
+
+static struct kobj_attribute cache_type_attr =
+	__ATTR(type, 0444, cache_type_show, NULL);
+
+static ssize_t cache_level_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
+{
+	struct cache_desc *cache = kobj_to_cache_desc(k);
+
+	return sprintf(buf, "%u\n", cache->level);
+}
+
+static struct kobj_attribute cache_level_attr =
+	__ATTR(level, 0444, cache_level_show, NULL);
+
+static ssize_t cache_assoc_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
+{
+	struct cache_desc *cache = kobj_to_cache_desc(k);
+
+	return sprintf(buf, "%u\n", cache->associativity);
+}
+
+static struct kobj_attribute cache_assoc_attr =
+	__ATTR(ways_of_associativity, 0444, cache_assoc_show, NULL);
+
+struct cache_desc_info {
+	const char *type;
+	const char *size_prop;
+	const char *line_size_prop;
+	const char *nr_sets_prop;
+};
+
+/* PowerPC Processor binding says the [di]-cache-* must be equal on
+ * unified caches, so just use d-cache properties. */
+static struct cache_desc_info ucache_info = {
+	.type = "Unified",
+	.size_prop = "d-cache-size",
+	.line_size_prop = "d-cache-line-size",
+	.nr_sets_prop = "d-cache-sets",
+};
+
+static struct cache_desc_info dcache_info = {
+	.type = "Data",
+	.size_prop = "d-cache-size",
+	.line_size_prop = "d-cache-line-size",
+	.nr_sets_prop = "d-cache-sets",
+};
+
+static struct cache_desc_info icache_info = {
+	.type = "Instruction",
+	.size_prop = "i-cache-size",
+	.line_size_prop = "i-cache-line-size",
+	.nr_sets_prop = "i-cache-sets",
+};
+
+static struct cache_desc * __cpuinit create_cache_desc(struct device_node *np, struct kobject *parent, int index, int level, struct cache_desc_info *info)
+{
+	const u32 *cache_line_size;
+	struct cache_desc *new;
+	const u32 *cache_size;
+	const u32 *nr_sets;
+	int rc;
+
+	new = kzalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return NULL;
+
+	rc = kobject_init_and_add(&new->kobj, &cache_desc_type, parent,
+				  "index%d", index);
+	if (rc)
+		goto err;
+
+	/* type */
+	new->type = info->type;
+	rc = sysfs_create_file(&new->kobj, &cache_type_attr.attr);
+	WARN_ON(rc);
+
+	/* level */
+	new->level = level;
+	rc = sysfs_create_file(&new->kobj, &cache_level_attr.attr);
+	WARN_ON(rc);
+
+	/* size */
+	cache_size = of_get_property(np, info->size_prop, NULL);
+	if (cache_size) {
+		new->size = *cache_size / 1024;
+		rc = sysfs_create_file(&new->kobj,
+				       &cache_size_attr.attr);
+		WARN_ON(rc);
+	}
+
+	/* coherency_line_size */
+	cache_line_size = of_get_property(np, info->line_size_prop, NULL);
+	if (cache_line_size) {
+		new->line_size = *cache_line_size;
+		rc = sysfs_create_file(&new->kobj,
+				       &cache_line_size_attr.attr);
+		WARN_ON(rc);
+	}
+
+	/* number_of_sets */
+	nr_sets = of_get_property(np, info->nr_sets_prop, NULL);
+	if (nr_sets) {
+		new->nr_sets = *nr_sets;
+		rc = sysfs_create_file(&new->kobj,
+				       &cache_nr_sets_attr.attr);
+		WARN_ON(rc);
+	}
+
+	/* ways_of_associativity */
+	if (new->nr_sets == 1) {
+		/* fully associative */
+		new->associativity = 0;
+		goto create_assoc;
+	}
+
+	if (new->nr_sets && new->size && new->line_size) {
+		/* If we have values for all of these we can derive
+		 * the associativity. */
+		new->associativity =
+			((new->size * 1024) / new->nr_sets) / new->line_size;
+create_assoc:
+		rc = sysfs_create_file(&new->kobj,
+				       &cache_assoc_attr.attr);
+		WARN_ON(rc);
+	}
+
+	return new;
+err:
+	kfree(new);
+	return NULL;
+}
+
+static bool cache_is_unified(struct device_node *np)
+{
+	return of_get_property(np, "cache-unified", NULL);
+}
+
+static struct cache_desc * __cpuinit create_cache_index_info(struct device_node *np, struct kobject *parent, int index, int level)
+{
+	const phandle *next_cache_phandle;
+	struct device_node *next_cache;
+	struct cache_desc *new, **end;
+
+	printk("%s(np = %s, index = %d)\n", __func__, np->name, index);
+	if (cache_is_unified(np)) {
+		new = create_cache_desc(np, parent, index, level,
+					&ucache_info);
+	} else {
+		new = create_cache_desc(np, parent, index, level,
+					&dcache_info);
+		if (new) {
+			index++;
+			new->next = create_cache_desc(np, parent, index, level,
+						      &icache_info);
+		}
+	}
+	if (!new)
+		return NULL;
+
+	end = &new->next;
+	while (*end)
+		end = &(*end)->next;
+
+	next_cache_phandle = of_get_property(np, "l2-cache", NULL);
+	if (!next_cache_phandle)
+		goto out;
+
+	next_cache = of_find_node_by_phandle(*next_cache_phandle);
+	if (!next_cache)
+		goto out;
+
+	*end = create_cache_index_info(next_cache, parent, ++index, ++level);
+
+	of_node_put(next_cache);
+out:
+	return new;
+}
+
+static void __cpuinit create_cache_info(struct sys_device *sysdev)
+{
+	struct kobject *cache_toplevel;
+	struct device_node *np = NULL;
+	int cpu = sysdev->id;
+
+	cache_toplevel = kobject_create_and_add("cache", &sysdev->kobj);
+	if (!cache_toplevel)
+		return;
+	per_cpu(cache_toplevel, cpu) = cache_toplevel;
+
+	np = of_get_cpu_node(cpu, NULL);
+	per_cpu(cache_desc, cpu) =
+		create_cache_index_info(np, cache_toplevel, 0, 1);
+	of_node_put(np);
+
+	return;
+}
 
 static void __cpuinit register_cpu_online(unsigned int cpu)
 {
@@ -346,9 +628,33 @@ static void __cpuinit register_cpu_online(unsigned int cpu)
 
 	if (cpu_has_feature(CPU_FTR_DSCR))
 		sysdev_create_file(s, &attr_dscr);
+
+	create_cache_info(s);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
+static void remove_cache_info(struct sys_device *sysdev)
+{
+	struct kobject *cache_toplevel;
+	struct cache_desc *cache_desc;
+	int cpu = sysdev->id;
+
+	cache_desc = per_cpu(cache_desc, cpu);
+
+	sysfs_remove_file(&cache_desc->kobj, &cache_size_attr.attr);
+	sysfs_remove_file(&cache_desc->kobj, &cache_line_size_attr.attr);
+	sysfs_remove_file(&cache_desc->kobj, &cache_type_attr.attr);
+	sysfs_remove_file(&cache_desc->kobj, &cache_level_attr.attr);
+	sysfs_remove_file(&cache_desc->kobj, &cache_nr_sets_attr.attr);
+	sysfs_remove_file(&cache_desc->kobj, &cache_assoc_attr.attr);
+
+	kobject_put(&cache_desc->kobj);
+
+	cache_toplevel = per_cpu(cache_toplevel, cpu);
+
+	kobject_put(cache_toplevel);
+}
+
 static void unregister_cpu_online(unsigned int cpu)
 {
 	struct cpu *c = &per_cpu(cpu_devices, cpu);
@@ -399,6 +705,8 @@ static void unregister_cpu_online(unsigned int cpu)
 
 	if (cpu_has_feature(CPU_FTR_DSCR))
 		sysdev_remove_file(s, &attr_dscr);
+
+	remove_cache_info(s);
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-- 
1.5.6.2
