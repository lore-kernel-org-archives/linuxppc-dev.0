Return-Path: <nfont@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2E2721007E0
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 18:12:35 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAP70Ps2028214
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 00:00:25 -0700
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAP7CPfT159794
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 00:12:25 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nAP7E8b7032453
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 00:14:08 -0700
Message-ID: <4B0CD8D5.8050803@austin.ibm.com>
Date: Wed, 25 Nov 2009 01:12:21 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] sysfs cpu probe/release files
References: <4B0CD70F.6090600@austin.ibm.com>
In-Reply-To: <4B0CD70F.6090600@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: gregkh@suse.de, paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to support kernel DLPAR of CPU resources we need to provide an
interface to add (probe) and remove (release) the resource from the system.
This patch Creates new generic probe and release sysfs files to facilitate
cpu probe/release.  The probe/release interface provides for allowing each
arch to supply their own routines for implementing the backend of adding
and removing cpus to/from the system.

This also creates the powerpc specific stubs to handle the arch callouts 
from writes to the sysfs files.

The creation and use of these files is regulated by the 
CONFIG_ARCH_CPU_PROBE_RELEASE option so that only architectures that need the
capability will have the files created.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---

 arch/powerpc/Kconfig               |    4 ++++
 arch/powerpc/include/asm/machdep.h |    5 +++++
 arch/powerpc/kernel/sysfs.c        |   19 +++++++++++++++++++
 drivers/base/cpu.c                 |   32 ++++++++++++++++++++++++++++++++
 include/linux/cpu.h                |    2 ++
 5 files changed, 62 insertions(+)

Index: powerpc/drivers/base/cpu.c
===================================================================
--- powerpc.orig/drivers/base/cpu.c	2009-11-25 04:06:10.000000000 -0600
+++ powerpc/drivers/base/cpu.c	2009-11-25 04:11:01.000000000 -0600
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
--- powerpc.orig/arch/powerpc/include/asm/machdep.h	2009-11-25 04:06:10.000000000 -0600
+++ powerpc/arch/powerpc/include/asm/machdep.h	2009-11-25 04:11:01.000000000 -0600
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
--- powerpc.orig/arch/powerpc/kernel/sysfs.c	2009-11-25 04:06:10.000000000 -0600
+++ powerpc/arch/powerpc/kernel/sysfs.c	2009-11-25 04:11:01.000000000 -0600
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
--- powerpc.orig/arch/powerpc/Kconfig	2009-11-25 04:06:10.000000000 -0600
+++ powerpc/arch/powerpc/Kconfig	2009-11-25 04:11:01.000000000 -0600
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
--- powerpc.orig/include/linux/cpu.h	2009-11-25 04:06:10.000000000 -0600
+++ powerpc/include/linux/cpu.h	2009-11-25 04:11:56.000000000 -0600
@@ -43,6 +43,8 @@
 
 #ifdef CONFIG_HOTPLUG_CPU
 extern void unregister_cpu(struct cpu *cpu);
+extern ssize_t arch_cpu_probe(const char *, size_t);
+extern ssize_t arch_cpu_release(const char *, size_t);
 #endif
 struct notifier_block;
 
