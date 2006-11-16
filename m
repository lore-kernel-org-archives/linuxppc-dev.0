Return-Path: <mohan@in.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 93AB267BB6
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 23:57:22 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAGCvH5e028295
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 07:57:17 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAGCvGEd327676
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 05:57:16 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAGCvGOP019178
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 05:57:16 -0700
Date: Thu, 16 Nov 2006 18:26:37 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [RFC] Fix for interrupt distribution
Message-ID: <20061116125637.GB13004@in.ibm.com>
References: <20061030180446.GA24307@in.ibm.com>
	<20061030181751.GI17168@localdomain>
	<20061031110515.GB7884@in.ibm.com>
	<20061106224603.GG6848@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061106224603.GG6848@localdomain>
Cc: linuxppc-dev@ozlabs.org, fastboot@lists.osdl.org, anton@samba.org
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 06, 2006 at 04:46:03PM -0600, Nathan Lynch wrote:
> Mohan Kumar M wrote:
> >
> > Index: linux-2.6.19-rc3/arch/powerpc/platforms/pseries/xics.c
> > ===================================================================
> > --- linux-2.6.19-rc3.orig/arch/powerpc/platforms/pseries/xics.c
> > +++ linux-2.6.19-rc3/arch/powerpc/platforms/pseries/xics.c
> > @@ -658,7 +658,7 @@ static void __init xics_setup_8259_casca
> >  
> >  void __init xics_init_IRQ(void)
> >  {
> > -	int i;
> > +	int i, j;
> >  	struct device_node *np;
> >  	u32 ilen, indx = 0;
> >  	const u32 *ireg;
> > @@ -686,23 +686,23 @@ void __init xics_init_IRQ(void)
> >  	for (np = of_find_node_by_type(NULL, "cpu");
> >  	     np;
> >  	     np = of_find_node_by_type(np, "cpu")) {
> > -		ireg = get_property(np, "reg", &ilen);
> > -		if (ireg && ireg[0] == get_hard_smp_processor_id(boot_cpuid)) {
> > -			ireg = get_property(np,
> > -					"ibm,ppc-interrupt-gserver#s", &ilen);
> > -			i = ilen / sizeof(int);
> > -			if (ireg && i > 0) {
> > -				default_server = ireg[0];
> > -				/* take last element */
> > -				default_distrib_server = ireg[i-1];
> > -			}
> > -			ireg = get_property(np,
> > +		ireg = get_property(np, "ibm,ppc-interrupt-gserver#s", &ilen);
> > +		i = ilen / sizeof(int);
> > +		for (j = 0; ireg[j] && j < i; j+=2) {
>                             ^^^^^^
> I don't understand this condition in the loop -- zero is a valid (and
> common) value for interrupt servers:
> 
> # xxd /proc/device-tree/cpus/PowerPC,POWER5@0/ibm,ppc-interrupt-server#s
> 0000000: 0000 0000 0000 0001
> 
> # xxd /proc/device-tree/cpus/PowerPC,POWER5@0/ibm,ppc-interrupt-gserver#s
> 0000000: 0000 0000 0000 00ff 0000 0001 0000 00ff
> 
> So I think this patch wouldn't always work.
> 
> > +			if (ireg[j] == get_hard_smp_processor_id(boot_cpuid)) {
> > +				if ( j + 1 < i) {
> > +					default_server = ireg[j];
> > +					default_distrib_server = ireg[j+1];
> > +				}
> > +				ireg = get_property(np,
> >  					"ibm,interrupt-server#-size", NULL);
> > -			if (ireg)
> > -				interrupt_server_size = *ireg;
> > -			break;
> > +				if (ireg)
> > +					interrupt_server_size = *ireg;
> > +				goto out;
> > +			}
> >  		}
> >  	}
> > +out:
> >  	of_node_put(np);
> 
> 
> I think we need a helper function or two to make this easier to do
> correctly and readably, e.g.
> 
> /* Returns the device node (with refcount incremented)
>  * corresponding to the given logical cpu id */
> struct device_node * cpuid_to_of_node(int cpu) {
> 	struct device_node *np;
> 	u32 hcpuid = get_hard_smp_processor_id(cpu);
> 
> 	for_each_node_by_type(np, "cpu") {
> 		int len, i;
> 		u32 *intserv = get_property(np,
> 				"ibm,ppc-interrupt-server#s", &len);
> 
> 		if (!intserv)
> 			intserv = get_property(np, "reg", &len);
> 
> 		i = len / sizeof(u32);
> 
> 		while (i--)
> 			if (intserv[i] == hcpuid)
> 				return np;
> 	}
> 	return NULL;
> }
> 
> 
> And then the loop in xics_init_IRQ can be replaced with something like:
> 
> np = cpuid_to_of_node(boot_cpuid);
> BUG_ON(!np);
> ireg = get_property(np, "ibm,ppc-interrupt-gserver#s", &ilen);
> hcpuid = get_hard_smp_processor_id(boot_cpuid);
> 
> if (ireg[0] == hcpuid)
> 	default_distrib_server = ireg[1];
> else
> 	default_distrib_server = ireg[3];
> 
> default_server = hcpuid;
> 
> ...

Back to work after a long vacation.

Nathan,

Thanks for your suggestions. Based on your suggestions I have rewritten
the patch to use ibm,ppc-interrupt-server#s to check for both primary
and secondary CPU ids. Accordingly default distribution server value is
initialized from "ibm,ppc-interrupt-gserver#s" property.

Patch created over 2.6.19-rc5.

o The following patch allows any secondary CPU thread also to become
  boot cpu for POWER5. The patch is required to solve kdump boot issue
  when the kdump kernel is booted with parameter "maxcpus=1". XICS init
  code tries to match the current boot cpu id with "reg" property in
  each CPU node in the device tree. But CPU node is created only for
  primary thread CPU ids and "reg" property only reflects primary CPU
  ids. So when a kernel is booted on a secondary cpu thread above
  condition will never meet and the default distribution server is left
  as zero. This leads to route the interrupts to CPU 0, but which is not
  online at this time.

o The patch uses ibm,ppc-interrupt-server#s to check for both primary
  and secondary CPU ids. Accordingly default distribution server value
  is initialized from "ibm,ppc-interrupt-gserver#s" property.

Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
---
 arch/powerpc/platforms/pseries/xics.c |   57 +++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 21 deletions(-)

Index: linux-2.6.19-rc5/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-2.6.19-rc5.orig/arch/powerpc/platforms/pseries/xics.c
+++ linux-2.6.19-rc5/arch/powerpc/platforms/pseries/xics.c
@@ -656,13 +656,37 @@ static void __init xics_setup_8259_casca
 	set_irq_chained_handler(cascade, pseries_8259_cascade);
 }
 
+static struct device_node *cpuid_to_of_node(int cpu)
+{
+	struct device_node *np;
+	u32 hcpuid = get_hard_smp_processor_id(cpu);
+
+	for_each_node_by_type(np, "cpu") {
+		int i, len;
+		const u32 *intserv;
+
+		intserv = get_property(np, "ibm,ppc-interrupt-server#s", &len);
+
+		if (!intserv)
+			intserv = get_property(np, "reg", &len);
+
+		i = len / sizeof(u32);
+
+		while (i--)
+			if (intserv[i] == hcpuid)
+				return np;
+	}
+
+	return NULL;
+}
+
 void __init xics_init_IRQ(void)
 {
-	int i;
 	struct device_node *np;
 	u32 ilen, indx = 0;
 	const u32 *ireg;
 	int found = 0;
+	int hcpuid;
 
 	ppc64_boot_msg(0x20, "XICS Init");
 
@@ -683,26 +707,17 @@ void __init xics_init_IRQ(void)
 	xics_init_host();
 
 	/* Find the server numbers for the boot cpu. */
-	for (np = of_find_node_by_type(NULL, "cpu");
-	     np;
-	     np = of_find_node_by_type(np, "cpu")) {
-		ireg = get_property(np, "reg", &ilen);
-		if (ireg && ireg[0] == get_hard_smp_processor_id(boot_cpuid)) {
-			ireg = get_property(np,
-					"ibm,ppc-interrupt-gserver#s", &ilen);
-			i = ilen / sizeof(int);
-			if (ireg && i > 0) {
-				default_server = ireg[0];
-				/* take last element */
-				default_distrib_server = ireg[i-1];
-			}
-			ireg = get_property(np,
-					"ibm,interrupt-server#-size", NULL);
-			if (ireg)
-				interrupt_server_size = *ireg;
-			break;
-		}
-	}
+	np = cpuid_to_of_node(boot_cpuid);
+	BUG_ON(!np);
+	ireg = get_property(np, "ibm,ppc-interrupt-gserver#s", &ilen);
+	hcpuid = get_hard_smp_processor_id(boot_cpuid);
+
+	if (ireg[0] == hcpuid)
+		default_distrib_server = ireg[1];
+	else
+		default_distrib_server = ireg[3];
+
+	default_server = hcpuid;
 	of_node_put(np);
 
 	if (firmware_has_feature(FW_FEATURE_LPAR))
