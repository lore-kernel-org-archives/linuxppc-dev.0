Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5E5EB140216
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:28:03 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 5 May 2014 11:28:03 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 74F462CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:28:01 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4516jj71048900
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:06:45 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s451S0Cg011664
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:28:00 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 20/22] powerpc/kvm: Infrastructure for error injection
Date: Mon,  5 May 2014 11:28:09 +1000
Message-Id: <1399253291-3975-21-git-send-email-gwshan@linux.vnet.ibm.com>
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

The patch intends to implements the infrastructure for error injection.
RTAS calls "ibm,{open-errinjct, close-errinjct, errinjct}" are handled
in the host directly. Each VM is allowed to have one opened token at
once.

There're multiple types of error injection to be supported by the system.
So we maintain an array of handlers with error type as index. The array
supports dynamic registration.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s_errinjct.h |  78 +++++++
 arch/powerpc/kvm/Makefile                  |   3 +
 arch/powerpc/kvm/book3s_errinjct.c         | 329 +++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_rtas.c             |  29 ++-
 4 files changed, 438 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/book3s_errinjct.h
 create mode 100644 arch/powerpc/kvm/book3s_errinjct.c

diff --git a/arch/powerpc/include/asm/book3s_errinjct.h b/arch/powerpc/include/asm/book3s_errinjct.h
new file mode 100644
index 0000000..35712be
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s_errinjct.h
@@ -0,0 +1,78 @@
+/*
+ * Copyright Benjamin Herrenschmidt & Gavin Shan, IBM Corporation 2014.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __POWERPC_BOOK3S_ERRINJCT_H__
+#define __POWERPC_BOOK3S_ERRINJCT_H__
+
+/* Error injection handler */
+typedef int (*kvm_errinjct_func)(struct kvm_vcpu *vcpu, rtas_arg_t buf);
+
+#ifdef CONFIG_KVM_ERRINJCT
+
+/* RTAS services for error injection */
+enum {
+	kvm_errinjct_open_token,
+	kvm_errinjct_close_token,
+	kvm_errinjct_errinjct
+};
+
+/* Supported types of error injection */
+enum {
+	kvm_errinjct_min = 0,
+	kvm_errinjct_fatal,
+	kvm_errinjct_recover_random_evt,
+	kvm_errinjct_recover_special_evt,
+	kvm_errinjct_corrupted_page,
+	kvm_errinjct_corrupted_slb,
+	kvm_errinjct_translator_failure,
+	kvm_errinjct_ioa_bus_error,
+	kvm_errinjct_ioa_bus_error_64,
+	kvm_errinjct_platform_specific,
+	kvm_errinjct_corrupted_dcache_start,
+	kvm_errinjct_corrupted_dcache_end,
+	kvm_errinjct_corrupted_icache_start,
+	kvm_errinjct_corrupted_icache_end,
+	kvm_errinjct_corrupted_tlb_start,
+	kvm_errinjct_corrupted_tlb_end,
+	kvm_errinjct_upstream_io_error,
+	kvm_errinjct_max
+};
+
+/* Handler for specific type of error injection */
+struct kvm_errinjct_handler {
+	int opcode;
+	kvm_errinjct_func handler;
+};
+
+/* Tokens that have been opened */
+struct kvm_errinjct_token {
+	struct kvm *kvm;
+	int token;
+	struct list_head list;
+};
+
+int kvm_errinjct_register(int opcode, kvm_errinjct_func handler);
+int kvm_errinjct_unregister(int opcode);
+void kvmppc_errinjct_rtas(struct kvm_vcpu *vcpu,
+			  struct rtas_args *args, int flag);
+
+#else
+
+static inline int kvm_errinjct_register(int opcode,
+					kvm_errinjct_func handler)
+{
+	return 0;
+}
+
+static inline int kvm_errinjct_unregister(int opcode);
+{
+	return 0;
+}
+
+#endif /* CONFIG_KVM_ERRINJCT */
+#endif /* __POWERPC_BOOK3S_ERRINJCT_H__ */
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index 673038d..f221f66 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -97,6 +97,9 @@ endif
 kvm-book3s_64-objs-$(CONFIG_KVM_XICS) += \
 	book3s_xics.o
 
+kvm-book3s_64-objs-$(CONFIG_KVM_ERRINJCT) += \
+	book3s_errinjct.o
+
 kvm-book3s_64-objs-$(CONFIG_KVM_VFIO) += \
 	$(addprefix ../../../virt/kvm/, vfio.o)
 
