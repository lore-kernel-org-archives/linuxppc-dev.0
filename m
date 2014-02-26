Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7189F2C057B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 11:12:44 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 19:12:41 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id E6D3138C8045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 19:12:38 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1Q0CcL261145264
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 00:12:38 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1Q0Cbe0030226
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 19:12:38 -0500
Subject: [PATCH 5/7] powermgt: Add OPAL call to resync timebase on wakeup
To: linux-pm@vger.kernel.org, geoff@infradead.org, fweisbec@gmail.com,
 daniel.lezcano@linaro.org, srivatsa.bhat@linux.vnet.ibm.com,
 benh@kernel.crashing.org, tglx@linutronix.de,
 svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Wed, 26 Feb 2014 05:38:43 +0530
Message-ID: <20140226000843.17879.45687.stgit@preeti>
In-Reply-To: <20140226000310.17879.67295.stgit@preeti>
References: <20140226000310.17879.67295.stgit@preeti>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: paulmck@linux.vnet.ibm.com, rafael.j.wysocki@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

During "Fast-sleep" and deeper power savings state, decrementer and
timebase could be stopped making it out of sync with rest
of the cores in the system.

Add a firmware call to request platform to resync timebase
using low level platform methods.

Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Signed-off-by: Preeti U. Murthy <preeti@linux.vnet.ibm.com>
---

 arch/powerpc/include/asm/opal.h                |    2 ++
 arch/powerpc/kernel/exceptions-64s.S           |    2 +-
 arch/powerpc/kernel/idle_power7.S              |   27 ++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |    1 +
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 40157e2..c71c72e 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -154,6 +154,7 @@ extern int opal_enter_rtas(struct rtas_args *args,
 #define OPAL_FLASH_VALIDATE			76
 #define OPAL_FLASH_MANAGE			77
 #define OPAL_FLASH_UPDATE			78
+#define OPAL_RESYNC_TIMEBASE			79
 #define OPAL_GET_MSG				85
 #define OPAL_CHECK_ASYNC_COMPLETION		86
 #define OPAL_SYNC_HOST_REBOOT			87
@@ -865,6 +866,7 @@ extern void opal_flash_init(void);
 extern int opal_machine_check(struct pt_regs *regs);
 
 extern void opal_shutdown(void);
+extern int opal_resync_timebase(void);
 
 extern void opal_lpc_init(void);
 
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index b01a9cb..9533d7a 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -145,7 +145,7 @@ BEGIN_FTR_SECTION
 
 	/* Fast Sleep wakeup on PowerNV */
 8:	GET_PACA(r13)
-	b 	.power7_wakeup_loss
+	b 	.power7_wakeup_tb_loss
 
 9:
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index 14f78be..c3ab869 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -17,6 +17,7 @@
 #include <asm/ppc-opcode.h>
 #include <asm/hw_irq.h>
 #include <asm/kvm_book3s_asm.h>
+#include <asm/opal.h>
 
 #undef DEBUG
 
@@ -125,6 +126,32 @@ _GLOBAL(power7_sleep)
 	b	power7_powersave_common
 	/* No return */
 
+_GLOBAL(power7_wakeup_tb_loss)
+	ld	r2,PACATOC(r13);
+	ld	r1,PACAR1(r13)
+
+	/* Time base re-sync */
+	li	r0,OPAL_RESYNC_TIMEBASE
+	LOAD_REG_ADDR(r11,opal);
+	ld	r12,8(r11);
+	ld	r2,0(r11);
+	mtctr	r12
+	bctrl
+
+	/* TODO: Check r3 for failure */
+
+	REST_NVGPRS(r1)
+	REST_GPR(2, r1)
+	ld	r3,_CCR(r1)
+	ld	r4,_MSR(r1)
+	ld	r5,_NIP(r1)
+	addi	r1,r1,INT_FRAME_SIZE
+	mtcr	r3
+	mfspr	r3,SPRN_SRR1		/* Return SRR1 */
+	mtspr	SPRN_SRR1,r4
+	mtspr	SPRN_SRR0,r5
+	rfid
+
 _GLOBAL(power7_wakeup_loss)
 	ld	r1,PACAR1(r13)
 	REST_NVGPRS(r1)
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 3e8829c..aab54b6 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -126,6 +126,7 @@ OPAL_CALL(opal_return_cpu,			OPAL_RETURN_CPU);
 OPAL_CALL(opal_validate_flash,			OPAL_FLASH_VALIDATE);
 OPAL_CALL(opal_manage_flash,			OPAL_FLASH_MANAGE);
 OPAL_CALL(opal_update_flash,			OPAL_FLASH_UPDATE);
+OPAL_CALL(opal_resync_timebase,			OPAL_RESYNC_TIMEBASE);
 OPAL_CALL(opal_get_msg,				OPAL_GET_MSG);
 OPAL_CALL(opal_check_completion,		OPAL_CHECK_ASYNC_COMPLETION);
 OPAL_CALL(opal_sync_host_reboot,		OPAL_SYNC_HOST_REBOOT);
