Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 34CF42C055B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 19:12:51 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 15 Jan 2014 01:12:49 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 55C533E40040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 01:12:46 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0F8CYx46947114
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 09:12:34 +0100
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0F8ChH4024986
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 01:12:46 -0700
Subject: [PATCH V5 4/8] powernv/cpuidle: Add context management for Fast Sleep
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
Date: Wed, 15 Jan 2014 13:39:11 +0530
Message-ID: <20140115080911.20446.74665.stgit@preeti.in.ibm.com>
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
index 027fefd..22e547a 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -444,6 +444,7 @@ enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
 
 extern int powersave_nap;	/* set if nap mode can be used in idle loop */
 extern void power7_nap(void);
+extern void power7_sleep(void);
 extern void flush_instruction_cache(void);
 extern void hard_reset_now(void);
 extern void poweroff_now(void);
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 9f905e4..b8139fb 100644
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
index 847e40e..e4bbca2 100644
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
 
@@ -89,15 +99,30 @@ _GLOBAL(power7_nap)
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
