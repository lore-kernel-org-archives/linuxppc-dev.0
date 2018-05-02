Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bT7m2PXBzF2Rn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 16:36:20 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w426YPgl045969
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 May 2018 02:36:17 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hq6t8b0sp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 May 2018 02:36:17 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Wed, 2 May 2018 07:36:15 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w426aCUQ8520126
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 May 2018 06:36:12 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A13D42041
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 07:27:25 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99DC34203F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 07:27:24 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 07:27:24 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 08A74A01B8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 16:36:11 +1000 (AEST)
Date: Wed, 2 May 2018 16:36:09 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/13] powerpc/eeh: Introduce eeh_for_each_pe()
References: <cover.1525242772.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1525242772.git.sbobroff@linux.ibm.com>
Message-Id: <8fd8b61f3e04aadd476116404b9047a898870f0b.1525242772.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a for_each-style macro for iterating through PEs without the
boilerplate required by a traversal function. eeh_pe_next() is now
exported, as it is now used directly in place.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 arch/powerpc/include/asm/eeh.h | 4 ++++
 arch/powerpc/kernel/eeh_pe.c   | 7 +++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index f02e0400e6f2..677102baf3cd 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -106,6 +106,9 @@ struct eeh_pe {
 #define eeh_pe_for_each_dev(pe, edev, tmp) \
 		list_for_each_entry_safe(edev, tmp, &pe->edevs, list)
 
+#define eeh_for_each_pe(root, pe) \
+	for (pe = root; pe; pe = eeh_pe_next(pe, root))
+
 static inline bool eeh_pe_passed(struct eeh_pe *pe)
 {
 	return pe ? !!atomic_read(&pe->pass_dev_cnt) : false;
@@ -267,6 +270,7 @@ typedef void *(*eeh_pe_traverse_func)(struct eeh_pe *pe, void *flag);
 void eeh_set_pe_aux_size(int size);
 int eeh_phb_pe_create(struct pci_controller *phb);
 struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb);
+struct eeh_pe *eeh_pe_next(struct eeh_pe *pe, struct eeh_pe *root);
 struct eeh_pe *eeh_pe_get(struct pci_controller *phb,
 			  int pe_no, int config_addr);
 int eeh_add_to_parent_pe(struct eeh_dev *edev);
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 38a4bcd8ed13..1b238ecc553e 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -142,8 +142,7 @@ struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb)
  * The function is used to retrieve the next PE in the
  * hierarchy PE tree.
  */
-static struct eeh_pe *eeh_pe_next(struct eeh_pe *pe,
-				  struct eeh_pe *root)
+struct eeh_pe *eeh_pe_next(struct eeh_pe *pe, struct eeh_pe *root)
 {
 	struct list_head *next = pe->child_list.next;
 
@@ -178,7 +177,7 @@ void *eeh_pe_traverse(struct eeh_pe *root,
 	struct eeh_pe *pe;
 	void *ret;
 
-	for (pe = root; pe; pe = eeh_pe_next(pe, root)) {
+	eeh_for_each_pe(root, pe) {
 		ret = fn(pe, flag);
 		if (ret) return ret;
 	}
@@ -209,7 +208,7 @@ void *eeh_pe_dev_traverse(struct eeh_pe *root,
 	}
 
 	/* Traverse root PE */
-	for (pe = root; pe; pe = eeh_pe_next(pe, root)) {
+	eeh_for_each_pe(root, pe) {
 		eeh_pe_for_each_dev(pe, edev, tmp) {
 			ret = fn(edev, flag);
 			if (ret)
-- 
2.16.1.74.g9b0b1f47b
