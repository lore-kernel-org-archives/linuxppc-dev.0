Return-Path: <mohan@in.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B9CE2DDF10
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 19:25:07 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3Q9PpNp007102
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 05:25:51 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3Q9Ov6w530504
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 05:24:57 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3Q9OugS005346
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 05:24:57 -0400
Date: Thu, 26 Apr 2007 14:54:55 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
Message-ID: <20070426092455.GA4144@in.ibm.com>
References: <20070306165529.GD7476@in.ibm.com>
	<1173202634.4675.37.camel@concordia.ozlabs.ibm.com>
	<20070307045341.GG7476@in.ibm.com>
	<1173264752.5101.49.camel@concordia.ozlabs.ibm.com>
	<20070409085732.GC4281@in.ibm.com>
	<1176188763.9836.16.camel@concordia.ozlabs.ibm.com>
	<eeb3b19029c753682f476e97dcfaa820@bga.com>
	<1176254201.4815.14.camel@concordia.ozlabs.ibm.com>
	<20070419115233.GA4172@in.ibm.com>
	<080126626f9bea228426c0c3d7bf1730@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <080126626f9bea228426c0c3d7bf1730@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, fastboot@lists.osdl.org
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 20, 2007 at 12:45:15AM -0500, Milton Miller wrote:
[snip]
> 
> Don't test cpus_empty twice, instead do a nested if.
> 
> Actually, looking at this a bit, you need your default_distrib or
> default_server check again.
> 
> How about reorder to be if (!cpus_equal(...ALL)) {
>     cpus_and
>     if !cpus_empty(tmp
>         return get_hard(first);
>     if (strict)
>         return -1;
> }
> 
> if (cpus_equal(online, preseent)
> return distrib
> return default_server
> 
> For that matter, can we just call first_cpu, and check its <= NUM_CPUS
> elminating the call to cpus_empty ?   Only call get_hard_cpu if its
> valid.
>

Milton, I hope this patch meets all your requirements.

Cc: Milton Miller <miltonm@bga.com>,
    Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
---
 arch/powerpc/platforms/pseries/xics.c |   39 ++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 15 deletions(-)

Index: linux-2.6.21-rc4/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-2.6.21-rc4.orig/arch/powerpc/platforms/pseries/xics.c
+++ linux-2.6.21-rc4/arch/powerpc/platforms/pseries/xics.c
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
+			if(strict_check)
+				return (-1);
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
@@ -415,7 +421,10 @@ static void xics_set_affinity(unsigned i
 
 	/* For the moment only implement delivery to all cpus or one cpu */
 	if (cpus_equal(cpumask, CPU_MASK_ALL)) {
-		newmask = default_distrib_server;
+		if (cpus_equal(cpu_online_map, cpu_present_map))
+			newmask = default_distrib_server;
+		else
+			newmask = default_server;
 	} else {
 		cpus_and(tmp, cpu_online_map, cpumask);
 		if (cpus_empty(tmp))


=================== 
> ...
> >@@ -415,7 +419,10 @@ static void xics_set_affinity(unsigned i
> ...
> > 	/* For the moment only implement delivery to all cpus or one cpu */
> > 	if (cpus_equal(cpumask, CPU_MASK_ALL)) {
> >-		newmask = default_distrib_server;
> >+		if (cpus_equal(cpu_online_map, cpu_present_map))
> >
> 
> this was supposed to be the call with strict = 1

Do you mean to use 'strict_check' argument in xics_set_affinity?
set_affinity call is declared in linux/irq.h, so if modifying
xics_set_affinity will affect other arch's set_affinity also.

Regards,
Mohan
