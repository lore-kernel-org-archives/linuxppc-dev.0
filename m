Return-Path: <nfont@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CB459DE1B9
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 07:37:06 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m16Kb34X019543
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 15:37:03 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m16Kb2qh178330
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 13:37:02 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m16Kb25r024338
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 13:37:02 -0700
Received: from austin.ibm.com (netmail1.austin.ibm.com [9.41.248.175])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m16Kb2UJ024325
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 13:37:02 -0700
Received: from [9.53.40.161] (dyn95340161.austin.ibm.com [9.53.40.161])
	by austin.ibm.com (8.13.8/8.12.10) with ESMTP id m16Kb1Ub035342
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 14:37:02 -0600
Message-ID: <47AA1A8F.3020704@austin.ibm.com>
Date: Wed, 06 Feb 2008 14:37:35 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/4][POWERPC] Remove redundant of_get_cpu_node routine
Content-Type: multipart/mixed; boundary="------------020902000106020702010003"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020902000106020702010003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

It appears that xics.c has its own of_get_cpu_node().  Remove this and use the 
common one from prom.c.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---

--------------020902000106020702010003
Content-Type: text/x-patch;
 name="of_get_cpu_node.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="of_get_cpu_node.patch"

Index: linux-2.6/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/xics.c	2008-02-06 11:31:44.000000000 -0600
+++ linux-2.6/arch/powerpc/platforms/pseries/xics.c	2008-02-06 11:34:34.000000000 -0600
@@ -658,31 +658,6 @@
 	set_irq_chained_handler(cascade, pseries_8259_cascade);
 }
 
-static struct device_node *cpuid_to_of_node(int cpu)
-{
-	struct device_node *np;
-	u32 hcpuid = get_hard_smp_processor_id(cpu);
-
-	for_each_node_by_type(np, "cpu") {
-		int i, len;
-		const u32 *intserv;
-
-		intserv = of_get_property(np, "ibm,ppc-interrupt-server#s",
-					&len);
-
-		if (!intserv)
-			intserv = of_get_property(np, "reg", &len);
-
-		i = len / sizeof(u32);
-
-		while (i--)
-			if (intserv[i] == hcpuid)
-				return np;
-	}
-
-	return NULL;
-}
-
 void __init xics_init_IRQ(void)
 {
 	int i, j;
@@ -711,7 +686,7 @@
 	xics_init_host();
 
 	/* Find the server numbers for the boot cpu. */
-	np = cpuid_to_of_node(boot_cpuid);
+	np = of_get_cpu_node(boot_cpuid, NULL);
 	BUG_ON(!np);
 	ireg = of_get_property(np, "ibm,ppc-interrupt-gserver#s", &ilen);
 	if (!ireg)

--------------020902000106020702010003--
