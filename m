Return-Path: <nfont@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AB555DE0D4
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 07:37:11 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m16Kb8RN019724
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 15:37:08 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m16Kb7Sh079796
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 13:37:07 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m16Kb7D8024620
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 13:37:07 -0700
Received: from austin.ibm.com (netmail1.austin.ibm.com [9.41.248.175])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m16Kb61I024577
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 13:37:07 -0700
Received: from [9.53.40.161] (dyn95340161.austin.ibm.com [9.53.40.161])
	by austin.ibm.com (8.13.8/8.12.10) with ESMTP id m16Kb6gl009852
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 14:37:06 -0600
Message-ID: <47AA1A94.9070803@austin.ibm.com>
Date: Wed, 06 Feb 2008 14:37:40 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/4][POWERPC] Update default irq servers when boot cpu is
	removed
Content-Type: multipart/mixed; boundary="------------040101060108050208090904"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040101060108050208090904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The xics code does update the default server information when the boot cpu is 
removed.  This patches recognizes when the boot cpu is being removed and updates 
the appropriate information based on the new 'boot cpu'.

Failure to update this information can causes us to leave irqs pinned to cpus 
that are being removed, especially when removing the boot cpu.  The cpu is 
removed from the kernel, but cpu dlpar remove operations fail since we cannot
return the cpu to the hypervisor.

Signed-off-by: Nathan Fonteno <nfont@austin.ibm.com>
---

--------------040101060108050208090904
Content-Type: text/x-patch;
 name="gserver_update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gserver_update.patch"

Index: linux-2.6/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/xics.c	2008-02-06 11:34:34.000000000 -0600
+++ linux-2.6/arch/powerpc/platforms/pseries/xics.c	2008-02-06 13:28:25.000000000 -0600
@@ -160,6 +160,46 @@
 
 /* High level handlers and init code */
 
+static void xics_update_irq_servers(void)
+{
+	int i, j;
+	struct device_node *np;
+	u32 ilen;
+	const u32 *ireg, *isize;
+	u32 hcpuid;
+
+	/* Find the server numbers for the boot cpu. */
+	np = of_get_cpu_node(boot_cpuid, NULL);
+	BUG_ON(!np);
+
+	ireg = of_get_property(np, "ibm,ppc-interrupt-gserver#s", &ilen);
+	if (!ireg) {
+		of_node_put(np);
+		return;
+	}
+
+	i = ilen / sizeof(int);
+	hcpuid = get_hard_smp_processor_id(boot_cpuid);
+
+	/* Global interrupt distribution server is specified in the last
+	 * entry of "ibm,ppc-interrupt-gserver#s" property. Get the last
+	 * entry fom this property for current boot cpu id and use it as
+	 * default distribution server
+	 */
+	for (j = 0; j < i; j += 2) {
+		if (ireg[j] == hcpuid) {
+			default_server = hcpuid;
+			default_distrib_server = ireg[j+1];
+
+			isize = of_get_property(np,
+					"ibm,interrupt-server#-size", NULL);
+			if (isize)
+				interrupt_server_size = *isize;
+		}
+	}
+
+	of_node_put(np);
+}
 
 #ifdef CONFIG_SMP
 static int get_irq_server(unsigned int virq, unsigned int strict_check)
@@ -169,6 +209,9 @@
 	cpumask_t cpumask = irq_desc[virq].affinity;
 	cpumask_t tmp = CPU_MASK_NONE;
 
+	if (! cpu_isset(default_server, cpu_online_map))
+		xics_update_irq_servers();
+
 	if (!distribute_irqs)
 		return default_server;
 
@@ -660,12 +703,9 @@
 
 void __init xics_init_IRQ(void)
 {
-	int i, j;
 	struct device_node *np;
-	u32 ilen, indx = 0;
-	const u32 *ireg, *isize;
+	u32 indx = 0;
 	int found = 0;
-	u32 hcpuid;
 
 	ppc64_boot_msg(0x20, "XICS Init");
 
@@ -684,34 +724,7 @@
 		return;
 
 	xics_init_host();
-
-	/* Find the server numbers for the boot cpu. */
-	np = of_get_cpu_node(boot_cpuid, NULL);
-	BUG_ON(!np);
-	ireg = of_get_property(np, "ibm,ppc-interrupt-gserver#s", &ilen);
-	if (!ireg)
-		goto skip_gserver_check;
-	i = ilen / sizeof(int);
-	hcpuid = get_hard_smp_processor_id(boot_cpuid);
-
-	/* Global interrupt distribution server is specified in the last
-	 * entry of "ibm,ppc-interrupt-gserver#s" property. Get the last
-	 * entry fom this property for current boot cpu id and use it as
-	 * default distribution server
-	 */
-	for (j = 0; j < i; j += 2) {
-		if (ireg[j] == hcpuid) {
-			default_server = hcpuid;
-			default_distrib_server = ireg[j+1];
-
-			isize = of_get_property(np,
-					"ibm,interrupt-server#-size", NULL);
-			if (isize)
-				interrupt_server_size = *isize;
-		}
-	}
-skip_gserver_check:
-	of_node_put(np);
+	xics_update_irq_servers();
 
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		ppc_md.get_irq = xics_get_irq_lpar;

--------------040101060108050208090904--
