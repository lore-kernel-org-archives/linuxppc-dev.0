Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBNMB0ZdwzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 20:47:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/sysfs: Move #ifdef CONFIG_HOTPLUG_CPU out of the
 function body
Date: Mon, 24 Apr 2017 20:46:59 +1000
Message-Id: <1493030819-3534-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The entire body of unregister_cpu_online() is inside an #ifdef
CONFIG_HOTPLUG_CPU block. This is ugly and means we create an empty function
when hotplug is disabled for no reason.

Instead move the #ifdef out of the function body and define the function to be
NULL in the else case. This means we'll pass NULL to cpuhp_setup_state(), but
that's fine because it accepts NULL to mean there is no teardown callback, which
is exactly what we want.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 949957b97ead..4437c70c7c2b 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -789,9 +789,9 @@ static int register_cpu_online(unsigned int cpu)
 	return 0;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
 static int unregister_cpu_online(unsigned int cpu)
 {
-#ifdef CONFIG_HOTPLUG_CPU
 	struct cpu *c = &per_cpu(cpu_devices, cpu);
 	struct device *s = &c->dev;
 	struct device_attribute *attrs, *pmc_attrs;
@@ -870,9 +870,11 @@ static int unregister_cpu_online(unsigned int cpu)
 	cacheinfo_cpu_offline(cpu);
 	of_node_put(s->of_node);
 	s->of_node = NULL;
-#endif /* CONFIG_HOTPLUG_CPU */
 	return 0;
 }
+#else /* !CONFIG_HOTPLUG_CPU */
+#define unregister_cpu_online NULL
+#endif
 
 #ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
 ssize_t arch_cpu_probe(const char *buf, size_t count)
-- 
2.7.4
