Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id ACFB6DDE98
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Dec 2008 15:56:00 +1100 (EST)
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id
	DF7488A12D
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Dec 2008 23:55:55 -0500 (EST)
Received: from thinkcentre (unknown [67.9.156.46]) by
	a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPA id DD70F8A12A
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Dec 2008 23:55:54 -0500 (EST)
Date: Tue, 23 Dec 2008 22:55:54 -0600
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH/RFC] sysfs cache code rewrite
Message-ID: <20081224045554.GA6958@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The current code for providing processor cache information in sysfs
has the following deficiencies:
- several complex functions that are hard to understand
- implicit recursion (cache_desc_release -> kobject_put -> cache_desc_release)
- explicit recursion (create_cache_index_info)
- use of two per-cpu arrays when one would suffice
- duplication of work on systems where CPUs share cache

Also, when I looked at implementing support for a shared_cpu_map
attribute, it was pretty much impossible to handle hotplug without
checking every single online CPU's cache_desc list and fixing things
up... not that this is a hot path, but it would have introduced
O(n^2)-ish behavior during boot.  Addressing this involved rethinking
the core data structures used, which didn't lend itself to an
incremental approach.

This implementation maintains a "forest" (potentially more than one
tree) of cache objects which reflects the system's cache topology.
Cache objects are instantiated as needed as CPUs come online.  A
per-cpu array is used mainly for sysfs-related bookkeeping; the
objects in the array just point to the appropriate points in the
forest.

This maintains compatibility with the existing code and includes some
enhancements:
- Implement the shared_cpu_map attribute, which is essential for
  enabling userspace to discover the system's overall cache topology.
- Use cache-block-size properties if cache-line-size is not available.

I chose to place this implementation in a new file since it would have
roughly doubled the size of sysfs.c, which is already kind of messy.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/kernel/Makefile    |    2 +-
 arch/powerpc/kernel/cacheinfo.c |  837 +++++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/cacheinfo.h |    8 +
 arch/powerpc/kernel/sysfs.c     |  300 +--------------
 4 files changed, 850 insertions(+), 297 deletions(-)
 create mode 100644 arch/powerpc/kernel/cacheinfo.c
 create mode 100644 arch/powerpc/kernel/cacheinfo.h

I've tested this on various ppc64 systems, making sure that the cache
attributes' output remain unchanged, as well as running cpu hotplug
stress tests while concurrently accessing the cpu sysfs hierarchy.

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 089209a..330463d 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -28,7 +28,7 @@ endif
 obj-y				:= cputable.o ptrace.o syscalls.o \
 				   irq.o align.o signal_32.o pmc.o vdso.o \
 				   init_task.o process.o systbl.o idle.o \
-				   signal.o sysfs.o
+				   signal.o sysfs.o cacheinfo.o
 obj-y				+= vdso32/
 obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 				   signal_64.o ptrace32.o \
diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
new file mode 100644
index 0000000..f3e3ae3
--- /dev/null
+++ b/arch/powerpc/kernel/cacheinfo.c
@@ -0,0 +1,837 @@
+/*
+ * Processor cache information made available to userspace via sysfs;
+ * intended to be compatible with x86 intel_cacheinfo implementation.
+ *
+ * Copyright 2008 IBM Corporation
+ * Author: Nathan Lynch
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ */
+
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/kobject.h>
+#include <linux/list.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/percpu.h>
+#include <asm/prom.h>
+
+#include "cacheinfo.h"
+
+/* per-cpu object for tracking:
+ * - a "cache" kobject for the top-level directory
+ * - a list of "index" objects representing the cpu's local cache hierarchy
+ */
+struct cache_dir {
+	struct kobject *kobj; /* bare (not embedded) kobject for cache
+			       * directory */
+	struct cache_index_dir *index; /* list of index objects */
+};
+
+/* "index" object: each cpu's cache directory has an index
+ * subdirectory corresponding to a cache object associated with the
+ * cpu.  This object's lifetime is managed via the embedded kobject.
+ */
+struct cache_index_dir {
+	struct kobject kobj;
+	struct cache_index_dir *next; /* next index in parent directory */
+	struct cache *cache;
+};
+
+/* Template for determining which OF properties to query for a given
+ * cache type */
+struct cache_type_info {
+	const char *name;
+	const char *size_prop;
+
+	/* Allow for both [di]-cache-line-size and
+	 * [di]-cache-block-size properties.  According to the PowerPC
+	 * Processor binding, -line-size should be provided if it
+	 * differs from the cache block size (that which is operated
+	 * on by cache instructions), so we look for -line-size first.
+	 * See cache_get_line_size(). */
+
+	const char *line_size_props[2];
+	const char *nr_sets_prop;
+};
+
+/* These are used to index the cache_type_info array. */
+#define CACHE_TYPE_UNIFIED     0
+#define CACHE_TYPE_INSTRUCTION 1
+#define CACHE_TYPE_DATA        2
+
+static const struct cache_type_info cache_type_info[] = {
+	{
+		/* PowerPC Processor binding says the [di]-cache-*
+		 * must be equal on unified caches, so just use
+		 * d-cache properties. */
+		.name            = "Unified",
+		.size_prop       = "d-cache-size",
+		.line_size_props = { "d-cache-line-size",
+				     "d-cache-block-size", },
+		.nr_sets_prop    = "d-cache-sets",
+	},
+	{
+		.name            = "Instruction",
+		.size_prop       = "i-cache-size",
+		.line_size_props = { "i-cache-line-size",
+				     "i-cache-block-size", },
+		.nr_sets_prop    = "i-cache-sets",
+	},
+	{
+		.name            = "Data",
+		.size_prop       = "d-cache-size",
+		.line_size_props = { "d-cache-line-size",
+				     "d-cache-block-size", },
+		.nr_sets_prop    = "d-cache-sets",
+	},
+};
+
+/* Cache object: each instance of this corresponds to a distinct cache
+ * in the system.  There are separate objects for Harvard caches: one
+ * each for instruction and data, and each refers to the same OF node.
+ * The refcount of the OF node is elevated for the lifetime of the
+ * cache object.  A cache object is released when its shared_cpu_map
+ * is cleared (see cache_cpu_clear).
+ *
+ * A cache object is on two lists: an unsorted global list
+ * (cache_list) of cache objects; and a singly-linked list
+ * representing the local cache hierarchy, which is ordered by level
+ * (e.g. L1d -> L1i -> L2 -> L3).
+ */
+struct cache {
+	struct device_node *ofnode;    /* OF node for this cache, may be cpu */
+	struct cpumask shared_cpu_map; /* online CPUs using this cache */
+	int type;                      /* split cache disambiguation */
+	int level;                     /* level not explicit in device tree */
+	struct list_head list;         /* global list of cache objects */
+	struct cache *next_local;      /* next cache of >= level */
+};
+
+static DEFINE_PER_CPU(struct cache_dir *, cache_dir);
+
+/* traversal/modification of this list occurs only at cpu hotplug time;
+ * access is serialized by cpu hotplug locking
+ */
+static LIST_HEAD(cache_list);
+
+static struct cache_index_dir *kobj_to_cache_index_dir(struct kobject *k)
+{
+	return container_of(k, struct cache_index_dir, kobj);
+}
+
+static const char *cache_type_string(const struct cache *cache)
+{
+	return cache_type_info[cache->type].name;
+}
+
+static void __cpuinit cache_init(struct cache *cache, int type, int level, struct device_node *ofnode)
+{
+	cache->type = type;
+	cache->level = level;
+	cache->ofnode = of_node_get(ofnode);
+	INIT_LIST_HEAD(&cache->list);
+	list_add(&cache->list, &cache_list);
+}
+
+static struct cache *__cpuinit new_cache(int type, int level, struct device_node *ofnode)
+{
+	struct cache *cache;
+
+	cache = kzalloc(sizeof(*cache), GFP_KERNEL);
+	if (cache)
+		cache_init(cache, type, level, ofnode);
+
+	return cache;
+}
+
+static void release_cache_debugcheck(struct cache *cache)
+{
+	struct cache *iter;
+
+	list_for_each_entry(iter, &cache_list, list)
+		WARN_ONCE(iter->next_local == cache,
+			  "cache for %s(%s) refers to cache for %s(%s)\n",
+			  iter->ofnode->full_name,
+			  cache_type_string(iter),
+			  cache->ofnode->full_name,
+			  cache_type_string(cache));
+}
+
+static void release_cache(struct cache *cache)
+{
+	if (!cache)
+		return;
+
+	pr_debug("freeing L%d %s cache for %s\n", cache->level,
+		 cache_type_string(cache), cache->ofnode->full_name);
+
+	release_cache_debugcheck(cache);
+	list_del(&cache->list);
+	of_node_put(cache->ofnode);
+	kfree(cache);
+}
+
+static void cache_cpu_set(struct cache *cache, int cpu)
+{
+	struct cache *next = cache;
+
+	while (next) {
+		WARN_ONCE(cpumask_test_cpu(cpu, &next->shared_cpu_map),
+			  "CPU %i already accounted in %s(%s)\n",
+			  cpu, next->ofnode->full_name,
+			  cache_type_string(next));
+		cpumask_set_cpu(cpu, &next->shared_cpu_map);
+		next = next->next_local;
+	}
+}
+
+static int cache_size(const struct cache *cache, unsigned int *ret)
+{
+	const char *propname;
+	const u32 *cache_size;
+
+	propname = cache_type_info[cache->type].size_prop;
+
+	cache_size = of_get_property(cache->ofnode, propname, NULL);
+	if (!cache_size)
+		return -ENODEV;
+
+	*ret = *cache_size;
+	return 0;
+}
+
+static int cache_size_kb(const struct cache *cache, unsigned int *ret)
+{
+	unsigned int size;
+
+	if (cache_size(cache, &size))
+		return -ENODEV;
+
+	*ret = size / 1024;
+	return 0;
+}
+
+/* not cache_line_size() because that's a macro in include/linux/cache.h */
+static int cache_get_line_size(const struct cache *cache, unsigned int *ret)
+{
+	const u32 *line_size;
+	int i, lim;
+
+	lim = ARRAY_SIZE(cache_type_info[cache->type].line_size_props);
+
+	for (i = 0; i < lim; i++) {
+		const char *propname;
+
+		propname = cache_type_info[cache->type].line_size_props[i];
+		line_size = of_get_property(cache->ofnode, propname, NULL);
+		if (line_size)
+			break;
+	}
+
+	if (!line_size)
+		return -ENODEV;
+
+	*ret = *line_size;
+	return 0;
+}
+
+static int cache_nr_sets(const struct cache *cache, unsigned int *ret)
+{
+	const char *propname;
+	const u32 *nr_sets;
+
+	propname = cache_type_info[cache->type].nr_sets_prop;
+
+	nr_sets = of_get_property(cache->ofnode, propname, NULL);
+	if (!nr_sets)
+		return -ENODEV;
+
+	*ret = *nr_sets;
+	return 0;
+}
+
+static int cache_associativity(const struct cache *cache, unsigned int *ret)
+{
+	unsigned int line_size;
+	unsigned int nr_sets;
+	unsigned int size;
+
+	if (cache_nr_sets(cache, &nr_sets))
+		goto err;
+
+	/* If the cache is fully associative, there is no need to
+	 * check the other properties.
+	 */
+	if (nr_sets == 1) {
+		*ret = 0;
+		return 0;
+	}
+
+	if (cache_get_line_size(cache, &line_size))
+		goto err;
+	if (cache_size(cache, &size))
+		goto err;
+
+	if (!(nr_sets > 0 && size > 0 && line_size > 0))
+		goto err;
+
+	*ret = (size / nr_sets) / line_size;
+	return 0;
+err:
+	return -ENODEV;
+}
+
+/* helper for dealing with split caches */
+static struct cache *cache_find_first_sibling(struct cache *cache)
+{
+	struct cache *iter;
+
+	if (cache->type == CACHE_TYPE_UNIFIED)
+		return cache;
+
+	list_for_each_entry(iter, &cache_list, list)
+		if (iter->ofnode == cache->ofnode && iter->next_local == cache)
+			return iter;
+
+	return cache;
+}
+
+/* return the first cache on a local list matching node */
+static struct cache *cache_lookup_by_node(const struct device_node *node)
+{
+	struct cache *cache = NULL;
+	struct cache *iter;
+
+	list_for_each_entry(iter, &cache_list, list) {
+		if (iter->ofnode != node)
+			continue;
+		cache = cache_find_first_sibling(iter);
+		break;
+	}
+
+	return cache;
+}
+
+static bool cache_node_is_unified(const struct device_node *np)
+{
+	return of_get_property(np, "cache-unified", NULL);
+}
+
+static struct cache *__cpuinit cache_do_one_devnode_unified(struct device_node *node, int level)
+{
+	struct cache *cache;
+
+	pr_debug("creating L%d ucache for %s\n", level, node->full_name);
+
+	cache = new_cache(CACHE_TYPE_UNIFIED, level, node);
+
+	return cache;
+}
+
+static struct cache *__cpuinit cache_do_one_devnode_split(struct device_node *node, int level)
+{
+	struct cache *dcache, *icache;
+
+	pr_debug("creating L%d dcache and icache for %s\n", level,
+		 node->full_name);
+
+	dcache = new_cache(CACHE_TYPE_DATA, level, node);
+	icache = new_cache(CACHE_TYPE_INSTRUCTION, level, node);
+
+	if (!dcache || !icache)
+		goto err;
+
+	dcache->next_local = icache;
+
+	return dcache;
+err:
+	release_cache(dcache);
+	release_cache(icache);
+	return NULL;
+}
+
+static struct cache *__cpuinit cache_do_one_devnode(struct device_node *node, int level)
+{
+	struct cache *cache;
+
+	if (cache_node_is_unified(node))
+		cache = cache_do_one_devnode_unified(node, level);
+	else
+		cache = cache_do_one_devnode_split(node, level);
+
+	return cache;
+}
+
+static struct cache *__cpuinit cache_lookup_or_instantiate(struct device_node *node, int level)
+{
+	struct cache *cache;
+
+	cache = cache_lookup_by_node(node);
+
+	WARN_ONCE(cache && cache->level != level,
+		  "cache level mismatch on lookup (got %d, expected %d)\n",
+		  cache->level, level);
+
+	if (!cache)
+		cache = cache_do_one_devnode(node, level);
+
+	return cache;
+}
+
+static void __cpuinit link_cache_lists(struct cache *smaller, struct cache *bigger)
+{
+	while (smaller->next_local) {
+		if (smaller->next_local == bigger)
+			return; /* already linked */
+		smaller = smaller->next_local;
+	}
+
+	smaller->next_local = bigger;
+}
+
+static void __cpuinit do_subsidiary_caches_debugcheck(struct cache *cache)
+{
+	WARN_ON_ONCE(cache->level != 1);
+	WARN_ON_ONCE(strcmp(cache->ofnode->type, "cpu"));
+}
+
+static void __cpuinit do_subsidiary_caches(struct cache *cache)
+{
+	struct device_node *subcache_node;
+	int level = cache->level;
+
+	do_subsidiary_caches_debugcheck(cache);
+
+	while ((subcache_node = of_find_next_cache_node(cache->ofnode))) {
+		struct cache *subcache;
+
+		level++;
+		subcache = cache_lookup_or_instantiate(subcache_node, level);
+		of_node_put(subcache_node);
+		if (!subcache)
+			break;
+
+		link_cache_lists(cache, subcache);
+		cache = subcache;
+	}
+}
+
+static struct cache *__cpuinit cache_chain_instantiate(unsigned int cpu_id)
+{
+	struct device_node *cpu_node;
+	struct cache *cpu_cache = NULL;
+
+	pr_debug("creating cache object(s) for CPU %i\n", cpu_id);
+
+	cpu_node = of_get_cpu_node(cpu_id, NULL);
+	WARN_ONCE(!cpu_node, "no OF node found for CPU %i\n", cpu_id);
+	if (!cpu_node)
+		goto out;
+
+	cpu_cache = cache_lookup_or_instantiate(cpu_node, 1);
+	if (!cpu_cache)
+		goto out;
+
+	do_subsidiary_caches(cpu_cache);
+
+	cache_cpu_set(cpu_cache, cpu_id);
+out:
+	of_node_put(cpu_node);
+
+	return cpu_cache;
+}
+
+static struct cache_dir *__cpuinit cacheinfo_create_cache_dir(unsigned int cpu_id)
+{
+	struct cache_dir *cache_dir;
+	struct sys_device *sysdev;
+	struct kobject *kobj = NULL;
+
+	sysdev = get_cpu_sysdev(cpu_id);
+	WARN_ONCE(!sysdev, "no sysdev for CPU %i\n", cpu_id);
+	if (!sysdev)
+		goto err;
+
+	kobj = kobject_create_and_add("cache", &sysdev->kobj);
+	if (!kobj)
+		goto err;
+
+	cache_dir = kzalloc(sizeof(*cache_dir), GFP_KERNEL);
+	if (!cache_dir)
+		goto err;
+
+	cache_dir->kobj = kobj;
+
+	WARN_ON_ONCE(per_cpu(cache_dir, cpu_id) != NULL);
+
+	per_cpu(cache_dir, cpu_id) = cache_dir;
+
+	return cache_dir;
+err:
+	kobject_put(kobj);
+	return NULL;
+}
+
+static void cache_index_release(struct kobject *kobj)
+{
+	struct cache_index_dir *index;
+
+	index = kobj_to_cache_index_dir(kobj);
+
+	pr_debug("freeing index directory for L%d %s cache\n",
+		 index->cache->level, cache_type_string(index->cache));
+
+	kfree(index);
+}
+
+static ssize_t cache_index_show(struct kobject *k, struct attribute *attr, char *buf)
+{
+	struct kobj_attribute *kobj_attr;
+
+	kobj_attr = container_of(attr, struct kobj_attribute, attr);
+
+	return kobj_attr->show(k, kobj_attr, buf);
+}
+
+static struct cache *index_kobj_to_cache(struct kobject *k)
+{
+	struct cache_index_dir *index;
+
+	index = kobj_to_cache_index_dir(k);
+
+	return index->cache;
+}
+
+static ssize_t size_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
+{
+	unsigned int size_kb;
+	struct cache *cache;
+
+	cache = index_kobj_to_cache(k);
+
+	if (cache_size_kb(cache, &size_kb))
+		return -ENODEV;
+
+	return sprintf(buf, "%uK\n", size_kb);
+}
+
+static struct kobj_attribute cache_size_attr =
+	__ATTR(size, 0444, size_show, NULL);
+
+
+static ssize_t line_size_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
+{
+	unsigned int line_size;
+	struct cache *cache;
+
+	cache = index_kobj_to_cache(k);
+
+	if (cache_get_line_size(cache, &line_size))
+		return -ENODEV;
+
+	return sprintf(buf, "%u\n", line_size);
+}
+
+static struct kobj_attribute cache_line_size_attr =
+	__ATTR(coherency_line_size, 0444, line_size_show, NULL);
+
+static ssize_t nr_sets_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
+{
+	unsigned int nr_sets;
+	struct cache *cache;
+
+	cache = index_kobj_to_cache(k);
+
+	if (cache_nr_sets(cache, &nr_sets))
+		return -ENODEV;
+
+	return sprintf(buf, "%u\n", nr_sets);
+}
+
+static struct kobj_attribute cache_nr_sets_attr =
+	__ATTR(number_of_sets, 0444, nr_sets_show, NULL);
+
+static ssize_t associativity_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
+{
+	unsigned int associativity;
+	struct cache *cache;
+
+	cache = index_kobj_to_cache(k);
+
+	if (cache_associativity(cache, &associativity))
+		return -ENODEV;
+
+	return sprintf(buf, "%u\n", associativity);
+}
+
+static struct kobj_attribute cache_assoc_attr =
+	__ATTR(ways_of_associativity, 0444, associativity_show, NULL);
+
+static ssize_t type_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
+{
+	struct cache *cache;
+
+	cache = index_kobj_to_cache(k);
+
+	return sprintf(buf, "%s\n", cache_type_string(cache));
+}
+
+static struct kobj_attribute cache_type_attr =
+	__ATTR(type, 0444, type_show, NULL);
+
+static ssize_t level_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
+{
+	struct cache_index_dir *index;
+	struct cache *cache;
+
+	index = kobj_to_cache_index_dir(k);
+	cache = index->cache;
+
+	return sprintf(buf, "%d\n", cache->level);
+}
+
+static struct kobj_attribute cache_level_attr =
+	__ATTR(level, 0444, level_show, NULL);
+
+static ssize_t shared_cpu_map_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
+{
+	struct cache_index_dir *index;
+	struct cache *cache;
+	int len;
+	int n = 0;
+
+	index = kobj_to_cache_index_dir(k);
+	cache = index->cache;
+	len = PAGE_SIZE - 2;
+
+	if (len > 1) {
+		n = cpumask_scnprintf(buf, len, cache->shared_cpu_map);
+		buf[n++] = '\n';
+		buf[n] = '\0';
+	}
+	return n;
+}
+
+static struct kobj_attribute cache_shared_cpu_map_attr =
+	__ATTR(shared_cpu_map, 0444, shared_cpu_map_show, NULL);
+
+/* Attributes which should always be created -- the kobject/sysfs core
+ * does this automatically via kobj_type->default_attrs.  This is the
+ * minimum data required to uniquely identify a cache.
+ */
+static struct attribute *cache_index_default_attrs[] = {
+	&cache_type_attr.attr,
+	&cache_level_attr.attr,
+	&cache_shared_cpu_map_attr.attr,
+	NULL,
+};
+
+/* Attributes which should be created if the cache device node has the
+ * right properties -- see cacheinfo_create_index_opt_attrs
+ */
+static struct kobj_attribute *cache_index_opt_attrs[] = {
+	&cache_size_attr,
+	&cache_line_size_attr,
+	&cache_nr_sets_attr,
+	&cache_assoc_attr,
+};
+
+static struct sysfs_ops cache_index_ops = {
+	.show = cache_index_show,
+};
+
+static struct kobj_type cache_index_type = {
+	.release = cache_index_release,
+	.sysfs_ops = &cache_index_ops,
+	.default_attrs = cache_index_default_attrs,
+};
+
+static void __cpuinit cacheinfo_create_index_opt_attrs(struct cache_index_dir *dir)
+{
+	const char *cache_name;
+	const char *cache_type;
+	struct cache *cache;
+	char *buf;
+	int i;
+
+	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	cache = dir->cache;
+	cache_name = cache->ofnode->full_name;
+	cache_type = cache_type_string(cache);
+
+	/* We don't want to create an attribute that can't provide a
+	 * meaningful value.  Check the return value of each optional
+	 * attribute's ->show method before registering the
+	 * attribute.
+	 */
+	for (i = 0; i < ARRAY_SIZE(cache_index_opt_attrs); i++) {
+		struct kobj_attribute *attr;
+		ssize_t rc;
+
+		attr = cache_index_opt_attrs[i];
+
+		rc = attr->show(&dir->kobj, attr, buf);
+		if (rc <= 0) {
+			pr_debug("not creating %s attribute for "
+				 "%s(%s) (rc = %zd)\n",
+				 attr->attr.name, cache_name,
+				 cache_type, rc);
+			continue;
+		}
+		if (sysfs_create_file(&dir->kobj, &attr->attr))
+			pr_debug("could not create %s attribute for %s(%s)\n",
+				 attr->attr.name, cache_name, cache_type);
+	}
+
+	kfree(buf);
+}
+
+static void __cpuinit cacheinfo_create_index_dir(struct cache *cache, int index, struct cache_dir *cache_dir)
+{
+	struct cache_index_dir *index_dir;
+	int rc;
+
+	index_dir = kzalloc(sizeof(*index_dir), GFP_KERNEL);
+	if (!index_dir)
+		goto err;
+
+	index_dir->cache = cache;
+
+	rc = kobject_init_and_add(&index_dir->kobj, &cache_index_type,
+				  cache_dir->kobj, "index%d", index);
+	if (rc)
+		goto err;
+
+	index_dir->next = cache_dir->index;
+	cache_dir->index = index_dir;
+
+	cacheinfo_create_index_opt_attrs(index_dir);
+
+	return;
+err:
+	kfree(index_dir);
+}
+
+static void __cpuinit cacheinfo_sysfs_populate(unsigned int cpu_id, struct cache *cache_list)
+{
+	struct cache_dir *cache_dir;
+	struct cache *cache;
+	int index = 0;
+
+	cache_dir = cacheinfo_create_cache_dir(cpu_id);
+	if (!cache_dir)
+		return;
+
+	cache = cache_list;
+	while (cache) {
+		cacheinfo_create_index_dir(cache, index, cache_dir);
+		index++;
+		cache = cache->next_local;
+	}
+}
+
+void __cpuinit cacheinfo_cpu_online(unsigned int cpu_id)
+{
+	struct cache *cache;
+
+	cache = cache_chain_instantiate(cpu_id);
+	if (!cache)
+		return;
+
+	cacheinfo_sysfs_populate(cpu_id, cache);
+}
+
+#ifdef CONFIG_HOTPLUG_CPU /* functions needed for cpu offline */
+
+static struct cache *cache_lookup_by_cpu(unsigned int cpu_id)
+{
+	struct device_node *cpu_node;
+	struct cache *cache;
+
+	cpu_node = of_get_cpu_node(cpu_id, NULL);
+	WARN_ONCE(!cpu_node, "no OF node found for CPU %i\n", cpu_id);
+	if (!cpu_node)
+		return NULL;
+
+	cache = cache_lookup_by_node(cpu_node);
+	of_node_put(cpu_node);
+
+	return cache;
+}
+
+static void remove_index_dirs(struct cache_dir *cache_dir)
+{
+	struct cache_index_dir *index;
+
+	index = cache_dir->index;
+
+	while (index) {
+		struct cache_index_dir *next;
+
+		next = index->next;
+		kobject_put(&index->kobj);
+		index = next;
+	}
+}
+
+static void remove_cache_dir(struct cache_dir *cache_dir)
+{
+	remove_index_dirs(cache_dir);
+
+	kobject_put(cache_dir->kobj);
+
+	kfree(cache_dir);
+}
+
+static void cache_cpu_clear(struct cache *cache, int cpu)
+{
+	while (cache) {
+		struct cache *next = cache->next_local;
+
+		WARN_ONCE(!cpumask_test_cpu(cpu, &cache->shared_cpu_map),
+			  "CPU %i not accounted in %s(%s)\n",
+			  cpu, cache->ofnode->full_name,
+			  cache_type_string(cache));
+
+		cpumask_clear_cpu(cpu, &cache->shared_cpu_map);
+
+		/* Release the cache object if all the cpus using it
+		 * are offline */
+		if (cpumask_empty(&cache->shared_cpu_map))
+			release_cache(cache);
+
+		cache = next;
+	}
+}
+
+void cacheinfo_cpu_offline(unsigned int cpu_id)
+{
+	struct cache_dir *cache_dir;
+	struct cache *cache;
+
+	/* Prevent userspace from seeing inconsistent state - remove
+	 * the sysfs hierarchy first */
+	cache_dir = per_cpu(cache_dir, cpu_id);
+
+	/* careful, sysfs population may have failed */
+	if (cache_dir)
+		remove_cache_dir(cache_dir);
+
+	per_cpu(cache_dir, cpu_id) = NULL;
+
+	/* clear the CPU's bit in its cache chain, possibly freeing
+	 * cache objects */
+	cache = cache_lookup_by_cpu(cpu_id);
+	if (cache)
+		cache_cpu_clear(cache, cpu_id);
+}
+#endif /* CONFIG_HOTPLUG_CPU */
diff --git a/arch/powerpc/kernel/cacheinfo.h b/arch/powerpc/kernel/cacheinfo.h
new file mode 100644
index 0000000..a7b74d3
--- /dev/null
+++ b/arch/powerpc/kernel/cacheinfo.h
@@ -0,0 +1,8 @@
+#ifndef _PPC_CACHEINFO_H
+#define _PPC_CACHEINFO_H
+
+/* These are just hooks for sysfs.c to use. */
+extern void cacheinfo_cpu_online(unsigned int cpu_id);
+extern void cacheinfo_cpu_offline(unsigned int cpu_id);
+
+#endif /* _PPC_CACHEINFO_H */
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 0c64f10..4a2ee08 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -18,6 +18,8 @@
 #include <asm/machdep.h>
 #include <asm/smp.h>
 
