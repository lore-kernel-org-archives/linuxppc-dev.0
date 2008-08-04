Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id BE82FDE06E
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Aug 2008 23:58:10 +1000 (EST)
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] powerpc - Initialize the irq radix tree earlier
Date: Mon,  4 Aug 2008 13:08:42 +0200
Message-Id: <1217848124-3719-2-git-send-email-sebastien.dugue@bull.net>
In-Reply-To: <1217848124-3719-1-git-send-email-sebastien.dugue@bull.net>
References: <1217848124-3719-1-git-send-email-sebastien.dugue@bull.net>
Cc: tinytim@us.ibm.com, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	jean-pierre.dion@bull.net,
	Sebastien Dugue <sebastien.dugue@bull.net>, paulus@samba.org,
	gilles.carry@ext.bull.net, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  The radix tree used for fast irq reverse mapping by the XICS is initialized
late in the boot process, after the first interrupt (IPI) gets registered
and after the first IPI is received.

  This patch moves the initialization of the XICS radix tree earlier into
the boot process in smp_xics_probe() (the mm is already up but no interrupts
have been registered at that point) to avoid having to insert a mapping into
the tree in interrupt context. This will help in simplifying the locking
constraints and move to a lockless radix tree in subsequent patches.


Signed-off-by: Sebastien Dugue <sebastien.dugue@bull.net>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/irq.c             |   17 -----------------
 arch/powerpc/platforms/pseries/smp.c  |    1 +
 arch/powerpc/platforms/pseries/xics.c |    5 +++++
 arch/powerpc/platforms/pseries/xics.h |    1 +
 4 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index d972dec..9bef9f3 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -1016,23 +1016,6 @@ void irq_early_init(void)
 		get_irq_desc(i)->status |= IRQ_NOREQUEST;
 }
 
-/* We need to create the radix trees late */
-static int irq_late_init(void)
-{
-	struct irq_host *h;
-	unsigned long flags;
-
-	irq_radix_wrlock(&flags);
-	list_for_each_entry(h, &irq_hosts, link) {
-		if (h->revmap_type == IRQ_HOST_MAP_TREE)
-			INIT_RADIX_TREE(&h->revmap_data.tree, GFP_ATOMIC);
-	}
-	irq_radix_wrunlock(flags);
-
-	return 0;
-}
-arch_initcall(irq_late_init);
-
 #ifdef CONFIG_VIRQ_DEBUG
 static int virq_debug_show(struct seq_file *m, void *private)
 {
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 9d8f8c8..3d4429a 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -130,6 +130,7 @@ static void smp_xics_message_pass(int target, int msg)
 
 static int __init smp_xics_probe(void)
 {
+	xics_radix_revmap_init();
 	xics_request_IPIs();
 
 	return cpus_weight(cpu_possible_map);
diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
index 0fc830f..d6e28f9 100644
--- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -556,6 +556,11 @@ static struct irq_host_ops xics_host_ops = {
 	.xlate = xics_host_xlate,
 };
 
+void __init xics_radix_revmap_init(void)
+{
+	INIT_RADIX_TREE(&xics_host->revmap_data.tree, GFP_ATOMIC);
+}
+
 static void __init xics_init_host(void)
 {
 	if (firmware_has_feature(FW_FEATURE_LPAR))
diff --git a/arch/powerpc/platforms/pseries/xics.h b/arch/powerpc/platforms/pseries/xics.h
index 1c5321a..11490be 100644
--- a/arch/powerpc/platforms/pseries/xics.h
+++ b/arch/powerpc/platforms/pseries/xics.h
@@ -19,6 +19,7 @@ extern void xics_setup_cpu(void);
 extern void xics_teardown_cpu(void);
 extern void xics_kexec_teardown_cpu(int secondary);
 extern void xics_cause_IPI(int cpu);
+extern void xics_radix_revmap_init(void);
 extern  void xics_request_IPIs(void);
 extern void xics_migrate_irqs_away(void);
 
-- 
1.5.5.1
