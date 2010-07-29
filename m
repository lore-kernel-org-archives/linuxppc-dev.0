Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 6FCA8B713A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Jul 2010 22:48:14 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 21/27] KVM: PPC: Introduce branch patching helper
Date: Thu, 29 Jul 2010 14:48:02 +0200
Message-Id: <1280407688-9815-22-git-send-email-agraf@suse.de>
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

We will need to patch several instruction streams over to a different
code path, so we need a way to patch a single instruction with a branch
somewhere else.

This patch adds a helper to facilitate this patching.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

v2 -> v3:

  - add safety check for relocatable kernels
---
 arch/powerpc/kernel/kvm.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 926f93f..239a70d 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -107,6 +107,20 @@ static void kvm_patch_ins_nop(u32 *inst)
 	kvm_patch_ins(inst, KVM_INST_NOP);
 }
 
+static void kvm_patch_ins_b(u32 *inst, int addr)
+{
+#ifdef CONFIG_RELOCATABLE
+	/* On relocatable kernels interrupts handlers and our code
+	   can be in different regions, so we don't patch them */
+
+	extern u32 __end_interrupts;
+	if ((ulong)inst < (ulong)&__end_interrupts)
+		return;
+#endif
+
+	kvm_patch_ins(inst, KVM_INST_B | (addr & KVM_INST_B_MASK));
+}
+
 static u32 *kvm_alloc(int len)
 {
 	u32 *p;
-- 
1.6.0.2
