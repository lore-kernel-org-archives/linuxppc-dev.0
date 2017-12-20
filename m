Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1yRj1kBLzF08c
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 01:52:33 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id b18so11995392pgv.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 06:52:32 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 5/8] powerpc/64s: put work_pending bit into r14
Date: Thu, 21 Dec 2017 00:52:03 +1000
Message-Id: <20171220145206.12234-6-npiggin@gmail.com>
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

Similarly, may not be worth an r14 bit, but...
---
 arch/powerpc/include/asm/paca.h |  4 ++--
 arch/powerpc/kernel/time.c      | 15 +++------------
 arch/powerpc/xmon/xmon.c        |  1 -
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 408fa079e00d..cd3637f4ee4e 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -36,7 +36,8 @@
 register struct paca_struct *local_paca asm("r13");
 #ifdef CONFIG_PPC_BOOK3S
 
-#define R14_BIT_IO_SYNC	0x0001
+#define R14_BIT_IO_SYNC			0x0001
+#define R14_BIT_IRQ_WORK_PENDING	0x0002 /* IRQ_WORK interrupt while soft-disable */
 
 /*
  * The top 32-bits of r14 is used as the per-cpu offset, shifted by PAGE_SHIFT.
@@ -212,7 +213,6 @@ struct paca_struct {
 	u16 trap_save;			/* Used when bad stack is encountered */
 	u8 irq_soft_mask;		/* mask for irq soft masking */
 	u8 irq_happened;		/* irq happened while soft-disabled */
-	u8 irq_work_pending;		/* IRQ_WORK interrupt while soft-disable */
 	u8 nap_state_lost;		/* NV GPR values lost in power7_idle */
 	u64 sprg_vdso;			/* Saved user-visible sprg */
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 8d32ce95ec88..fac30152723f 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -488,26 +488,17 @@ EXPORT_SYMBOL(profile_pc);
 #ifdef CONFIG_PPC64
 static inline unsigned long test_irq_work_pending(void)
 {
-	unsigned long x;
-
-	asm volatile("lbz %0,%1(13)"
-		: "=r" (x)
-		: "i" (offsetof(struct paca_struct, irq_work_pending)));
-	return x;
+	return local_r14 & R14_BIT_IRQ_WORK_PENDING;
 }
 
 static inline void set_irq_work_pending_flag(void)
 {
-	asm volatile("stb %0,%1(13)" : :
-		"r" (1),
-		"i" (offsetof(struct paca_struct, irq_work_pending)));
+	r14_set_bits(R14_BIT_IRQ_WORK_PENDING);
 }
 
 static inline void clear_irq_work_pending(void)
 {
-	asm volatile("stb %0,%1(13)" : :
-		"r" (0),
-		"i" (offsetof(struct paca_struct, irq_work_pending)));
+	r14_clear_bits(R14_BIT_IRQ_WORK_PENDING);
 }
 
 #else /* 32-bit */
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 40f0d02ae92d..7d2bb26ff333 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2393,7 +2393,6 @@ static void dump_one_paca(int cpu)
 	DUMP(p, trap_save, "x");
 	DUMP(p, irq_soft_mask, "x");
 	DUMP(p, irq_happened, "x");
-	DUMP(p, irq_work_pending, "x");
 	DUMP(p, nap_state_lost, "x");
 	DUMP(p, sprg_vdso, "llx");
 
-- 
2.15.0
