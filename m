Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40fXYK0gGpzF14g
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 16:20:37 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id a13-v6so19492461pgu.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 May 2018 23:20:36 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: kvm-ppc@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v2 01/10] KVM: PPC: add pt_regs into kvm_vcpu_arch and move
 vcpu->arch.gpr[] into it
Date: Mon,  7 May 2018 14:20:07 +0800
Message-Id: <1525674016-6703-2-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1525674016-6703-1-git-send-email-wei.guo.simon@gmail.com>
References: <1525674016-6703-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

Current regs are scattered at kvm_vcpu_arch structure and it will
be more neat to organize them into pt_regs structure.

Also it will enable reimplementation of MMIO emulation code with
analyse_instr() later.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/include/asm/kvm_book3s.h    |  4 +--
 arch/powerpc/include/asm/kvm_book3s_64.h |  8 ++---
 arch/powerpc/include/asm/kvm_booke.h     |  4 +--
 arch/powerpc/include/asm/kvm_host.h      |  2 +-
 arch/powerpc/kernel/asm-offsets.c        |  2 +-
 arch/powerpc/kvm/book3s_64_vio_hv.c      |  2 +-
 arch/powerpc/kvm/book3s_hv_builtin.c     |  6 ++--
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      | 15 +++++----
 arch/powerpc/kvm/book3s_hv_rm_xics.c     |  2 +-
 arch/powerpc/kvm/book3s_pr.c             | 56 ++++++++++++++++----------------
 arch/powerpc/kvm/book3s_xive_template.c  |  4 +--
 arch/powerpc/kvm/e500_emulate.c          |  4 +--
 12 files changed, 55 insertions(+), 54 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 4c02a73..9de4127 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -273,12 +273,12 @@ static inline struct kvmppc_vcpu_book3s *to_book3s(struct kvm_vcpu *vcpu)
 
 static inline void kvmppc_set_gpr(struct kvm_vcpu *vcpu, int num, ulong val)
 {
-	vcpu->arch.gpr[num] = val;
+	vcpu->arch.regs.gpr[num] = val;
 }
 
 static inline ulong kvmppc_get_gpr(struct kvm_vcpu *vcpu, int num)
 {
-	return vcpu->arch.gpr[num];
+	return vcpu->arch.regs.gpr[num];
 }
 
 static inline void kvmppc_set_cr(struct kvm_vcpu *vcpu, u32 val)
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index c424e44..38dbcad 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -490,8 +490,8 @@ static inline void copy_from_checkpoint(struct kvm_vcpu *vcpu)
 	vcpu->arch.ppr = vcpu->arch.ppr_tm;
 	vcpu->arch.dscr = vcpu->arch.dscr_tm;
 	vcpu->arch.tar = vcpu->arch.tar_tm;
-	memcpy(vcpu->arch.gpr, vcpu->arch.gpr_tm,
-	       sizeof(vcpu->arch.gpr));
+	memcpy(vcpu->arch.regs.gpr, vcpu->arch.gpr_tm,
+	       sizeof(vcpu->arch.regs.gpr));
 	vcpu->arch.fp  = vcpu->arch.fp_tm;
 	vcpu->arch.vr  = vcpu->arch.vr_tm;
 	vcpu->arch.vrsave = vcpu->arch.vrsave_tm;
@@ -507,8 +507,8 @@ static inline void copy_to_checkpoint(struct kvm_vcpu *vcpu)
 	vcpu->arch.ppr_tm = vcpu->arch.ppr;
 	vcpu->arch.dscr_tm = vcpu->arch.dscr;
 	vcpu->arch.tar_tm = vcpu->arch.tar;
-	memcpy(vcpu->arch.gpr_tm, vcpu->arch.gpr,
-	       sizeof(vcpu->arch.gpr));
+	memcpy(vcpu->arch.gpr_tm, vcpu->arch.regs.gpr,
+	       sizeof(vcpu->arch.regs.gpr));
 	vcpu->arch.fp_tm  = vcpu->arch.fp;
 	vcpu->arch.vr_tm  = vcpu->arch.vr;
 	vcpu->arch.vrsave_tm = vcpu->arch.vrsave;
