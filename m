Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0181.outbound.protection.outlook.com [207.46.163.181])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 849911A0017
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jun 2014 08:49:24 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 3/5 v4] KVM: PPC: Book3s: Remove kvmppc_read_inst() function
Date: Sat, 28 Jun 2014 01:49:05 +0300
Message-ID: <1403909347-31622-4-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1403909347-31622-1-git-send-email-mihai.caraman@freescale.com>
References: <1403909347-31622-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the context of replacing kvmppc_ld() function calls with a version of
kvmppc_get_last_inst() which allow to fail, Alex Graf suggested this:

"If we get EMULATE_AGAIN, we just have to make sure we go back into the guest.
No need to inject an ISI into  the guest - it'll do that all by itself.
With an error returning kvmppc_get_last_inst we can just use completely
get rid of kvmppc_read_inst() and only use kvmppc_get_last_inst() instead."

As a intermediate step get rid of kvmppc_read_inst() and only use kvmppc_ld()
instead.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v4:
 - new patch

 arch/powerpc/kvm/book3s_pr.c | 85 ++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 15fd6c2..d247d88 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -665,42 +665,6 @@ static void kvmppc_giveup_fac(struct kvm_vcpu *vcpu, ulong fac)
 #endif
 }
 
-static int kvmppc_read_inst(struct kvm_vcpu *vcpu)
-{
-	ulong srr0 = kvmppc_get_pc(vcpu);
-	u32 last_inst = kvmppc_get_last_inst(vcpu);
-	int ret;
-
-	ret = kvmppc_ld(vcpu, &srr0, sizeof(u32), &last_inst, false);
-	if (ret == -ENOENT) {
-		ulong msr = kvmppc_get_msr(vcpu);
-
-		msr = kvmppc_set_field(msr, 33, 33, 1);
-		msr = kvmppc_set_field(msr, 34, 36, 0);
-		msr = kvmppc_set_field(msr, 42, 47, 0);
-		kvmppc_set_msr_fast(vcpu, msr);
-		kvmppc_book3s_queue_irqprio(vcpu, BOOK3S_INTERRUPT_INST_STORAGE);
-		return EMULATE_AGAIN;
-	}
-
-	return EMULATE_DONE;
-}
-
-static int kvmppc_check_ext(struct kvm_vcpu *vcpu, unsigned int exit_nr)
-{
-
-	/* Need to do paired single emulation? */
-	if (!(vcpu->arch.hflags & BOOK3S_HFLAG_PAIRED_SINGLE))
-		return EMULATE_DONE;
-
-	/* Read out the instruction */
-	if (kvmppc_read_inst(vcpu) == EMULATE_DONE)
-		/* Need to emulate */
-		return EMULATE_FAIL;
-
-	return EMULATE_AGAIN;
-}
-
 /* Handle external providers (FPU, Altivec, VSX) */
 static int kvmppc_handle_ext(struct kvm_vcpu *vcpu, unsigned int exit_nr,
 			     ulong msr)
@@ -1101,31 +1065,51 @@ program_interrupt:
 	case BOOK3S_INTERRUPT_VSX:
 	{
 		int ext_msr = 0;
+		int emul;
+		ulong pc;
+		u32 last_inst;
 
-		switch (exit_nr) {
-		case BOOK3S_INTERRUPT_FP_UNAVAIL: ext_msr = MSR_FP;  break;
-		case BOOK3S_INTERRUPT_ALTIVEC:    ext_msr = MSR_VEC; break;
-		case BOOK3S_INTERRUPT_VSX:        ext_msr = MSR_VSX; break;
-		}
+		if (!(vcpu->arch.hflags & BOOK3S_HFLAG_PAIRED_SINGLE)) {
+			/* Do paired single emulation */
+
+			switch (exit_nr) {
+			case BOOK3S_INTERRUPT_FP_UNAVAIL:
+				ext_msr = MSR_FP;
+				break;
+
+			case BOOK3S_INTERRUPT_ALTIVEC:
+				ext_msr = MSR_VEC;
+				break;
+
+			case BOOK3S_INTERRUPT_VSX:
+				ext_msr = MSR_VSX;
+				break;
+			}
 
-		switch (kvmppc_check_ext(vcpu, exit_nr)) {
-		case EMULATE_DONE:
-			/* everything ok - let's enable the ext */
 			r = kvmppc_handle_ext(vcpu, exit_nr, ext_msr);
 			break;
-		case EMULATE_FAIL:
+		}
+
+		pc = kvmppc_get_pc(vcpu);
+		last_inst = kvmppc_get_last_inst(vcpu);
+		emul = kvmppc_ld(vcpu, &pc, sizeof(u32), &last_inst, false);
+		if (emul == EMULATE_DONE) {
 			/* we need to emulate this instruction */
 			goto program_interrupt;
 			break;
-		default:
-			/* nothing to worry about - go again */
-			break;
+		} else {
+			r = RESUME_GUEST;
 		}
+
 		break;
 	}
 	case BOOK3S_INTERRUPT_ALIGNMENT:
-		if (kvmppc_read_inst(vcpu) == EMULATE_DONE) {
-			u32 last_inst = kvmppc_get_last_inst(vcpu);
+	{
+		ulong pc = kvmppc_get_pc(vcpu);
+		u32 last_inst = kvmppc_get_last_inst(vcpu);
+		int emul = kvmppc_ld(vcpu, &pc, sizeof(u32), &last_inst, false);
+
+		if (emul == EMULATE_DONE) {
 			u32 dsisr;
 			u64 dar;
 
@@ -1139,6 +1123,7 @@ program_interrupt:
 		}
 		r = RESUME_GUEST;
 		break;
+	}
 #ifdef CONFIG_PPC_BOOK3S_64
 	case BOOK3S_INTERRUPT_FAC_UNAVAIL:
 		kvmppc_handle_fac(vcpu, vcpu->arch.shadow_fscr >> 56);
-- 
1.7.11.7
