Return-Path: <yamada.masahiro@socionext.com>
Received: from condef001-v.nifty.com (condef001-v.nifty.com [210.131.4.238])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sT4Cp3SnkzDrqg
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 21:30:46 +1000 (AEST)
Received: from conuserg-08.nifty.com ([10.26.8.71])by condef001-v.nifty.com
 with ESMTP id u86BLkxH001977
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 20:21:59 +0900
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 Geoff Levand <geoff@infradead.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Khem Raj <raj.khem@gmail.com>,
 Cyril Bur <cyrilbur@gmail.com>, kvm@vger.kernel.org,
 Simon Guo <wei.guo.simon@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Kees Cook <keescook@chromium.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
 Rashmica Gupta <rashmicy@gmail.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: squash lines for simple wrapper functions
Date: Tue,  6 Sep 2016 20:21:50 +0900
Message-Id: <1473160910-20247-1-git-send-email-yamada.masahiro@socionext.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove unneeded variables and assignments.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/powerpc/kernel/ptrace.c            | 42 ++++++++++-----------------------
 arch/powerpc/kvm/booke.c                |  5 +---
 arch/powerpc/platforms/ps3/repository.c | 22 ++++-------------
 3 files changed, 18 insertions(+), 51 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index bf91658..1979bae 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1714,11 +1714,8 @@ static int ppr_get(struct task_struct *target,
 		      unsigned int pos, unsigned int count,
 		      void *kbuf, void __user *ubuf)
 {
-	int ret;
-
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				&target->thread.ppr, 0, sizeof(u64));
-	return ret;
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				   &target->thread.ppr, 0, sizeof(u64));
 }
 
 static int ppr_set(struct task_struct *target,
@@ -1726,11 +1723,8 @@ static int ppr_set(struct task_struct *target,
 		      unsigned int pos, unsigned int count,
 		      const void *kbuf, const void __user *ubuf)
 {
-	int ret;
-
-	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				&target->thread.ppr, 0, sizeof(u64));
-	return ret;
+	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				  &target->thread.ppr, 0, sizeof(u64));
 }
 
 static int dscr_get(struct task_struct *target,
@@ -1738,22 +1732,16 @@ static int dscr_get(struct task_struct *target,
 		      unsigned int pos, unsigned int count,
 		      void *kbuf, void __user *ubuf)
 {
-	int ret;
-
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				&target->thread.dscr, 0, sizeof(u64));
-	return ret;
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				   &target->thread.dscr, 0, sizeof(u64));
 }
 static int dscr_set(struct task_struct *target,
 		      const struct user_regset *regset,
 		      unsigned int pos, unsigned int count,
 		      const void *kbuf, const void __user *ubuf)
 {
-	int ret;
-
-	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				&target->thread.dscr, 0, sizeof(u64));
-	return ret;
+	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				  &target->thread.dscr, 0, sizeof(u64));
 }
 #endif
 #ifdef CONFIG_PPC_BOOK3S_64
@@ -1762,22 +1750,16 @@ static int tar_get(struct task_struct *target,
 		      unsigned int pos, unsigned int count,
 		      void *kbuf, void __user *ubuf)
 {
-	int ret;
-
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				&target->thread.tar, 0, sizeof(u64));
-	return ret;
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				   &target->thread.tar, 0, sizeof(u64));
 }
 static int tar_set(struct task_struct *target,
 		      const struct user_regset *regset,
 		      unsigned int pos, unsigned int count,
 		      const void *kbuf, const void __user *ubuf)
 {
-	int ret;
-
-	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				&target->thread.tar, 0, sizeof(u64));
-	return ret;
+	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				  &target->thread.tar, 0, sizeof(u64));
 }
 
 static int ebb_active(struct task_struct *target,
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 02b4672..881e136 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1767,10 +1767,7 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
                                   struct kvm_translation *tr)
 {
-	int r;
-
-	r = kvmppc_core_vcpu_translate(vcpu, tr);
-	return r;
+	return kvmppc_core_vcpu_translate(vcpu, tr);
 }
 
 int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
index 814a7ea..50dbaf2 100644
--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -170,14 +170,8 @@ int ps3_repository_read_bus_str(unsigned int bus_index, const char *bus_str,
 
 int ps3_repository_read_bus_id(unsigned int bus_index, u64 *bus_id)
 {
-	int result;
-
-	result = read_node(PS3_LPAR_ID_PME,
-		make_first_field("bus", bus_index),
-		make_field("id", 0),
-		0, 0,
-		bus_id, NULL);
-	return result;
+	return read_node(PS3_LPAR_ID_PME, make_first_field("bus", bus_index),
+			 make_field("id", 0), 0, 0, bus_id, NULL);
 }
 
 int ps3_repository_read_bus_type(unsigned int bus_index,
@@ -224,15 +218,9 @@ int ps3_repository_read_dev_str(unsigned int bus_index,
 int ps3_repository_read_dev_id(unsigned int bus_index, unsigned int dev_index,
 	u64 *dev_id)
 {
-	int result;
-
-	result = read_node(PS3_LPAR_ID_PME,
-		make_first_field("bus", bus_index),
-		make_field("dev", dev_index),
-		make_field("id", 0),
-		0,
-		dev_id, NULL);
-	return result;
+	return read_node(PS3_LPAR_ID_PME, make_first_field("bus", bus_index),
+			 make_field("dev", dev_index), make_field("id", 0), 0,
+			 dev_id, NULL);
 }
 
 int ps3_repository_read_dev_type(unsigned int bus_index,
-- 
1.9.1
