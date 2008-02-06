Return-Path: <nfont@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 13370DE193
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 07:37:05 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m16Kb1dB032720
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 15:37:01 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m16KawxS157442
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 13:36:59 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m16KawZb014343
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 13:36:58 -0700
Received: from austin.ibm.com (netmail1.austin.ibm.com [9.41.248.175])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m16KawSN014321
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 13:36:58 -0700
Received: from [9.53.40.161] (dyn95340161.austin.ibm.com [9.53.40.161])
	by austin.ibm.com (8.13.8/8.12.10) with ESMTP id m16KavVW044090
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 14:36:58 -0600
Message-ID: <47AA1A8B.2060209@austin.ibm.com>
Date: Wed, 06 Feb 2008 14:37:31 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4] [POWERPC] Split xics_teardown_cpu()
Content-Type: multipart/mixed; boundary="------------030402000109070701070405"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030402000109070701070405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch splits off the kexec path bits of the xics_teardown_cpu()
routine into its own xics_kexec_teardown_cpu() routine.  With the
previous combined routine the CPPR for a cpu that is being removed may have its 
CPPR reset in the plpar_eoi() call (which explicitly sets the CPPR to a non-zero 
value).  Splitting of the kexec bits of the code prevents this from happening in
the cpu remove path.

Once again, this does not cause the cpu remove from the kernel to fail, but it 
does cause cpu dlpar operations to not be able to return the cpu to the hypervisor.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---


--------------030402000109070701070405
Content-Type: text/x-patch;
 name="kexec_teardown_cpu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kexec_teardown_cpu.patch"

Index: linux-2.6/arch/powerpc/platforms/pseries/hotplug-cpu.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/hotplug-cpu.c	2008-02-04 14:27:43.000000000 -0600
+++ linux-2.6/arch/powerpc/platforms/pseries/hotplug-cpu.c	2008-02-04 16:29:27.000000000 -0600
@@ -58,7 +58,7 @@
 {
 	local_irq_disable();
 	idle_task_exit();
-	xics_teardown_cpu(0);
+	xics_teardown_cpu();
 	unregister_slb_shadow(hard_smp_processor_id(), __pa(get_slb_shadow()));
 	rtas_stop_self();
 	/* Should never get here... */
Index: linux-2.6/arch/powerpc/platforms/pseries/kexec.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/kexec.c	2008-02-04 14:27:43.000000000 -0600
+++ linux-2.6/arch/powerpc/platforms/pseries/kexec.c	2008-02-04 16:29:46.000000000 -0600
@@ -54,7 +54,7 @@
 static void pseries_kexec_cpu_down_xics(int crash_shutdown, int secondary)
 {
 	pseries_kexec_cpu_down(crash_shutdown, secondary);
-	xics_teardown_cpu(secondary);
+	xics_kexec_teardown_cpu(secondary);
 }
 
 void __init setup_kexec_cpu_down_xics(void)
Index: linux-2.6/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/xics.c	2008-02-04 16:25:36.000000000 -0600
+++ linux-2.6/arch/powerpc/platforms/pseries/xics.c	2008-02-04 16:28:50.000000000 -0600
@@ -776,11 +776,9 @@
 }
 #endif /* CONFIG_SMP */
 
-void xics_teardown_cpu(int secondary)
+void xics_teardown_cpu()
 {
 	int cpu = smp_processor_id();
-	unsigned int ipi;
-	struct irq_desc *desc;
 
 	xics_set_cpu_priority(0);
 
@@ -791,9 +789,17 @@
 		lpar_qirr_info(cpu, 0xff);
 	else
 		direct_qirr_info(cpu, 0xff);
+}
+
+void xics_kexec_teardown_cpu(int secondary)
+{
+	unsigned int ipi;
+	struct irq_desc *desc;
+
+	xics_teardown_cpu();
 
 	/*
-	 * we need to EOI the IPI if we got here from kexec down IPI
+	 * we need to EOI the IPI
 	 *
 	 * probably need to check all the other interrupts too
 	 * should we be flagging idle loop instead?
Index: linux-2.6/arch/powerpc/platforms/pseries/xics.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/xics.h	2008-02-04 14:27:43.000000000 -0600
+++ linux-2.6/arch/powerpc/platforms/pseries/xics.h	2008-02-04 16:29:08.000000000 -0600
@@ -16,7 +16,8 @@
 
 extern void xics_init_IRQ(void);
 extern void xics_setup_cpu(void);
-extern void xics_teardown_cpu(int secondary);
+extern void xics_teardown_cpu(void);
+extern void xics_kexec_teardown_cpu(int secondary);
 extern void xics_cause_IPI(int cpu);
 extern  void xics_request_IPIs(void);
 extern void xics_migrate_irqs_away(void);

--------------030402000109070701070405--
