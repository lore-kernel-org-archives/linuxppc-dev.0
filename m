Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D66C1A0986
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Oct 2014 03:05:20 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 10 Oct 2014 10:05:18 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id E82533E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Oct 2014 10:05:14 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9AG5ELn53739746
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Oct 2014 18:05:14 +0200
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9AG5EmK007324
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Oct 2014 10:05:14 -0600
Date: Fri, 10 Oct 2014 09:04:49 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3] powerpc/numa: add ability to disable and debug topology
 updates
Message-ID: <20141010160449.GD30604@linux.vnet.ibm.com>
References: <20141009234215.GC30604@linux.vnet.ibm.com>
 <20141010042816.A75841400EA@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141010042816.A75841400EA@ozlabs.org>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10.10.2014 [15:28:16 +1100], Michael Ellerman wrote:
> On Thu, 2014-09-10 at 23:42:15 UTC, Nishanth Aravamudan wrote:
> > We have hit a few customer issues with the topology update code (VPHN
> > and PRRN). It would be nice to be able to debug the notifications coming
> > from the hypervisor in both cases to the LPAR, as well as to disable
> > responding to the notifications at boot-time, to narrow down the source
> > of the problems. Add a basic level of such functionality, similar to the
> > numa= command-line parameter. We already have a toggle in
> > /proc/powerpc/topology_updates that allows run-time enabling/disabling,
> > so the updates can be started at run-time if desired. But the bugs we've
> > run into have occured during boot or very shortly after coming to login,
> > and have resulted in a broken NUMA topology.
> 
> Thanks Nish, a couple of minor nits.

Thanks for the review, fixed.

<snip>

> > +static int __init early_topology_updates(char *p)
> > +{
> > +	if (!p)
> > +		return 0;
> > +
> > +	if (strstr(p, "off")) {
> 
> You're better off using strcmp. Using strstr() is nice if you need to support
> multiple values, but it's sloppy otherwise. This will match "offset",
> "smirnoff" etc.

I feel like this is the Linux-equivalent of "You just got iced!"

<snip>

We have hit a few customer issues with the topology update code (VPHN
and PRRN). It would be nice to be able to debug the notifications coming
from the hypervisor in both cases to the LPAR, as well as to disable
responding to the notifications at boot-time, to narrow down the source
of the problems. Add a basic level of such functionality, similar to the
numa= command-line parameter. We already have a toggle in
/proc/powerpc/topology_updates that allows run-time enabling/disabling,
so the updates can be started at run-time if desired. But the bugs we've
run into have occured during boot or very shortly after coming to login,
and have resulted in a broken NUMA topology.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
---
v1 -> v2:
 Updated commit message to answer some of mpe's reviews.
 Switched to pr_fmt based debugging, which removes the need for the
   debug flag.
 Be a little less verbose in the debugging, as it was duplicating
   information.
v2 -> v3:
 Move pr_fmt define to the right spot.
 Make topology_updates_enabled bool.
 Use strcmp instead of strstr for topology_updates= parsing.
 Add a missing newline.

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index d9a452e8fb9b..35a46b8240ad 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -3388,6 +3388,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			e.g. base its process migration decisions on it.
 			Default is on.
 
+	topology_updates= [KNL, PPC, NUMA]
+			Format: {off}
+			Specify if the kernel should ignore (off)
+			topology updates sent by the hypervisor to this
+			LPAR.
+
 	tp720=		[HW,PS2]
 
 	tpm_suspend_pcr=[HW,TPM]
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index e28c21ba862d..6fde1d4351e6 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -8,6 +8,8 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
+#define pr_fmt(fmt) "numa: " fmt
+
 #include <linux/threads.h>
 #include <linux/bootmem.h>
 #include <linux/init.h>
@@ -1160,6 +1162,22 @@ static int __init early_numa(char *p)
 }
 early_param("numa", early_numa);
 
+static bool topology_updates_enabled = true;
+
+static int __init early_topology_updates(char *p)
+{
+	if (!p)
+		return 0;
+
+	if (!strcmp(p, "off")) {
+		pr_info("Disabling topology updates\n");
+		topology_updates_enabled = false;
+	}
+
+	return 0;
+}
+early_param("topology_updates", early_topology_updates);
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 /*
  * Find the node associated with a hot added memory section for
@@ -1546,6 +1564,9 @@ int arch_update_cpu_topology(void)
 	struct device *dev;
 	int weight, new_nid, i = 0;
 
+	if (!prrn_enabled && !vphn_enabled)
+		return 0;
+
 	weight = cpumask_weight(&cpu_associativity_changes_mask);
 	if (!weight)
 		return 0;
@@ -1599,6 +1620,15 @@ int arch_update_cpu_topology(void)
 		cpu = cpu_last_thread_sibling(cpu);
 	}
 
+	pr_debug("Topology update for the following CPUs:\n");
+	if (cpumask_weight(&updated_cpus)) {
+		for (ud = &updates[0]; ud; ud = ud->next) {
+			pr_debug("cpu %d moving from node %d "
+					  "to %d\n", ud->cpu,
+					  ud->old_nid, ud->new_nid);
+		}
+	}
+
 	/*
 	 * In cases where we have nothing to update (because the updates list
 	 * is too short or because the new topology is same as the old one),
@@ -1807,7 +1837,10 @@ static const struct file_operations topology_ops = {
 
 static int topology_update_init(void)
 {
-	start_topology_update();
+	/* Do not poll for changes if disabled at boot */
+	if (topology_updates_enabled)
+		start_topology_update();
+
 	if (!proc_create("powerpc/topology_updates", 0644, NULL, &topology_ops))
 		return -ENOMEM;
 
