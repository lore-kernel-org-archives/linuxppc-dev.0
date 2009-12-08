Return-Path: <nfont@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 00676B6F0A
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Dec 2009 06:49:03 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nB8Jk738010393
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Dec 2009 12:46:07 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	nB8Jmrb1226942
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Dec 2009 12:48:55 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nB8JmmE4024522
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Dec 2009 12:48:49 -0700
Message-ID: <4B1EAD9C.8020405@austin.ibm.com>
Date: Tue, 08 Dec 2009 13:48:44 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] pseries: Correct pseries/dlpar.c build break without
	CONFIG_SMP
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Gautham R Shenoy <ego@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The recent patch to add cpu offline/online as part of the DLPAR
process for pseries causes a build break if CONFIG_SMP is not
defined.  Original patch here;
http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-November/078299.html

This corrects the build break by moving the online_node_cpus
and offline_node_cpus under the #ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
portions of dlpar.c.

This patch also slightly modifies the online_node_cpus and offline_node_cpus
routines to prepend dlpar_ to the them and make them static.  These two
routine are only used in the dlpar add/remove of cpus and these changes
should help clarify that.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c |  188 ++++++++++++++++-----------------
 1 file changed, 94 insertions(+), 94 deletions(-)

Index: powerpc/arch/powerpc/platforms/pseries/dlpar.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/dlpar.c	2009-12-08 12:47:44.000000000 -0600
+++ powerpc/arch/powerpc/platforms/pseries/dlpar.c	2009-12-08 13:14:24.000000000 -0600
@@ -288,98 +288,6 @@
 	return 0;
 }
 
-int online_node_cpus(struct device_node *dn)
-{
-	int rc = 0;
-	unsigned int cpu;
-	int len, nthreads, i;
-	const u32 *intserv;
-
-	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
-	if (!intserv)
-		return -EINVAL;
-
-	nthreads = len / sizeof(u32);
-
-	cpu_maps_update_begin();
-	for (i = 0; i < nthreads; i++) {
-		for_each_present_cpu(cpu) {
-			if (get_hard_smp_processor_id(cpu) != intserv[i])
-				continue;
-			BUG_ON(get_cpu_current_state(cpu)
-					!= CPU_STATE_OFFLINE);
-			cpu_maps_update_done();
-			rc = cpu_up(cpu);
-			if (rc)
-				goto out;
-			cpu_maps_update_begin();
-
-			break;
-		}
-		if (cpu == num_possible_cpus())
-			printk(KERN_WARNING "Could not find cpu to online "
-			       "with physical id 0x%x\n", intserv[i]);
-	}
-	cpu_maps_update_done();
-
-out:
-	return rc;
-
-}
-
-int offline_node_cpus(struct device_node *dn)
-{
-	int rc = 0;
-	unsigned int cpu;
-	int len, nthreads, i;
-	const u32 *intserv;
-
-	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
-	if (!intserv)
-		return -EINVAL;
-
-	nthreads = len / sizeof(u32);
-
-	cpu_maps_update_begin();
-	for (i = 0; i < nthreads; i++) {
-		for_each_present_cpu(cpu) {
-			if (get_hard_smp_processor_id(cpu) != intserv[i])
-				continue;
-
-			if (get_cpu_current_state(cpu) == CPU_STATE_OFFLINE)
-				break;
-
-			if (get_cpu_current_state(cpu) == CPU_STATE_ONLINE) {
-				cpu_maps_update_done();
-				rc = cpu_down(cpu);
-				if (rc)
-					goto out;
-				cpu_maps_update_begin();
-				break;
-
-			}
-
-			/*
-			 * The cpu is in CPU_STATE_INACTIVE.
-			 * Upgrade it's state to CPU_STATE_OFFLINE.
-			 */
-			set_preferred_offline_state(cpu, CPU_STATE_OFFLINE);
-			BUG_ON(plpar_hcall_norets(H_PROD, intserv[i])
-								!= H_SUCCESS);
-			__cpu_die(cpu);
-			break;
-		}
-		if (cpu == num_possible_cpus())
-			printk(KERN_WARNING "Could not find cpu to offline "
-			       "with physical id 0x%x\n", intserv[i]);
-	}
-	cpu_maps_update_done();
-
-out:
-	return rc;
-
-}
-
 #define DR_ENTITY_SENSE		9003
 #define DR_ENTITY_PRESENT	1
 #define DR_ENTITY_UNUSABLE	2
