Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C018D1401FA
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:28:02 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 5 May 2014 11:28:02 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D8FB22CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:59 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4516q1m55574542
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:06:52 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s451Rwl4013873
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:27:59 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 17/22] powerpc/kvm: Connect EEH RTAS emulation backend
Date: Mon,  5 May 2014 11:28:06 +1000
Message-Id: <1399253291-3975-18-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1399253291-3975-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1399253291-3975-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch intends to connect the KVM module with the backend for
EEH RTAS emulation. In turn, we can handle the EEH RTAS services
from the guest.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_ppc.h |  7 +++++++
 arch/powerpc/kvm/book3s_rtas.c     | 40 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 4096f16..18b51a1 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -29,6 +29,9 @@
 #include <linux/kvm_types.h>
 #include <linux/kvm_host.h>
 #include <linux/bug.h>
+#ifdef CONFIG_KVM_EEH
+#include <asm/rtas.h>
+#endif
 #ifdef CONFIG_PPC_BOOK3S
 #include <asm/kvm_book3s.h>
 #else
@@ -166,6 +169,10 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_interrupt *irq);
 extern int kvm_vm_ioctl_rtas_define_token(struct kvm *kvm, void __user *argp);
 extern int kvmppc_rtas_hcall(struct kvm_vcpu *vcpu);
 extern void kvmppc_rtas_tokens_free(struct kvm *kvm);
+#ifdef CONFIG_KVM_EEH
+extern void kvmppc_eeh_rtas(struct kvm_vcpu *vcpu,
+			    struct rtas_args *args, int flag);
+#endif
 extern int kvmppc_xics_set_xive(struct kvm *kvm, u32 irq, u32 server,
 				u32 priority);
 extern int kvmppc_xics_get_xive(struct kvm *kvm, u32 irq, u32 *server,
diff --git a/arch/powerpc/kvm/book3s_rtas.c b/arch/powerpc/kvm/book3s_rtas.c
index 7a05315..17bdb4a 100644
--- a/arch/powerpc/kvm/book3s_rtas.c
+++ b/arch/powerpc/kvm/book3s_rtas.c
@@ -16,6 +16,8 @@
 #include <asm/kvm_ppc.h>
 #include <asm/hvcall.h>
 #include <asm/rtas.h>
+#include <asm/ppc-pci.h>
+#include <asm/eeh.h>
 
 #ifdef CONFIG_KVM_XICS
 static void kvm_rtas_set_xive(struct kvm_vcpu *vcpu, struct rtas_args *args)
@@ -103,6 +105,24 @@ out:
 }
 #endif /* CONFIG_KVM_XICS */
 
+#ifdef CONFIG_KVM_EEH
+
+#define KVM_RTAS_EEH_FUNC(name, flag)			\
+static void kvm_rtas_eeh_##name(struct kvm_vcpu *vcpu,	\
+				struct rtas_args *args)	\
+{							\
+	kvmppc_eeh_rtas(vcpu, args, flag);		\
+}
+
+KVM_RTAS_EEH_FUNC(set_option,	eeh_rtas_set_option)
+KVM_RTAS_EEH_FUNC(set_reset,	eeh_rtas_set_slot_reset)
+KVM_RTAS_EEH_FUNC(read_state2,	eeh_rtas_read_slot_reset_state2)
+KVM_RTAS_EEH_FUNC(addr_info2,	eeh_rtas_get_config_addr_info2)
+KVM_RTAS_EEH_FUNC(error_detail,	eeh_rtas_slot_error_detail)
+KVM_RTAS_EEH_FUNC(configure_pe,	eeh_rtas_configure_pe)
+
+#endif /* CONFIG_KVM_EEH */
+
 struct rtas_handler {
 	void (*handler)(struct kvm_vcpu *vcpu, struct rtas_args *args);
 	char *name;
@@ -115,6 +135,26 @@ static struct rtas_handler rtas_handlers[] = {
 	{ .name = "ibm,int-off",  .handler = kvm_rtas_int_off },
 	{ .name = "ibm,int-on",   .handler = kvm_rtas_int_on },
 #endif
+#ifdef CONFIG_KVM_EEH
+	{ .name = "ibm,set-eeh-option",
+	  .handler = kvm_rtas_eeh_set_option
+	},
+	{ .name = "ibm,set-slot-reset",
+	  .handler = kvm_rtas_eeh_set_reset
+	},
+	{ .name = "ibm,read-slot-reset-state2",
+	  .handler = kvm_rtas_eeh_read_state2
+	},
+	{ .name = "ibm,get-config-addr-info2",
+	  .handler = kvm_rtas_eeh_addr_info2
+	},
+	{ .name = "ibm,slot-error-detail",
+	  .handler = kvm_rtas_eeh_error_detail
+	},
+	{ .name = "ibm,configure-pe",
+	  .handler = kvm_rtas_eeh_configure_pe
+	}
+#endif /* CONFIG_KVM_EEH */
 };
 
 struct rtas_token_definition {
-- 
1.8.3.2
