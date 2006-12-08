Return-Path: <mohan@in.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B4C6A67B5F
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 15:55:45 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB84tgtx018122
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Dec 2006 23:55:42 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB84tgZq475918
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Dec 2006 21:55:42 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB84tgsv022930
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Dec 2006 21:55:42 -0700
Date: Fri, 8 Dec 2006 10:25:37 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] Fix interrupt distribution in ppc970
Message-ID: <20061208045537.GA14626@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: fastboot@lists.osdl.org
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

We have encountered a strange problem with kdump in ppc970 based
machines. When a kdump kernel is booted with maxcpus=1 parameter,
interrupt is distributed to non-existent cpus also. It created lot of
interrupt missing problems.

This problem can be resolved by passing the additional kernel parameter
"noirqdistrib", which uses boot cpu id as interrupt distribution server.

To overcome this problem, I have created the patch, which
checks for the condition if the machine is ppc970 based and maxcpus
kernel parameter is specified. If the condition is met, the default
distribution server is assigned to be current boot cpu instead of
assigning from the gserver#s property.

Tested on PPC970 based box and POWER5 based box.

Any comment, feedback?

Patch is generated over 2.6.19-git7.


o Kdump with maxcpus kernel parameter in PPC970xx creates interrupt
  distribution problem, so set default distribution server to the
  current cpu (i.e. boot cpu)

Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>

---
 arch/powerpc/platforms/pseries/xics.c |   35 +++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

Index: linux-2.6.19-git7/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-2.6.19-git7.orig/arch/powerpc/platforms/pseries/xics.c
+++ linux-2.6.19-git7/arch/powerpc/platforms/pseries/xics.c
@@ -680,6 +680,27 @@ static struct device_node *cpuid_to_of_n
 	return NULL;
 }
 
+static int is_processor_970(void)
+{
+	unsigned long rval;
+	int rc;
+	rval = PVR_VER(mfspr(SPRN_PVR));
+
+	switch(rval) {
+		case PV_970:
+		case PV_970FX:
+		case PV_970MP:
+		case PV_970GX:
+			rc = 1;
+			break;
+		default:
+			rc = 0;
+			break;
+	}
+
+	return rc;
+}
+
 void __init xics_init_IRQ(void)
 {
 	int i, j;
@@ -688,6 +709,7 @@ void __init xics_init_IRQ(void)
 	const u32 *ireg, *isize;
 	int found = 0;
 	u32 hcpuid;
+	int fix_970_intr_distrib = 0;
 
 	ppc64_boot_msg(0x20, "XICS Init");
 
@@ -707,6 +729,13 @@ void __init xics_init_IRQ(void)
 
 	xics_init_host();
 
+	/* Kdump with maxcpus kernel parameter in PPC970xx creates interrupt
+	 * distribution problem, so set default distribution server to the
+	 * current cpu (i.e. boot cpu)
+	 */
+	if (strstr(saved_command_line, "maxcpus=") && is_processor_970())
+		fix_970_intr_distrib = 1;
+
 	/* Find the server numbers for the boot cpu. */
 	np = cpuid_to_of_node(boot_cpuid);
 	BUG_ON(!np);
@@ -724,7 +753,11 @@ void __init xics_init_IRQ(void)
 	for (j = 0; j < i; j += 2) {
 		if (ireg[j] == hcpuid) {
 			default_server = hcpuid;
-			default_distrib_server = ireg[j+1];
+
+			if (fix_970_intr_distrib)
+				default_distrib_server = hcpuid;
+			else
+				default_distrib_server = ireg[j+1];
 
 			isize = get_property(np,
 					"ibm,interrupt-server#-size", NULL);