diff --git a/arch/powerpc/include/asm/kvm_booke.h b/arch/powerpc/include/asm/kvm_booke.h
index bc6e29e..f5fc956 100644
--- a/arch/powerpc/include/asm/kvm_booke.h
+++ b/arch/powerpc/include/asm/kvm_booke.h
@@ -36,12 +36,12 @@
 
 static inline void kvmppc_set_gpr(struct kvm_vcpu *vcpu, int num, ulong val)
 {
-	vcpu->arch.gpr[num] = val;
+	vcpu->arch.regs.gpr[num] = val;
 }
 
 static inline ulong kvmppc_get_gpr(struct kvm_vcpu *vcpu, int num)
 {
-	return vcpu->arch.gpr[num];
+	return vcpu->arch.regs.gpr[num];
 }
 
 static inline void kvmppc_set_cr(struct kvm_vcpu *vcpu, u32 val)
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 17498e9..1c93d82 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -486,7 +486,7 @@ struct kvm_vcpu_arch {
 	struct kvmppc_book3s_shadow_vcpu *shadow_vcpu;
 #endif
 
-	ulong gpr[32];
+	struct pt_regs regs;
 
 	struct thread_fp_state fp;
 
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 6bee65f..3dd6984 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -425,7 +425,7 @@ int main(void)
 	OFFSET(VCPU_HOST_STACK, kvm_vcpu, arch.host_stack);
 	OFFSET(VCPU_HOST_PID, kvm_vcpu, arch.host_pid);
 	OFFSET(VCPU_GUEST_PID, kvm_vcpu, arch.pid);
-	OFFSET(VCPU_GPRS, kvm_vcpu, arch.gpr);
+	OFFSET(VCPU_GPRS, kvm_vcpu, arch.regs.gpr);
 	OFFSET(VCPU_VRSAVE, kvm_vcpu, arch.vrsave);
 	OFFSET(VCPU_FPRS, kvm_vcpu, arch.fp.fpr);
 #ifdef CONFIG_ALTIVEC
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 6651f73..bdd872a 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -571,7 +571,7 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	page = stt->pages[idx / TCES_PER_PAGE];
 	tbl = (u64 *)page_address(page);
 
-	vcpu->arch.gpr[4] = tbl[idx % TCES_PER_PAGE];
+	vcpu->arch.regs.gpr[4] = tbl[idx % TCES_PER_PAGE];
 
 	return H_SUCCESS;
 }
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index de18299..2b12758 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -211,9 +211,9 @@ long kvmppc_h_random(struct kvm_vcpu *vcpu)
 
 	/* Only need to do the expensive mfmsr() on radix */
 	if (kvm_is_radix(vcpu->kvm) && (mfmsr() & MSR_IR))
-		r = powernv_get_random_long(&vcpu->arch.gpr[4]);
+		r = powernv_get_random_long(&vcpu->arch.regs.gpr[4]);
 	else
-		r = powernv_get_random_real_mode(&vcpu->arch.gpr[4]);
+		r = powernv_get_random_real_mode(&vcpu->arch.regs.gpr[4]);
 	if (r)
 		return H_SUCCESS;
 
@@ -562,7 +562,7 @@ unsigned long kvmppc_rm_h_xirr_x(struct kvm_vcpu *vcpu)
 {
 	if (!kvmppc_xics_enabled(vcpu))
 		return H_TOO_HARD;
-	vcpu->arch.gpr[5] = get_tb();
+	vcpu->arch.regs.gpr[5] = get_tb();
 	if (xive_enabled()) {
 		if (is_rm())
 			return xive_rm_h_xirr(vcpu);
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index e1c083f..3d3ce7a 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -418,7 +418,8 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 		    long pte_index, unsigned long pteh, unsigned long ptel)
 {
 	return kvmppc_do_h_enter(vcpu->kvm, flags, pte_index, pteh, ptel,
-				 vcpu->arch.pgdir, true, &vcpu->arch.gpr[4]);
+				 vcpu->arch.pgdir, true,
+				 &vcpu->arch.regs.gpr[4]);
 }
 
 #ifdef __BIG_ENDIAN__
@@ -565,13 +566,13 @@ long kvmppc_h_remove(struct kvm_vcpu *vcpu, unsigned long flags,
 		     unsigned long pte_index, unsigned long avpn)
 {
 	return kvmppc_do_h_remove(vcpu->kvm, flags, pte_index, avpn,
-				  &vcpu->arch.gpr[4]);
+				  &vcpu->arch.regs.gpr[4]);
 }
 
 long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
-	unsigned long *args = &vcpu->arch.gpr[4];
+	unsigned long *args = &vcpu->arch.regs.gpr[4];
 	__be64 *hp, *hptes[4];
 	unsigned long tlbrb[4];
 	long int i, j, k, n, found, indexes[4];
@@ -791,8 +792,8 @@ long kvmppc_h_read(struct kvm_vcpu *vcpu, unsigned long flags,
 			r = rev[i].guest_rpte | (r & (HPTE_R_R | HPTE_R_C));
 			r &= ~HPTE_GR_RESERVED;
 		}
