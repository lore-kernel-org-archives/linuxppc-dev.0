Return-Path: <bigeasy@www.tglx.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BC4CEDDDF0
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jun 2009 06:20:43 +1000 (EST)
Date: Wed, 3 Jun 2009 21:54:29 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] powerpc/mpc85xx: add support for suspend mode
Message-ID: <20090603195429.GA31269@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for the MPC85xx boards to enter the SLEEP mode.
The wake up is done via an external interrupt.
mpc85xx_enter_sleep() does not clear HID0_SLEEP in resume but it may be
okay since it gets cleared on next NAP/DOZE.
mpc85xx_enter_sleep() is mostly copied from NAP/DOZE. It does not look
like it is worth to merge into e500_idle(). I removed the feature check
for NAP/DOZE because it does not look required. It is just there to work
around the BDI. If it is required it could be moved to
mpc85xx_init_suspend().
The suspend.c file contains a sample implementation. I need additionally
to add hooks prio and after mpc85xx_enter_sleep() to toggle a few bits
in my FPGA. Since the suspend.c is really short I'm not sure if it is
worth to keep it here and add couple function prototypes or add the
required bits directly into the board code.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/Kconfig                  |    2 +-
 arch/powerpc/kernel/idle_e500.S       |   43 +++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/Makefile  |    1 +
 arch/powerpc/platforms/85xx/suspend.c |   27 ++++++++++++++++++++
 4 files changed, 72 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/suspend.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ff75539..80e3f6e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -215,7 +215,7 @@ config ARCH_HIBERNATION_POSSIBLE
 
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
-	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx
+	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx || PPC_85xx
 
 config PPC_DCR_NATIVE
 	bool
diff --git a/arch/powerpc/kernel/idle_e500.S b/arch/powerpc/kernel/idle_e500.S
index 47a1a98..185f807 100644
--- a/arch/powerpc/kernel/idle_e500.S
+++ b/arch/powerpc/kernel/idle_e500.S
@@ -92,3 +92,46 @@ _GLOBAL(power_save_ppc32_restore)
 #endif
 
 	b	transfer_to_handler_cont
+
+_GLOBAL(mpc85xx_enter_sleep)
+
+	rlwinm	r3,r1,0,0,31-THREAD_SHIFT	/* current thread_info */
+	lwz	r4,TI_LOCAL_FLAGS(r3)	/* set napping bit */
+	ori	r4,r4,_TLF_SLEEPING	/* so when we take an exception */
+	stw	r4,TI_LOCAL_FLAGS(r3)	/* it will return to our caller */
+
+	stwu	r1, -16(r1)
+	mflr	r0
+	stw	r0, 20(r1)
+	bl	flush_dcache_L1
+	lwz	r0, 20(r1)
+	addi	r1, r1, 16
+	mtlr	r0
+	lis	r3, HID0_SLEEP@h
+
+BEGIN_FTR_SECTION
+	msync
+	li	r7, L2CSR0_L2FL@l
+	mtspr	SPRN_L2CSR0, r7
+2:
+	mfspr	r7, SPRN_L2CSR0
+	andi.	r4, r7, L2CSR0_L2FL@l
+	bne	2b
+END_FTR_SECTION_IFSET(CPU_FTR_L2CSR)
+1:
+	/* Go to SLEEP now */
+	mfspr	r4, SPRN_HID0
+	rlwinm	r4, r4, 0, ~(HID0_DOZE|HID0_NAP|HID0_SLEEP)
+	or	r4, r4, r3
+	isync
+	mtspr	SPRN_HID0,r4
+	isync
+
+	mfmsr	r7
+	oris	r7,r7,MSR_WE@h
+	ori	r7,r7,MSR_EE
+	msync
+	mtmsr	r7
+	isync
+2:
+	b       2b
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index a857b35..e2ae7d1 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_SBC8560)     += sbc8560.o
 obj-$(CONFIG_SBC8548)     += sbc8548.o
 obj-$(CONFIG_SOCRATES)    += socrates.o socrates_fpga_pic.o
 obj-$(CONFIG_KSI8560)	  += ksi8560.o
+obj-$(CONFIG_SUSPEND)	  += suspend.o
diff --git a/arch/powerpc/platforms/85xx/suspend.c b/arch/powerpc/platforms/85xx/suspend.c
new file mode 100644
index 0000000..b6507d0
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/suspend.c
@@ -0,0 +1,27 @@
+#include <linux/suspend.h>
+
+void mpc85xx_enter_sleep(void);
+static int mpc85xx_suspend_valid(suspend_state_t state)
+{
+	switch (state) {
+		case PM_SUSPEND_STANDBY:
+			return 1;
+	}
+	return 0;
+}
+
+static int mpc85xx_suspend_enter(suspend_state_t state)
+{
+	mpc85xx_enter_sleep();
+}
+
+static struct platform_suspend_ops mpc85xx_pm_ops = {
+	.valid = mpc85xx_suspend_valid,
+	.enter = mpc85xx_suspend_enter,
+};
+
+int mpc85xx_init_suspend(void)
+{
+	suspend_set_ops(&mpc85xx_pm_ops);
+	return 0;
+}
-- 
1.6.0.6
