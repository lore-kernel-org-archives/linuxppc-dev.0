Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 632861A0044
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Sep 2014 08:41:53 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Wed, 10 Sep 2014 18:41:50 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id EFBFE38C803B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 18:41:46 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8AMfkaK3735852
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 22:41:46 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8AMfk7k032181
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 18:41:46 -0400
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] pseries: Fix endian issues in cpu hot-removal
Date: Wed, 10 Sep 2014 17:41:44 -0500
Message-Id: <1410388904-20061-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Cc: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When removing a cpu, this patch makes sure that values
gotten from or passed to firmware are in the correct
endian format.

Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c       | 14 +++++++-------
 arch/powerpc/platforms/pseries/hotplug-cpu.c |  8 ++++----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index cd425dc..c5ecfdb 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -442,7 +442,7 @@ static int dlpar_offline_cpu(struct device_node *dn)
 	int rc = 0;
 	unsigned int cpu;
 	int len, nthreads, i;
-	const u32 *intserv;
+	const __be32 *intserv;
 
 	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
 	if (!intserv)
@@ -453,7 +453,7 @@ static int dlpar_offline_cpu(struct device_node *dn)
 	cpu_maps_update_begin();
 	for (i = 0; i < nthreads; i++) {
 		for_each_present_cpu(cpu) {
-			if (get_hard_smp_processor_id(cpu) != intserv[i])
+			if (get_hard_smp_processor_id(cpu) != be32_to_cpu(intserv[i]))
 				continue;
 
 			if (get_cpu_current_state(cpu) == CPU_STATE_OFFLINE)
@@ -475,14 +475,14 @@ static int dlpar_offline_cpu(struct device_node *dn)
 			 * Upgrade it's state to CPU_STATE_OFFLINE.
 			 */
 			set_preferred_offline_state(cpu, CPU_STATE_OFFLINE);
-			BUG_ON(plpar_hcall_norets(H_PROD, intserv[i])
+			BUG_ON(plpar_hcall_norets(H_PROD, be32_to_cpu(intserv[i]))
 								!= H_SUCCESS);
 			__cpu_die(cpu);
 			break;
 		}
 		if (cpu == num_possible_cpus())
 			printk(KERN_WARNING "Could not find cpu to offline "
-			       "with physical id 0x%x\n", intserv[i]);
+			       "with physical id 0x%x\n", be32_to_cpu(intserv[i]));
 	}
 	cpu_maps_update_done();
 
@@ -494,7 +494,7 @@ out:
 static ssize_t dlpar_cpu_release(const char *buf, size_t count)
 {
 	struct device_node *dn;
-	const u32 *drc_index;
+	const __be32 *drc_index;
 	int rc;
 
 	dn = of_find_node_by_path(buf);
@@ -513,7 +513,7 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
 		return -EINVAL;
 	}
 
-	rc = dlpar_release_drc(*drc_index);
+	rc = dlpar_release_drc(be32_to_cpup(drc_index));
 	if (rc) {
 		of_node_put(dn);
 		return rc;
@@ -521,7 +521,7 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
 
 	rc = dlpar_detach_node(dn);
 	if (rc) {
-		dlpar_acquire_drc(*drc_index);
+		dlpar_acquire_drc(be32_to_cpup(drc_index));
 		return rc;
 	}
 
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 447f8c6..031762d 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -90,7 +90,7 @@ static void rtas_stop_self(void)
 {
 	static struct rtas_args args = {
 		.nargs = 0,
-		.nret = 1,
+		.nret = cpu_to_be32(1),
 		.rets = &args.args[0],
 	};
 
@@ -312,7 +312,7 @@ static void pseries_remove_processor(struct device_node *np)
 {
 	unsigned int cpu;
 	int len, nthreads, i;
-	const u32 *intserv;
+	const __be32 *intserv;
 
 	intserv = of_get_property(np, "ibm,ppc-interrupt-server#s", &len);
 	if (!intserv)
@@ -323,7 +323,7 @@ static void pseries_remove_processor(struct device_node *np)
 	cpu_maps_update_begin();
 	for (i = 0; i < nthreads; i++) {
 		for_each_present_cpu(cpu) {
-			if (get_hard_smp_processor_id(cpu) != intserv[i])
+			if (get_hard_smp_processor_id(cpu) != be32_to_cpu(intserv[i]))
 				continue;
 			BUG_ON(cpu_online(cpu));
 			set_cpu_present(cpu, false);
@@ -332,7 +332,7 @@ static void pseries_remove_processor(struct device_node *np)
 		}
 		if (cpu >= nr_cpu_ids)
 			printk(KERN_WARNING "Could not find cpu to remove "
-			       "with physical id 0x%x\n", intserv[i]);
+			       "with physical id 0x%x\n", be32_to_cpu(intserv[i]));
 	}
 	cpu_maps_update_done();
 }
-- 
1.8.5.2
