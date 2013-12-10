Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp16.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3036B2C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 18:39:38 +1100 (EST)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Tue, 10 Dec 2013 07:39:33 -0000
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
To: Linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: set default kernel thread priority to medium-low
Date: Tue, 10 Dec 2013 08:39:23 +0100
Message-Id: <1386661163-4478-1-git-send-email-felix@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All the important PThread locking occurs in GLIBC libpthread.so

For scaling to large core counts we need to stay out of the kernel and scheduler as much as possible which implies increasing the spin time in user mode. For POWER implementations with SMT this implies that user mode needs to manage SMT priority for spinning and active (in the critical region) threads.

Libpthread must be able to raise and lower the the SMT priority versus the default to be effective.

This lowers the default kernel thread priority from medium to medium-low.

Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h        |    2 +-
 arch/powerpc/include/asm/ppc_asm.h              |    4 ++--
 arch/powerpc/include/asm/processor.h            |    2 +-
 arch/powerpc/include/asm/spinlock.h             |    8 ++++----
 arch/powerpc/kernel/entry_64.S                  |    2 +-
 arch/powerpc/kernel/exceptions-64s.S            |    4 ++--
 arch/powerpc/kernel/head_64.S                   |    4 ++--
 arch/powerpc/kernel/idle.c                      |    2 +-
 arch/powerpc/kernel/prom_init.c                 |    2 +-
 arch/powerpc/kernel/time.c                      |    2 +-
 arch/powerpc/kvm/book3s_hv.c                    |    2 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S         |    4 ++--
 arch/powerpc/lib/locks.c                        |    2 +-
 arch/powerpc/platforms/cell/beat_hvCall.S       |   16 ++++++++--------
 arch/powerpc/platforms/powernv/opal-takeover.S  |    2 +-
 arch/powerpc/platforms/pseries/hvCall.S         |   10 +++++-----
 arch/powerpc/platforms/pseries/processor_idle.c |    4 ++--
 17 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 402c1c4..30bedd9 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -135,7 +135,7 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,941)
  */
 #define HMT_MEDIUM_PPR_DISCARD						\
 BEGIN_FTR_SECTION_NESTED(942)						\
-	HMT_MEDIUM;							\
+	HMT_MEDIUM_LOW;							\
 END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,0,942)  /*non P7*/		
 
 /*
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index ce05bba..22d4ba4 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -478,9 +478,9 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
  * PPR restore macros used in entry_64.S
  * Used for P7 or later processors
  */
-#define HMT_MEDIUM_LOW_HAS_PPR						\
+#define HMT_LOW_HAS_PPR							\
 BEGIN_FTR_SECTION_NESTED(944)						\
-	HMT_MEDIUM_LOW;							\
+	HMT_LOW;							\
 END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,944)
 
 #define SET_DEFAULT_THREAD_PPR(ra, rb)					\
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index b4a3045..2f8625b 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -387,7 +387,7 @@ static inline unsigned long __pack_fe01(unsigned int fpmode)
 }
 
 #ifdef CONFIG_PPC64
-#define cpu_relax()	do { HMT_low(); HMT_medium(); barrier(); } while (0)
+#define cpu_relax()	do { HMT_low(); HMT_medium_low(); barrier(); } while (0)
 #else
 #define cpu_relax()	barrier()
 #endif
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 5f54a74..b047a6a 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -120,7 +120,7 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 			if (SHARED_PROCESSOR)
 				__spin_yield(lock);
 		} while (unlikely(lock->slock != 0));
-		HMT_medium();
+		HMT_medium_low();
 	}
 }
 
@@ -140,7 +140,7 @@ void arch_spin_lock_flags(arch_spinlock_t *lock, unsigned long flags)
 			if (SHARED_PROCESSOR)
 				__spin_yield(lock);
 		} while (unlikely(lock->slock != 0));
-		HMT_medium();
+		HMT_medium_low();
 		local_irq_restore(flags_dis);
 	}
 }
@@ -240,7 +240,7 @@ static inline void arch_read_lock(arch_rwlock_t *rw)
 			if (SHARED_PROCESSOR)
 				__rw_yield(rw);
 		} while (unlikely(rw->lock < 0));
-		HMT_medium();
+		HMT_medium_low();
 	}
 }
 
@@ -254,7 +254,7 @@ static inline void arch_write_lock(arch_rwlock_t *rw)
 			if (SHARED_PROCESSOR)
 				__rw_yield(rw);
 		} while (unlikely(rw->lock != 0));
-		HMT_medium();
+		HMT_medium_low();
 	}
 }
 
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 889ea2b..c3ee079 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -229,7 +229,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 
 	beq-	1f
 	ACCOUNT_CPU_USER_EXIT(r11, r12)
-	HMT_MEDIUM_LOW_HAS_PPR
+	HMT_LOW_HAS_PPR
 	ld	r13,GPR13(r1)	/* only restore r13 if returning to usermode */
 1:	ld	r2,GPR2(r1)
 	ld	r1,GPR1(r1)
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 2a273be..dd704d1 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -271,7 +271,7 @@ decrementer_pSeries:
 	. = 0xc00
 	.globl	system_call_pSeries
 system_call_pSeries:
