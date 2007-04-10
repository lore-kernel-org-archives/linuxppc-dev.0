Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
From: Michael Ellerman <michael@ellerman.id.au>
To: mohan@in.ibm.com
In-Reply-To: <20070409085732.GC4281@in.ibm.com>
References: <20061208045537.GA14626@in.ibm.com>
	<17798.6928.378248.28903@cargo.ozlabs.ibm.com>
	<20061218105706.GB3911@in.ibm.com> <20070306135754.GB7476@in.ibm.com>
	<1173190615.4675.30.camel@concordia.ozlabs.ibm.com>
	<20070306165529.GD7476@in.ibm.com>
	<1173202634.4675.37.camel@concordia.ozlabs.ibm.com>
	<20070307045341.GG7476@in.ibm.com>
	<1173264752.5101.49.camel@concordia.ozlabs.ibm.com>
	<20070409085732.GC4281@in.ibm.com>
Content-Type: text/plain
Date: Tue, 10 Apr 2007 17:06:03 +1000
Message-Id: <1176188763.9836.16.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: ppcdev <linuxppc-dev@ozlabs.org>, fastboot@lists.osdl.org,
	Milton Miller <miltonm@bga.com>, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-04-09 at 14:27 +0530, Mohan Kumar M wrote:
> On Wed, Mar 07, 2007 at 11:52:32AM +0100, Michael Ellerman wrote:
> > There's already maxcpus in init/main.c, that would probably be better,
> > though still ugly.
> >
> Based on Mike's suggestions, I modified the patch. The attached patch
> refers max_cpus variable to check whether the kernel is booted with
> maxcpus=1 parameter and if maxcpus=1 is specified the patch assigns only
> the current boot cpu to be the default distribution server.
> 
> Patch is generated over 2.6.20 kernel, cleanly applies to 2.6.21-rc5
> kernel.
> 
> Any suggestion, comment?

So the core of the problem is that if we haven't onlined all cpus then
we can't use the default_distrib_server value given to us by firmware,
because some of the cpus in that queue won't be online.

We can detect this situation by comparing the number of cpus that are
online vs the number that are present (not possible). This might even
work if you boot with maxcpus=1 and then hotplug the rest in.

How about this:

Index: powerpc/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/xics.c
+++ powerpc/arch/powerpc/platforms/pseries/xics.c
@@ -167,7 +167,10 @@ static int get_irq_server(unsigned int v
 		return default_server;
 
 	if (cpus_equal(cpumask, CPU_MASK_ALL)) {
-		server = default_distrib_server;
+		if (num_online_cpus() == num_present_cpus())
+			server = default_distrib_server;
+		else
+			server = default_server;
 	} else {
 		cpus_and(tmp, cpu_online_map, cpumask);
 
@@ -415,7 +418,10 @@ static void xics_set_affinity(unsigned i
 
 	/* For the moment only implement delivery to all cpus or one cpu */
 	if (cpus_equal(cpumask, CPU_MASK_ALL)) {
-		newmask = default_distrib_server;
+		if (num_online_cpus() == num_present_cpus())
+			newmask = default_distrib_server;
+		else
+			newmask = default_server;
 	} else {
 		cpus_and(tmp, cpu_online_map, cpumask);
 		if (cpus_empty(tmp))
