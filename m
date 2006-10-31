Return-Path: <mohan@in.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 428ED67BD4
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 22:05:24 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9VB5LLK023473
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 06:05:21 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9VB5L4M363162
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 04:05:21 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9VB5KtF004452
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 04:05:20 -0700
Date: Tue, 31 Oct 2006 16:35:15 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [RFC] Fix for interrupt distribution
Message-ID: <20061031110515.GB7884@in.ibm.com>
References: <20061030180446.GA24307@in.ibm.com>
	<20061030181751.GI17168@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061030181751.GI17168@localdomain>
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

On Mon, Oct 30, 2006 at 12:17:51PM -0600, Nathan Lynch wrote:
> Mohan Kumar M wrote:
> > Hello,
> > 
> > When kdump kernel is booted with the parameter "maxcpus=1" on a threaded
> > CPU, we faced some interrupt routing problems.
> > 
> > In the xics initialization code, "reg" property in each cpu node
> > (device-tree/cpus/PowerPC,POWER5@x) is used to match the current boot
> > cpu id and based on that "default_server" and "default_distrib_server"
> > are calculated. This condition will always meet when OF chooses CPU0 as
> > boot cpu or crash happenes on any cpu whose id is any physical cpu id.
> > 
> > The "reg" property in cpu node gives the id of the cpu and this cpu node
> > is created only for physical cpus (not for logical/threaded cpus). The
> > code compares the "reg" value to the current boot cpu id and if it
> > matches then only it reads "ibm,ppc-interrupt-gserver#s" and assigns the
> > last value of it (which is usually 0xff) to default_distrib_server. So
> > when a crash occurs on CPU 3, it will not be able to match the condition
> > and thus default_distrib_server is left as zero only. This makes all
> > interrupts routed to cpu 0 but cpu 0 is not up because of "maxcpus=1"
> > parameter.
> > 
> > To overcome this, I have just added one more condition to check the
> > above condition. I have attached the patch also. Patch is generated over
> > 2.6.19-rc3.
> > 
> > One more idea will be instead of using "reg" property in each cpu node,
> > can we use "ibm,ppc-interrupt-gserver#s" to determine the distribution
> > server? "ibm,ppc-interrupt-gserver#s" format is (please correct
> > if I am wrong) 
> > 	phys_cpu_id distrib_server logical_cpu_id distrib_server
> 
> Firmware has no notion of Linux's logical cpu numbering.
> 
>

I have created a patch based on "ibm,ppc-interrupt-gserver#s" property.

Attached patch uses "ibm,ppc-interrupt-gserver#s" property to match the
boot cpu id with available cpu ids. The property
"ibm,ppc-interrupt-gserver#" is encoded as a list of server# and
gserver#s pairs. The first integer specifies a single processor server#
as presented in "ibm,ppc-interrupt-server#s" property and followed by
distribution server. So if a match is found, corresponding server# is
taken as default server and the corresponding gserver# is taken as
default distribution server.

In a Dual core SMT enabled system, "ibm,ppc-interrupt-gserver#s" for
PowerPC,POWER5@2 will be:

        00000002 000000ff 00000003 000000ff
         ^ cpu id
                  ^ distribution server
                              ^ cpu id
                                       ^ distribution server

Tested on a POWER5 box.

Patch is generated over 2.6.19-rc3


Allow any cpu to become boot cpu.

Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
---
 arch/powerpc/platforms/pseries/xics.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

Index: linux-2.6.19-rc3/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-2.6.19-rc3.orig/arch/powerpc/platforms/pseries/xics.c
+++ linux-2.6.19-rc3/arch/powerpc/platforms/pseries/xics.c
@@ -658,7 +658,7 @@ static void __init xics_setup_8259_casca
 
 void __init xics_init_IRQ(void)
 {
-	int i;
+	int i, j;
 	struct device_node *np;
 	u32 ilen, indx = 0;
 	const u32 *ireg;
@@ -686,23 +686,23 @@ void __init xics_init_IRQ(void)
 	for (np = of_find_node_by_type(NULL, "cpu");
 	     np;
 	     np = of_find_node_by_type(np, "cpu")) {
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
+		ireg = get_property(np, "ibm,ppc-interrupt-gserver#s", &ilen);
+		i = ilen / sizeof(int);
+		for (j = 0; ireg[j] && j < i; j+=2) {
+			if (ireg[j] == get_hard_smp_processor_id(boot_cpuid)) {
+				if ( j + 1 < i) {
+					default_server = ireg[j];
+					default_distrib_server = ireg[j+1];
+				}
+				ireg = get_property(np,
 					"ibm,interrupt-server#-size", NULL);
-			if (ireg)
-				interrupt_server_size = *ireg;
-			break;
+				if (ireg)
+					interrupt_server_size = *ireg;
+				goto out;
+			}
 		}
 	}
+out:
 	of_node_put(np);
 
 	if (firmware_has_feature(FW_FEATURE_LPAR))