@@ -448,6 +356,45 @@
 	mutex_unlock(&pseries_cpu_hotplug_mutex);
 }
 
+static int dlpar_online_cpu(struct device_node *dn)
+{
+	int rc = 0;
+	unsigned int cpu;
+	int len, nthreads, i;
+	const u32 *intserv;
+
+	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
+	if (!intserv)
+		return -EINVAL;
+
+	nthreads = len / sizeof(u32);
+
+	cpu_maps_update_begin();
+	for (i = 0; i < nthreads; i++) {
+		for_each_present_cpu(cpu) {
+			if (get_hard_smp_processor_id(cpu) != intserv[i])
+				continue;
+			BUG_ON(get_cpu_current_state(cpu)
+					!= CPU_STATE_OFFLINE);
+			cpu_maps_update_done();
+			rc = cpu_up(cpu);
+			if (rc)
+				goto out;
+			cpu_maps_update_begin();
+
+			break;
+		}
+		if (cpu == num_possible_cpus())
+			printk(KERN_WARNING "Could not find cpu to online "
+			       "with physical id 0x%x\n", intserv[i]);
+	}
+	cpu_maps_update_done();
+
+out:
+	return rc;
+
+}
+
 static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
 {
 	struct device_node *dn;
@@ -497,13 +444,66 @@
 		dlpar_free_cc_nodes(dn);
 	}
 
-	rc = online_node_cpus(dn);
+	rc = dlpar_online_cpu(dn);
 out:
 	cpu_hotplug_driver_unlock();
 
 	return rc ? rc : count;
 }
 
+static int dlpar_offline_cpu(struct device_node *dn)
+{
+	int rc = 0;
+	unsigned int cpu;
+	int len, nthreads, i;
+	const u32 *intserv;
+
+	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
+	if (!intserv)
+		return -EINVAL;
+
+	nthreads = len / sizeof(u32);
+
+	cpu_maps_update_begin();
+	for (i = 0; i < nthreads; i++) {
+		for_each_present_cpu(cpu) {
+			if (get_hard_smp_processor_id(cpu) != intserv[i])
+				continue;
+
+			if (get_cpu_current_state(cpu) == CPU_STATE_OFFLINE)
+				break;
+
+			if (get_cpu_current_state(cpu) == CPU_STATE_ONLINE) {
+				cpu_maps_update_done();
+				rc = cpu_down(cpu);
+				if (rc)
+					goto out;
+				cpu_maps_update_begin();
+				break;
+
+			}
+
+			/*
+			 * The cpu is in CPU_STATE_INACTIVE.
+			 * Upgrade it's state to CPU_STATE_OFFLINE.
+			 */
+			set_preferred_offline_state(cpu, CPU_STATE_OFFLINE);
+			BUG_ON(plpar_hcall_norets(H_PROD, intserv[i])
+								!= H_SUCCESS);
+			__cpu_die(cpu);
+			break;
+		}
+		if (cpu == num_possible_cpus())
+			printk(KERN_WARNING "Could not find cpu to offline "
+			       "with physical id 0x%x\n", intserv[i]);
+	}
+	cpu_maps_update_done();
+
+out:
+	return rc;
+
+}
+
 static ssize_t dlpar_cpu_release(const char *buf, size_t count)
 {
 	struct device_node *dn;
@@ -521,7 +521,7 @@
 	}
 
 	cpu_hotplug_driver_lock();
-	rc = offline_node_cpus(dn);
+	rc = dlpar_offline_cpu(dn);
 	if (rc) {
 		of_node_put(dn);
 		rc = -EINVAL;
