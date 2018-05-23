Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rPl64LCSzF0SN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 17:48:18 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id p14-v6so10069450pfh.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 00:48:18 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v4 23/29] KVM: PPC: Book3S PR: add guard code to prevent
 returning to guest with PR=0 and Transactional state
Date: Wed, 23 May 2018 15:02:06 +0800
Message-Id: <1527058932-7434-24-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1527058932-7434-1-git-send-email-wei.guo.simon@gmail.com>
References: <1527058932-7434-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

Currently PR KVM doesn't support transaction memory at guest privilege
state.

This patch adds a check at setting guest msr, so that we can never return
to guest with PR=0 and TS=0b10. A tabort will be emulated to indicate
this and fail transaction immediately.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/include/uapi/asm/tm.h |  2 +-
 arch/powerpc/kvm/book3s.h          |  6 ++++++
 arch/powerpc/kvm/book3s_emulate.c  |  2 +-
 arch/powerpc/kvm/book3s_pr.c       | 13 ++++++++++++-
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/tm.h b/arch/powerpc/include/uapi/asm/tm.h
index e1bf0e2..e2947c9 100644
--- a/arch/powerpc/include/uapi/asm/tm.h
+++ b/arch/powerpc/include/uapi/asm/tm.h
@@ -13,7 +13,7 @@
 #define TM_CAUSE_TLBI		0xdc
 #define TM_CAUSE_FAC_UNAV	0xda
 #define TM_CAUSE_SYSCALL	0xd8
-#define TM_CAUSE_MISC		0xd6  /* future use */
+#define TM_CAUSE_PRIV_T		0xd6
 #define TM_CAUSE_SIGNAL		0xd4
 #define TM_CAUSE_ALIGNMENT	0xd2
 #define TM_CAUSE_EMULATE	0xd0
diff --git a/arch/powerpc/kvm/book3s.h b/arch/powerpc/kvm/book3s.h
index 4ad5e28..14ef035 100644
--- a/arch/powerpc/kvm/book3s.h
+++ b/arch/powerpc/kvm/book3s.h
@@ -31,4 +31,10 @@ extern int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu,
 extern int kvmppc_book3s_init_pr(void);
 extern void kvmppc_book3s_exit_pr(void);
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+extern void kvmppc_emulate_tabort(struct kvm_vcpu *vcpu, int ra_val);
+#else
+static inline void kvmppc_emulate_tabort(struct kvm_vcpu *vcpu, int ra_val) {}
+#endif
+
 #endif
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 34f910e..67d0fb40 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -199,7 +199,7 @@ static void kvmppc_emulate_trchkpt(struct kvm_vcpu *vcpu)
 }
 
 /* emulate tabort. at guest privilege state */
-static void kvmppc_emulate_tabort(struct kvm_vcpu *vcpu, int ra_val)
+void kvmppc_emulate_tabort(struct kvm_vcpu *vcpu, int ra_val)
 {
 	/* currently we only emulate tabort. but no emulation of other
 	 * tabort variants since there is no kernel usage of them at
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 5359f9c..526c928 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -446,12 +446,23 @@ static void kvm_set_spte_hva_pr(struct kvm *kvm, unsigned long hva, pte_t pte)
 
 static void kvmppc_set_msr_pr(struct kvm_vcpu *vcpu, u64 msr)
 {
-	ulong old_msr = kvmppc_get_msr(vcpu);
+	ulong old_msr;
 
 #ifdef EXIT_DEBUG
 	printk(KERN_INFO "KVM: Set MSR to 0x%llx\n", msr);
 #endif
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	/* We should never target guest MSR to TS=10 && PR=0,
+	 * since we always fail transaction for guest privilege
+	 * state.
+	 */
+	if (!(msr & MSR_PR) && MSR_TM_TRANSACTIONAL(msr))
+		kvmppc_emulate_tabort(vcpu,
+			TM_CAUSE_PRIV_T | TM_CAUSE_PERSISTENT);
+#endif
+
+	old_msr = kvmppc_get_msr(vcpu);
 	msr &= to_book3s(vcpu)->msr_mask;
 	kvmppc_set_msr_fast(vcpu, msr);
 	kvmppc_recalc_shadow_msr(vcpu);
-- 
1.8.3.1
