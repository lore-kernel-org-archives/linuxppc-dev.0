Return-Path: <ananth@in.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4556B2C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 22:44:56 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Fri, 22 Mar 2013 05:44:53 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 3CC531FF0026
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 05:39:53 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2MBinnl115438
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 05:44:49 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2MBim92000966
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 05:44:49 -0600
Date: Fri, 22 Mar 2013 17:14:46 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] uprobes: add trap variant helper
Message-ID: <20130322114446.GG26183@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ppcdev <linuxppc-dev@lists.ozlabs.org>, oleg@redhat.com,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

Some architectures like powerpc have multiple variants of the trap
instruction. Introduce an additional helper is_trap_insn() for run-time
handling of non-uprobe traps on such architectures.

While there, change is_swbp_at_addr() to is_trap_at_addr() for reading
clarity.

With this change, the uprobe registration path will supercede any trap
instruction inserted at the requested location, while taking care of
delivering the SIGTRAP for cases where the trap notification came in
for an address without a uprobe. See [1] for a more detailed explanation.

[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2013-March/104771.html

This change was suggested by Oleg Nesterov.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
---
 include/linux/uprobes.h |    1 +
 kernel/events/uprobes.c |   32 ++++++++++++++++++++++++++++----
 2 files changed, 29 insertions(+), 4 deletions(-)

Index: linux-3.9-rc3/include/linux/uprobes.h
===================================================================
--- linux-3.9-rc3.orig/include/linux/uprobes.h
+++ linux-3.9-rc3/include/linux/uprobes.h
@@ -100,6 +100,7 @@ struct uprobes_state {
 extern int __weak set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
 extern int __weak set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
 extern bool __weak is_swbp_insn(uprobe_opcode_t *insn);
+extern bool __weak is_trap_insn(uprobe_opcode_t *insn);
 extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
Index: linux-3.9-rc3/kernel/events/uprobes.c
===================================================================
--- linux-3.9-rc3.orig/kernel/events/uprobes.c
+++ linux-3.9-rc3/kernel/events/uprobes.c
@@ -173,6 +173,20 @@ bool __weak is_swbp_insn(uprobe_opcode_t
 	return *insn == UPROBE_SWBP_INSN;
 }
 
+/**
+ * is_trap_insn - check if instruction is breakpoint instruction.
+ * @insn: instruction to be checked.
+ * Default implementation of is_trap_insn
+ * Returns true if @insn is a breakpoint instruction.
+ *
+ * This function is needed for the case where an architecture has multiple
+ * trap instructions (like powerpc).
+ */
+bool __weak is_trap_insn(uprobe_opcode_t *insn)
+{
+	return is_swbp_insn(insn);
+}
+
 static void copy_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *opcode)
 {
 	void *kaddr = kmap_atomic(page);
@@ -185,6 +199,15 @@ static int verify_opcode(struct page *pa
 	uprobe_opcode_t old_opcode;
 	bool is_swbp;
 
+	/*
+	 * Note: We only check if the old_opcode is UPROBE_SWBP_INSN here.
+	 * We do not check if it is any other 'trap variant' which could
+	 * be conditional trap instruction such as the one powerpc supports.
+	 *
+	 * The logic is that we do not care if the underlying instruction
+	 * is a trap variant; uprobes always wins over any other (gdb)
+	 * breakpoint.
+	 */
 	copy_opcode(page, vaddr, &old_opcode);
 	is_swbp = is_swbp_insn(&old_opcode);
 
@@ -204,7 +227,7 @@ static int verify_opcode(struct page *pa
  * Expect the breakpoint instruction to be the smallest size instruction for
  * the architecture. If an arch has variable length instruction and the
  * breakpoint instruction is not of the smallest length instruction
- * supported by that architecture then we need to modify is_swbp_at_addr and
+ * supported by that architecture then we need to modify is_trap_at_addr and
  * write_opcode accordingly. This would never be a problem for archs that
  * have fixed length instructions.
  */
@@ -1431,7 +1454,7 @@ static void mmf_recalc_uprobes(struct mm
 	clear_bit(MMF_HAS_UPROBES, &mm->flags);
 }
 
-static int is_swbp_at_addr(struct mm_struct *mm, unsigned long vaddr)
+static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
 {
 	struct page *page;
 	uprobe_opcode_t opcode;
@@ -1452,7 +1475,8 @@ static int is_swbp_at_addr(struct mm_str
 	copy_opcode(page, vaddr, &opcode);
 	put_page(page);
  out:
-	return is_swbp_insn(&opcode);
+	/* This needs to return true for any variant of the trap insn */
+	return is_trap_insn(&opcode);
 }
 
 static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is_swbp)
@@ -1472,7 +1496,7 @@ static struct uprobe *find_active_uprobe
 		}
 
 		if (!uprobe)
-			*is_swbp = is_swbp_at_addr(mm, bp_vaddr);
+			*is_swbp = is_trap_at_addr(mm, bp_vaddr);
 	} else {
 		*is_swbp = -EFAULT;
 	}
