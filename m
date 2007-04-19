Return-Path: <mohan@in.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8A068DDE30
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2007 21:52:42 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3JBqdun008981
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2007 07:52:39 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3JBqdjg510408
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2007 07:52:39 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3JBqccM024596
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2007 07:52:38 -0400
Date: Thu, 19 Apr 2007 17:22:33 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
Message-ID: <20070419115233.GA4172@in.ibm.com>
References: <20070306135754.GB7476@in.ibm.com>
	<1173190615.4675.30.camel@concordia.ozlabs.ibm.com>
	<20070306165529.GD7476@in.ibm.com>
	<1173202634.4675.37.camel@concordia.ozlabs.ibm.com>
	<20070307045341.GG7476@in.ibm.com>
	<1173264752.5101.49.camel@concordia.ozlabs.ibm.com>
	<20070409085732.GC4281@in.ibm.com>
	<1176188763.9836.16.camel@concordia.ozlabs.ibm.com>
	<eeb3b19029c753682f476e97dcfaa820@bga.com>
	<1176254201.4815.14.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1176254201.4815.14.camel@concordia.ozlabs.ibm.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>,
	Milton Miller <miltonm@bga.com>, fastboot@lists.osdl.org
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 11, 2007 at 11:16:41AM +1000, Michael Ellerman wrote:
> On Tue, 2007-04-10 at 11:59 -0500, Milton Miller wrote:
> > 
> > This means we are doing population counts of two masks, when we really
> > just care that they are the same.   How about using
> > cpus_equal(cpu_online_mask, cpu_present_mask)?
> 
> Yep that's sensible.
> 
> > This shows how close these two functions are.  The difference is
> > what happens when cpus_empty is true -- we default in one and
> > ignore in the other.
> > 
> > How about adding another arg to get_server, that says to fail
> > or default for the empty case, with failure being -1?
> > 
> > I'll try to code this up, but it might be a day or two until i get
> > the time.

I modified the patch based on suggestions given by Milton and Mike.
Milton is this patch okay?

Tested on 2.6.21-rc7.

=====
It is observed that in some PPC970 based machines, When the kernel is
booted with maxcpus=1, interrupts were distributed to non online cpus
also. So a condition is included to check whether the cpu online
map and cpu present map are equal or not. If they are equal
default_distrib_server is used as the interrupt server otherwise
default_server(ie boot cpu) is used as the interrupt server.

In addition to this, if an interrupt is assigned to a specific cpu (ie
smp affinity) and if that cpu is not online, the earlier code used to
return the default_distrib_server as interrupt server. This patch
introduces an additional parameter to the get_irq function ie
strict_check, based on this parameter, if the cpu is not online either
default_distrib_server or -1 is returned.

Cc: Milton Miller <miltonm@bga.com>,
    Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
---
 arch/powerpc/platforms/pseries/xics.c |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

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
@@ -167,21 +167,25 @@ static int get_irq_server(unsigned int v
 		return default_server;
 
 	if (cpus_equal(cpumask, CPU_MASK_ALL)) {
-		server = default_distrib_server;
+		if (cpus_equal(cpu_online_map, cpu_present_map))
+			server = default_distrib_server;
+		else
+			server = default_server;
 	} else {
 		cpus_and(tmp, cpu_online_map, cpumask);
 
-		if (cpus_empty(tmp))
+		if (cpus_empty(tmp) && !strict_check)
 			server = default_distrib_server;
+		else if(cpus_empty(tmp) && strict_check)
+			server = -1;
 		else
 			server = get_hard_smp_processor_id(first_cpu(tmp));
 	}
 
 	return server;
-
 }
 #else
-static int get_irq_server(unsigned int virq)
+static int get_irq_server(unsigned int virq, unsigned int strict_check)
 {
 	return default_server;
 }
@@ -192,7 +196,7 @@ static void xics_unmask_irq(unsigned int
 {
 	unsigned int irq;
 	int call_status;
-	unsigned int server;
+	int server;
 
 	pr_debug("xics: unmask virq %d\n", virq);
 
@@ -201,7 +205,7 @@ static void xics_unmask_irq(unsigned int
 	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
 		return;
 
-	server = get_irq_server(virq);
+	server = get_irq_server(virq, 0);
 
 	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, irq, server,
 				DEFAULT_PRIORITY);
@@ -415,7 +419,10 @@ static void xics_set_affinity(unsigned i
 
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
