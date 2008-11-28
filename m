Return-Path: <arnd@arndb.de>
Message-Id: <20081128200325.075254354@arndb.de>
References: <20081128195120.869318403@arndb.de>
Date: Fri, 28 Nov 2008 20:51:23 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: [patch 3/4] powerpc/mpic: dont reset affinity for secondary MPIC on
	boot
Cc: paulus@samba.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kexec/kdump currently fails on the IBM QS2x blades when the kexec happens
on a CPU other than the initial boot CPU.  It turns out that this is the
result of mpic_init trying to set affinity of each interrupt vector to the
current boot CPU.

As far as I can tell,  the same problem is likely to exist on any
secondary MPIC, because they have to deliver interrupts to the first
output all the time. There are two potential solutions for this: either
not set up affinity at all for secondary MPICs, or assume that a single
CPU output is connected to the upstream interrupt controller and hardcode
affinity to that per architecture.

This patch implements the second approach, defaulting to the first output.
Currently, all known secondary MPICs are routed to their upstream port
using the first destination, so we hardcode that.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/sysdev/mpic.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index f6299cc..b24e1d0 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1271,6 +1271,7 @@ void __init mpic_set_default_senses(struct mpic *mpic, u8 *senses, int count)
 void __init mpic_init(struct mpic *mpic)
 {
 	int i;
+	int cpu;
 
 	BUG_ON(mpic->num_sources == 0);
 
@@ -1313,6 +1314,11 @@ void __init mpic_init(struct mpic *mpic)
 
 	mpic_pasemi_msi_init(mpic);
 
+	if (mpic->flags & MPIC_PRIMARY)
+		cpu = hard_smp_processor_id();
+	else
+		cpu = 0;
+
 	for (i = 0; i < mpic->num_sources; i++) {
 		/* start with vector = source number, and masked */
 		u32 vecpri = MPIC_VECPRI_MASK | i |
@@ -1323,8 +1329,7 @@ void __init mpic_init(struct mpic *mpic)
 			continue;
 		/* init hw */
 		mpic_irq_write(i, MPIC_INFO(IRQ_VECTOR_PRI), vecpri);
-		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
-			       1 << hard_smp_processor_id());
+		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION), 1 << cpu);
 	}
 	
 	/* Init spurious vector */
-- 
1.5.6.3

-- 
