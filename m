Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/3] powerpc: Context switch the new EBB SPRs
Date: Wed,  1 May 2013 16:17:04 +1000
Message-Id: <1367389024-20391-4-git-send-email-mikey@neuling.org>
In-Reply-To: <1367389024-20391-1-git-send-email-mikey@neuling.org>
References: <1367389024-20391-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>

This context switches the new Event Based Branching (EBB) SPRs.  The three new
SPRs are:
  - Event Based Branch Handler Register (EBBHR)
  - Event Based Branch Return Register (EBBRR)
  - Branch Event Status and Control Register (BESCR)

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Matt Evans <matt@ozlabs.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/processor.h |    3 +++
 arch/powerpc/include/asm/reg.h       |    3 +++
 arch/powerpc/kernel/asm-offsets.c    |    3 +++
 arch/powerpc/kernel/entry_64.S       |   16 ++++++++++++++++
 4 files changed, 25 insertions(+)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 0a4cc5d..d7e67ca 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -281,6 +281,9 @@ struct thread_struct {
 #endif
 #ifdef CONFIG_PPC_BOOK3S_64
 	unsigned long	tar;
+	unsigned long	ebbrr;
+	unsigned long	ebbhr;
+	unsigned long	bescr;
 #endif
 };
 
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index cd241ed..fa8285b 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -663,6 +663,9 @@
 #define SPRN_MMCRH	316	/* Hypervisor monitor mode control register */
 #define SPRN_MMCRS	894	/* Supervisor monitor mode control register */
 #define SPRN_MMCRC	851	/* Core monitor mode control register */
+#define SPRN_EBBHR	804	/* Event based branch handler register */
+#define SPRN_EBBRR	805	/* Event based branch return register */
+#define SPRN_BESCR	806	/* Branch event status and control register */
 
 #define SPRN_PMC1	787
 #define SPRN_PMC2	788
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index b6c17ec..172233e 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -124,6 +124,9 @@ int main(void)
 
 #ifdef CONFIG_PPC_BOOK3S_64
 	DEFINE(THREAD_TAR, offsetof(struct thread_struct, tar));
+	DEFINE(THREAD_BESCR, offsetof(struct thread_struct, bescr));
+	DEFINE(THREAD_EBBHR, offsetof(struct thread_struct, ebbhr));
+	DEFINE(THREAD_EBBRR, offsetof(struct thread_struct, ebbrr));
 #endif
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	DEFINE(PACATMSCRATCH, offsetof(struct paca_struct, tm_scratch));
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 7a6801f..3fe5259 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -458,6 +458,14 @@ BEGIN_FTR_SECTION
 	 */
 	mfspr	r0,SPRN_TAR
 	std	r0,THREAD_TAR(r3)
+
+	/* Event based branch registers */
+	mfspr	r0, SPRN_BESCR
+	std	r0, THREAD_BESCR(r3)
+	mfspr	r0, SPRN_EBBHR
+	std	r0, THREAD_EBBHR(r3)
+	mfspr	r0, SPRN_EBBRR
+	std	r0, THREAD_EBBRR(r3)
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 #endif
 
@@ -545,6 +553,14 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 
 #ifdef CONFIG_PPC_BOOK3S_64
 BEGIN_FTR_SECTION
+	/* Event based branch registers */
+	ld	r0, THREAD_BESCR(r4)
+	mtspr	SPRN_BESCR, r0
+	ld	r0, THREAD_EBBHR(r4)
+	mtspr	SPRN_EBBHR, r0
+	ld	r0, THREAD_EBBRR(r4)
+	mtspr	SPRN_EBBRR, r0
+
 	ld	r0,THREAD_TAR(r4)
 	mtspr	SPRN_TAR,r0
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
-- 
1.7.10.4