-		vcpu->arch.gpr[4 + i * 2] = v;
-		vcpu->arch.gpr[5 + i * 2] = r;
+		vcpu->arch.regs.gpr[4 + i * 2] = v;
+		vcpu->arch.regs.gpr[5 + i * 2] = r;
 	}
 	return H_SUCCESS;
 }
@@ -838,7 +839,7 @@ long kvmppc_h_clear_ref(struct kvm_vcpu *vcpu, unsigned long flags,
 			}
 		}
 	}
-	vcpu->arch.gpr[4] = gr;
+	vcpu->arch.regs.gpr[4] = gr;
 	ret = H_SUCCESS;
  out:
 	unlock_hpte(hpte, v & ~HPTE_V_HVLOCK);
@@ -885,7 +886,7 @@ long kvmppc_h_clear_mod(struct kvm_vcpu *vcpu, unsigned long flags,
 			kvmppc_set_dirty_from_hpte(kvm, v, gr);
 		}
 	}
-	vcpu->arch.gpr[4] = gr;
+	vcpu->arch.regs.gpr[4] = gr;
 	ret = H_SUCCESS;
  out:
 	unlock_hpte(hpte, v & ~HPTE_V_HVLOCK);
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index 2a86261..758d1d2 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -517,7 +517,7 @@ unsigned long xics_rm_h_xirr(struct kvm_vcpu *vcpu)
 	} while (!icp_rm_try_update(icp, old_state, new_state));
 
 	/* Return the result in GPR4 */
-	vcpu->arch.gpr[4] = xirr;
+	vcpu->arch.regs.gpr[4] = xirr;
 
 	return check_too_hard(xics, icp);
 }
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index d3f304d..899bc9a 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -147,20 +147,20 @@ void kvmppc_copy_to_svcpu(struct kvm_vcpu *vcpu)
 {
 	struct kvmppc_book3s_shadow_vcpu *svcpu = svcpu_get(vcpu);
 
-	svcpu->gpr[0] = vcpu->arch.gpr[0];
-	svcpu->gpr[1] = vcpu->arch.gpr[1];
-	svcpu->gpr[2] = vcpu->arch.gpr[2];
-	svcpu->gpr[3] = vcpu->arch.gpr[3];
-	svcpu->gpr[4] = vcpu->arch.gpr[4];
-	svcpu->gpr[5] = vcpu->arch.gpr[5];
-	svcpu->gpr[6] = vcpu->arch.gpr[6];
-	svcpu->gpr[7] = vcpu->arch.gpr[7];
-	svcpu->gpr[8] = vcpu->arch.gpr[8];
-	svcpu->gpr[9] = vcpu->arch.gpr[9];
-	svcpu->gpr[10] = vcpu->arch.gpr[10];
-	svcpu->gpr[11] = vcpu->arch.gpr[11];
-	svcpu->gpr[12] = vcpu->arch.gpr[12];
-	svcpu->gpr[13] = vcpu->arch.gpr[13];
+	svcpu->gpr[0] = vcpu->arch.regs.gpr[0];
+	svcpu->gpr[1] = vcpu->arch.regs.gpr[1];
+	svcpu->gpr[2] = vcpu->arch.regs.gpr[2];
+	svcpu->gpr[3] = vcpu->arch.regs.gpr[3];
+	svcpu->gpr[4] = vcpu->arch.regs.gpr[4];
+	svcpu->gpr[5] = vcpu->arch.regs.gpr[5];
+	svcpu->gpr[6] = vcpu->arch.regs.gpr[6];
+	svcpu->gpr[7] = vcpu->arch.regs.gpr[7];
+	svcpu->gpr[8] = vcpu->arch.regs.gpr[8];
+	svcpu->gpr[9] = vcpu->arch.regs.gpr[9];
+	svcpu->gpr[10] = vcpu->arch.regs.gpr[10];
+	svcpu->gpr[11] = vcpu->arch.regs.gpr[11];
+	svcpu->gpr[12] = vcpu->arch.regs.gpr[12];
+	svcpu->gpr[13] = vcpu->arch.regs.gpr[13];
 	svcpu->cr  = vcpu->arch.cr;
 	svcpu->xer = vcpu->arch.xer;
 	svcpu->ctr = vcpu->arch.ctr;
@@ -194,20 +194,20 @@ void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu)
 	if (!svcpu->in_use)
 		goto out;
 
