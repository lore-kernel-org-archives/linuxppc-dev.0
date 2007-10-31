Return-Path: <pbadari@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 247A2DDEE6
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 02:45:48 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9VFjhEe012458
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 11:45:43 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9VFjSWt086264
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 09:45:36 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9VFjRmv025734
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 09:45:27 -0600
Subject: [PATCH 3/3] Add arch-specific walk_memory_remove() for ppc64
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain
Date: Wed, 31 Oct 2007 08:48:55 -0800
Message-Id: <1193849335.17412.33.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, anton@au1.ibm.com,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	linux-mm <linux-mm@kvack.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

walk_memory_resource() verifies if there are holes in a given
memory range, by checking against /proc/iomem. On x86/ia64
system memory is represented in /proc/iomem. On PPC64, we
don't show system memory as IO resource in /proc/iomem - instead
its maintained in /proc/device-tree. 

This patch provides a way for an architecture to provide its
own walk_memory_resource() function. On PPC64, the memory
region is small (16MB), contiguous and non-overlapping.
So extra checking, against device-tree is not needed.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
Acked-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
---
 arch/powerpc/Kconfig  |    3 +++
 arch/powerpc/mm/mem.c |   16 ++++++++++++++++
 kernel/resource.c     |    2 +-
 3 files changed, 20 insertions(+), 1 deletion(-)

Index: linux-2.6.24-rc1/arch/powerpc/mm/mem.c
===================================================================
--- linux-2.6.24-rc1.orig/arch/powerpc/mm/mem.c	2007-10-30 07:39:16.000000000 -0800
+++ linux-2.6.24-rc1/arch/powerpc/mm/mem.c	2007-10-31 07:17:52.000000000 -0800
@@ -129,6 +129,22 @@ int __devinit arch_add_memory(int nid, u
 	return __add_pages(zone, start_pfn, nr_pages);
 }
 
+/*
+ * walk_memory_resource() needs to make sure there is no holes in a given
+ * memory range. On PPC64, since this range comes from /sysfs, the range
+ * is guaranteed to be valid, non-overlapping and can not contain any
+ * holes. By the time we get here (memory add or remove), /proc/device-tree
+ * is updated and correct. Only reason we need to check against device-tree
+ * would be if we allow user-land to specify a memory range through a
+ * system call/ioctl etc.. (instead of doing offline/online through /sysfs.
+ */
+int
+walk_memory_resource(unsigned long start_pfn, unsigned long nr_pages, void *arg,
+			int (*func)(unsigned long, unsigned long, void *))
+{
+	return  (*func)(start_pfn, nr_pages, arg);
+}
+
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
Index: linux-2.6.24-rc1/kernel/resource.c
===================================================================
--- linux-2.6.24-rc1.orig/kernel/resource.c	2007-10-23 20:50:57.000000000 -0700
+++ linux-2.6.24-rc1/kernel/resource.c	2007-10-30 08:58:41.000000000 -0800
@@ -228,7 +228,7 @@ int release_resource(struct resource *ol
 
 EXPORT_SYMBOL(release_resource);
 
-#ifdef CONFIG_MEMORY_HOTPLUG
+#if defined(CONFIG_MEMORY_HOTPLUG) && !defined(CONFIG_ARCH_HAS_WALK_MEMORY)
 /*
  * Finds the lowest memory reosurce exists within [res->start.res->end)
  * the caller must specify res->start, res->end, res->flags.
Index: linux-2.6.24-rc1/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.24-rc1.orig/arch/powerpc/Kconfig	2007-10-30 07:39:17.000000000 -0800
+++ linux-2.6.24-rc1/arch/powerpc/Kconfig	2007-10-30 08:54:57.000000000 -0800
@@ -234,6 +234,9 @@ config HOTPLUG_CPU
 config ARCH_ENABLE_MEMORY_HOTPLUG
 	def_bool y
 
+config ARCH_HAS_WALK_MEMORY
+	def_bool y
+
 config ARCH_ENABLE_MEMORY_HOTREMOVE
 	def_bool y
 
