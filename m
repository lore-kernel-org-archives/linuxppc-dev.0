Return-Path: <mohan@in.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BA2FADDFF0
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 00:47:24 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l43ElIRH022481
	for <linuxppc-dev@ozlabs.org>; Thu, 3 May 2007 10:47:18 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l43ElIkZ530478
	for <linuxppc-dev@ozlabs.org>; Thu, 3 May 2007 10:47:18 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l43ElIsw004752
	for <linuxppc-dev@ozlabs.org>; Thu, 3 May 2007 10:47:18 -0400
Date: Thu, 3 May 2007 20:17:21 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
Message-ID: <20070503144721.GA28460@in.ibm.com>
References: <20070307045341.GG7476@in.ibm.com>
	<1173264752.5101.49.camel@concordia.ozlabs.ibm.com>
	<20070409085732.GC4281@in.ibm.com>
	<1176188763.9836.16.camel@concordia.ozlabs.ibm.com>
	<eeb3b19029c753682f476e97dcfaa820@bga.com>
	<1176254201.4815.14.camel@concordia.ozlabs.ibm.com>
	<20070419115233.GA4172@in.ibm.com>
	<080126626f9bea228426c0c3d7bf1730@bga.com>
	<20070426092455.GA4144@in.ibm.com>
	<4cb567d635b4ac3333e6b4b2c27c12f2@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4cb567d635b4ac3333e6b4b2c27c12f2@bga.com>
Cc: fastboot@lists.osdl.org, kexec@lists.infradead.org,
	ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 26, 2007 at 09:42:50AM -0500, Milton Miller wrote:
> Yes.   The whole point of
> >-static int get_irq_server(unsigned int virq)
> >+static int get_irq_server(unsigned int virq, unsigned int 
> >strict_check)
> was to factor out the common code in this function.
> 
> I wasn't trying to change the prototype of xics_set_affinity.
> 
> Looking at the code a bit, I think part of the confusion is that newmask
> is horribly misnamed.   Please rename it to server or irqserver.
> Obtain its value by calling get_irq_server.  If the server returned
> is -1 (in strict mode), don't call rtas (just return like today).
> I guess a printk could be in order since the function is void, and
> only root can request the change.

Milton,

How about this patch?


It is observed that in some PPC970 based machines, When the kernel is
booted with maxcpus=1, interrupts were distributed to offline cpus
also. So a condition is included to check whether the cpu online
map and cpu present map are equal or not. If they are equal
default_distrib_server is used as the interrupt server otherwise
default_server(ie boot cpu) is used as the interrupt server.

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
 arch/powerpc/platforms/pseries/xics.c |   63 +++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 24 deletions(-)

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
@@ -166,22 +166,28 @@ static int get_irq_server(unsigned int v
 	if (!distribute_irqs)
 		return default_server;
 
-	if (cpus_equal(cpumask, CPU_MASK_ALL)) {
-		server = default_distrib_server;
-	} else {
+	if (!cpus_equal(cpumask, CPU_MASK_ALL)) {
 		cpus_and(tmp, cpu_online_map, cpumask);
 
-		if (cpus_empty(tmp))
-			server = default_distrib_server;
+		server = first_cpu(tmp);
+
+		if (server < NR_CPUS)
+			return get_hard_smp_processor_id(server);
+		else {
+			if (strict_check)
+				return -1;
+			else
+				return default_distrib_server;
+		}
+	} else {
+		if (cpus_equal(cpu_online_map, cpu_present_map))
+			return default_distrib_server;
 		else
-			server = get_hard_smp_processor_id(first_cpu(tmp));
+			return default_server;
 	}
-
-	return server;
-
 }
 #else
-static int get_irq_server(unsigned int virq)
+static int get_irq_server(unsigned int virq, unsigned int strict_check)
 {
 	return default_server;
 }
@@ -192,7 +198,7 @@ static void xics_unmask_irq(unsigned int
 {
 	unsigned int irq;
 	int call_status;
-	unsigned int server;
+	int server;
 
 	pr_debug("xics: unmask virq %d\n", virq);
 
@@ -201,7 +207,7 @@ static void xics_unmask_irq(unsigned int
 	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
 		return;
 
-	server = get_irq_server(virq);
+	server = get_irq_server(virq, 0);
 
 	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, irq, server,
 				DEFAULT_PRIORITY);
@@ -398,8 +404,7 @@ static void xics_set_affinity(unsigned i
 	unsigned int irq;
 	int status;
 	int xics_status[2];
-	unsigned long newmask;
-	cpumask_t tmp = CPU_MASK_NONE;
+	int irq_server;
 
 	irq = (unsigned int)irq_map[virq].hwirq;
 	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
@@ -413,18 +418,28 @@ static void xics_set_affinity(unsigned i
 		return;
 	}
 
-	/* For the moment only implement delivery to all cpus or one cpu */
-	if (cpus_equal(cpumask, CPU_MASK_ALL)) {
-		newmask = default_distrib_server;
-	} else {
-		cpus_and(tmp, cpu_online_map, cpumask);
-		if (cpus_empty(tmp))
+	/* Get current irq_server for the given irq */
+	irq_server = get_irq_server(irq, 1);
+	if (irq_server == -1) {
+		printk(KERN_ERR "xics_set_affinity: Invalid cpumask\n");
+		return;
+	}
+
+	/* For the moment only implement delivery to all cpus or one cpu.
+	 * Compare the irq_server with the new cpumask. If the irq_server
+	 * is specified in cpumask, do the required rtas_call, otherwise
+	 * return by printing an error message
+	 */
+	if (!cpus_equal(cpumask, CPU_MASK_ALL)) {
+		if (!cpu_isset(irq_server, cpumask)) {
+			printk(KERN_ERR "xics_set_affinity: Invalid "
+							"cpumask\n");
 			return;
-		newmask = get_hard_smp_processor_id(first_cpu(tmp));
+		}
 	}
 
 	status = rtas_call(ibm_set_xive, 3, 1, NULL,
-				irq, newmask, xics_status[1]);
+				irq, irq_server, xics_status[1]);
 
 	if (status) {
 		printk(KERN_ERR "xics_set_affinity: irq=%u ibm,set-xive "
