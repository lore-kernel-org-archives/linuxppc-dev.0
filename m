Return-Path: <nfont@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BC0E3B6EF5
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 12:50:06 +1100 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAP1ftZp020366
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2009 20:41:55 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAP1o2ED876624
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2009 20:50:02 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAP1o1Ti002489
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2009 20:50:02 -0500
Message-ID: <4B0C8D46.1030206@austin.ibm.com>
Date: Tue, 24 Nov 2009 19:49:58 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] sysfs cpu probe/release files
References: <4B0C8B45.6080804@austin.ibm.com>
In-Reply-To: <4B0C8B45.6080804@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Create new probe and release sysfs files to facilitate adding and removing
cpus from the system.  This also creates the powerpc specific stubs to handle
the arch callouts from writes to the sysfs files.

The creation and use of these files is regulated by the 
CONFIG_ARCH_CPU_PROBE_RELEASE option so that only architectures that need the
capability will have the files created.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---
 arch/powerpc/Kconfig               |    4 ++++
 arch/powerpc/include/asm/machdep.h |    5 +++++
 arch/powerpc/kernel/sysfs.c        |   19 +++++++++++++++++++
 drivers/base/cpu.c                 |   32 ++++++++++++++++++++++++++++++++
 include/linux/cpu.h                |    4 ++++
 5 files changed, 64 insertions(+)

Index: powerpc/drivers/base/cpu.c
===================================================================
--- powerpc.orig/drivers/base/cpu.c	2009-11-23 18:19:23.000000000 -0600
+++ powerpc/drivers/base/cpu.c	2009-11-24 14:30:07.000000000 -0600
@@ -72,6 +72,38 @@
 	per_cpu(cpu_sys_devices, logical_cpu) = NULL;
 	return;
 }
+
+#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
+static ssize_t cpu_probe_store(struct class *class, const char *buf,
+			       size_t count)
+{
+	return arch_cpu_probe(buf, count);
+}
+
+static ssize_t cpu_release_store(struct class *class, const char *buf,
+				 size_t count)
+{
+	return arch_cpu_release(buf, count);
+}
+
+static CLASS_ATTR(probe, S_IWUSR, NULL, cpu_probe_store);
+static CLASS_ATTR(release, S_IWUSR, NULL, cpu_release_store);
+
+int __init cpu_probe_release_init(void)
+{
+	int rc;
+
+	rc = sysfs_create_file(&cpu_sysdev_class.kset.kobj,
+			       &class_attr_probe.attr);
+	if (!rc)
+		rc = sysfs_create_file(&cpu_sysdev_class.kset.kobj,
+				       &class_attr_release.attr);
+
+	return rc;
+}
+device_initcall(cpu_probe_release_init);
+#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
+
 #else /* ... !CONFIG_HOTPLUG_CPU */
 static inline void register_cpu_control(struct cpu *cpu)
 {
Index: powerpc/arch/powerpc/include/asm/machdep.h
===================================================================
--- powerpc.orig/arch/powerpc/include/asm/machdep.h	2009-11-23 18:19:23.000000000 -0600
+++ powerpc/arch/powerpc/include/asm/machdep.h	2009-11-24 14:30:07.000000000 -0600
@@ -266,6 +266,11 @@
 	void (*suspend_disable_irqs)(void);
 	void (*suspend_enable_irqs)(void);
 #endif
+
+#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
+	ssize_t (*cpu_probe)(const char *, size_t);
+	ssize_t (*cpu_release)(const char *, size_t);
+#endif
 };
 
 extern void e500_idle(void);
Index: powerpc/arch/powerpc/kernel/sysfs.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/sysfs.c	2009-11-23 18:19:23.000000000 -0600
+++ powerpc/arch/powerpc/kernel/sysfs.c	2009-11-24 14:43:40.000000000 -0600
@@ -461,6 +461,25 @@
 
 	cacheinfo_cpu_offline(cpu);
 }
+
+#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
+ssize_t arch_cpu_probe(const char *buf, size_t count)
+{
+	if (ppc_md.cpu_probe)
+		return ppc_md.cpu_probe(buf, count);
+
+	return -EINVAL;
+}
+
+ssize_t arch_cpu_release(const char *buf, size_t count)
+{
+	if (ppc_md.cpu_release)
+		return ppc_md.cpu_release(buf, count);
+
+	return -EINVAL;
+}
+#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
+
 #endif /* CONFIG_HOTPLUG_CPU */
 
 static int __cpuinit sysfs_cpu_notify(struct notifier_block *self,
Index: powerpc/arch/powerpc/Kconfig
===================================================================
--- powerpc.orig/arch/powerpc/Kconfig	2009-11-23 18:19:23.000000000 -0600
+++ powerpc/arch/powerpc/Kconfig	2009-11-24 14:30:07.000000000 -0600
@@ -320,6 +320,10 @@
 
 	  Say N if you are unsure.
 
+config ARCH_CPU_PROBE_RELEASE
+	def_bool y
+	depends on HOTPLUG_CPU
+
 config ARCH_ENABLE_MEMORY_HOTPLUG
 	def_bool y
 
Index: powerpc/include/linux/cpu.h
===================================================================
--- powerpc.orig/include/linux/cpu.h	2009-11-23 18:19:23.000000000 -0600
+++ powerpc/include/linux/cpu.h	2009-11-24 14:30:07.000000000 -0600
@@ -43,6 +43,10 @@
 
 #ifdef CONFIG_HOTPLUG_CPU
 extern void unregister_cpu(struct cpu *cpu);
+#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
+extern ssize_t arch_cpu_probe(const char *, size_t);
+extern ssize_t arch_cpu_release(const char *, size_t);
+#endif
 #endif
 struct notifier_block;
 
