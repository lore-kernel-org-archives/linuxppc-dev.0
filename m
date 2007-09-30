Return-Path: <anton@ozlabs.org>
Date: Sun, 30 Sep 2007 16:45:55 -0500
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] fix xics set_affinity code
Message-ID: <20070930214555.GA21186@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On a POWER6 machine running 2.6.23-rc8 I sometimes see the following error:

xics_set_affinity: No online cpus in the mask 00000000,00000000,00000000,00000001 for irq 20

In a desperate attempt to get a changelog entry in 2.6.23, I took a look
into it.

It turns out we are passing a real and not a virtual irq into
get_irq_server. This works for the case where hwirq < NR_IRQS and we set
virq = hwirq. In my case however hwirq = 590082 and we try and access
irq_desc[590082], slightly past the end at 512 entries. 

Lucky we ship lots of memory with our machines.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
2.6.23 candidate? Am I too late?

diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
index 5bd90a7..f0b5ff1 100644
--- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -419,7 +419,7 @@ static void xics_set_affinity(unsigned int virq, cpumask_t cpumask)
 	 * For the moment only implement delivery to all cpus or one cpu.
 	 * Get current irq_server for the given irq
 	 */
-	irq_server = get_irq_server(irq, 1);
+	irq_server = get_irq_server(virq, 1);
 	if (irq_server == -1) {
 		char cpulist[128];
 		cpumask_scnprintf(cpulist, sizeof(cpulist), cpumask);
