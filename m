Return-Path: <joe@perches.com>
Received: from mail.perches.com (mail.perches.com [173.55.12.10])
	by ozlabs.org (Postfix) with ESMTP id 21E10B70AE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 12 Sep 2010 15:11:08 +1000 (EST)
From: Joe Perches <joe@perches.com>
To: Jiri Kosina <trivial@kernel.org>
Subject: [PATCH 05/11] arch/powerpc: Remove pr_<level> uses of KERN_<level>
Date: Sat, 11 Sep 2010 22:10:53 -0700
Message-Id: <e6f85a0d313ac767da0c9f2af4ff51f022f1e08c.1284267142.git.joe@perches.com>
In-Reply-To: <cover.1284267142.git.joe@perches.com>
References: <cover.1284267142.git.joe@perches.com>
Cc: kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
	Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Avi Kivity <avi@redhat.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/powerpc/kvm/emulate.c |    4 ++--
 arch/powerpc/sysdev/pmi.c  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
index 4568ec3..b83ba58 100644
--- a/arch/powerpc/kvm/emulate.c
+++ b/arch/powerpc/kvm/emulate.c
@@ -145,7 +145,7 @@ int kvmppc_emulate_instruction(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	/* this default type might be overwritten by subcategories */
 	kvmppc_set_exit_type(vcpu, EMULATED_INST_EXITS);
 
-	pr_debug(KERN_INFO "Emulating opcode %d / %d\n", get_op(inst), get_xop(inst));
+	pr_debug("Emulating opcode %d / %d\n", get_op(inst), get_xop(inst));
 
 	switch (get_op(inst)) {
 	case OP_TRAP:
@@ -275,7 +275,7 @@ int kvmppc_emulate_instruction(struct kvm_run *run, struct kvm_vcpu *vcpu)
 			{
 				u64 jd = get_tb() - vcpu->arch.dec_jiffies;
 				kvmppc_set_gpr(vcpu, rt, vcpu->arch.dec - jd);
-				pr_debug(KERN_INFO "mfDEC: %x - %llx = %lx\n",
+				pr_debug("mfDEC: %x - %llx = %lx\n",
 					 vcpu->arch.dec, jd,
 					 kvmppc_get_gpr(vcpu, rt));
 				break;
diff --git a/arch/powerpc/sysdev/pmi.c b/arch/powerpc/sysdev/pmi.c
index 24a0bb9..4260f36 100644
--- a/arch/powerpc/sysdev/pmi.c
+++ b/arch/powerpc/sysdev/pmi.c
@@ -114,7 +114,7 @@ static void pmi_notify_handlers(struct work_struct *work)
 
 	spin_lock(&data->handler_spinlock);
 	list_for_each_entry(handler, &data->handler, node) {
-		pr_debug(KERN_INFO "pmi: notifying handler %p\n", handler);
+		pr_debug("pmi: notifying handler %p\n", handler);
 		if (handler->type == data->msg.type)
 			handler->handle_pmi_message(data->msg);
 	}
-- 
1.7.3.rc1
