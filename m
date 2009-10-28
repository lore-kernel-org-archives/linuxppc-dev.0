Return-Path: <nfont@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 13929100829
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Oct 2009 08:45:36 +1100 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9SL1JNn018671
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Oct 2009 17:01:19 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9SKu2dA1405110
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Oct 2009 16:56:02 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n9SAuSDj009431
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Oct 2009 06:56:28 -0400
Message-ID: <4AE8AFDD.6030504@austin.ibm.com>
Date: Wed, 28 Oct 2009 15:55:57 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6 v5] Memory probe/release files
References: <4AE8ADCF.6090104@austin.ibm.com>
In-Reply-To: <4AE8ADCF.6090104@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch creates the release sysfs file for memory and updates the
exisiting probe file so both make arch-specific callouts to handle removing
and adding memory to the system.  This also creates the powerpc specific stubs
for handling the arch callouts.

The creation and use of these files are governed by the exisitng
CONFIG_ARCH_MEMORY_PROBE and new CONFIG_ARCH_MEMORY_RELEASE config options.

Signed-off-by: Nathan Fontenot <nfont at austin.ibm.com>
---

Index: powerpc/arch/powerpc/mm/mem.c
===================================================================
--- powerpc.orig/arch/powerpc/mm/mem.c	2009-10-28 15:20:36.000000000 -0500
+++ powerpc/arch/powerpc/mm/mem.c	2009-10-28 15:21:47.000000000 -0500
@@ -110,6 +110,26 @@
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 
+#ifdef CONFIG_ARCH_MEMORY_RELEASE
+int arch_memory_release(const char *buf, size_t count)
+{
+	if (ppc_md.memory_release)
+		return ppc_md.memory_release(buf, count);
+
+	return -EINVAL;
+}
+#endif
+
+#ifdef CONFIG_ARCH_MEMORY_PROBE
+int arch_memory_probe(u64 phys_addr)
+{
+	if (ppc_md.memory_probe)
+		return ppc_md.memory_probe(phys_addr);
+
+	return -EINVAL;
+}
+#endif
+
 #ifdef CONFIG_NUMA
 int memory_add_physaddr_to_nid(u64 start)
 {
Index: powerpc/drivers/base/memory.c
===================================================================
--- powerpc.orig/drivers/base/memory.c	2009-10-28 15:20:36.000000000 -0500
+++ powerpc/drivers/base/memory.c	2009-10-28 15:21:47.000000000 -0500
@@ -319,6 +319,10 @@
 
 	phys_addr = simple_strtoull(buf, NULL, 0);
 
+	ret = arch_memory_probe(phys_addr);
+	if (ret)
+		return ret;
+
 	nid = memory_add_physaddr_to_nid(phys_addr);
 	ret = add_memory(nid, phys_addr, PAGES_PER_SECTION << PAGE_SHIFT);
 
@@ -328,19 +332,35 @@
 	return count;
 }
 static CLASS_ATTR(probe, S_IWUSR, NULL, memory_probe_store);
+#endif
 
-static int memory_probe_init(void)
+#ifdef CONFIG_ARCH_MEMORY_RELEASE
+static ssize_t
+memory_release_store(struct class *class, const char *buf, size_t count)
 {
-	return sysfs_create_file(&memory_sysdev_class.kset.kobj,
-				&class_attr_probe.attr);
+	return arch_memory_release(buf, count);
 }
-#else
-static inline int memory_probe_init(void)
+static CLASS_ATTR(release, S_IWUSR, NULL, memory_release_store);
+#endif
+
+static int memory_probe_release_init(void)
 {
-	return 0;
-}
+	int rc = 0;
+
+#ifdef CONFIG_ARCH_MEMORY_PROBE
+	rc = sysfs_create_file(&memory_sysdev_class.kset.kobj,
+			       &class_attr_probe.attr);
+#endif
+
+#ifdef CONFIG_ARCH_MEMORY_RELEASE
+	if (!rc)
+		rc = sysfs_create_file(&memory_sysdev_class.kset.kobj,
+				       &class_attr_release.attr);
 #endif
 
+	return rc;
+}
+
 /*
  * Note that phys_device is optional.  It is here to allow for
  * differentiation between which *physical* devices each
@@ -470,7 +490,7 @@
 			ret = err;
 	}
 
-	err = memory_probe_init();
+	err = memory_probe_release_init();
 	if (!ret)
 		ret = err;
 	err = block_size_init();
Index: powerpc/arch/powerpc/include/asm/machdep.h
===================================================================
--- powerpc.orig/arch/powerpc/include/asm/machdep.h	2009-10-28 15:20:36.000000000 -0500
+++ powerpc/arch/powerpc/include/asm/machdep.h	2009-10-28 15:21:47.000000000 -0500
@@ -266,6 +266,14 @@
 	void (*suspend_disable_irqs)(void);
 	void (*suspend_enable_irqs)(void);
 #endif
+
+#ifdef CONFIG_ARCH_MEMORY_RELEASE
+	int (*memory_release)(const char *, size_t);
+#endif
+#ifdef CONFIG_ARCH_MEMORY_PROBE
+	int (*memory_probe)(u64);
+#endif
+
 };
 
 extern void e500_idle(void);
Index: powerpc/arch/powerpc/Kconfig
===================================================================
--- powerpc.orig/arch/powerpc/Kconfig	2009-10-28 15:20:36.000000000 -0500
+++ powerpc/arch/powerpc/Kconfig	2009-10-28 15:21:47.000000000 -0500
@@ -414,6 +414,10 @@
 	def_bool y
 	depends on MEMORY_HOTPLUG
 
+config ARCH_MEMORY_RELEASE
+	def_bool y
+	depends on MEMORY_HOTPLUG
+
 # Some NUMA nodes have memory ranges that span
 # other nodes.  Even though a pfn is valid and
 # between a node's start and end pfns, it may not
Index: powerpc/include/linux/memory_hotplug.h
===================================================================
--- powerpc.orig/include/linux/memory_hotplug.h	2009-10-28 15:20:36.000000000 -0500
+++ powerpc/include/linux/memory_hotplug.h	2009-10-28 15:21:47.000000000 -0500
@@ -86,6 +86,14 @@
 }
 #endif
 
+#ifdef CONFIG_ARCH_MEMORY_RELEASE
+extern int arch_memory_release(const char *, size_t);
+#endif
+
+#ifdef CONFIG_ARCH_MEMORY_PROBE
+extern int arch_memory_probe(u64);
+#endif
+
 #ifdef CONFIG_HAVE_ARCH_NODEDATA_EXTENSION
 /*
  * For supporting node-hotadd, we have to allocate a new pgdat.