diff --git a/arch/powerpc/kvm/book3s_errinjct.c b/arch/powerpc/kvm/book3s_errinjct.c
new file mode 100644
index 0000000..27a49ab
--- /dev/null
+++ b/arch/powerpc/kvm/book3s_errinjct.c
@@ -0,0 +1,329 @@
+/*
+ * The file intends to implement RTAS errinjct functionality for book3s
+ * architecture. Due to the individual errors injected to the system
+ * are defined by device tree node, it's reasonable to introduce the
+ * mechanism to register the supported errors and their corresponding
+ * handlers.
+ *
+ * Copyright Benjamin Herrenschmidt & Gavin Shan, IBM Corporation 2014.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/kvm_host.h>
+#include <linux/kvm.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+
+#include <asm/uaccess.h>
+#include <asm/kvm_book3s.h>
+#include <asm/kvm_ppc.h>
+#include <asm/book3s_errinjct.h>
+#include <asm/hvcall.h>
+
+static struct kvm_errinjct_handler handlers[kvm_errinjct_max];
+static DEFINE_SPINLOCK(handler_lock);
+static LIST_HEAD(open_token_list);
+static DEFINE_SPINLOCK(token_lock);
+static unsigned long *token_bitmap = NULL;
+static int token_max = 1024;
+
+/**
+ * kvm_errinjct_register - Register error injection handler
+ * @opcode: to idenfity the error type to be injected
+ * @handler: function to handler the error type
+ *
+ * Register function handler for the specified type of error.
+ */
+int kvm_errinjct_register(int opcode, kvm_errinjct_func handler)
+{
+	spin_lock(&handler_lock);
+	if (!opcode || !handler) {
+		spin_unlock(&handler_lock);
+		pr_warn("%s: Invalid argument\n", __func__);
+		return -EINVAL;
+	}
+
+	if (opcode <= kvm_errinjct_min ||
+	    opcode >= kvm_errinjct_max) {
+		spin_unlock(&handler_lock);
+		pr_warn("%s: Opcode %d out of range (%d, %d)\n",
+			__func__, opcode, kvm_errinjct_min, kvm_errinjct_max);
+		return -ERANGE;
+	}
+
+	if (handlers[opcode].handler) {
+		spin_unlock(&handler_lock);
+		pr_warn("%s: Opcode %d had attached handler\n",
+			__func__, opcode);
+		return -EBUSY;
+	}
+
+	handlers[opcode].opcode  = opcode;
+	handlers[opcode].handler = handler;
+	spin_unlock(&handler_lock);
+
+	return 0;
+}
+
+/**
+ * kvm_errinjct_unregister - Unregister error injection handler
+ * @opcode: to identify the error type
+ *
+ * Unregister function handler for the specified type of error.
+ */
+int kvm_errinjct_unregister(int opcode)
+{
+	spin_lock(&handler_lock);
+
+	if (opcode <= kvm_errinjct_min ||
+	    opcode >= kvm_errinjct_max) {
+		spin_unlock(&handler_lock);
+		pr_warn("%s: Opcode %d out of range (%d, %d)\n",
+			__func__, opcode, kvm_errinjct_min, kvm_errinjct_max);
+		return -ERANGE;
+	}
+
+	handlers[opcode].opcode  = 0;
+	handlers[opcode].handler = NULL;
+	spin_unlock(&handler_lock);
+
+	return 0;
+}
+
+/* Allocate token from the bitmap */
+static int kvm_errinjct_token_alloc(void)
+{
+	int token;
+
+	/* The token bitmap isn't initialized yet */
+	if (unlikely(!token_bitmap)) {
+		unsigned long size;
+		unsigned long *mem;
+
+		size = _ALIGN_UP(token_max, sizeof(unsigned long));
+		mem = kzalloc(size, GFP_KERNEL);
+		if (!mem) {
+			pr_err("%s: Out of memory!\n", __func__);
+			return -ENOMEM;
+		}
+
+		/* In case some body else did it */
+		if (unlikely(token_bitmap))
+			kfree(mem);
+		else
+			token_bitmap = mem;
+	}
+
+	/* Allocate token */
+	do {
+		token = find_next_zero_bit(token_bitmap, token_max, 0);
+		if (token >= token_max)
+			return -ERANGE;
+        } while(test_and_set_bit(token, token_bitmap));
+
+	return token;
+}
+
+/* Free token to the bitmap */
+static void kvm_errinjct_token_free(int token)
+{
+	if (unlikely(!token_bitmap))
+		return;
+	if (unlikely(token >= token_max))
+		return;
+
+	clear_bit(token, token_bitmap);
+}
+
+/* Check if the specified VM has opened token or not */
+static bool kvm_errinjct_token_get(struct kvm *kvm,
+				   struct kvm_errinjct_token **token)
+{
+	struct kvm_errinjct_token *t;
+
+	list_for_each_entry(t, &open_token_list, list) {
+		if (t->kvm == kvm) {
+			if (token)
+				*token = t;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+/* Emulation handler for opening token */
+static int kvmppc_errinjct_open(struct kvm_vcpu *vcpu,
+				struct rtas_args *args)
+{
+        struct kvm_errinjct_token *t;
+	int token;
+	int ret = 0;
+
+	/* Check the parameters */
+	if (args->nargs != 0 || args->nret != 2) {
+		pr_warn("%s: Breaking rule (#args: 0, #rets: 2)\n",
+			__func__);
+		ret = -1;
+		goto out;
+	}
+
+	/* Check if the guest has opened token */
+	spin_lock(&token_lock);
+	if (kvm_errinjct_token_get(vcpu->kvm, NULL)) {
+		ret = -4;
+		spin_unlock(&token_lock);
+		goto out;
+	}
+
+	/* Allocate token */
+	token = kvm_errinjct_token_alloc();
+	if (token > token_max) {
+		ret = -1;
+		spin_unlock(&token_lock);
+		goto out;
+	}
+
+	/* Attach open token */
+	t = kzalloc(sizeof(*t), GFP_KERNEL);
+	if (!t) {
+		ret = -2;
+		pr_warn("%s: Out of memory !\n", __func__);
+		kvm_errinjct_token_free(token);
+                spin_unlock(&token_lock);
+                goto out;
+        }
+        t->kvm   = vcpu->kvm;
+        t->token = token;
+	INIT_LIST_HEAD(&t->list);
+	list_add_tail(&t->list, &open_token_list);
+	spin_unlock(&token_lock);
+out:
+        args->rets[1] = ret;
+        return ret == 0 ? token : -1;
+}
+
+/* Emulation handler for closing token */
+static int kvmppc_errinjct_close(struct kvm_vcpu *vcpu,
+				 struct rtas_args *args)
+{
+	struct kvm_errinjct_token *t;
+	int ret = 0;
+
+	/* Check the parameters */
+	if (args->nargs != 1 || args->nret != 1) {
+		pr_warn("%s: Breaking rule (#args: 1, #rets: 1)\n",
+			__func__);
+		ret = -1;
+		goto out;
+	}
+
+	/* Search the opened token */
+	spin_lock(&token_lock);
+	if (!kvm_errinjct_token_get(vcpu->kvm, &t)) {
+		ret = -4;
+		spin_unlock(&token_lock);
+		goto out;
+	}
+
+	/* Detach and free it */
+	list_del(&t->list);
+	kvm_errinjct_token_free(t->token);
+	spin_unlock(&token_lock);
+
+	kfree(t);
+out:
+        return ret;
+}
+
+/*
+ * Emulation handler for error injection. After checking
+ * the arguments, we will dispatch the request to the
+ * dynamically registered handler if possible.
+ */
+static int kvmppc_errinjct(struct kvm_vcpu *vcpu,
+			   struct rtas_args *args)
+{
+	struct kvm_errinjct_token *t;
+	int token, opcode, ret = 0;
+	rtas_arg_t buf;
+
+	/* Check the parameters */
+	if (args->nargs != 3 || args->nret != 1) {
+		pr_warn("%s: Breaking rule (#args: 3, #rets: 1)\n",
+			__func__);
+                ret = -3;
+                goto out;
+        }
+
+	/* Check opcode and buffer */
+	opcode = args->args[0];
+	token  = args->args[1];
+	buf    = args->args[2];
+	if (opcode < kvm_errinjct_min ||
+	    opcode >= kvm_errinjct_max ||
+	    (buf & 0x3fful)) {
+		ret = -3;
+		goto out;
+	}
+
+	/* Check if the VM has the opened token */
+	spin_lock(&token_lock);
+	if (!kvm_errinjct_token_get(vcpu->kvm, &t) ||
+	    t->token != token) {
+		ret = -4;
+		spin_unlock(&token_lock);
+		goto out;
+	}
+	spin_unlock(&token_lock);
+
+	/* Dispatch the request */
+	spin_lock(&handler_lock);
+	if (handlers[opcode].handler)
+		ret = handlers[opcode].handler(vcpu, buf);
+	else
+		ret = -3;
+	spin_unlock(&handler_lock);
+out:
+	return ret;
+}
+
+/**
+ * kvmppc_errinjct_rtas - Common handler for error injection emulation
+ * @vcpu: KVM virtual CPU
+ * @args: RTAS call arguments
+ * @flag: error injection service indicator
+ *
+ * The function is the common handler to emulate error injection RTAS.
+ * All error injection requests will trigger the function and in turn,
+ * the requests will be distributed to individual handler.
+ */
+void kvmppc_errinjct_rtas(struct kvm_vcpu *vcpu,
+			  struct rtas_args *args, int flag)
+{
+	int ret = -1;
+
+	/* Parse the requested service */
+	switch (flag) {
+	case kvm_errinjct_open_token:
+		ret = kvmppc_errinjct_open(vcpu, args);
+		break;
+	case kvm_errinjct_close_token:
+		ret = kvmppc_errinjct_close(vcpu, args);
+		break;
+	case kvm_errinjct_errinjct:
+		ret = kvmppc_errinjct(vcpu, args);
+		break;
+	default:
+		pr_warn("%s: Unsupported option %d\n",
+			__func__, flag);
+	}
+
+	/* Update the return value */
+	args->rets[0] = ret;
+}
diff --git a/arch/powerpc/kvm/book3s_rtas.c b/arch/powerpc/kvm/book3s_rtas.c
index 17bdb4a..030b006 100644
--- a/arch/powerpc/kvm/book3s_rtas.c
+++ b/arch/powerpc/kvm/book3s_rtas.c
@@ -18,6 +18,7 @@
 #include <asm/rtas.h>
 #include <asm/ppc-pci.h>
 #include <asm/eeh.h>
+#include <asm/book3s_errinjct.h>
 
 #ifdef CONFIG_KVM_XICS
 static void kvm_rtas_set_xive(struct kvm_vcpu *vcpu, struct rtas_args *args)
@@ -123,6 +124,21 @@ KVM_RTAS_EEH_FUNC(configure_pe,	eeh_rtas_configure_pe)
 
 #endif /* CONFIG_KVM_EEH */
 
+#ifdef CONFIG_KVM_ERRINJCT
+
+#define KVM_RTAS_ERRINJCT_FUNC(name, flag)			\
+static void kvm_rtas_errinjct_##name(struct kvm_vcpu *vcpu,	\
+				     struct rtas_args *args)	\
+{								\
+	kvmppc_errinjct_rtas(vcpu, args, flag);			\
+}
+
+KVM_RTAS_ERRINJCT_FUNC(open_token,	kvm_errinjct_open_token);
+KVM_RTAS_ERRINJCT_FUNC(close_token,	kvm_errinjct_close_token);
+KVM_RTAS_ERRINJCT_FUNC(errinjct,	kvm_errinjct_errinjct);
+
+#endif /* CONFIG_KVM_ERRINJCT */
+
 struct rtas_handler {
 	void (*handler)(struct kvm_vcpu *vcpu, struct rtas_args *args);
 	char *name;
@@ -153,8 +169,19 @@ static struct rtas_handler rtas_handlers[] = {
 	},
 	{ .name = "ibm,configure-pe",
 	  .handler = kvm_rtas_eeh_configure_pe
-	}
+	},
 #endif /* CONFIG_KVM_EEH */
+#ifdef CONFIG_KVM_ERRINJCT
+	{ .name = "ibm,open-errinjct",
+	  .handler = kvm_rtas_errinjct_open_token
+	},
+	{ .name = "ibm,close-errinjct",
+	  .handler = kvm_rtas_errinjct_close_token
+	},
+	{ .name = "ibm,errinjct",
+	  .handler = kvm_rtas_errinjct_errinjct
+	},
+#endif /* CONFIG_KVM_ERRINJCT */
 };
 
 struct rtas_token_definition {
-- 
1.8.3.2
