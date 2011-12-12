Return-Path: <paulus@ozlabs.org>
Date: Tue, 13 Dec 2011 09:26:50 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH v3 02/14] KVM: PPC: Move kvm_vcpu_ioctl_[gs]et_one_reg down
 to platform-specific code
Message-ID: <20111212222650.GC18868@bloggs.ozlabs.ibm.com>
References: <20111212222347.GA18868@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111212222347.GA18868@bloggs.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves the get/set_one_reg implementation down from powerpc.c into
booke.c, book3s_pr.c and book3s_hv.c.  This avoids #ifdefs in C code,
but more importantly, it fixes a bug on Book3s HV where we were
accessing beyond the end of the kvm_vcpu struct (via the to_book3s()
macro) and corrupting memory, causing random crashes and file corruption.

On Book3s HV we only accept setting the HIOR to zero, since the guest
runs in supervisor mode and its vectors are never offset from zero.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_ppc.h |    3 ++
 arch/powerpc/kvm/book3s_hv.c       |   33 ++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_pr.c       |   33 ++++++++++++++++++++++++++++++
 arch/powerpc/kvm/booke.c           |   10 +++++++++
 arch/powerpc/kvm/powerpc.c         |   39 ------------------------------------
 5 files changed, 79 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 5192c2e..fc2d696 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -176,6 +176,9 @@ int kvmppc_core_set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
 void kvmppc_get_sregs_ivor(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
 int kvmppc_set_sregs_ivor(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
 
+int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg);
+int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg);
+
 void kvmppc_set_pid(struct kvm_vcpu *vcpu, u32 pid);
 
 #ifdef CONFIG_KVM_BOOK3S_64_HV
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index b1e3b9c..da7db14 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -392,6 +392,39 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
+{
+	int r = -EINVAL;
+
+	switch (reg->id) {
+	case KVM_ONE_REG_PPC_HIOR:
+		reg->u.reg64 = 0;
+		r = 0;
+		break;
+	default:
+		break;
+	}
+
+	return r;
+}
+
+int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
+{
+	int r = -EINVAL;
+
+	switch (reg->id) {
+	case KVM_ONE_REG_PPC_HIOR:
+		/* Only allow this to be set to zero */
+		if (reg->u.reg64 == 0)
+			r = 0;
+		break;
+	default:
+		break;
+	}
+
+	return r;
+}
+
 int kvmppc_core_check_processor_compat(void)
 {
 	if (cpu_has_feature(CPU_FTR_HVMODE))
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index ae6a034..ddd92a5 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -863,6 +863,39 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
+{
+	int r = -EINVAL;
+
+	switch (reg->id) {
+	case KVM_ONE_REG_PPC_HIOR:
+		reg->u.reg64 = to_book3s(vcpu)->hior;
+		r = 0;
+		break;
+	default:
+		break;
+	}
+
+	return r;
+}
+
+int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
+{
+	int r = -EINVAL;
+
+	switch (reg->id) {
+	case KVM_ONE_REG_PPC_HIOR:
+		to_book3s(vcpu)->hior = reg->u.reg64;
+		to_book3s(vcpu)->hior_explicit = true;
+		r = 0;
+		break;
+	default:
+		break;
+	}
+
+	return r;
+}
+
 int kvmppc_core_check_processor_compat(void)
 {
 	return 0;
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 9e41f45..ee9e1ee 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -887,6 +887,16 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 	return kvmppc_core_set_sregs(vcpu, sregs);
 }
 
+int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
+{
+	return -EINVAL;
+}
+
+int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
+{
+	return -EINVAL;
+}
+
 int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
 	return -ENOTSUPP;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index b939b8a..69367ac 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -624,45 +624,6 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 	return r;
 }
 
-static int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu,
-				      struct kvm_one_reg *reg)
-{
-	int r = -EINVAL;
-
-	switch (reg->id) {
-#ifdef CONFIG_PPC_BOOK3S
-	case KVM_ONE_REG_PPC_HIOR:
-		reg->u.reg64 = to_book3s(vcpu)->hior;
-		r = 0;
-		break;
-#endif
-	default:
-		break;
-	}
-
-	return r;
-}
-
-static int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu,
-				      struct kvm_one_reg *reg)
-{
-	int r = -EINVAL;
-
-	switch (reg->id) {
-#ifdef CONFIG_PPC_BOOK3S
-	case KVM_ONE_REG_PPC_HIOR:
-		to_book3s(vcpu)->hior = reg->u.reg64;
-		to_book3s(vcpu)->hior_explicit = true;
-		r = 0;
-		break;
-#endif
-	default:
-		break;
-	}
-
-	return r;
-}
-
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
                                     struct kvm_mp_state *mp_state)
 {
-- 
1.7.7.3
