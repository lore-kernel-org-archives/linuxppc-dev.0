Return-Path: <mohan@in.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3F59FDDEC0
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 20:54:49 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l54Ask9Y030444
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 06:54:46 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l54AskQL201486
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 04:54:46 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l54Asj0B022723
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 04:54:45 -0600
Date: Mon, 4 Jun 2007 16:24:55 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
Message-ID: <20070604105455.GA4916@in.ibm.com>
References: <20070409085732.GC4281@in.ibm.com>
	<1176188763.9836.16.camel@concordia.ozlabs.ibm.com>
	<eeb3b19029c753682f476e97dcfaa820@bga.com>
	<1176254201.4815.14.camel@concordia.ozlabs.ibm.com>
	<20070419115233.GA4172@in.ibm.com>
	<080126626f9bea228426c0c3d7bf1730@bga.com>
	<20070426092455.GA4144@in.ibm.com>
	<4cb567d635b4ac3333e6b4b2c27c12f2@bga.com>
	<20070503144721.GA28460@in.ibm.com>
	<ca045e7e6fde9345b3461214777d8102@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ca045e7e6fde9345b3461214777d8102@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, kexec@lists.infradead.org,
	Paul Mackerras <paulus@samba.org>
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton,

How about this patch?

=============================================================
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
 arch/powerpc/platforms/pseries/xics.c |   54 ++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 25 deletions(-)

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
@@ -166,22 +166,24 @@ static int get_irq_server(unsigned int v
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
-	}
+		server = first_cpu(tmp);
 
-	return server;
+		if (server < NR_CPUS)
+			return get_hard_smp_processor_id(server);
+		else if (strict_check)
+				return -1;
+	}
 
+	if (cpus_equal(cpu_online_map, cpu_present_map))
+		return default_distrib_server;
+	else
+		return default_server;
 }
 #else
-static int get_irq_server(unsigned int virq)
+static int get_irq_server(unsigned int virq, unsigned int strict_check)
 {
 	return default_server;
 }
@@ -192,7 +194,7 @@ static void xics_unmask_irq(unsigned int
 {
 	unsigned int irq;
 	int call_status;
-	unsigned int server;
+	int server;
 
 	pr_debug("xics: unmask virq %d\n", virq);
 
@@ -201,7 +203,7 @@ static void xics_unmask_irq(unsigned int
 	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
 		return;
 
-	server = get_irq_server(virq);
+	server = get_irq_server(virq, 0);
 
 	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, irq, server,
 				DEFAULT_PRIORITY);
@@ -398,8 +400,7 @@ static void xics_set_affinity(unsigned i
 	unsigned int irq;
 	int status;
 	int xics_status[2];
-	unsigned long newmask;
-	cpumask_t tmp = CPU_MASK_NONE;
+	int irq_server;
 
 	irq = (unsigned int)irq_map[virq].hwirq;
 	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
@@ -413,18 +414,21 @@ static void xics_set_affinity(unsigned i
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
+		cpulist_scnprintf(cpulist, sizeof(cpulist), cpumask);
+		printk(KERN_WARNING "xics_set_affinity: No online cpus in "
+				"the mask %s for irq %d\n", cpulist, virq);
+		return;
 	}
 
 	status = rtas_call(ibm_set_xive, 3, 1, NULL,
-				irq, newmask, xics_status[1]);
+				irq, irq_server, xics_status[1]);
 
 	if (status) {
 		printk(KERN_ERR "xics_set_affinity: irq=%u ibm,set-xive "
