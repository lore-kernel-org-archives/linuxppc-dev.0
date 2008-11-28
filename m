Return-Path: <arnd@arndb.de>
Message-Id: <20081128200325.240671747@arndb.de>
References: <20081128195120.869318403@arndb.de>
Date: Fri, 28 Nov 2008 20:51:24 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: [patch 4/4] powerpc/cell: fix GDB watchpoints, again
Cc: paulus@samba.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

An earlier patch from Jens Osterkamp attempted to fix GDB
watchpoints by enabling the DABRX register at boot time.
Unfortunately, this did not work on SMP setups, where
secondary CPUs were still using the power-on DABRX value.

This introduces the same change for secondary CPUs on cell
as well.

Reported-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Tested-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/smp.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/smp.c b/arch/powerpc/platforms/cell/smp.c
index c0d86e1..9046803 100644
--- a/arch/powerpc/platforms/cell/smp.c
+++ b/arch/powerpc/platforms/cell/smp.c
@@ -129,10 +129,15 @@ static int __init smp_iic_probe(void)
 	return cpus_weight(cpu_possible_map);
 }
 
-static void __devinit smp_iic_setup_cpu(int cpu)
+static void __devinit smp_cell_setup_cpu(int cpu)
 {
 	if (cpu != boot_cpuid)
 		iic_setup_cpu();
+
+	/*
+	 * change default DABRX to allow user watchpoints
+	 */
+	mtspr(SPRN_DABRX, DABRX_KERNEL | DABRX_USER);
 }
 
 static DEFINE_SPINLOCK(timebase_lock);
@@ -192,7 +197,7 @@ static struct smp_ops_t bpa_iic_smp_ops = {
 	.message_pass	= smp_iic_message_pass,
 	.probe		= smp_iic_probe,
 	.kick_cpu	= smp_cell_kick_cpu,
-	.setup_cpu	= smp_iic_setup_cpu,
+	.setup_cpu	= smp_cell_setup_cpu,
 	.cpu_bootable	= smp_cell_cpu_bootable,
 };
 
-- 
1.5.6.3

-- 
