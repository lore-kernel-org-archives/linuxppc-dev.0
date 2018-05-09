Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gzxp4NDRzF2NW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 00:58:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: mwb@linux.vnet.ibm.com
Subject: [PATCH] powerpc/pseries: Fix CONFIG_NUMA=n build
Date: Thu, 10 May 2018 00:58:18 +1000
Message-Id: <20180509145818.17254-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The build is failing with CONFIG_NUMA=n and some compiler versions:

  arch/powerpc/platforms/pseries/hotplug-cpu.o: In function `dlpar_online_cpu':
  hotplug-cpu.c:(.text+0x12c): undefined reference to `timed_topology_update'
  arch/powerpc/platforms/pseries/hotplug-cpu.o: In function `dlpar_cpu_remove':
  hotplug-cpu.c:(.text+0x400): undefined reference to `timed_topology_update'

Fix it by moving the empty version of timed_topology_update() into the
existing #ifdef block, which has the right guard of SPLPAR && NUMA.

Fixes: cee5405da402 ("powerpc/hotplug: Improve responsiveness of hotplug change")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/topology.h | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 9f421641a35c..16b077801a5f 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -91,6 +91,7 @@ extern int start_topology_update(void);
 extern int stop_topology_update(void);
 extern int prrn_is_enabled(void);
 extern int find_and_online_cpu_nid(int cpu);
+extern int timed_topology_update(int nsecs);
 #else
 static inline int start_topology_update(void)
 {
@@ -108,16 +109,12 @@ static inline int find_and_online_cpu_nid(int cpu)
 {
 	return 0;
 }
+static inline int timed_topology_update(int nsecs)
+{
+	return 0;
+}
 #endif /* CONFIG_NUMA && CONFIG_PPC_SPLPAR */
 
-#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_NEED_MULTIPLE_NODES)
-#if defined(CONFIG_PPC_SPLPAR)
-extern int timed_topology_update(int nsecs);
-#else
-#define	timed_topology_update(nsecs)
-#endif /* CONFIG_PPC_SPLPAR */
-#endif /* CONFIG_HOTPLUG_CPU || CONFIG_NEED_MULTIPLE_NODES */
-
 #include <asm-generic/topology.h>
 
 #ifdef CONFIG_SMP
-- 
2.14.1
