Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id F0B9010084D
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Jun 2010 09:25:18 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 21/26] KVM: PPC: Introduce kvm_tmp framework
Date: Sat, 26 Jun 2010 01:25:09 +0200
Message-Id: <1277508314-915-22-git-send-email-agraf@suse.de>
In-Reply-To: <1277508314-915-1-git-send-email-agraf@suse.de>
References: <1277508314-915-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We will soon require more sophisticated methods to replace single instructions
with multiple instructions. We do that by branching to a memory region where we
write replacement code for the instruction to.

This region needs to be within 32 MB of the patched instruction though, because
that's the furthest we can jump with immediate branches.

So we keep 1MB of free space around in bss. After we're done initing we can just
tell the mm system that the unused pages are free, but until then we have enough
space to fit all our code in.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kernel/kvm.c |   41 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index b091f94..7e8fe6f 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -64,6 +64,8 @@
 #define KVM_INST_TLBSYNC	0x7c00046c
 
 static bool kvm_patching_worked = true;
+static char kvm_tmp[1024 * 1024];
+static int kvm_tmp_index;
 
 static void kvm_patch_ins_ld(u32 *inst, long addr, u32 rt)
 {
@@ -98,6 +100,23 @@ static void kvm_patch_ins_nop(u32 *inst)
 	*inst = KVM_INST_NOP;
 }
 
+static u32 *kvm_alloc(int len)
+{
+	u32 *p;
+
+	if ((kvm_tmp_index + len) > ARRAY_SIZE(kvm_tmp)) {
+		printk(KERN_ERR "KVM: No more space (%d + %d)\n",
+				kvm_tmp_index, len);
+		kvm_patching_worked = false;
+		return NULL;
+	}
+
+	p = (void*)&kvm_tmp[kvm_tmp_index];
+	kvm_tmp_index += len;
+
+	return p;
+}
+
 static void kvm_map_magic_page(void *data)
 {
 	kvm_hypercall2(KVM_HC_PPC_MAP_MAGIC_PAGE,
@@ -197,12 +216,27 @@ static void kvm_use_magic_page(void)
 		kvm_check_ins(p);
 }
 
+static void kvm_free_tmp(void)
+{
+	unsigned long start, end;
+
+	start = (ulong)&kvm_tmp[kvm_tmp_index + (PAGE_SIZE - 1)] & PAGE_MASK;
+	end = (ulong)&kvm_tmp[ARRAY_SIZE(kvm_tmp)] & PAGE_MASK;
+
+	/* Free the tmp space we don't need */
+	for (; start < end; start += PAGE_SIZE) {
+		ClearPageReserved(virt_to_page(start));
+		init_page_count(virt_to_page(start));
+		free_page(start);
+		totalram_pages++;
+	}
+}
+
 static int __init kvm_guest_init(void)
 {
-	char *p;
 
 	if (!kvm_para_available())
-		return 0;
+		goto free_tmp;
 
 	if (kvm_para_has_feature(KVM_FEATURE_MAGIC_PAGE))
 		kvm_use_magic_page();
@@ -210,6 +244,9 @@ static int __init kvm_guest_init(void)
 	printk(KERN_INFO "KVM: Live patching for a fast VM %s\n",
 			 kvm_patching_worked ? "worked" : "failed");
 
+free_tmp:
+	kvm_free_tmp();
+
 	return 0;
 }
 
-- 
1.6.0.2