-	vcpu->arch.gpr[0] = svcpu->gpr[0];
-	vcpu->arch.gpr[1] = svcpu->gpr[1];
-	vcpu->arch.gpr[2] = svcpu->gpr[2];
-	vcpu->arch.gpr[3] = svcpu->gpr[3];
-	vcpu->arch.gpr[4] = svcpu->gpr[4];
-	vcpu->arch.gpr[5] = svcpu->gpr[5];
-	vcpu->arch.gpr[6] = svcpu->gpr[6];
-	vcpu->arch.gpr[7] = svcpu->gpr[7];
-	vcpu->arch.gpr[8] = svcpu->gpr[8];
-	vcpu->arch.gpr[9] = svcpu->gpr[9];
-	vcpu->arch.gpr[10] = svcpu->gpr[10];
-	vcpu->arch.gpr[11] = svcpu->gpr[11];
-	vcpu->arch.gpr[12] = svcpu->gpr[12];
-	vcpu->arch.gpr[13] = svcpu->gpr[13];
+	vcpu->arch.regs.gpr[0] = svcpu->gpr[0];
+	vcpu->arch.regs.gpr[1] = svcpu->gpr[1];
+	vcpu->arch.regs.gpr[2] = svcpu->gpr[2];
+	vcpu->arch.regs.gpr[3] = svcpu->gpr[3];
+	vcpu->arch.regs.gpr[4] = svcpu->gpr[4];
+	vcpu->arch.regs.gpr[5] = svcpu->gpr[5];
+	vcpu->arch.regs.gpr[6] = svcpu->gpr[6];
+	vcpu->arch.regs.gpr[7] = svcpu->gpr[7];
+	vcpu->arch.regs.gpr[8] = svcpu->gpr[8];
+	vcpu->arch.regs.gpr[9] = svcpu->gpr[9];
+	vcpu->arch.regs.gpr[10] = svcpu->gpr[10];
+	vcpu->arch.regs.gpr[11] = svcpu->gpr[11];
+	vcpu->arch.regs.gpr[12] = svcpu->gpr[12];
+	vcpu->arch.regs.gpr[13] = svcpu->gpr[13];
 	vcpu->arch.cr  = svcpu->cr;
 	vcpu->arch.xer = svcpu->xer;
 	vcpu->arch.ctr = svcpu->ctr;
diff --git a/arch/powerpc/kvm/book3s_xive_template.c b/arch/powerpc/kvm/book3s_xive_template.c
index c7a5dea..b5940fc 100644
--- a/arch/powerpc/kvm/book3s_xive_template.c
+++ b/arch/powerpc/kvm/book3s_xive_template.c
@@ -327,7 +327,7 @@ X_STATIC unsigned long GLUE(X_PFX,h_xirr)(struct kvm_vcpu *vcpu)
 	 */
 
 	/* Return interrupt and old CPPR in GPR4 */
-	vcpu->arch.gpr[4] = hirq | (old_cppr << 24);
+	vcpu->arch.regs.gpr[4] = hirq | (old_cppr << 24);
 
 	return H_SUCCESS;
 }
@@ -362,7 +362,7 @@ X_STATIC unsigned long GLUE(X_PFX,h_ipoll)(struct kvm_vcpu *vcpu, unsigned long
 	hirq = GLUE(X_PFX,scan_interrupts)(xc, pending, scan_poll);
 
 	/* Return interrupt and old CPPR in GPR4 */
-	vcpu->arch.gpr[4] = hirq | (xc->cppr << 24);
+	vcpu->arch.regs.gpr[4] = hirq | (xc->cppr << 24);
 
 	return H_SUCCESS;
 }
diff --git a/arch/powerpc/kvm/e500_emulate.c b/arch/powerpc/kvm/e500_emulate.c
index 990db69..8f871fb 100644
--- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -53,7 +53,7 @@ static int dbell2prio(ulong param)
 
 static int kvmppc_e500_emul_msgclr(struct kvm_vcpu *vcpu, int rb)
 {
-	ulong param = vcpu->arch.gpr[rb];
+	ulong param = vcpu->arch.regs.gpr[rb];
 	int prio = dbell2prio(param);
 
 	if (prio < 0)
@@ -65,7 +65,7 @@ static int kvmppc_e500_emul_msgclr(struct kvm_vcpu *vcpu, int rb)
 
 static int kvmppc_e500_emul_msgsnd(struct kvm_vcpu *vcpu, int rb)
 {
-	ulong param = vcpu->arch.gpr[rb];
+	ulong param = vcpu->arch.regs.gpr[rb];
 	int prio = dbell2prio(rb);
 	int pir = param & PPC_DBELL_PIR_MASK;
 	int i;
-- 
1.8.3.1
