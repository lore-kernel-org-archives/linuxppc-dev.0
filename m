Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 863F7B7273
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Jul 2010 22:48:19 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 19/27] KVM: PPC: PV tlbsync to nop
Date: Thu, 29 Jul 2010 14:48:00 +0200
Message-Id: <1280407688-9815-20-git-send-email-agraf@suse.de>
In-Reply-To: <1280407688-9815-1-git-send-email-agraf@suse.de>
References: <1280407688-9815-1-git-send-email-agraf@suse.de>
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

With our current MMU scheme we don't need to know about the tlbsync instruction.
So we can just nop it out.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

v1 -> v2:

  - use kvm_patch_ins
---
 arch/powerpc/kernel/kvm.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 9ec572c..3258922 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -62,6 +62,8 @@
 #define KVM_INST_MTSPR_DAR	0x7c1303a6
 #define KVM_INST_MTSPR_DSISR	0x7c1203a6
 
+#define KVM_INST_TLBSYNC	0x7c00046c
+
 static bool kvm_patching_worked = true;
 
 static inline void kvm_patch_ins(u32 *inst, u32 new_inst)
@@ -98,6 +100,11 @@ static void kvm_patch_ins_stw(u32 *inst, long addr, u32 rt)
 	kvm_patch_ins(inst, KVM_INST_STW | rt | (addr & 0x0000fffc));
 }
 
+static void kvm_patch_ins_nop(u32 *inst)
+{
+	kvm_patch_ins(inst, KVM_INST_NOP);
+}
+
 static void kvm_map_magic_page(void *data)
 {
 	kvm_hypercall2(KVM_HC_PPC_MAP_MAGIC_PAGE,
@@ -166,6 +173,11 @@ static void kvm_check_ins(u32 *inst)
 	case KVM_INST_MTSPR_DSISR:
 		kvm_patch_ins_stw(inst, magic_var(dsisr), inst_rt);
 		break;
+
+	/* Nops */
+	case KVM_INST_TLBSYNC:
+		kvm_patch_ins_nop(inst);
+		break;
 	}
 
 	switch (_inst) {
-- 
1.6.0.2
