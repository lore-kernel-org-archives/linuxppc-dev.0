Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKWCc4T3czDvvN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 06:19:40 +1100 (AEDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: rt@linuxtronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 16/20] powerpc/sysfs: Convert to hotplug state machine
Date: Thu, 17 Nov 2016 19:35:37 +0100
Message-Id: <20161117183541.8588-17-bigeasy@linutronix.de>
In-Reply-To: <20161117183541.8588-1-bigeasy@linutronix.de>
References: <20161117183541.8588-1-bigeasy@linutronix.de>
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Install the callbacks via the state machine and let the core invoke
the callbacks on the already online CPUs.

The previous convention of keeping the files around until the CPU is dead
has not been preserved as there is no point to keep them available when the
cpu is going down. This makes the hotplug call symmetric.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/kernel/sysfs.c | 50 +++++++++--------------------------------=
----
 1 file changed, 10 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index c4f1d1f7bae0..c1fb255a60d6 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -703,7 +703,7 @@ static struct device_attribute pa6t_attrs[] =3D {
 #endif /* HAS_PPC_PMC_PA6T */
 #endif /* HAS_PPC_PMC_CLASSIC */
=20
-static void register_cpu_online(unsigned int cpu)
+static int register_cpu_online(unsigned int cpu)
 {
 	struct cpu *c =3D &per_cpu(cpu_devices, cpu);
 	struct device *s =3D &c->dev;
@@ -782,11 +782,12 @@ static void register_cpu_online(unsigned int cpu)
 	}
 #endif
 	cacheinfo_cpu_online(cpu);
+	return 0;
 }
=20
-#ifdef CONFIG_HOTPLUG_CPU
-static void unregister_cpu_online(unsigned int cpu)
+static int unregister_cpu_online(unsigned int cpu)
 {
+#ifdef CONFIG_HOTPLUG_CPU
 	struct cpu *c =3D &per_cpu(cpu_devices, cpu);
 	struct device *s =3D &c->dev;
 	struct device_attribute *attrs, *pmc_attrs;
@@ -863,6 +864,8 @@ static void unregister_cpu_online(unsigned int cpu)
 	}
 #endif
 	cacheinfo_cpu_offline(cpu);
+#endif /* CONFIG_HOTPLUG_CPU */
+	return 0;
 }
=20
 #ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
@@ -883,32 +886,6 @@ ssize_t arch_cpu_release(const char *buf, size_t count)
 }
 #endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
=20
-#endif /* CONFIG_HOTPLUG_CPU */
-
-static int sysfs_cpu_notify(struct notifier_block *self,
-				      unsigned long action, void *hcpu)
-{
-	unsigned int cpu =3D (unsigned int)(long)hcpu;
-
-	switch (action) {
-	case CPU_ONLINE:
-	case CPU_ONLINE_FROZEN:
-		register_cpu_online(cpu);
-		break;
-#ifdef CONFIG_HOTPLUG_CPU
-	case CPU_DEAD:
-	case CPU_DEAD_FROZEN:
-		unregister_cpu_online(cpu);
-		break;
-#endif
-	}
-	return NOTIFY_OK;
-}
-
-static struct notifier_block sysfs_cpu_nb =3D {
-	.notifier_call	=3D sysfs_cpu_notify,
-};
-
 static DEFINE_MUTEX(cpu_mutex);
=20
 int cpu_add_dev_attr(struct device_attribute *attr)
@@ -1023,12 +1000,10 @@ static DEVICE_ATTR(physical_id, 0444, show_physical=
_id, NULL);
=20
 static int __init topology_init(void)
 {
-	int cpu;
+	int cpu, r;
=20
 	register_nodes();
=20
-	cpu_notifier_register_begin();
-
 	for_each_possible_cpu(cpu) {
 		struct cpu *c =3D &per_cpu(cpu_devices, cpu);
=20
@@ -1047,15 +1022,10 @@ static int __init topology_init(void)
=20
 			device_create_file(&c->dev, &dev_attr_physical_id);
 		}
-
-		if (cpu_online(cpu))
-			register_cpu_online(cpu);
 	}
-
-	__register_cpu_notifier(&sysfs_cpu_nb);
-
-	cpu_notifier_register_done();
-
+	r =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "powerpc/topology:online",
+			      register_cpu_online, unregister_cpu_online);
+	WARN_ON(r < 0);
 #ifdef CONFIG_PPC64
 	sysfs_create_dscr_default();
 #endif /* CONFIG_PPC64 */
--=20
2.10.2
