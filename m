Return-Path: <rickard_strandqvist@spectrumdigital.se>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
 [209.85.212.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7AA7C1A09D2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 04:26:18 +1100 (AEDT)
Received: by mail-wi0-f170.google.com with SMTP id bs8so5325538wib.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Dec 2014 09:26:15 -0800 (PST)
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Alexander Graf <agraf@suse.de>,
	Gleb Natapov <gleb@kernel.org>
Subject: [PATCH] arch: powerpc: kvm: book3s.c:  Remove some unused functions
Date: Sun,  7 Dec 2014 18:28:54 +0100
Message-Id: <1417973334-13318-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Cc: kvm@vger.kernel.org,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Removes some functions that are not used anywhere:
kvmppc_core_load_guest_debugstate() kvmppc_core_load_host_debugstate()

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/powerpc/kvm/book3s.c |    8 --------
 arch/powerpc/kvm/e500.c   |    8 --------
 2 files changed, 16 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index b32db4b..888bf46 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -64,14 +64,6 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ NULL }
 };
 
-void kvmppc_core_load_host_debugstate(struct kvm_vcpu *vcpu)
-{
-}
-
-void kvmppc_core_load_guest_debugstate(struct kvm_vcpu *vcpu)
-{
-}
-
 void kvmppc_unfixup_split_real(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.hflags & BOOK3S_HFLAG_SPLIT_HACK) {
diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index 2e02ed8..be4f3fd 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -299,14 +299,6 @@ void kvmppc_mmu_msr_notify(struct kvm_vcpu *vcpu, u32 old_msr)
 	kvmppc_e500_recalc_shadow_pid(to_e500(vcpu));
 }
 
-void kvmppc_core_load_host_debugstate(struct kvm_vcpu *vcpu)
-{
-}
-
-void kvmppc_core_load_guest_debugstate(struct kvm_vcpu *vcpu)
-{
-}
-
 static void kvmppc_core_vcpu_load_e500(struct kvm_vcpu *vcpu, int cpu)
 {
 	kvmppc_booke_vcpu_load(vcpu, cpu);
-- 
1.7.10.4
