Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id BFEB9DDE01
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Aug 2007 10:03:46 +1000 (EST)
Date: Sun, 26 Aug 2007 02:03:49 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH, RFC] linkstation: implement standby
Message-ID: <Pine.LNX.4.60.0708260157330.3809@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-pm@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Implement suspend/resume for "mpc10x" compatible fsl host PCI controllers, 
use it for linkstation standby.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

---

This requires patches from Scott Wood from this thread: 
http://ozlabs.org/pipermail/linuxppc-dev/2007-July/039109.html and my 
recent patch to implement wakeup from serial ports.

Thanks
Guennadi

 arch/powerpc/platforms/embedded6xx/linkstation.c |   57 +++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_soc.c                    |   44 +++++++++++++++++
 arch/powerpc/sysdev/fsl_soc.h                    |    6 ++
 include/asm-powerpc/mpc6xx.h                     |    2
 4 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index ab9e3f9..8ee0f0b 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -197,3 +197,60 @@ define_machine(linkstation){
 	.halt	 		= linkstation_halt,
 	.calibrate_decr 	= generic_calibrate_decr,
 };
+
+#ifdef CONFIG_PM
+
+#include <sysdev/fsl_soc.h>
+#include <asm/mpc6xx.h>
+
+static int ls_pm_valid(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static int ls_pm_enter(suspend_state_t state)
+{
+	char ier;
+	int ret = 0;
+	u64 tb;
+
+	if ((ret = mpc10x_suspend(state)) < 0)
+		return ret;
+
+	/* Get timebase */
+	tb = get_tb();
+
+	/* put CPU to sleep, re-enabling interrupts */
+	mpc6xx_enter_sleep();
+
+	local_irq_disable();
+
+	set_tb(tb >> 32, tb & 0xfffffffful);
+
+fail:
+	mpc10x_resume(state);
+
+	return ret;
+}
+
+static struct pm_ops ls_pm_ops = {
+	.valid		= ls_pm_valid,
+	.enter		= ls_pm_enter,
+};
+
+static int __init ls_pm_init(void)
+{
+	if (!machine_is(linkstation))
+		return 0;
+
+	pm_set_ops(&ls_pm_ops);
+	return 0;
+}
+
+device_initcall(ls_pm_init);
+#endif
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 727453d..c0d66df 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -1186,3 +1186,47 @@ err:
 arch_initcall(cpm_smc_uart_of_init);
 
 #endif /* CONFIG_8xx */
+
+#ifdef CONFIG_PM
+#include <linux/pci.h>
+#include <asm/pci-bridge.h>
+
+#define	MPC10X_LP_REF_EN	(1<<12)
+#define	MPC10X_PM		(1<<7)
+#define MPC10X_DOZE		(1<<5)
+#define	MPC10X_NAP		(1<<4)
+#define	MPC10X_SLEEP		(1<<3)
+
+int mpc10x_suspend(suspend_state_t state)
+{
+	struct pci_dev *bridge;
+	u16 pmcr1;
+
+	bridge = pci_find_slot(0, 0);
+	if (!bridge)
+		return -ENODEV;
+
+	pci_read_config_word(bridge, 0x70, &pmcr1);
+	pmcr1 &= ~(MPC10X_DOZE | MPC10X_NAP);
+	pmcr1 |= MPC10X_PM | MPC10X_SLEEP | MPC10X_LP_REF_EN;
+	pci_write_config_word(bridge, 0x70, pmcr1);
+
+	return 0;
+}
+
+int mpc10x_resume(suspend_state_t state)
+{
+	struct pci_dev *bridge;
+	u16 pmcr1;
+
+	bridge = pci_find_slot(0, 0);
+	if (!bridge)
+		return -ENODEV;
+
+	pci_read_config_word(bridge, 0x70, &pmcr1);
+	pmcr1 &= ~(MPC10X_PM | MPC10X_DOZE | MPC10X_SLEEP | MPC10X_NAP | MPC10X_LP_REF_EN);
+	pci_write_config_word(bridge, 0x70, pmcr1);
+
+	return 0;
+}
+#endif
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index 04e145b..bcb96cf 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -8,5 +8,11 @@ extern phys_addr_t get_immrbase(void);
 extern u32 get_brgfreq(void);
 extern u32 get_baudrate(void);
 
+#ifdef CONFIG_PM
+#include <linux/pm.h>
+extern int mpc10x_suspend(suspend_state_t state);
+extern int mpc10x_resume(suspend_state_t state);
+#endif
+
 #endif
 #endif
diff --git a/include/asm-powerpc/mpc6xx.h b/include/asm-powerpc/mpc6xx.h
index 01a33ed..be86967 100644
--- a/include/asm-powerpc/mpc6xx.h
+++ b/include/asm-powerpc/mpc6xx.h
@@ -1,6 +1,6 @@
 #ifndef __ASM_POWERPC_MPC6xx_H
 #define __ASM_POWERPC_MPC6xx_H
 
-void mpc6xx_enter_sleep(void);
+extern void mpc6xx_enter_sleep(void);
 
 #endif
