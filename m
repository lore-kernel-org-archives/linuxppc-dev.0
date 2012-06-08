Return-Path: <ananth@in.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DA166B6FD1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2012 19:33:33 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Fri, 8 Jun 2012 03:33:31 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 67E673E40048
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2012 09:33:07 +0000 (WET)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q589X7cG190156
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jun 2012 03:33:07 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q589X0ZF010508
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jun 2012 03:33:06 -0600
Date: Fri, 8 Jun 2012 15:02:57 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] uprobes: Pass probed vaddr to
 arch_uprobe_analyze_insn()
Message-ID: <20120608093257.GG13409@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, peterz@infradead.org,
 antonb@thinktux.localdomain, oleg@redhat.com, michael@ellerman.id.au,
 Jim Keniston <jkenisto@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Ingo Molnar <mingo@elte.hu>
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

On RISC architectures like powerpc, instructions are fixed size.
Instruction analysis on such platforms is just a matter of (insn % 4).
Pass the vaddr at which the uprobe is to be inserted so that
arch_uprobe_analyze_insn() can flag misaligned registration requests.

Changes in V2:
Pass (unsigned long)addr instead of (loff_t)vaddr to
arch_uprobe_analyze_insn(). We need the loff_t vaddr to take care of
the offset of inode:offset pair for large file sizes on 32bit.

Signed-off-by: Ananth N Mavinakaynahalli <ananth@in.ibm.com>
---
 arch/x86/include/asm/uprobes.h |    2 +-
 arch/x86/kernel/uprobes.c      |    3 ++-
 kernel/events/uprobes.c        |    2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

Index: linux-3.5-rc1/arch/x86/include/asm/uprobes.h
===================================================================
--- linux-3.5-rc1.orig/arch/x86/include/asm/uprobes.h
+++ linux-3.5-rc1/arch/x86/include/asm/uprobes.h
@@ -48,7 +48,7 @@ struct arch_uprobe_task {
 #endif
 };
 
-extern int  arch_uprobe_analyze_insn(struct arch_uprobe *aup, struct mm_struct *mm);
+extern int  arch_uprobe_analyze_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long addr);
 extern int  arch_uprobe_pre_xol(struct arch_uprobe *aup, struct pt_regs *regs);
 extern int  arch_uprobe_post_xol(struct arch_uprobe *aup, struct pt_regs *regs);
 extern bool arch_uprobe_xol_was_trapped(struct task_struct *tsk);
Index: linux-3.5-rc1/arch/x86/kernel/uprobes.c
===================================================================
--- linux-3.5-rc1.orig/arch/x86/kernel/uprobes.c
+++ linux-3.5-rc1/arch/x86/kernel/uprobes.c
@@ -409,9 +409,10 @@ static int validate_insn_bits(struct arc
  * arch_uprobe_analyze_insn - instruction analysis including validity and fixups.
  * @mm: the probed address space.
  * @arch_uprobe: the probepoint information.
+ * @addr: virtual address at which to install the probepoint
  * Return 0 on success or a -ve number on error.
  */
-int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm)
+int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long addr)
 {
 	int ret;
 	struct insn insn;
Index: linux-3.5-rc1/kernel/events/uprobes.c
===================================================================
--- linux-3.5-rc1.orig/kernel/events/uprobes.c
+++ linux-3.5-rc1/kernel/events/uprobes.c
@@ -697,7 +697,7 @@ install_breakpoint(struct uprobe *uprobe
 		if (is_swbp_insn((uprobe_opcode_t *)uprobe->arch.insn))
 			return -EEXIST;
 
-		ret = arch_uprobe_analyze_insn(&uprobe->arch, mm);
+		ret = arch_uprobe_analyze_insn(&uprobe->arch, mm, addr);
 		if (ret)
 			return ret;
 
