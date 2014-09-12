Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF0BD1A01F1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Sep 2014 05:11:53 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Fri, 12 Sep 2014 15:11:51 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 6AAE938C8026
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 15:11:48 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8CJBmlU7667970
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 19:11:48 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8CJBlV5017656
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 15:11:48 -0400
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH v2 2/2] pseries: Fix endian issues in cpu hot-removal
Date: Fri, 12 Sep 2014 14:11:42 -0500
Message-Id: <1410549102-8410-2-git-send-email-tlfalcon@linux.vnet.ibm.com>
In-Reply-To: <1410549102-8410-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1410549102-8410-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Cc: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
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
Changes in v2:

 Followed suggestions from Michael Ellerman:
   Conversion of intserv to cpu endian occurs once.
   Conversion of drc_index to cpu endian occurs once
   using of_property_read_u32.
---
 arch/powerpc/platforms/pseries/dlpar.c       | 20 +++++++++++---------
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 10 ++++++----
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 9e9f30b2..343dfdf 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -444,7 +444,8 @@ static int dlpar_offline_cpu(struct device_node *dn)
 	int rc = 0;
 	unsigned int cpu;
 	int len, nthreads, i;
-	const u32 *intserv;
+	const __be32 *intserv;
+	u32 thread;
 
 	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
 	if (!intserv)
@@ -454,8 +455,9 @@ static int dlpar_offline_cpu(struct device_node *dn)
 
 	cpu_maps_update_begin();
 	for (i = 0; i < nthreads; i++) {
+		thread = be32_to_cpu(intserv[i]);
 		for_each_present_cpu(cpu) {
-			if (get_hard_smp_processor_id(cpu) != intserv[i])
+			if (get_hard_smp_processor_id(cpu) != thread)
 				continue;
 
 			if (get_cpu_current_state(cpu) == CPU_STATE_OFFLINE)
@@ -477,14 +479,14 @@ static int dlpar_offline_cpu(struct device_node *dn)
 			 * Upgrade it's state to CPU_STATE_OFFLINE.
 			 */
 			set_preferred_offline_state(cpu, CPU_STATE_OFFLINE);
-			BUG_ON(plpar_hcall_norets(H_PROD, intserv[i])
+			BUG_ON(plpar_hcall_norets(H_PROD, thread)
 								!= H_SUCCESS);
 			__cpu_die(cpu);
 			break;
 		}
 		if (cpu == num_possible_cpus())
 			printk(KERN_WARNING "Could not find cpu to offline "
-			       "with physical id 0x%x\n", intserv[i]);
+			       "with physical id 0x%x\n", thread);
 	}
 	cpu_maps_update_done();
 
@@ -496,15 +498,15 @@ out:
 static ssize_t dlpar_cpu_release(const char *buf, size_t count)
 {
 	struct device_node *dn;
-	const u32 *drc_index;
+	const u32 drc_index;
 	int rc;
 
 	dn = of_find_node_by_path(buf);
 	if (!dn)
 		return -EINVAL;
 
-	drc_index = of_get_property(dn, "ibm,my-drc-index", NULL);
-	if (!drc_index) {
+	rc = of_property_read_u32(dn, "ibm,my-drc-index", &drc_index);
+	if (rc) {
 		of_node_put(dn);
 		return -EINVAL;
 	}
@@ -515,7 +517,7 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
 		return -EINVAL;
 	}
 
-	rc = dlpar_release_drc(*drc_index);
+	rc = dlpar_release_drc(drc_index);
 	if (rc) {
 		of_node_put(dn);
 		return rc;
@@ -523,7 +525,7 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
 
 	rc = dlpar_detach_node(dn);
 	if (rc) {
-		dlpar_acquire_drc(*drc_index);
+		dlpar_acquire_drc(drc_index);
 		return rc;
 	}
 
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 447f8c6..5c375f9 100644
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
 
@@ -312,7 +312,8 @@ static void pseries_remove_processor(struct device_node *np)
 {
 	unsigned int cpu;
 	int len, nthreads, i;
-	const u32 *intserv;
+	const __be32 *intserv;
+	u32 thread;
 
 	intserv = of_get_property(np, "ibm,ppc-interrupt-server#s", &len);
 	if (!intserv)
@@ -322,8 +323,9 @@ static void pseries_remove_processor(struct device_node *np)
 
 	cpu_maps_update_begin();
 	for (i = 0; i < nthreads; i++) {
+		thread = be32_to_cpu(intserv[i]);
 		for_each_present_cpu(cpu) {
-			if (get_hard_smp_processor_id(cpu) != intserv[i])
+			if (get_hard_smp_processor_id(cpu) != thread)
 				continue;
 			BUG_ON(cpu_online(cpu));
 			set_cpu_present(cpu, false);
@@ -332,7 +334,7 @@ static void pseries_remove_processor(struct device_node *np)
 		}
 		if (cpu >= nr_cpu_ids)
 			printk(KERN_WARNING "Could not find cpu to remove "
-			       "with physical id 0x%x\n", intserv[i]);
+			       "with physical id 0x%x\n", thread);
 	}
 	cpu_maps_update_done();
 }
-- 
1.8.5.2
