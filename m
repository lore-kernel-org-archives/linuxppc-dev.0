Return-Path: <jlarrew@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1FBD8B70FE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Dec 2010 09:31:46 +1100 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oB1MK3ss025636
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Dec 2010 15:20:03 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oB1MVUKE181186
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Dec 2010 15:31:30 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oB1MVRJe006910
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Dec 2010 15:31:30 -0700
Date: Wed, 1 Dec 2010 15:31:26 -0700
From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Message-Id: <20101201223126.15119.58152.sendpatchset@manic8ball.ltc.austin.ibm.com>
In-Reply-To: <20101201223052.15119.61473.sendpatchset@manic8ball.ltc.austin.ibm.com>
References: <20101201223052.15119.61473.sendpatchset@manic8ball.ltc.austin.ibm.com>
Subject: [PATCH V3 3/3] powerpc: Disable VPHN polling during a suspend
	operation
Cc: markn@au1.ibm.com, pmac@au1.ibm.com, tbreeds@au1.ibm.com,
	lkessler@us.ibm.com, Jesse Larrew <jlarrew@linux.vnet.ibm.com>,
	mjwolf@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>

Tie the polling mechanism into the ibm,suspend-me rtas call to
stop/restart polling before/after a suspend, hibernate, migrate,
or checkpoint restart operation. This ensures that the system has a
chance to disable the polling if the partition is migrated to a system
that does not support VPHN (and vice versa).

Signed-off-by: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/topology.h |   10 ++++++++++
 arch/powerpc/kernel/rtas.c          |    3 +++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index afe4aaa..aed188b 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -93,6 +93,8 @@ extern void __init dump_numa_cpu_topology(void);
 extern int sysfs_add_device_to_node(struct sys_device *dev, int nid);
 extern void sysfs_remove_device_from_node(struct sys_device *dev, int nid);
 
+extern int start_topology_update(void);
+extern int stop_topology_update(void);
 #else
 
 static inline void dump_numa_cpu_topology(void) {}
@@ -107,6 +109,14 @@ static inline void sysfs_remove_device_from_node(struct sys_device *dev,
 {
 }
 
+static inline int start_topology_update(void)
+{
+	return 0;
+}
+static inline int stop_topology_update(void)
+{
+	return 0;
+}
 #endif /* CONFIG_NUMA */
 
 #include <asm-generic/topology.h>
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 8fe8bc6..2097f2b 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -41,6 +41,7 @@
 #include <asm/atomic.h>
 #include <asm/time.h>
 #include <asm/mmu.h>
+#include <asm/topology.h>
 
 struct rtas_t rtas = {
 	.lock = __ARCH_SPIN_LOCK_UNLOCKED
@@ -713,6 +714,7 @@ static int __rtas_suspend_last_cpu(struct rtas_suspend_me_data *data, int wake_w
 	int cpu;
 
 	slb_set_size(SLB_MIN_SIZE);
+	stop_topology_update();
 	printk(KERN_DEBUG "calling ibm,suspend-me on cpu %i\n", smp_processor_id());
 
 	while (rc == H_MULTI_THREADS_ACTIVE && !atomic_read(&data->done) &&
@@ -728,6 +730,7 @@ static int __rtas_suspend_last_cpu(struct rtas_suspend_me_data *data, int wake_w
 		rc = atomic_read(&data->error);
 
 	atomic_set(&data->error, rc);
+	start_topology_update();
 
 	if (wake_when_done) {
 		atomic_set(&data->done, 1);
-- 
1.7.2.3
