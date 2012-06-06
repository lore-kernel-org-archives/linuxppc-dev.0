Return-Path: <ananth@in.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 49871B6FAB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 19:20:01 +1000 (EST)
Received: from /spool/local
 by e3.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Wed, 6 Jun 2012 05:19:59 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id A834B38C803A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 05:19:56 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q569JuTo186086
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jun 2012 05:19:56 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q569JsUZ016503
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jun 2012 03:19:55 -0600
Date: Wed, 6 Jun 2012 14:49:50 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] uprobes: Pass probed vaddr to arch_uprobe_analyze_insn()
Message-ID: <20120606091950.GB6745@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, peterz@infradead.org,
 oleg@redhat.com, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>
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

Signed-off-by: Ananth N Mavinakaynahalli <ananth@in.ibm.com>
---
 arch/x86/include/asm/uprobes.h |    2 +-
 arch/x86/kernel/uprobes.c      |    3 ++-
 kernel/events/uprobes.c        |    2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

Index: uprobes-24may/arch/x86/include/asm/uprobes.h
===================================================================
--- uprobes-24may.orig/arch/x86/include/asm/uprobes.h
+++ uprobes-24may/arch/x86/include/asm/uprobes.h
@@ -48,7 +48,7 @@ struct arch_uprobe_task {
 #endif
 };
 
-extern int  arch_uprobe_analyze_insn(struct arch_uprobe *aup, struct mm_struct *mm);
+extern int  arch_uprobe_analyze_insn(struct arch_uprobe *aup, struct mm_struct *mm, loff_t vaddr);
 extern int  arch_uprobe_pre_xol(struct arch_uprobe *aup, struct pt_regs *regs);
 extern int  arch_uprobe_post_xol(struct arch_uprobe *aup, struct pt_regs *regs);
 extern bool arch_uprobe_xol_was_trapped(struct task_struct *tsk);
Index: uprobes-24may/arch/x86/kernel/uprobes.c
===================================================================
--- uprobes-24may.orig/arch/x86/kernel/uprobes.c
+++ uprobes-24may/arch/x86/kernel/uprobes.c
@@ -409,9 +409,10 @@ static int validate_insn_bits(struct arc
  * arch_uprobe_analyze_insn - instruction analysis including validity and fixups.
  * @mm: the probed address space.
  * @arch_uprobe: the probepoint information.
+ * @vaddr: virtual address at which to install the probepoint
  * Return 0 on success or a -ve number on error.
  */
-int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm)
+int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, loff_t vaddr)
 {
 	int ret;
 	struct insn insn;
Index: uprobes-24may/kernel/events/uprobes.c
===================================================================
--- uprobes-24may.orig/kernel/events/uprobes.c
+++ uprobes-24may/kernel/events/uprobes.c
@@ -697,7 +697,7 @@ install_breakpoint(struct uprobe *uprobe
 		if (is_swbp_insn((uprobe_opcode_t *)uprobe->arch.insn))
 			return -EEXIST;
 
-		ret = arch_uprobe_analyze_insn(&uprobe->arch, mm);
+		ret = arch_uprobe_analyze_insn(&uprobe->arch, mm, vaddr);
 		if (ret)
 			return ret;
 
