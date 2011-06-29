Return-Path: <paulus@ozlabs.org>
Date: Wed, 29 Jun 2011 20:19:22 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
	Alexander Graf <agraf@suse.de>
Subject: [PATCH 06/17] KVM: PPC: Pass init/destroy vm and prepare/commit
	memory region ops down
Message-ID: <20110629101922.GG25406@bloggs.ozlabs.ibm.com>
References: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This arranges for the top-level arch/powerpc/kvm/powerpc.c file to
pass down some of the calls it gets to the lower-level subarchitecture
specific code.  The lower-level implementations (in booke.c and book3s.c)
are no-ops.  The coming book3s_hv.c will need this.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_ppc.h |    7 +++++++
 arch/powerpc/kvm/book3s_pr.c       |   20 ++++++++++++++++++++
 arch/powerpc/kvm/booke.c           |   20 ++++++++++++++++++++
 arch/powerpc/kvm/powerpc.c         |    9 ++++++---
 4 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index c662f14..9b6f3f9 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -111,6 +111,13 @@ extern void kvmppc_core_destroy_mmu(struct kvm_vcpu *vcpu);
 extern int kvmppc_kvm_pv(struct kvm_vcpu *vcpu);
 extern void kvmppc_map_magic(struct kvm_vcpu *vcpu);
 
+extern int kvmppc_core_init_vm(struct kvm *kvm);
+extern void kvmppc_core_destroy_vm(struct kvm *kvm);
+extern int kvmppc_core_prepare_memory_region(struct kvm *kvm,
+				struct kvm_userspace_memory_region *mem);
+extern void kvmppc_core_commit_memory_region(struct kvm *kvm,
+				struct kvm_userspace_memory_region *mem);
+
 /*
  * Cuts out inst bits with ordering according to spec.
  * That means the leftmost bit is zero. All given bits are included.
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index fcdc97e..72b20b8 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -984,6 +984,26 @@ int __kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+int kvmppc_core_prepare_memory_region(struct kvm *kvm,
+				      struct kvm_userspace_memory_region *mem)
+{
+	return 0;
+}
+
+void kvmppc_core_commit_memory_region(struct kvm *kvm,
+				struct kvm_userspace_memory_region *mem)
+{
+}
+
+int kvmppc_core_init_vm(struct kvm *kvm)
+{
+	return 0;
+}
+
+void kvmppc_core_destroy_vm(struct kvm *kvm)
+{
+}
+
 static int kvmppc_book3s_init(void)
 {
 	int r;
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 9f2e4a5..9066325 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -865,6 +865,26 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 	return -ENOTSUPP;
 }
 
+int kvmppc_core_prepare_memory_region(struct kvm *kvm,
+				      struct kvm_userspace_memory_region *mem)
+{
+	return 0;
+}
+
+void kvmppc_core_commit_memory_region(struct kvm *kvm,
+				struct kvm_userspace_memory_region *mem)
+{
+}
+
+int kvmppc_core_init_vm(struct kvm *kvm)
+{
+	return 0;
+}
+
+void kvmppc_core_destroy_vm(struct kvm *kvm)
+{
+}
+
 int __init kvmppc_booke_init(void)
 {
 	unsigned long ivor[16];
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 24e2b64..0c80e15 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -148,7 +148,7 @@ void kvm_arch_check_processor_compat(void *rtn)
 
 int kvm_arch_init_vm(struct kvm *kvm)
 {
-	return 0;
+	return kvmppc_core_init_vm(kvm);
 }
 
 void kvm_arch_destroy_vm(struct kvm *kvm)
@@ -164,6 +164,9 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 		kvm->vcpus[i] = NULL;
 
 	atomic_set(&kvm->online_vcpus, 0);
+
+	kvmppc_core_destroy_vm(kvm);
+
 	mutex_unlock(&kvm->lock);
 }
 
@@ -212,7 +215,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
                                    struct kvm_userspace_memory_region *mem,
                                    int user_alloc)
 {
-	return 0;
+	return kvmppc_core_prepare_memory_region(kvm, mem);
 }
 
 void kvm_arch_commit_memory_region(struct kvm *kvm,
@@ -220,7 +223,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
                struct kvm_memory_slot old,
                int user_alloc)
 {
-       return;
+	kvmppc_core_commit_memory_region(kvm, mem);
 }
 
 
-- 
1.7.5.4
