Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B3C102C0585
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 19:13:09 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 15 Jan 2014 01:13:06 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 7A9E41FF0028
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 01:12:34 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0F6AgJ69503040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 07:10:42 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0F8D2gS010396
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 01:13:04 -0700
Subject: [PATCH V5 5/8] powermgt: Add OPAL call to resync timebase on wakeup
To: daniel.lezcano@linaro.org, peterz@infradead.org, fweisbec@gmail.com,
 agraf@suse.de, paul.gortmaker@windriver.com, paulus@samba.org,
 mingo@kernel.org, mikey@neuling.org, shangw@linux.vnet.ibm.com,
 rafael.j.wysocki@intel.com, galak@kernel.crashing.org,
 benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, arnd@arndb.de,
 linux-pm@vger.kernel.org, rostedt@goodmis.org, michael@ellerman.id.au,
 john.stultz@linaro.org, anton@samba.org, tglx@linutronix.de,
 chenhui.zhao@freescale.com, deepthi@linux.vnet.ibm.com,
 r58472@freescale.com, geoff@infradead.org,
 linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com,
 schwidefsky@de.ibm.com, svaidy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Wed, 15 Jan 2014 13:39:29 +0530
Message-ID: <20140115080929.20446.31990.stgit@preeti.in.ibm.com>
In-Reply-To: <20140115080555.20446.27238.stgit@preeti.in.ibm.com>
References: <20140115080555.20446.27238.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
index 033c06b..a662d06 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -132,6 +132,7 @@ extern int opal_enter_rtas(struct rtas_args *args,
 #define OPAL_FLASH_VALIDATE			76
 #define OPAL_FLASH_MANAGE			77
 #define OPAL_FLASH_UPDATE			78
+#define OPAL_RESYNC_TIMEBASE			79
 
 #ifndef __ASSEMBLY__
 
@@ -763,6 +764,7 @@ extern void opal_flash_init(void);
 extern int opal_machine_check(struct pt_regs *regs);
 
 extern void opal_shutdown(void);
+extern int opal_resync_timebase(void);
 
 extern void opal_lpc_init(void);
 
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index b8139fb..91e6417 100644
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
index e4bbca2..34c71e8 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -17,6 +17,7 @@
 #include <asm/ppc-opcode.h>
 #include <asm/hw_irq.h>
 #include <asm/kvm_book3s_asm.h>
+#include <asm/opal.h>
 
 #undef DEBUG
 
@@ -124,6 +125,32 @@ _GLOBAL(power7_sleep)
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
index e780650..ddfe95a 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -126,3 +126,4 @@ OPAL_CALL(opal_return_cpu,			OPAL_RETURN_CPU);
 OPAL_CALL(opal_validate_flash,			OPAL_FLASH_VALIDATE);
 OPAL_CALL(opal_manage_flash,			OPAL_FLASH_MANAGE);
 OPAL_CALL(opal_update_flash,			OPAL_FLASH_UPDATE);
+OPAL_CALL(opal_resync_timebase,			OPAL_RESYNC_TIMEBASE);
