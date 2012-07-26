Return-Path: <paulus@ozlabs.org>
Date: Fri, 27 Jul 2012 09:53:47 +1000
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: powernv: Always go into nap mode when CPU is offline
Message-ID: <20120726235347.GA16461@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The CPU hotplug code for the powernv platform currently only puts
offline CPUs into nap mode if the powersave_nap variable is set.
However, HV-style KVM on this platform requires secondary CPU threads
to be offline and in nap mode.  Since we know nap mode works just
fine on all POWER7 machines, and the only machines that support the
powernv platform are POWER7 machines, this changes the code to
always put offline CPUs into nap mode, regardless of powersave_nap.
Powersave_nap still controls whether or not CPUs go into nap mode
when idle, as before.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/processor.h |    1 +
 arch/powerpc/kernel/idle_power7.S    |    2 ++
 arch/powerpc/platforms/powernv/smp.c |   10 +---------
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 2a25ab0..42d3869 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -390,6 +390,7 @@ enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
 
 extern int powersave_nap;	/* set if nap mode can be used in idle loop */
 void cpu_idle_wait(void);
+extern void power7_nap(void);
 
 #ifdef CONFIG_PSERIES_IDLE
 extern void update_smt_snooze_delay(int snooze);
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index 7140d83..e11863f 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -28,7 +28,9 @@ _GLOBAL(power7_idle)
 	lwz	r4,ADDROFF(powersave_nap)(r3)
 	cmpwi	0,r4,0
 	beqlr
+	/* fall through */
 
+_GLOBAL(power7_nap)
 	/* NAP is a state loss, we create a regs frame on the
 	 * stack, fill it up with the state we care about and
 	 * stick a pointer to it in PACAR1. We really only
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 3ef4625..7698b6e 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -106,14 +106,6 @@ static void pnv_smp_cpu_kill_self(void)
 {
 	unsigned int cpu;
 
-	/* If powersave_nap is enabled, use NAP mode, else just
-	 * spin aimlessly
-	 */
-	if (!powersave_nap) {
-		generic_mach_cpu_die();
-		return;
-	}
-
 	/* Standard hot unplug procedure */
 	local_irq_disable();
 	idle_task_exit();
@@ -128,7 +120,7 @@ static void pnv_smp_cpu_kill_self(void)
 	 */
 	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1);
 	while (!generic_check_cpu_restart(cpu)) {
-		power7_idle();
+		power7_nap();
 		if (!generic_check_cpu_restart(cpu)) {
 			DBG("CPU%d Unexpected exit while offline !\n", cpu);
 			/* We may be getting an IPI, so we re-enable
-- 
1.7.10.rc3.219.g53414