-	HMT_MEDIUM
+	HMT_MEDIUM_LOW
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 	SET_SCRATCH0(r13)
 	GET_PACA(r13)
@@ -825,7 +825,7 @@ hardware_interrupt_relon_hv:
 	. = 0x4c00
 	.globl system_call_relon_pSeries
 system_call_relon_pSeries:
-	HMT_MEDIUM
+	HMT_MEDIUM_LOW
 	SYSCALL_PSERIES_1
 	SYSCALL_PSERIES_2_DIRECT
 	SYSCALL_PSERIES_3
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 2ae41ab..278c499 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -605,8 +605,8 @@ _GLOBAL(pmac_secondary_start)
 
 	.globl	__secondary_start
 __secondary_start:
-	/* Set thread priority to MEDIUM */
-	HMT_MEDIUM
+	/* Set thread priority to MEDIUM_LOW */
+	HMT_MEDIUM_LOW
 
 	/* Initialize the kernel stack */
 	LOAD_REG_ADDR(r3, current_set)
diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
index d7216c9..2c1e403 100644
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -75,7 +75,7 @@ void arch_cpu_idle(void)
 		HMT_very_low();
 	}
 
-	HMT_medium();
+	HMT_medium_low();
 	ppc64_runlatch_on();
 }
 
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 5fe2842..60ec3c7 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1383,7 +1383,7 @@ static void __init prom_opal_hold_cpus(void)
 				HMT_low();
 				mb();
 			}
-			HMT_medium();
+			HMT_medium_low();
 			if (data->ack != -1)
 				prom_debug("done, PIR=0x%x\n", data->ack);
 			else
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 192b051..576ba95 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -399,7 +399,7 @@ void __delay(unsigned long loops)
 		start = get_tbl();
 		while (get_tbl() - start < loops)
 			HMT_low();
-		HMT_medium();
+		HMT_medium_low();
 	}
 }
 EXPORT_SYMBOL(__delay);
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 350bc34..c82832b 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1249,7 +1249,7 @@ static void kvmppc_wait_for_nap(struct kvmppc_vcore *vc)
 		}
 		cpu_relax();
 	}
-	HMT_medium();
+	HMT_medium_low();
 }
 
 /*
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 89d4fbe..b30724e 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1045,7 +1045,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
 13:	lbz	r3,VCORE_IN_GUEST(r5)
 	cmpwi	r3,0
 	bne	13b
-	HMT_MEDIUM
+	HMT_MEDIUM_LOW
 	b	16f
 
 	/* Primary thread waits for all the secondaries to exit guest */
@@ -1317,7 +1317,7 @@ secondary_too_late:
 13:	lbz	r3,VCORE_IN_GUEST(r5)
 	cmpwi	r3,0
 	bne	13b
-	HMT_MEDIUM
+	HMT_MEDIUM_LOW
 	li	r0, KVM_GUEST_MODE_NONE
 	stb	r0, HSTATE_IN_GUEST(r13)
 	ld	r11,PACA_SLBSHADOWPTR(r13)
diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
index 0c9c8d7..d6eb1cf 100644
--- a/arch/powerpc/lib/locks.c
+++ b/arch/powerpc/lib/locks.c
@@ -75,7 +75,7 @@ void arch_spin_unlock_wait(arch_spinlock_t *lock)
 		if (SHARED_PROCESSOR)
 			__spin_yield(lock);
 	}
-	HMT_medium();
+	HMT_medium_low();
 }
 
 EXPORT_SYMBOL(arch_spin_unlock_wait);
diff --git a/arch/powerpc/platforms/cell/beat_hvCall.S b/arch/powerpc/platforms/cell/beat_hvCall.S
index 96c8019..c4a929b 100644
--- a/arch/powerpc/platforms/cell/beat_hvCall.S
+++ b/arch/powerpc/platforms/cell/beat_hvCall.S
@@ -32,7 +32,7 @@
 
 /* Note: takes only 7 input parameters at maximum */
 _GLOBAL(beat_hcall_norets)
-	HMT_MEDIUM
+	HMT_MEDIUM_LOW
 
 	mfcr	r0
 	stw	r0,8(r1)
@@ -58,7 +58,7 @@ _GLOBAL(beat_hcall_norets)
 
 /* Note: takes 8 input parameters at maximum */
 _GLOBAL(beat_hcall_norets8)
-	HMT_MEDIUM
+	HMT_MEDIUM_LOW
 
 	mfcr	r0
 	stw	r0,8(r1)
@@ -85,7 +85,7 @@ _GLOBAL(beat_hcall_norets8)
 
 /* Note: takes only 6 input parameters, 1 output parameters at maximum */
 _GLOBAL(beat_hcall1)
-	HMT_MEDIUM
+	HMT_MEDIUM_LOW
 
 	mfcr	r0
 	stw	r0,8(r1)