+#include "cacheinfo.h"
+
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
 #include <asm/lppaca.h>
@@ -25,8 +27,6 @@
 
 static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
-static DEFINE_PER_CPU(struct kobject *, cache_toplevel);
-
 /*
  * SMT snooze delay stuff, 64-bit only for now
  */
@@ -343,283 +343,6 @@ static struct sysdev_attribute pa6t_attrs[] = {
 #endif /* HAS_PPC_PMC_PA6T */
 #endif /* HAS_PPC_PMC_CLASSIC */
 
-struct cache_desc {
-	struct kobject kobj;
-	struct cache_desc *next;
-	const char *type;	/* Instruction, Data, or Unified */
-	u32 size;		/* total cache size in KB */
-	u32 line_size;		/* in bytes */
-	u32 nr_sets;		/* number of sets */
-	u32 level;		/* e.g. 1, 2, 3... */
-	u32 associativity;	/* e.g. 8-way... 0 is fully associative */
-};
-
-DEFINE_PER_CPU(struct cache_desc *, cache_desc);
-
-static struct cache_desc *kobj_to_cache_desc(struct kobject *k)
-{
-	return container_of(k, struct cache_desc, kobj);
-}
-
-static void cache_desc_release(struct kobject *k)
-{
-	struct cache_desc *desc = kobj_to_cache_desc(k);
-
-	pr_debug("%s: releasing %s\n", __func__, kobject_name(k));
-
-	if (desc->next)
-		kobject_put(&desc->next->kobj);
-
-	kfree(kobj_to_cache_desc(k));
-}
-
-static ssize_t cache_desc_show(struct kobject *k, struct attribute *attr, char *buf)
-{
-	struct kobj_attribute *kobj_attr;
-
-	kobj_attr = container_of(attr, struct kobj_attribute, attr);
-
-	return kobj_attr->show(k, kobj_attr, buf);
-}
-
-static struct sysfs_ops cache_desc_sysfs_ops = {
-	.show = cache_desc_show,
-};
-
-static struct kobj_type cache_desc_type = {
-	.release = cache_desc_release,
-	.sysfs_ops = &cache_desc_sysfs_ops,
-};
-
-static ssize_t cache_size_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
-{
-	struct cache_desc *cache = kobj_to_cache_desc(k);
-
-	return sprintf(buf, "%uK\n", cache->size);
-}
-
-static struct kobj_attribute cache_size_attr =
-	__ATTR(size, 0444, cache_size_show, NULL);
-
-static ssize_t cache_line_size_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
-{
-	struct cache_desc *cache = kobj_to_cache_desc(k);
-
-	return sprintf(buf, "%u\n", cache->line_size);
-}
-
-static struct kobj_attribute cache_line_size_attr =
-	__ATTR(coherency_line_size, 0444, cache_line_size_show, NULL);
-
-static ssize_t cache_nr_sets_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
-{
-	struct cache_desc *cache = kobj_to_cache_desc(k);
-
-	return sprintf(buf, "%u\n", cache->nr_sets);
-}
-
-static struct kobj_attribute cache_nr_sets_attr =
-	__ATTR(number_of_sets, 0444, cache_nr_sets_show, NULL);
-
-static ssize_t cache_type_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
-{
-	struct cache_desc *cache = kobj_to_cache_desc(k);
-
-	return sprintf(buf, "%s\n", cache->type);
-}
-
-static struct kobj_attribute cache_type_attr =
-	__ATTR(type, 0444, cache_type_show, NULL);
-
-static ssize_t cache_level_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
-{
-	struct cache_desc *cache = kobj_to_cache_desc(k);
-
-	return sprintf(buf, "%u\n", cache->level);
-}
-
-static struct kobj_attribute cache_level_attr =
-	__ATTR(level, 0444, cache_level_show, NULL);
-
-static ssize_t cache_assoc_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
-{
-	struct cache_desc *cache = kobj_to_cache_desc(k);
-
-	return sprintf(buf, "%u\n", cache->associativity);
-}
-
-static struct kobj_attribute cache_assoc_attr =
-	__ATTR(ways_of_associativity, 0444, cache_assoc_show, NULL);
-
-struct cache_desc_info {
-	const char *type;
-	const char *size_prop;
-	const char *line_size_prop;
-	const char *nr_sets_prop;
-};
-
-/* PowerPC Processor binding says the [di]-cache-* must be equal on
- * unified caches, so just use d-cache properties. */
-static struct cache_desc_info ucache_info = {
-	.type = "Unified",
-	.size_prop = "d-cache-size",
-	.line_size_prop = "d-cache-line-size",
-	.nr_sets_prop = "d-cache-sets",
-};
-
-static struct cache_desc_info dcache_info = {
-	.type = "Data",
-	.size_prop = "d-cache-size",
-	.line_size_prop = "d-cache-line-size",
-	.nr_sets_prop = "d-cache-sets",
-};
-
-static struct cache_desc_info icache_info = {
-	.type = "Instruction",
-	.size_prop = "i-cache-size",
-	.line_size_prop = "i-cache-line-size",
-	.nr_sets_prop = "i-cache-sets",
-};
-
-static struct cache_desc * __cpuinit create_cache_desc(struct device_node *np, struct kobject *parent, int index, int level, struct cache_desc_info *info)
-{
-	const u32 *cache_line_size;
-	struct cache_desc *new;
-	const u32 *cache_size;
-	const u32 *nr_sets;
-	int rc;
-
-	new = kzalloc(sizeof(*new), GFP_KERNEL);
-	if (!new)
-		return NULL;
-
-	rc = kobject_init_and_add(&new->kobj, &cache_desc_type, parent,
-				  "index%d", index);
-	if (rc)
-		goto err;
-
-	/* type */
-	new->type = info->type;
-	rc = sysfs_create_file(&new->kobj, &cache_type_attr.attr);
-	WARN_ON(rc);
-
-	/* level */
-	new->level = level;
-	rc = sysfs_create_file(&new->kobj, &cache_level_attr.attr);
-	WARN_ON(rc);
-
-	/* size */
-	cache_size = of_get_property(np, info->size_prop, NULL);
-	if (cache_size) {
-		new->size = *cache_size / 1024;
-		rc = sysfs_create_file(&new->kobj,
-				       &cache_size_attr.attr);
-		WARN_ON(rc);
-	}
-
-	/* coherency_line_size */
-	cache_line_size = of_get_property(np, info->line_size_prop, NULL);
-	if (cache_line_size) {
-		new->line_size = *cache_line_size;
-		rc = sysfs_create_file(&new->kobj,
-				       &cache_line_size_attr.attr);
-		WARN_ON(rc);
-	}
-
-	/* number_of_sets */
-	nr_sets = of_get_property(np, info->nr_sets_prop, NULL);
-	if (nr_sets) {
-		new->nr_sets = *nr_sets;
-		rc = sysfs_create_file(&new->kobj,
-				       &cache_nr_sets_attr.attr);
-		WARN_ON(rc);
-	}
-
-	/* ways_of_associativity */
-	if (new->nr_sets == 1) {
-		/* fully associative */
-		new->associativity = 0;
-		goto create_assoc;
-	}
-
-	if (new->nr_sets && new->size && new->line_size) {
-		/* If we have values for all of these we can derive
-		 * the associativity. */
-		new->associativity =
-			((new->size * 1024) / new->nr_sets) / new->line_size;
-create_assoc:
-		rc = sysfs_create_file(&new->kobj,
-				       &cache_assoc_attr.attr);
-		WARN_ON(rc);
-	}
-
-	return new;
-err:
-	kfree(new);
-	return NULL;
-}
-
-static bool cache_is_unified(struct device_node *np)
-{
-	return of_get_property(np, "cache-unified", NULL);
-}
-
-static struct cache_desc * __cpuinit create_cache_index_info(struct device_node *np, struct kobject *parent, int index, int level)
-{
-	struct device_node *next_cache;
-	struct cache_desc *new, **end;
-
-	pr_debug("%s(node = %s, index = %d)\n", __func__, np->full_name, index);
-
-	if (cache_is_unified(np)) {
-		new = create_cache_desc(np, parent, index, level,
-					&ucache_info);
-	} else {
-		new = create_cache_desc(np, parent, index, level,
-					&dcache_info);
-		if (new) {
-			index++;
-			new->next = create_cache_desc(np, parent, index, level,
-						      &icache_info);
-		}
-	}
-	if (!new)
-		return NULL;
-
-	end = &new->next;
-	while (*end)
-		end = &(*end)->next;
-
-	next_cache = of_find_next_cache_node(np);
-	if (!next_cache)
-		goto out;
-
-	*end = create_cache_index_info(next_cache, parent, ++index, ++level);
-
-	of_node_put(next_cache);
-out:
-	return new;
-}
-
-static void __cpuinit create_cache_info(struct sys_device *sysdev)
-{
-	struct kobject *cache_toplevel;
-	struct device_node *np = NULL;
-	int cpu = sysdev->id;
-
-	cache_toplevel = kobject_create_and_add("cache", &sysdev->kobj);
-	if (!cache_toplevel)
-		return;
-	per_cpu(cache_toplevel, cpu) = cache_toplevel;
-	np = of_get_cpu_node(cpu, NULL);
-	if (np != NULL) {
-		per_cpu(cache_desc, cpu) =
-			create_cache_index_info(np, cache_toplevel, 0, 1);
-		of_node_put(np);
-	}
-	return;
-}
-
 static void __cpuinit register_cpu_online(unsigned int cpu)
 {
 	struct cpu *c = &per_cpu(cpu_devices, cpu);
@@ -684,25 +407,10 @@ static void __cpuinit register_cpu_online(unsigned int cpu)
 		sysdev_create_file(s, &attr_dscr);
 #endif /* CONFIG_PPC64 */
 
-	create_cache_info(s);
+	cacheinfo_cpu_online(cpu);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-static void remove_cache_info(struct sys_device *sysdev)
-{
-	struct kobject *cache_toplevel;
-	struct cache_desc *cache_desc;
-	int cpu = sysdev->id;
-
-	cache_desc = per_cpu(cache_desc, cpu);
-	if (cache_desc != NULL)
-		kobject_put(&cache_desc->kobj);
-
-	cache_toplevel = per_cpu(cache_toplevel, cpu);
-	if (cache_toplevel != NULL)
-		kobject_put(cache_toplevel);
-}
-
 static void unregister_cpu_online(unsigned int cpu)
 {
 	struct cpu *c = &per_cpu(cpu_devices, cpu);
@@ -769,7 +477,7 @@ static void unregister_cpu_online(unsigned int cpu)
 		sysdev_remove_file(s, &attr_dscr);
 #endif /* CONFIG_PPC64 */
 
-	remove_cache_info(s);
+	cacheinfo_cpu_offline(cpu);
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-- 
1.5.5
