Return-Path: <mohan@in.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 571D6DDE20
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 00:52:10 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5CDnKuP001818
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 09:49:20 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5CEq6fv549798
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 10:52:06 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5CEq5fb012032
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 10:52:05 -0400
Date: Tue, 12 Jun 2007 20:21:57 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
Message-ID: <20070612145157.GA7562@in.ibm.com>
References: <20070419115233.GA4172@in.ibm.com>
	<080126626f9bea228426c0c3d7bf1730@bga.com>
	<20070426092455.GA4144@in.ibm.com>
	<4cb567d635b4ac3333e6b4b2c27c12f2@bga.com>
	<20070503144721.GA28460@in.ibm.com>
	<ca045e7e6fde9345b3461214777d8102@bga.com>
	<20070604105455.GA4916@in.ibm.com>
	<c1b8d82c8241fc3750c1339c34ecc799@bga.com>
	<20070606113134.GC4916@in.ibm.com>
	<ac119a2f080a47cf41f7c916010eaccd@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ac119a2f080a47cf41f7c916010eaccd@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	kexec@lists.infradead.org
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jun 10, 2007 at 08:58:10PM -0500, Milton Miller wrote:
> The code is structured cleanly.  However, when testing this patch, I 
> found (1) you printed the mask as a cpulist instead of a cpumask.  
> Since the user writes a cpumask to /proc/irq/xx/smp_affinity, it would 
> make more sense to print a mask in the error message.

Attached patch uses cpumask_scnprintf function.

> 
> However, this is all mute because (2) the common in /kenrel/irq/proc.c 
> checks that a cpu in the mask is online and returns -EINVAL to the user 
> without calling the ->set_affinity hook (we have no select_smp_affinity 
> hook arch code).   Unless there is another path to call ->set_affinity, 
> we can only trigger the case of no online cpu by racing between setting 
> the affinity and taking a cpu offline.
>
> Does anyone know of another path to set the affinity?  If not I would 
> remove this extra logic and change the behavior from ignore to set to 
> default server.
>

tick_setup_device function in kernel/time/tick-common.c file calls
irq_set_affinity function without validating the new cpumask with the
cpu online mask. So IMHO the check in get_irq_server is required.

================
In some of the PPC970 based systems, interrupt would be distributed to
offline cpus also even when booted with "maxcpus=1". So check whether
cpu online map and cpu present map are equal or not. If they are equal
default_distrib_server is used as interrupt server otherwise boot cpu
(default_server) used as interrupt server. 

In addition to this, if an interrupt is assigned to a specific cpu (ie
smp affinity) and if that cpu is not online, the earlier code used to
return the default_distrib_server as interrupt server. This patch
introduces an additional paramter to the get_irq function ie
strict_check, based on this parameter, if the cpu is not online either
default_distrib_server or -1 is returned.

Cc: Milton Miller <miltonm@bga.com>,
    Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
---
 arch/powerpc/platforms/pseries/xics.c |   53 ++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 24 deletions(-)

Index: linux-2.6.21.1/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-2.6.21.1.orig/arch/powerpc/platforms/pseries/xics.c
+++ linux-2.6.21.1/arch/powerpc/platforms/pseries/xics.c
@@ -156,9 +156,9 @@ static inline void lpar_qirr_info(int n_
 
 
 #ifdef CONFIG_SMP
-static int get_irq_server(unsigned int virq)
+static int get_irq_server(unsigned int virq, unsigned int strict_check)
 {
-	unsigned int server;
+	int server;
 	/* For the moment only implement delivery to all cpus or one cpu */
 	cpumask_t cpumask = irq_desc[virq].affinity;
 	cpumask_t tmp = CPU_MASK_NONE;
@@ -166,22 +166,25 @@ static int get_irq_server(unsigned int v
 	if (!distribute_irqs)
 		return default_server;
 
-	if (cpus_equal(cpumask, CPU_MASK_ALL)) {
-		server = default_distrib_server;
-	} else {
+	if (!cpus_equal(cpumask, CPU_MASK_ALL)) {
 		cpus_and(tmp, cpu_online_map, cpumask);
 
-		if (cpus_empty(tmp))
-			server = default_distrib_server;
-		else
-			server = get_hard_smp_processor_id(first_cpu(tmp));
+		server = first_cpu(tmp);
+
+		if (server < NR_CPUS)
+			return get_hard_smp_processor_id(server);
+
+		if (strict_check)
+			return -1;
 	}
 
-	return server;
+	if (cpus_equal(cpu_online_map, cpu_present_map))
+		return default_distrib_server;
 
+	return default_server;
 }
 #else
-static int get_irq_server(unsigned int virq)
+static int get_irq_server(unsigned int virq, unsigned int strict_check)
 {
 	return default_server;
 }
@@ -192,7 +195,7 @@ static void xics_unmask_irq(unsigned int
 {
 	unsigned int irq;
 	int call_status;
-	unsigned int server;
+	int server;
 
 	pr_debug("xics: unmask virq %d\n", virq);
 
@@ -201,7 +204,7 @@ static void xics_unmask_irq(unsigned int
 	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
 		return;
 
-	server = get_irq_server(virq);
+	server = get_irq_server(virq, 0);
 
 	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, irq, server,
 				DEFAULT_PRIORITY);
@@ -398,8 +401,7 @@ static void xics_set_affinity(unsigned i
 	unsigned int irq;
 	int status;
 	int xics_status[2];
-	unsigned long newmask;
-	cpumask_t tmp = CPU_MASK_NONE;
+	int irq_server;
 
 	irq = (unsigned int)irq_map[virq].hwirq;
 	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
@@ -413,18 +415,21 @@ static void xics_set_affinity(unsigned i
 		return;
 	}
 
-	/* For the moment only implement delivery to all cpus or one cpu */
-	if (cpus_equal(cpumask, CPU_MASK_ALL)) {
-		newmask = default_distrib_server;
-	} else {
-		cpus_and(tmp, cpu_online_map, cpumask);
-		if (cpus_empty(tmp))
-			return;
-		newmask = get_hard_smp_processor_id(first_cpu(tmp));
+	/*
+	 * For the moment only implement delivery to all cpus or one cpu.
+	 * Get current irq_server for the given irq
+	 */
+	irq_server = get_irq_server(irq, 1);
+	if (irq_server == -1) {
+		char cpulist[128];
+		cpumask_scnprintf(cpulist, sizeof(cpulist), cpumask);
+		printk(KERN_WARNING "xics_set_affinity: No online cpus in "
+				"the mask %s for irq %d\n", cpulist, virq);
+		return;
 	}
 
 	status = rtas_call(ibm_set_xive, 3, 1, NULL,
-				irq, newmask, xics_status[1]);
+				irq, irq_server, xics_status[1]);
 
 	if (status) {
 		printk(KERN_ERR "xics_set_affinity: irq=%u ibm,set-xive "
