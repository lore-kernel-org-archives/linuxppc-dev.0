Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdNsz4tWvzF0fG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 05:30:47 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w19IUc8u007543
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Feb 2018 13:30:44 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g1fae3v0j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Feb 2018 13:30:40 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 9 Feb 2018 13:30:33 -0500
Subject: [PATCH] pseries: Fix build break for SPLPAR=n and CPU hotplug
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, mwb@linux.vnet.ibm.com
Date: Fri, 09 Feb 2018 12:13:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <151820002192.57762.14326361815004034389.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Build break fix for SPLPAR=n builds and CPU hotplug.

arch/powerpc/platforms/pseries/hotplug-cpu.o: In function `.dlpar_online_cpu':
hotplug-cpu.c:(.text+0xc40): undefined reference to `.find_and_online_cpu_nid'

Move the declaration of find_and_online_cpu_nid() to topology.h where
we can define it as a no-op for SPLAPR=n builds.

Fixes: e67e02a ("powerpc/pseries: Fix cpu hotplug crash with memoryless nodes")
Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/topology.h          |    9 +++++++++
 arch/powerpc/platforms/pseries/hotplug-cpu.c |    3 +--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 88187c285c70..4c5704a14f0d 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -105,6 +105,15 @@ extern int timed_topology_update(int nsecs);
 #endif /* CONFIG_PPC_SPLPAR */
 #endif /* CONFIG_HOTPLUG_CPU || CONFIG_NEED_MULTIPLE_NODES */
 
+#if defined(CONFIG_PPC_SPLPAR)
+int find_and_online_cpu_nid(int cpu);
+#else
+static inline int find_and_online_cpu_nid(int cpu)
+{
+	return 0;
+}
+#endif
+
 #include <asm-generic/topology.h>
 
 #ifdef CONFIG_SMP
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index dceb51454d8d..ca6e363c2d75 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -36,6 +36,7 @@
 #include <asm/xics.h>
 #include <asm/xive.h>
 #include <asm/plpar_wrappers.h>
+#include <asm/topology.h>
 
 #include "pseries.h"
 #include "offline_states.h"
@@ -340,8 +341,6 @@ static void pseries_remove_processor(struct device_node *np)
 	cpu_maps_update_done();
 }
 
-extern int find_and_online_cpu_nid(int cpu);
-
 static int dlpar_online_cpu(struct device_node *dn)
 {
 	int rc = 0;
