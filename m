Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6D1AC2C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 03:49:01 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 8 Oct 2013 02:49:01 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3DB032CE8053
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 03:48:59 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r97GmlOc8192472
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 03:48:47 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r97GmwPG025299
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 03:48:58 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V2 14/14] kvm: powerpc: book3s: drop is_hv_enabled
Date: Mon,  7 Oct 2013 22:18:02 +0530
Message-Id: <1381164482-31001-15-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1381164482-31001-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1381164482-31001-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

drop is_hv_enabled, because that should not be a callback property

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_ppc.h | 6 +++++-
 arch/powerpc/kvm/book3s.c          | 6 +++---
 arch/powerpc/kvm/book3s_hv.c       | 1 -
 arch/powerpc/kvm/book3s_pr.c       | 1 -
 arch/powerpc/kvm/book3s_xics.c     | 2 +-
 arch/powerpc/kvm/powerpc.c         | 2 +-
 6 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 3069cf4..c8317fb 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -183,7 +183,6 @@ union kvmppc_one_reg {
 
 struct kvmppc_ops {
 	struct module *owner;
-	bool is_hv_enabled;
 	int (*get_sregs)(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
 	int (*set_sregs)(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
 	int (*get_one_reg)(struct kvm_vcpu *vcpu, u64 id,
@@ -232,6 +231,11 @@ struct kvmppc_ops {
 extern struct kvmppc_ops *kvmppc_hv_ops;
 extern struct kvmppc_ops *kvmppc_pr_ops;
 
+static inline bool is_kvmppc_hv_enabled(struct kvm *kvm)
+{
+	return kvm->arch.kvm_ops == kvmppc_hv_ops;
+}
+
 /*
  * Cuts out inst bits with ordering according to spec.
  * That means the leftmost bit is zero. All given bits are included.
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index ad8f6ed..8912608 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -72,7 +72,7 @@ void kvmppc_core_load_guest_debugstate(struct kvm_vcpu *vcpu)
 
 static inline unsigned long kvmppc_interrupt_offset(struct kvm_vcpu *vcpu)
 {
-	if (!vcpu->kvm->arch.kvm_ops->is_hv_enabled)
+	if (!is_kvmppc_hv_enabled(vcpu->kvm))
 		return to_book3s(vcpu)->hior;
 	return 0;
 }
@@ -80,7 +80,7 @@ static inline unsigned long kvmppc_interrupt_offset(struct kvm_vcpu *vcpu)
 static inline void kvmppc_update_int_pending(struct kvm_vcpu *vcpu,
 			unsigned long pending_now, unsigned long old_pending)
 {
-	if (vcpu->kvm->arch.kvm_ops->is_hv_enabled)
+	if (is_kvmppc_hv_enabled(vcpu->kvm))
 		return;
 	if (pending_now)
 		vcpu->arch.shared->int_pending = 1;
@@ -94,7 +94,7 @@ static inline bool kvmppc_critical_section(struct kvm_vcpu *vcpu)
 	ulong crit_r1;
 	bool crit;
 
-	if (vcpu->kvm->arch.kvm_ops->is_hv_enabled)
+	if (is_kvmppc_hv_enabled(vcpu->kvm))
 		return false;
 
 	crit_raw = vcpu->arch.shared->critical;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 31922d5..b5229eb 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2160,7 +2160,6 @@ static long kvm_arch_vm_ioctl_hv(struct file *filp,
 }
 
 static struct kvmppc_ops kvm_ops_hv = {
-	.is_hv_enabled = true,
 	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_hv,
 	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_hv,
 	.get_one_reg = kvmppc_get_one_reg_hv,
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index fbd985f..df36cf2 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1526,7 +1526,6 @@ static long kvm_arch_vm_ioctl_pr(struct file *filp,
 }
 
 static struct kvmppc_ops kvm_ops_pr = {
-	.is_hv_enabled = false,
 	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_pr,
 	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_pr,
 	.get_one_reg = kvmppc_get_one_reg_pr,
diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index 76ef525..20d56ec 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -818,7 +818,7 @@ int kvmppc_xics_hcall(struct kvm_vcpu *vcpu, u32 req)
 	}
 
 	/* Check for real mode returning too hard */
-	if (xics->real_mode && vcpu->kvm->arch.kvm_ops->is_hv_enabled)
+	if (xics->real_mode && is_kvmppc_hv_enabled(vcpu->kvm))
 		return kvmppc_xics_rm_complete(vcpu, req);
 
 	switch (req) {
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 00a995a..058f9d6 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -200,7 +200,7 @@ int kvmppc_sanity_check(struct kvm_vcpu *vcpu)
 		goto out;
 
 	/* HV KVM can only do PAPR mode for now */
-	if (!vcpu->arch.papr_enabled && vcpu->kvm->arch.kvm_ops->is_hv_enabled)
+	if (!vcpu->arch.papr_enabled && is_kvmppc_hv_enabled(vcpu->kvm))
 		goto out;
 
 #ifdef CONFIG_KVM_BOOKE_HV
-- 
1.8.1.2