@@ -116,7 +116,7 @@ _GLOBAL(beat_hcall1)
 
 /* Note: takes only 6 input parameters, 2 output parameters at maximum */
 _GLOBAL(beat_hcall2)
-	HMT_MEDIUM
+	HMT_MEDIUM_LOW
 
 	mfcr	r0
 	stw	r0,8(r1)
@@ -148,7 +148,7 @@ _GLOBAL(beat_hcall2)
 
 /* Note: takes only 6 input parameters, 3 output parameters at maximum */
 _GLOBAL(beat_hcall3)
-	HMT_MEDIUM
+	HMT_MEDIUM_LOW
 
 	mfcr	r0
 	stw	r0,8(r1)
@@ -181,7 +181,7 @@ _GLOBAL(beat_hcall3)
 
 /* Note: takes only 6 input parameters, 4 output parameters at maximum */
 _GLOBAL(beat_hcall4)
-	HMT_MEDIUM
+	HMT_MEDIUM_LOW
 
 	mfcr	r0
 	stw	r0,8(r1)
@@ -215,7 +215,7 @@ _GLOBAL(beat_hcall4)
 
 /* Note: takes only 6 input parameters, 5 output parameters at maximum */
 _GLOBAL(beat_hcall5)
-	HMT_MEDIUM
+	HMT_MEDIUM_LOW
 
 	mfcr	r0
 	stw	r0,8(r1)
@@ -250,7 +250,7 @@ _GLOBAL(beat_hcall5)
 
 /* Note: takes only 6 input parameters, 6 output parameters at maximum */
 _GLOBAL(beat_hcall6)
-	HMT_MEDIUM
+	HMT_MEDIUM_LOW
 
 	mfcr	r0
 	stw	r0,8(r1)
diff --git a/arch/powerpc/platforms/powernv/opal-takeover.S b/arch/powerpc/platforms/powernv/opal-takeover.S
index 3cd2628..e350790 100644
--- a/arch/powerpc/platforms/powernv/opal-takeover.S
+++ b/arch/powerpc/platforms/powernv/opal-takeover.S
@@ -74,7 +74,7 @@ opal_secondary_entry:
 	ld	r4,8(r3)
 	cmpli	cr0,r4,0
 	beq	1b
-	HMT_MEDIUM
+	HMT_MEDIUM_LOW
 1:	addi	r3,r31,16
 	bl	__opal_do_takeover
 	b	1b
diff --git a/arch/powerpc/platforms/pseries/hvCall.S b/arch/powerpc/platforms/pseries/hvCall.S
index 444fe77..be90f7b 100644
--- a/arch/powerpc/platforms/pseries/hvCall.S
+++ b/arch/powerpc/platforms/pseries/hvCall.S
@@ -107,7 +107,7 @@ END_FTR_SECTION(0, 1);						\
 	.text
 
 _GLOBAL(plpar_hcall_norets)
-	HMT_MEDIUM
+	HMT_MEDIUM_LOW
 
 	mfcr	r0
 	stw	r0,8(r1)
@@ -123,7 +123,7 @@ _GLOBAL(plpar_hcall_norets)
 	blr				/* return r3 = status */
 
 _GLOBAL(plpar_hcall)
-	HMT_MEDIUM
+	HMT_MEDIUM_LOW
 
 	mfcr	r0
 	stw	r0,8(r1)
@@ -161,7 +161,7 @@ _GLOBAL(plpar_hcall)
  * since these variables may not be present in the RMO region.
  */
 _GLOBAL(plpar_hcall_raw)
-	HMT_MEDIUM
+	HMT_MEDIUM_LOW
 
 	mfcr	r0
 	stw	r0,8(r1)
@@ -189,7 +189,7 @@ _GLOBAL(plpar_hcall_raw)
 	blr				/* return r3 = status */
 
 _GLOBAL(plpar_hcall9)
-	HMT_MEDIUM
+	HMT_MEDIUM_LOW
 
 	mfcr	r0
 	stw	r0,8(r1)
@@ -231,7 +231,7 @@ _GLOBAL(plpar_hcall9)
 
 /* See plpar_hcall_raw to see why this is needed */
 _GLOBAL(plpar_hcall9_raw)
-	HMT_MEDIUM
+	HMT_MEDIUM_LOW
 
 	mfcr	r0
 	stw	r0,8(r1)
diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
index a166e38..8124e24 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -68,7 +68,7 @@ static int snooze_loop(struct cpuidle_device *dev,
 		HMT_very_low();
 	}
 
-	HMT_medium();
+	HMT_medium_low();
 	clear_thread_flag(TIF_POLLING_NRFLAG);
 	smp_mb();
 
@@ -104,7 +104,7 @@ static int dedicated_cede_loop(struct cpuidle_device *dev,
 	get_lppaca()->donate_dedicated_cpu = 1;
 
 	ppc64_runlatch_off();
-	HMT_medium();
+	HMT_medium_low();
 	check_and_cede_processor();
 
 	get_lppaca()->donate_dedicated_cpu = 0;
-- 
1.7.10.4
