Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 34/63] powerpc: Make rwlocks endian safe
Date: Wed,  7 Aug 2013 02:01:51 +1000
Message-Id: <1375804940-22050-35-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Our ppc64 spinlocks and rwlocks use a trick where a lock token and
the paca index are placed in the lock with a single store. Since we
are using two u16s they need adjusting for little endian.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/paca.h         | 5 +++++
 arch/powerpc/include/asm/spinlock.h     | 4 ++++
 arch/powerpc/kvm/book3s_hv_rm_mmu.c     | 4 ++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 8 ++++++++
 4 files changed, 21 insertions(+)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 77c91e7..2bf78b3 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -68,8 +68,13 @@ struct paca_struct {
 	 * instruction.  They must travel together and be properly
 	 * aligned.
 	 */
+#ifdef __BIG_ENDIAN__
 	u16 lock_token;			/* Constant 0x8000, used in locks */
 	u16 paca_index;			/* Logical processor number */
+#else
+	u16 paca_index;			/* Logical processor number */
+	u16 lock_token;			/* Constant 0x8000, used in locks */
+#endif
 
 	u64 kernel_toc;			/* Kernel TOC address */
 	u64 kernelbase;			/* Base address of kernel */
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 7c345b6..5f54a74 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -32,8 +32,12 @@
 
 #ifdef CONFIG_PPC64
 /* use 0x800000yy when locked, where yy == CPU number */
+#ifdef __BIG_ENDIAN__
 #define LOCK_TOKEN	(*(u32 *)(&get_paca()->lock_token))
 #else
+#define LOCK_TOKEN	(*(u32 *)(&get_paca()->paca_index))
+#endif
+#else
 #define LOCK_TOKEN	1
 #endif
 
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index fc25689..c3785d4 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -363,7 +363,11 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 				 vcpu->arch.pgdir, true, &vcpu->arch.gpr[4]);
 }
 
+#ifdef __BIG_ENDIAN__
 #define LOCK_TOKEN	(*(u32 *)(&get_paca()->lock_token))
+#else
+#define LOCK_TOKEN	(*(u32 *)(&get_paca()->paca_index))
+#endif
 
 static inline int try_lock_tlbie(unsigned int *lock)
 {
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 20e7fcd..b93e3cd 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -393,7 +393,11 @@ toc_tlbie_lock:
 	.tc	native_tlbie_lock[TC],native_tlbie_lock
 	.previous
 	ld	r3,toc_tlbie_lock@toc(2)
+#ifdef __BIG_ENDIAN__
 	lwz	r8,PACA_LOCK_TOKEN(r13)
+#else
+	lwz	r8,PACAPACAINDEX(r13)
+#endif
 24:	lwarx	r0,0,r3
 	cmpwi	r0,0
 	bne	24b
@@ -968,7 +972,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
 32:	ld	r4,VCPU_KVM(r9)		/* pointer to struct kvm */
 
 	/* Take the guest's tlbie_lock */
+#ifdef __BIG_ENDIAN__
 	lwz	r8,PACA_LOCK_TOKEN(r13)
+#else
+	lwz	r8,PACAPACAINDEX(r13)
+#endif
 	addi	r3,r4,KVM_TLBIE_LOCK
 24:	lwarx	r0,0,r3
 	cmpwi	r0,0
-- 
1.8.1.2
