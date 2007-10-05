Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 03190DDDE4
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Oct 2007 13:52:41 +1000 (EST)
Date: Fri, 5 Oct 2007 13:52:41 +1000
To: Paul Mackerras <paulus@samba.org>, LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: Fix regression.  Make hot unlplug of CPU0 work again.
Message-ID: <20071005035241.GO9814@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
From: tony@bakeyournoodle.com (Tony Breeds)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Early in the 2.6.23 cycle we broke the ability to offline cpu0
(7ccb4a662462616f6be5053e26b79580e02f1529).  This patch fixes that by
ensuring that the (xics)  default irq server, will not be 0 when taking
cpu0 offline.

Also catches a use of irq, when virq should be used (I think that the
last one).

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

---

Unless there is a problem with this patch, it'd be nice to get it into
2.6.23 :)

 arch/powerpc/platforms/pseries/xics.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
index f0b5ff1..2fb8fd0 100644
--- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -837,6 +837,15 @@ void xics_migrate_irqs_away(void)
 	/* Allow IPIs again... */
 	xics_set_cpu_priority(cpu, DEFAULT_PRIORITY);
 
+	/* It would be bad to migrate any IRQs to the CPU we're taking down */
+	if (default_server == cpu) {
+		unsigned int new_server = first_cpu(cpu_online_map);
+
+		default_server = get_hard_smp_processor_id(new_server);
+		printk(KERN_WARNING "%s: default server was %d, reset to %d\n",
+		       __func__, cpu, default_server);
+	}
+
 	for_each_irq(virq) {
 		struct irq_desc *desc;
 		int xics_status[2];
@@ -882,7 +891,7 @@ void xics_migrate_irqs_away(void)
 
 		/* Reset affinity to all cpus */
 		desc->chip->set_affinity(virq, CPU_MASK_ALL);
-		irq_desc[irq].affinity = CPU_MASK_ALL;
+		irq_desc[virq].affinity = CPU_MASK_ALL;
 unlock:
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
