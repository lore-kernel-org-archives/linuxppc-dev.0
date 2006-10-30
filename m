Return-Path: <mohan@in.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D0D2467DA0
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 05:05:11 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9UI57xN005306
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Oct 2006 13:05:07 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9UI4wmH078472
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Oct 2006 13:05:02 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9UI4wIE015325
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Oct 2006 13:04:58 -0500
Date: Mon, 30 Oct 2006 23:34:46 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: linuxppc-dev@ozlabs.org, fastboot@lists.osdl.org
Subject: [RFC] Fix for interrupt distribution
Message-ID: <20061030180446.GA24307@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: anton@samba.org
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

When kdump kernel is booted with the parameter "maxcpus=1" on a threaded
CPU, we faced some interrupt routing problems.

In the xics initialization code, "reg" property in each cpu node
(device-tree/cpus/PowerPC,POWER5@x) is used to match the current boot
cpu id and based on that "default_server" and "default_distrib_server"
are calculated. This condition will always meet when OF chooses CPU0 as
boot cpu or crash happenes on any cpu whose id is any physical cpu id.

The "reg" property in cpu node gives the id of the cpu and this cpu node
is created only for physical cpus (not for logical/threaded cpus). The
code compares the "reg" value to the current boot cpu id and if it
matches then only it reads "ibm,ppc-interrupt-gserver#s" and assigns the
last value of it (which is usually 0xff) to default_distrib_server. So
when a crash occurs on CPU 3, it will not be able to match the condition
and thus default_distrib_server is left as zero only. This makes all
interrupts routed to cpu 0 but cpu 0 is not up because of "maxcpus=1"
parameter.

To overcome this, I have just added one more condition to check the
above condition. I have attached the patch also. Patch is generated over
2.6.19-rc3.

One more idea will be instead of using "reg" property in each cpu node,
can we use "ibm,ppc-interrupt-gserver#s" to determine the distribution
server? "ibm,ppc-interrupt-gserver#s" format is (please correct
if I am wrong) 
	phys_cpu_id distrib_server logical_cpu_id distrib_server

In a Dual core SMT enabled system, "ibm,ppc-interrupt-gserver#s" will
be: 

	00000002 000000ff 00000003 000000ff
	 ^ phys cpu id
        	  ^ distribution server
                	      ^ logical cpu id
                        	       ^ distribution server

Tested on POWER5 box.

Since POWER4 does not have SMT, crash can happen on any CPU and kdump
kernel can boot with "maxcpus=1" without any problem.



Allow any cpu to become boot cpu.

Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
---

Index: test/linux-2.6.19-rc3/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- test.orig/linux-2.6.19-rc3/arch/powerpc/platforms/pseries/xics.c
+++ test/linux-2.6.19-rc3/arch/powerpc/platforms/pseries/xics.c
@@ -687,7 +687,8 @@ void __init xics_init_IRQ(void)
 	     np;
 	     np = of_find_node_by_type(np, "cpu")) {
 		ireg = get_property(np, "reg", &ilen);
-		if (ireg && ireg[0] == get_hard_smp_processor_id(boot_cpuid)) {
+		if (ireg && ((ireg[0] == get_hard_smp_processor_id(boot_cpuid))
+		  || (ireg[0] == get_hard_smp_processor_id(boot_cpuid) - 1))) {
 			ireg = get_property(np,
 					"ibm,ppc-interrupt-gserver#s", &ilen);
 			i = ilen / sizeof(int);
