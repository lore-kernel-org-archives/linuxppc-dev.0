Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E19BB140166
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 May 2014 17:49:52 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 9 May 2014 17:49:51 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2958F2BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 May 2014 17:49:48 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s497SZWt50135196
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 May 2014 17:28:36 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s497nlGn021351
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 May 2014 17:49:47 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 09/10] powerpc/powernv: Implement ppc_call_opal()
Date: Fri,  9 May 2014 17:49:41 +1000
Message-Id: <1399621782-23281-10-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1399621782-23281-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1399621782-23281-1-git-send-email-gwshan@linux.vnet.ibm.com>
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

If we're running PowerNV platform, ppc_firmware() will be directed
to ppc_call_opal() where we can call to OPAL API accordingly. In
ppc_call_opal(), the input argument are parsed out and call to
appropriate OPAL API to handle that. Each request passed to the
function is identified with token. As we get to the function either
from host owned application (e.g. errinjct) or VM, we always have
the first parameter (so-called "virtual") to differentiate the
cases.

The patch implements above logic and OPAL call handler dynamica
registeration mechanism so that the handlers could be distributed.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h       |  3 +-
 arch/powerpc/platforms/powernv/opal.c | 90 ++++++++++++++++++++++++++++++++++-
 2 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index ca55d9c..7c4ffd0 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -997,7 +997,8 @@ extern void opal_lpc_init(void);
 struct opal_sg_list *opal_vmalloc_to_sg_list(void *vmalloc_addr,
 					     unsigned long vmalloc_size);
 void opal_free_sg_list(struct opal_sg_list *sg);
-
+int opal_call_handler_register(bool virt, int token,
+			       int (*fn)(struct rtas_args *));
 #endif /* __ASSEMBLY__ */
 
 #endif /* __OPAL_H */
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index ad33c2b..c84823c 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -38,6 +38,13 @@ struct opal {
 	u64 size;
 } opal;
 
+struct opal_call_handler {
+	bool virt;
+	int token;
+	int (*fn)(struct rtas_args *args);
+	struct list_head list;
+};
+
 struct mcheck_recoverable_range {
 	u64 start_addr;
 	u64 end_addr;
@@ -47,6 +54,10 @@ struct mcheck_recoverable_range {
 static struct mcheck_recoverable_range *mc_recoverable_range;
 static int mc_recoverable_range_len;
 
+/* OPAL call handler */
+static LIST_HEAD(opal_call_handler_list);
+static DEFINE_SPINLOCK(opal_call_lock);
+
 struct device_node *opal_node;
 static DEFINE_SPINLOCK(opal_write_lock);
 extern u64 opal_mc_secondary_handler[];
@@ -703,8 +714,83 @@ void opal_free_sg_list(struct opal_sg_list *sg)
 	}
 }
 
-/* Extend it later */
-int ppc_call_opal(struct rtas_args *args)
+int opal_call_handler_register(bool virt, int token,
+			       int (*fn)(struct rtas_args *))
 {
+	struct opal_call_handler *h, *handler;
+
+	if (!token || !fn) {
+		pr_warn("%s: Invalid parameters\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	handler = kzalloc(sizeof(*handler), GFP_KERNEL);
+	if (!handler) {
+		pr_warn("%s: Out of memory\n",
+			__func__);
+		return -ENOMEM;
+	}
+	handler->token = token;
+	handler->virt = virt;
+	handler->fn = fn;
+	INIT_LIST_HEAD(&handler->list);
+
+	spin_lock(&opal_call_lock);
+	list_for_each_entry(h, &opal_call_handler_list, list) {
+		if (h->token == token &&
+		    h->virt  == virt) {
+			spin_unlock(&opal_call_lock);
+			pr_warn("%s: Handler existing (%s, %x)\n",
+				__func__, virt ? "T" : "F", token);
+			kfree(handler);
+			return -EEXIST;
+		}
+	}
+
+	list_add_tail(&handler->list, &opal_call_handler_list);
+	spin_unlock(&opal_call_lock);
+
 	return 0;
 }
+
+/*
+ * It's usually invoked from syscall ppc_firmware() by host
+ * owned application or VM. The information carried in the
+ * input arguments is different. So we always have the first
+ * argument to differentiate it.
+ *
+ * Also, we have to extend 32-bits address to 64-bits. So
+ * for each address sensitive field, it will require 8
+ * bytes.
+ */
+int ppc_call_opal(struct rtas_args *args)
+{
+	bool virt, found;
+	int token;
+	struct opal_call_handler *h;
+
+	/* We should have "virt" at least */
+	if (args->nargs < 1)
+		return -EINVAL;
+	virt = !!args->args[0];
+	token = args->token;
+
+	/* Do we have handler ? */
+	found = false;
+	spin_lock(&opal_call_lock);
+	list_for_each_entry(h, &opal_call_handler_list, list) {
+		if (h->token == token &&
+		    h->virt == virt) {
+			found = true;
+			break;
+		}
+	}
+	spin_unlock(&opal_call_lock);
+
+	/* Call to handler */
+	if (!found)
+		return -ERANGE;
+
+	return h->fn(args);
+}
-- 
1.8.3.2
