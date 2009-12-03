Return-Path: <markn@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EEEC6B7BBE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Dec 2009 16:04:37 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id nB354b80022552
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Dec 2009 16:04:37 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nB350uiI1216566
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Dec 2009 16:00:56 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nB354bxX010196
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Dec 2009 16:04:37 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.190.163.12])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	nB354bUF010193
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Dec 2009 16:04:37 +1100
Received: from ubrain.localnet (haven.au.ibm.com [9.190.164.82])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.au.ibm.com (Postfix) with ESMTP id ED46E7371F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Dec 2009 16:04:36 +1100 (EST)
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pseries: Track previous CPPR values to correctly EOI
	interrupts
Date: Thu, 3 Dec 2009 16:07:50 +1100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200912031607.50465.markn@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment when we EOI an interrupt we set the CPPR back to 0xFF
regardless of its previous value. This could lead to problems if we
take an interrupt with a priority of 5, but before EOIing it we get
an IPI which has a priority of 4. The problem is that at the moment
when we EOI the IPI we will set the CPPR to 0xFF, but it should
really be set back to 5 (the previous priority).

To keep track of the previous CPPR values we create the xics_cppr
structure that has an array for CPPR values and an index pointing
to the current priority. This can easily grow if new priorities get
added in the future.

This will also be useful because the partition adjunct option of
upcoming machines will update the H_XIRR hcall to accept the CPPR
as a parameter.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
---
 arch/powerpc/platforms/pseries/xics.c |   48 ++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 5 deletions(-)

Index: upstream/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- upstream.orig/arch/powerpc/platforms/pseries/xics.c
+++ upstream/arch/powerpc/platforms/pseries/xics.c
@@ -20,6 +20,7 @@
 #include <linux/cpu.h>
 #include <linux/msi.h>
 #include <linux/of.h>
+#include <linux/percpu.h>
 
 #include <asm/firmware.h>
 #include <asm/io.h>
@@ -46,6 +47,12 @@ static struct irq_host *xics_host;
  */
 #define IPI_PRIORITY		4
 
+/* The least favored priority */
+#define LOWEST_PRIORITY		0xFF
+
+/* The number of priorities defined above */
+#define MAX_NUM_PRIORITIES	3
+
 static unsigned int default_server = 0xFF;
 static unsigned int default_distrib_server = 0;
 static unsigned int interrupt_server_size = 8;
@@ -56,6 +63,12 @@ static int ibm_set_xive;
 static int ibm_int_on;
 static int ibm_int_off;
 
+struct xics_cppr {
+	unsigned char stack[MAX_NUM_PRIORITIES];
+	int index;
+};
+
+static DEFINE_PER_CPU(struct xics_cppr, xics_cppr);
 
 /* Direct hardware low level accessors */
 
@@ -284,6 +297,16 @@ static inline unsigned int xics_xirr_vec
 	return xirr & 0x00ffffff;
 }
 
+static void get_irq_update_cppr(unsigned int vec)
+{
+	struct xics_cppr *os_cppr = &__get_cpu_var(xics_cppr);
+
+	if (vec == XICS_IPI)
+		os_cppr->stack[++os_cppr->index] = IPI_PRIORITY;
+	else
+		os_cppr->stack[++os_cppr->index] = DEFAULT_PRIORITY;
+}
+
 static unsigned int xics_get_irq_direct(void)
 {
 	unsigned int xirr = direct_xirr_info_get();
@@ -294,8 +317,10 @@ static unsigned int xics_get_irq_direct(
 		return NO_IRQ;
 
 	irq = irq_radix_revmap_lookup(xics_host, vec);
-	if (likely(irq != NO_IRQ))
+	if (likely(irq != NO_IRQ)) {
+		get_irq_update_cppr(vec);
 		return irq;
+	}
 
 	/* We don't have a linux mapping, so have rtas mask it. */
 	xics_mask_unknown_vec(vec);
@@ -315,8 +340,10 @@ static unsigned int xics_get_irq_lpar(vo
 		return NO_IRQ;
 
 	irq = irq_radix_revmap_lookup(xics_host, vec);
-	if (likely(irq != NO_IRQ))
+	if (likely(irq != NO_IRQ)) {
+		get_irq_update_cppr(vec);
 		return irq;
+	}
 
 	/* We don't have a linux mapping, so have RTAS mask it. */
 	xics_mask_unknown_vec(vec);
@@ -326,12 +353,19 @@ static unsigned int xics_get_irq_lpar(vo
 	return NO_IRQ;
 }
 
+static unsigned char eoi_update_and_get_cppr(void)
+{
+	struct xics_cppr *os_cppr = &__get_cpu_var(xics_cppr);
+
+	return os_cppr->stack[--os_cppr->index];
+}
+
 static void xics_eoi_direct(unsigned int virq)
 {
 	unsigned int irq = (unsigned int)irq_map[virq].hwirq;
 
 	iosync();
-	direct_xirr_info_set((0xff << 24) | irq);
+	direct_xirr_info_set((eoi_update_and_get_cppr() << 24) | irq);
 }
 
 static void xics_eoi_lpar(unsigned int virq)
@@ -339,7 +373,7 @@ static void xics_eoi_lpar(unsigned int v
 	unsigned int irq = (unsigned int)irq_map[virq].hwirq;
 
 	iosync();
-	lpar_xirr_info_set((0xff << 24) | irq);
+	lpar_xirr_info_set((eoi_update_and_get_cppr() << 24) | irq);
 }
 
 static int xics_set_affinity(unsigned int virq, const struct cpumask *cpumask)
@@ -746,6 +780,10 @@ void __init xics_init_IRQ(void)
 
 static void xics_set_cpu_priority(unsigned char cppr)
 {
+	struct xics_cppr *os_cppr = &__get_cpu_var(xics_cppr);
+	os_cppr->index = 0;
+	os_cppr->stack[os_cppr->index] = cppr;
+
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		lpar_cppr_info(cppr);
 	else
@@ -772,7 +810,7 @@ static void xics_set_cpu_giq(unsigned in
 
 void xics_setup_cpu(void)
 {
-	xics_set_cpu_priority(0xff);
+	xics_set_cpu_priority(LOWEST_PRIORITY);
 
 	xics_set_cpu_giq(default_distrib_server, 1);
 }
