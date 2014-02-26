Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A75B92C058E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 11:12:21 +1100 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 17:12:19 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 223F61FF0045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 17:12:16 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with
 ESMTP id s1Q0BoGm22937784
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 01:11:50 +0100
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1Q0CEpP010023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 17:12:15 -0700
Subject: [PATCH 4/7] powernv/cpuidle: Add context management for Fast Sleep
To: linux-pm@vger.kernel.org, geoff@infradead.org, fweisbec@gmail.com,
 daniel.lezcano@linaro.org, srivatsa.bhat@linux.vnet.ibm.com,
 benh@kernel.crashing.org, tglx@linutronix.de,
 svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Wed, 26 Feb 2014 05:38:25 +0530
Message-ID: <20140226000824.17879.93116.stgit@preeti>
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

Before adding Fast-Sleep into the cpuidle framework, some low level
support needs to be added to enable it. This includes saving and
restoring of certain registers at entry and exit time of this state
respectively just like we do in the NAP idle state.

Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
[Changelog modified by Preeti U. Murthy <preeti@linux.vnet.ibm.com>]
Signed-off-by: Preeti U. Murthy <preeti@linux.vnet.ibm.com>
---

 arch/powerpc/include/asm/processor.h |    1 +
 arch/powerpc/kernel/exceptions-64s.S |   10 ++++-
 arch/powerpc/kernel/idle_power7.S    |   63 ++++++++++++++++++++++++----------
 3 files changed, 53 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index b62de43..d660dc3 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -450,6 +450,7 @@ enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
 
 extern int powersave_nap;	/* set if nap mode can be used in idle loop */
 extern void power7_nap(void);
+extern void power7_sleep(void);
 extern void flush_instruction_cache(void);
 extern void hard_reset_now(void);
 extern void poweroff_now(void);
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 38d5073..b01a9cb 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -121,9 +121,10 @@ BEGIN_FTR_SECTION
 	cmpwi	cr1,r13,2
 	/* Total loss of HV state is fatal, we could try to use the
 	 * PIR to locate a PACA, then use an emergency stack etc...
-	 * but for now, let's just stay stuck here
+	 * OPAL v3 based powernv platforms have new idle states
+	 * which fall in this catagory.
 	 */
-	bgt	cr1,.
+	bgt	cr1,8f
 	GET_PACA(r13)
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
@@ -141,6 +142,11 @@ BEGIN_FTR_SECTION
 	beq	cr1,2f
 	b	.power7_wakeup_noloss
 2:	b	.power7_wakeup_loss
+
+	/* Fast Sleep wakeup on PowerNV */
+8:	GET_PACA(r13)
+	b 	.power7_wakeup_loss
+
 9:
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 #endif /* CONFIG_PPC_P7_NAP */
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index 3fdef0f..14f78be 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -20,17 +20,27 @@
 
 #undef DEBUG
 
-	.text
+/* Idle state entry routines */
 
-_GLOBAL(power7_idle)
-	/* Now check if user or arch enabled NAP mode */
-	LOAD_REG_ADDRBASE(r3,powersave_nap)
-	lwz	r4,ADDROFF(powersave_nap)(r3)
-	cmpwi	0,r4,0
-	beqlr
-	/* fall through */
+#define	IDLE_STATE_ENTER_SEQ(IDLE_INST)				\
+	/* Magic NAP/SLEEP/WINKLE mode enter sequence */	\
+	std	r0,0(r1);					\
+	ptesync;						\
+	ld	r0,0(r1);					\
+1:	cmp	cr0,r0,r0;					\
+	bne	1b;						\
+	IDLE_INST;						\
+	b	.
 
-_GLOBAL(power7_nap)
+	.text
+
+/*
+ * Pass requested state in r3:
+ * 	0 - nap
+ * 	1 - sleep
+ */
+_GLOBAL(power7_powersave_common)
+	/* Use r3 to pass state nap/sleep/winkle */
 	/* NAP is a state loss, we create a regs frame on the
 	 * stack, fill it up with the state we care about and
 	 * stick a pointer to it in PACAR1. We really only
@@ -79,8 +89,8 @@ _GLOBAL(power7_nap)
 	/* Continue saving state */
 	SAVE_GPR(2, r1)
 	SAVE_NVGPRS(r1)
-	mfcr	r3
-	std	r3,_CCR(r1)
+	mfcr	r4
+	std	r4,_CCR(r1)
 	std	r9,_MSR(r1)
 	std	r1,PACAR1(r13)
 
@@ -90,15 +100,30 @@ _GLOBAL(power7_enter_nap_mode)
 	li	r4,KVM_HWTHREAD_IN_NAP
 	stb	r4,HSTATE_HWTHREAD_STATE(r13)
 #endif
+	cmpwi	cr0,r3,1
+	beq	2f
+	IDLE_STATE_ENTER_SEQ(PPC_NAP)
+	/* No return */
+2:	IDLE_STATE_ENTER_SEQ(PPC_SLEEP)
+	/* No return */
 
-	/* Magic NAP mode enter sequence */
-	std	r0,0(r1)
-	ptesync
-	ld	r0,0(r1)
-1:	cmp	cr0,r0,r0
-	bne	1b
-	PPC_NAP
-	b	.
+_GLOBAL(power7_idle)
+	/* Now check if user or arch enabled NAP mode */
+	LOAD_REG_ADDRBASE(r3,powersave_nap)
+	lwz	r4,ADDROFF(powersave_nap)(r3)
+	cmpwi	0,r4,0
+	beqlr
+	/* fall through */
+
+_GLOBAL(power7_nap)
+	li	r3,0
+	b	power7_powersave_common
+	/* No return */
+
+_GLOBAL(power7_sleep)
+	li	r3,1
+	b	power7_powersave_common
+	/* No return */
 
 _GLOBAL(power7_wakeup_loss)
 	ld	r1,PACAR1(r13)
