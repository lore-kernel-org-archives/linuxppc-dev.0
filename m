Return-Path: <groeck7@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgL7Y3rXLzDqZs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 09:34:14 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id e11so2533098pgq.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 14:34:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: [PATCH 2/2] powerpc/pseries: Declare optional dummy function for
 find_and_online_cpu_nid
Date: Mon, 12 Feb 2018 14:34:08 -0800
Message-Id: <1518474848-3158-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1518474848-3158-1-git-send-email-linux@roeck-us.net>
References: <1518474848-3158-1-git-send-email-linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit e67e02a544e9 ("powerpc/pseries: Fix cpu hotplug crash with
memoryless nodes") adds an unconditional call to find_and_online_cpu_nid(),
which is only declared if CONFIG_PPC_SPLPAR is enabled. This results in
the following build error if this is not the case.

arch/powerpc/platforms/pseries/hotplug-cpu.o: In function `dlpar_online_cpu':
arch/powerpc/platforms/pseries/hotplug-cpu.c:369:
			undefined reference to `.find_and_online_cpu_nid'

Follow the guideline provided by similar functions and provide a dummy
function if CONFIG_PPC_SPLPAR is not enabled. This also moves the external
function declaration into an include file where it should be.

Fixes: e67e02a544e9 ("powerpc/pseries: Fix cpu hotplug crash with ...")
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/powerpc/include/asm/topology.h          | 5 +++++
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 2 --
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 88187c285c70..52815982436f 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -82,6 +82,7 @@ static inline int numa_update_cpu_topology(bool cpus_locked)
 extern int start_topology_update(void);
 extern int stop_topology_update(void);
 extern int prrn_is_enabled(void);
+extern int find_and_online_cpu_nid(int cpu);
 #else
 static inline int start_topology_update(void)
 {
@@ -95,6 +96,10 @@ static inline int prrn_is_enabled(void)
 {
 	return 0;
 }
+static inline int find_and_online_cpu_nid(int cpu)
+{
+	return 0;
+}
 #endif /* CONFIG_NUMA && CONFIG_PPC_SPLPAR */
 
 #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_NEED_MULTIPLE_NODES)
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index dceb51454d8d..f5c6a8cd2926 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -340,8 +340,6 @@ static void pseries_remove_processor(struct device_node *np)
 	cpu_maps_update_done();
 }
 
-extern int find_and_online_cpu_nid(int cpu);
-
 static int dlpar_online_cpu(struct device_node *dn)
 {
 	int rc = 0;
-- 
2.7.4
