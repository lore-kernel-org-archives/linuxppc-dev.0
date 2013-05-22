Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Context switch more PMU related SPRs
Date: Wed, 22 May 2013 12:31:12 +1000
Message-Id: <1369189872-17660-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 9353374 "Context switch the new EBB SPRs" we added support for
context switching some new EBB SPRs. However despite four of us signing
off on that patch we missed some. To be fair these are not actually new
SPRs, but they are now potentially user accessible so need to be context
switched.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/processor.h |    6 ++++++
 arch/powerpc/kernel/asm-offsets.c    |    6 ++++++
 arch/powerpc/kernel/entry_64.S       |   28 ++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index d7e67ca..594db6b 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -284,6 +284,12 @@ struct thread_struct {
 	unsigned long	ebbrr;
 	unsigned long	ebbhr;
 	unsigned long	bescr;
+	unsigned long	siar;
+	unsigned long	sdar;
+	unsigned long	sier;
+	unsigned long	mmcr0;
+	unsigned long	mmcr2;
+	unsigned long	mmcra;
 #endif
 };
 
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index b51a97c..6f16ffa 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -127,6 +127,12 @@ int main(void)
 	DEFINE(THREAD_BESCR, offsetof(struct thread_struct, bescr));
 	DEFINE(THREAD_EBBHR, offsetof(struct thread_struct, ebbhr));
 	DEFINE(THREAD_EBBRR, offsetof(struct thread_struct, ebbrr));
+	DEFINE(THREAD_SIAR, offsetof(struct thread_struct, siar));
+	DEFINE(THREAD_SDAR, offsetof(struct thread_struct, sdar));
+	DEFINE(THREAD_SIER, offsetof(struct thread_struct, sier));
+	DEFINE(THREAD_MMCR0, offsetof(struct thread_struct, mmcr0));
+	DEFINE(THREAD_MMCR2, offsetof(struct thread_struct, mmcr2));
+	DEFINE(THREAD_MMCRA, offsetof(struct thread_struct, mmcra));
 #endif
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	DEFINE(PACATMSCRATCH, offsetof(struct paca_struct, tm_scratch));
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 51cfb8f..0e9095e 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -465,6 +465,20 @@ BEGIN_FTR_SECTION
 	std	r0, THREAD_EBBHR(r3)
 	mfspr	r0, SPRN_EBBRR
 	std	r0, THREAD_EBBRR(r3)
+
+	/* PMU registers made user read/(write) by EBB */
+	mfspr	r0, SPRN_SIAR
+	std	r0, THREAD_SIAR(r3)
+	mfspr	r0, SPRN_SDAR
+	std	r0, THREAD_SDAR(r3)
+	mfspr	r0, SPRN_SIER
+	std	r0, THREAD_SIER(r3)
+	mfspr	r0, SPRN_MMCR0
+	std	r0, THREAD_MMCR0(r3)
+	mfspr	r0, SPRN_MMCR2
+	std	r0, THREAD_MMCR2(r3)
+	mfspr	r0, SPRN_MMCRA
+	std	r0, THREAD_MMCRA(r3)
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 #endif
 
@@ -560,6 +574,20 @@ BEGIN_FTR_SECTION
 	ld	r0, THREAD_EBBRR(r4)
 	mtspr	SPRN_EBBRR, r0
 
+	/* PMU registers made user read/(write) by EBB */
+	ld	r0, THREAD_SIAR(r4)
+	mtspr	SPRN_SIAR, r0
+	ld	r0, THREAD_SDAR(r4)
+	mtspr	SPRN_SDAR, r0
+	ld	r0, THREAD_SIER(r4)
+	mtspr	SPRN_SIER, r0
+	ld	r0, THREAD_MMCR0(r4)
+	mtspr	SPRN_MMCR0, r0
+	ld	r0, THREAD_MMCR2(r4)
+	mtspr	SPRN_MMCR2, r0
+	ld	r0, THREAD_MMCRA(r4)
+	mtspr	SPRN_MMCRA, r0
+
 	ld	r0,THREAD_TAR(r4)
 	mtspr	SPRN_TAR,r0
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
-- 
1.7.10.4
