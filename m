Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org, kexec@lists.infradead.org,
	Max Krasnyansky <maxk@qualcomm.com>, paulus@samba.org,
	benh@kernel.crashing.org
Subject: [PATCH] powerpc/mpic: don't reset affinity for secondary MPIC on boot
Date: Wed, 19 Nov 2008 14:50:58 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200811191450.59361.arnd@arndb.de>
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
not set up affinity at all for secondary MPICs, or assume that CPU
output 0 is connected to the upstream interrupt controller and hardcode
affinity to that.

This patch implements the first approach, because it can work on
machines that have a secondary controller that needs to deliver
interrupts to a destination other than CPU 0. The disadvantage
is that it requires the system to set up the affinity register
correctly on bootup.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---
Index: linux-2.6/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/mpic.c
+++ linux-2.6/arch/powerpc/sysdev/mpic.c
@@ -1323,8 +1323,9 @@ void __init mpic_init(struct mpic *mpic)
 			continue;
 		/* init hw */
 		mpic_irq_write(i, MPIC_INFO(IRQ_VECTOR_PRI), vecpri);
-		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
-			       1 << hard_smp_processor_id());
+		if (mpic->flags & MPIC_PRIMARY)
+			mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
+				       1 << hard_smp_processor_id());
 	}
 	
 	/* Init spurious vector */
