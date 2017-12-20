Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1yRb0fx8zF07X
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 01:52:26 +1100 (AEDT)
Received: by mail-pl0-x242.google.com with SMTP id s3so9128622plp.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 06:52:26 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 3/8] powerpc/64s: put the per-cpu data_offset in r14
Date: Thu, 21 Dec 2017 00:52:01 +1000
Message-Id: <20171220145206.12234-4-npiggin@gmail.com>
In-Reply-To: <20171220145206.12234-1-npiggin@gmail.com>
References: <20171220145206.12234-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Shifted left by 16 bits, so the low 16 bits of r14 remain available.
This allows per-cpu pointers to be dereferenced with a single extra
shift whereas previously it was a load and add.
---
 arch/powerpc/include/asm/paca.h   |  5 +++++
 arch/powerpc/include/asm/percpu.h |  2 +-
 arch/powerpc/kernel/entry_64.S    |  5 -----
 arch/powerpc/kernel/head_64.S     |  5 +----
 arch/powerpc/kernel/setup_64.c    | 11 +++++++++--
 5 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index cd6a9a010895..4dd4ac69e84f 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -35,6 +35,11 @@
 
 register struct paca_struct *local_paca asm("r13");
 #ifdef CONFIG_PPC_BOOK3S
+/*
+ * The top 32-bits of r14 is used as the per-cpu offset, shifted by PAGE_SHIFT.
+ * The per-cpu could be moved completely to vmalloc space if we had large
+ * vmalloc page mapping? (no, must access it in real mode).
+ */
 register u64 local_r14 asm("r14");
 #endif
 
diff --git a/arch/powerpc/include/asm/percpu.h b/arch/powerpc/include/asm/percpu.h
index dce863a7635c..1e0d79d30eac 100644
--- a/arch/powerpc/include/asm/percpu.h
+++ b/arch/powerpc/include/asm/percpu.h
@@ -12,7 +12,7 @@
 
 #include <asm/paca.h>
 
-#define __my_cpu_offset local_paca->data_offset
+#define __my_cpu_offset (local_r14 >> 16)
 
 #endif /* CONFIG_SMP */
 #endif /* __powerpc64__ */
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 592e4b36065f..6b0e3ac311e8 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -262,11 +262,6 @@ system_call_exit:
 BEGIN_FTR_SECTION
 	stdcx.	r0,0,r1			/* to clear the reservation */
 END_FTR_SECTION_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
-	LOAD_REG_IMMEDIATE(r10, 0xdeadbeefULL << 32)
-	mfspr	r11,SPRN_PIR
-	or	r10,r10,r11
-	tdne	r10,r14
-
 	andi.	r6,r8,MSR_PR
 	ld	r4,_LINK(r1)
 
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 5a9ec06eab14..cdb710f43681 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -413,10 +413,7 @@ generic_secondary_common_init:
 	b	kexec_wait		/* next kernel might do better	 */
 
 2:	SET_PACA(r13)
-	LOAD_REG_IMMEDIATE(r14, 0xdeadbeef << 32)
-	mfspr	r3,SPRN_PIR
-	or	r14,r14,r3
-	std	r14,PACA_R14(r13)
+	ld	r14,PACA_R14(r13)
 
 #ifdef CONFIG_PPC_BOOK3E
 	addi	r12,r13,PACA_EXTLB	/* and TLB exc frame in another  */
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 9a4c5bf35d92..f4a96ebb523a 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -192,8 +192,8 @@ static void __init fixup_boot_paca(void)
 	get_paca()->data_offset = 0;
 	/* Mark interrupts disabled in PACA */
 	irq_soft_mask_set(IRQ_SOFT_MASK_STD);
-	/* Set r14 and paca_r14 to debug value */
-	get_paca()->r14 = (0xdeadbeefULL << 32) | mfspr(SPRN_PIR);
+	/* Set r14 and paca_r14 to zero */
+	get_paca()->r14 = 0;
 	local_r14 = get_paca()->r14;
 }
 
@@ -761,7 +761,14 @@ void __init setup_per_cpu_areas(void)
 	for_each_possible_cpu(cpu) {
                 __per_cpu_offset[cpu] = delta + pcpu_unit_offsets[cpu];
 		paca[cpu].data_offset = __per_cpu_offset[cpu];
+
+		BUG_ON(paca[cpu].data_offset & (PAGE_SIZE-1));
+		BUG_ON(paca[cpu].data_offset >= (1UL << (64 - 16)));
+
+		/* The top 48 bits are used for per-cpu data */
+		paca[cpu].r14 |= paca[cpu].data_offset << 16;
 	}
+	local_r14 = paca[smp_processor_id()].r14;
 }
 #endif
 
-- 
2.15.0
