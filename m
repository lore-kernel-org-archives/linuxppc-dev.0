Return-Path: <paulus@ozlabs.org>
Date: Tue, 6 Dec 2011 17:08:00 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH 05/13] KVM: PPC: Make the H_ENTER hcall more reliable
Message-ID: <20111206060800.GI12389@drongo>
References: <20111206060156.GD12389@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111206060156.GD12389@drongo>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At present, our implementation of H_ENTER only makes one try at locking
each slot that it looks at, and doesn't even retry the ldarx/stdcx.
atomic update sequence that it uses to attempt to lock the slot.  Thus
it can return the H_PTEG_FULL error unnecessarily, particularly when
the H_EXACT flag is set, meaning that the caller wants a specific PTEG
slot.

This improves the situation by making a second pass when no free HPTE
slot is found, where we spin until we succeed in locking each slot in
turn and then check whether it is full while we hold the lock.  If the
second pass fails, then we return H_PTEG_FULL.

This also moves lock_hpte to a header file (since later commits in this
series will need to use it from other source files) and renames it to
try_lock_hpte, which is a somewhat less misleading name.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_book3s_64.h |   25 ++++++++++++
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |   63 ++++++++++++++++--------------
 2 files changed, 59 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 23bb17e..fe45a81 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -37,6 +37,31 @@ static inline struct kvmppc_book3s_shadow_vcpu *to_svcpu(struct kvm_vcpu *vcpu)
 #define HPT_HASH_MASK	(HPT_NPTEG - 1)
 #endif
 
+/*
+ * We use a lock bit in HPTE dword 0 to synchronize updates and
+ * accesses to each HPTE, and another bit to indicate non-present
+ * HPTEs.
+ */
+#define HPTE_V_HVLOCK	0x40UL
+
+static inline long try_lock_hpte(unsigned long *hpte, unsigned long bits)
+{
+	unsigned long tmp, old;
+
+	asm volatile("	ldarx	%0,0,%2\n"
+		     "	and.	%1,%0,%3\n"
+		     "	bne	2f\n"
+		     "	ori	%0,%0,%4\n"
+		     "  stdcx.	%0,0,%2\n"
+		     "	beq+	2f\n"
+		     "	li	%1,%3\n"
+		     "2:	isync"
+		     : "=&r" (tmp), "=&r" (old)
+		     : "r" (hpte), "r" (bits), "i" (HPTE_V_HVLOCK)
+		     : "cc", "memory");
+	return old == 0;
+}
+
 static inline unsigned long compute_tlbie_rb(unsigned long v, unsigned long r,
 					     unsigned long pte_index)
 {
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 5f45ba7..659175f 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -56,26 +56,6 @@ static void *real_vmalloc_addr(void *x)
 	return __va(addr);
 }
 
-#define HPTE_V_HVLOCK	0x40UL
-
-static inline long lock_hpte(unsigned long *hpte, unsigned long bits)
-{
-	unsigned long tmp, old;
-
-	asm volatile("	ldarx	%0,0,%2\n"
-		     "	and.	%1,%0,%3\n"
-		     "	bne	2f\n"
-		     "	ori	%0,%0,%4\n"
-		     "  stdcx.	%0,0,%2\n"
-		     "	beq+	2f\n"
-		     "	li	%1,%3\n"
-		     "2:	isync"
-		     : "=&r" (tmp), "=&r" (old)
-		     : "r" (hpte), "r" (bits), "i" (HPTE_V_HVLOCK)
-		     : "cc", "memory");
-	return old == 0;
-}
-
 long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 		    long pte_index, unsigned long pteh, unsigned long ptel)
 {
@@ -129,24 +109,49 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	pteh &= ~0x60UL;
 	ptel &= ~(HPTE_R_PP0 - kvm->arch.ram_psize);
 	ptel |= pa;
+
 	if (pte_index >= HPT_NPTE)
 		return H_PARAMETER;
 	if (likely((flags & H_EXACT) == 0)) {
 		pte_index &= ~7UL;
 		hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
-		for (i = 0; ; ++i) {
-			if (i == 8)
-				return H_PTEG_FULL;
+		for (i = 0; i < 8; ++i) {
 			if ((*hpte & HPTE_V_VALID) == 0 &&
-			    lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID))
+			    try_lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID))
 				break;
 			hpte += 2;
 		}
+		if (i == 8) {
+			/*
+			 * Since try_lock_hpte doesn't retry (not even stdcx.
+			 * failures), it could be that there is a free slot
+			 * but we transiently failed to lock it.  Try again,
+			 * actually locking each slot and checking it.
+			 */
+			hpte -= 16;
+			for (i = 0; i < 8; ++i) {
+				while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
+					cpu_relax();
+				if ((*hpte & HPTE_V_VALID) == 0)
+					break;
+				*hpte &= ~HPTE_V_HVLOCK;
+				hpte += 2;
+			}
+			if (i == 8)
+				return H_PTEG_FULL;
+		}
 		pte_index += i;
 	} else {
 		hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
-		if (!lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID))
-			return H_PTEG_FULL;
+		if (!try_lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID)) {
+			/* Lock the slot and check again */
+			while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
+				cpu_relax();
+			if (*hpte & HPTE_V_VALID) {
+				*hpte &= ~HPTE_V_HVLOCK;
+				return H_PTEG_FULL;
+			}
+		}
 	}
 
 	/* Save away the guest's idea of the second HPTE dword */
@@ -192,7 +197,7 @@ long kvmppc_h_remove(struct kvm_vcpu *vcpu, unsigned long flags,
 	if (pte_index >= HPT_NPTE)
 		return H_PARAMETER;
 	hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
-	while (!lock_hpte(hpte, HPTE_V_HVLOCK))
+	while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
 		cpu_relax();
 	if ((hpte[0] & HPTE_V_VALID) == 0 ||
 	    ((flags & H_AVPN) && (hpte[0] & ~0x7fUL) != avpn) ||
@@ -251,7 +256,7 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 			break;
 		}
 		hp = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
-		while (!lock_hpte(hp, HPTE_V_HVLOCK))
+		while (!try_lock_hpte(hp, HPTE_V_HVLOCK))
 			cpu_relax();
 		found = 0;
 		if (hp[0] & HPTE_V_VALID) {
@@ -313,7 +318,7 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 	if (pte_index >= HPT_NPTE)
 		return H_PARAMETER;
 	hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
-	while (!lock_hpte(hpte, HPTE_V_HVLOCK))
+	while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
 		cpu_relax();
 	if ((hpte[0] & HPTE_V_VALID) == 0 ||
 	    ((flags & H_AVPN) && (hpte[0] & ~0x7fUL) != avpn)) {
-- 
1.7.5.4
