Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 03DB92C0328
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 16:38:13 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 00:38:11 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id DC183C9003E
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 00:38:04 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1P5c7xD8978862
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 05:38:08 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1P5c7CF018548
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 00:38:07 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/9] powerpc/eeh: Introduce eeh_ops->event()
Date: Tue, 25 Feb 2014 13:37:46 +0800
Message-Id: <1393306670-17435-6-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1393306670-17435-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1393306670-17435-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch introduces eeh_ops->event() so that we can pass various
events to underly platform. One reason to have that is to allocate
or free PHB diag-data for individual PEs on PowerNV platform in
future when EEH core to create or destroy PE instances.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h |    6 ++++++
 arch/powerpc/kernel/eeh_pe.c   |   14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index a61b06f..8fd1c2d 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -71,6 +71,7 @@ struct eeh_pe {
 	struct list_head child_list;	/* Link PE to the child list	*/
 	struct list_head edevs;		/* Link list of EEH devices	*/
 	struct list_head child;		/* Child PEs			*/
+	void *data;			/* Platform dependent data	*/
 };
 
 #define eeh_pe_for_each_dev(pe, edev, tmp) \
@@ -151,6 +152,10 @@ enum {
 #define EEH_LOG_TEMP		1	/* EEH temporary error log	*/
 #define EEH_LOG_PERM		2	/* EEH permanent error log	*/
 
+/* EEH events sent to platform */
+#define EEH_EVENT_PE_ALLOC	0
+#define EEH_EVENT_PE_FREE	1
+
 struct eeh_ops {
 	char *name;
 	int (*init)(void);
@@ -168,6 +173,7 @@ struct eeh_ops {
 	int (*write_config)(struct device_node *dn, int where, int size, u32 val);
 	int (*next_error)(struct eeh_pe **pe);
 	int (*restore_config)(struct device_node *dn);
+	int (*event)(int event, void *data);
 };
 
 extern struct eeh_ops *eeh_ops;
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 2add834..6cdc7a8 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -44,6 +44,7 @@ static LIST_HEAD(eeh_phb_pe);
 static struct eeh_pe *eeh_pe_alloc(struct pci_controller *phb, int type)
 {
 	struct eeh_pe *pe;
+	int ret;
 
 	/* Allocate PHB PE */
 	pe = kzalloc(sizeof(struct eeh_pe), GFP_KERNEL);
@@ -56,6 +57,16 @@ static struct eeh_pe *eeh_pe_alloc(struct pci_controller *phb, int type)
 	INIT_LIST_HEAD(&pe->child);
 	INIT_LIST_HEAD(&pe->edevs);
 
+	if (eeh_ops->event) {
+		ret = eeh_ops->event(EEH_EVENT_PE_ALLOC, pe);
+		if (ret) {
+			pr_warn("%s: Can't alloc PE (%d)\n",
+				__func__, ret);
+			kfree(pe);
+			return NULL;
+		}
+	}
+
 	return pe;
 }
 
@@ -77,6 +88,9 @@ static void eeh_pe_free(struct eeh_pe *pe)
 		return;
 	}
 
+	if (eeh_ops->event)
+		eeh_ops->event(EEH_EVENT_PE_FREE, pe);
+
 	kfree(pe);
 }
 
-- 
1.7.10.4
