Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 40B621008EA
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Jun 2010 09:25:23 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 18/26] KVM: PPC: KVM PV guest stubs
Date: Sat, 26 Jun 2010 01:25:06 +0200
Message-Id: <1277508314-915-19-git-send-email-agraf@suse.de>
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

We will soon start and replace instructions from the text section with
other, paravirtualized versions. To ease the readability of those patches
I split out the generic looping and magic page mapping code out.

This patch still only contains stubs. But at least it loops through the
text section :).

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kernel/kvm.c |   59 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 2d8dd73..d873bc6 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -32,3 +32,62 @@
 #define KVM_MAGIC_PAGE		(-4096L)
 #define magic_var(x) KVM_MAGIC_PAGE + offsetof(struct kvm_vcpu_arch_shared, x)
 
+static bool kvm_patching_worked = true;
+
+static void kvm_map_magic_page(void *data)
+{
+	kvm_hypercall2(KVM_HC_PPC_MAP_MAGIC_PAGE,
+		       KVM_MAGIC_PAGE,  /* Physical Address */
+		       KVM_MAGIC_PAGE); /* Effective Address */
+}
+
+static void kvm_check_ins(u32 *inst)
+{
+	u32 _inst = *inst;
+	u32 inst_no_rt = _inst & ~KVM_MASK_RT;
+	u32 inst_rt = _inst & KVM_MASK_RT;
+
+	switch (inst_no_rt) {
+	}
+
+	switch (_inst) {
+	}
+
+	flush_icache_range((ulong)inst, (ulong)inst + 4);
+}
+
+static void kvm_use_magic_page(void)
+{
+	u32 *p;
+	u32 *start, *end;
+
+	/* Tell the host to map the magic page to -4096 on all CPUs */
+
+	on_each_cpu(kvm_map_magic_page, NULL, 1);
+
+	/* Now loop through all code and find instructions */
+
+	start = (void*)_stext;
+	end = (void*)_etext;
+
+	for (p = start; p < end; p++)
+		kvm_check_ins(p);
+}
+
+static int __init kvm_guest_init(void)
+{
+	char *p;
+
+	if (!kvm_para_available())
+		return 0;
+
+	if (kvm_para_has_feature(KVM_FEATURE_MAGIC_PAGE))
+		kvm_use_magic_page();
+
+	printk(KERN_INFO "KVM: Live patching for a fast VM %s\n",
+			 kvm_patching_worked ? "worked" : "failed");
+
+	return 0;
+}
+
+postcore_initcall(kvm_guest_init);
-- 
1.6.0.2
