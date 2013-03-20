Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id DD2912C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 03:09:40 +1100 (EST)
Date: Wed, 20 Mar 2013 17:06:44 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH] powerpc/uprobes: teach uprobes to ignore gdb breakpoints
Message-ID: <20130320160644.GA20352@redhat.com>
References: <20130320104033.GA19844@in.ibm.com>
 <20130320122639.GA29541@redhat.com> <20130320154152.GA8246@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130320154152.GA8246@in.ibm.com>
Cc: ppcdev <linuxppc-dev@lists.ozlabs.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/20, Ananth N Mavinakayanahalli wrote:
>
> On Wed, Mar 20, 2013 at 01:26:39PM +0100, Oleg Nesterov wrote:
> > But, at the same time, is the new definition fine for verify_opcode()?
> >
> > IOW, powerpc has another is_trap() insn(s) used by gdb, lets denote it X.
> > X != UPROBE_SWBP_INSN.
> >
> > Suppose that gdb installs the trap X at some addr, and then uprobe_register()
> > tries to install uprobe at the same address. Then set_swbp() will do nothing,
> > assuming the uprobe was already installed.
> >
> > But we did not install UPROBE_SWBP_INSN. Is it fine? I hope yes, just to
> > verify. If not, we need 2 definitions. is_uprobe_insn() should still check
> > insns == UPROBE_SWBP_INSN, and is_swbp_insn() should check is_trap().
>
> is_trap() checks for all trap variants on powerpc, including the one
> uprobe uses. It returns true if the instruction is *any* trap variant.

I understand,

> So, install_breakpoint()->prepare_uprobe()->is_swbp_insn() will return
> ENOTSUPP. In fact, arch_uprobe_analyze_insn() will also do the same.

Yes and the check in arch_uprobe_analyze_insn() should go away.

But you missed my point. Please forget about prepare_uprobe(), it is
wrong anyway. And, prepare_uprobe() inspects the _original_ insn from
the file, this has nothing install_breakpoint/etc.

I meant verify_opcode() called by install_breakpoint/etc.

> This itself should take care of all the cases.
>
> > And I am just curious, could you explain how X and UPROBE_SWBP_INSN
> > differ?
>
> Powerpc has numerous variants of the trap instruction based on
> comparison of two registers or a regsiter and immediate value and a condition
> (less than, greater than, [signed forms thereof], or equal to).
>
> Uprobes uses 0x7fe0008 which is 'tw 31,0,0'  which essentially is an
> unconditional trap.
>
> Gdb uses many traps, one of which is 0x7d821008 which is twge r2,r2,
> which is basically trap if r2 greater than or equal to r2.

OK. So, if I understand correctly, gdb can use some conditional
breakpoint, and it is possible that this insn won't generate the
trap?

Then this patch is not right, or at least we need another change
on top?

Once again. Suppose that gdb installs the TRAP_IF_R1_GT_R2.

After that uprobe_register() is called, but it won't change this
insn because verify_opcode() returns 0.

Then the probed task hits this breakoint with "r1 < r2" and we do
not report this event.


So. I still think that we actually need something like below, and
powerpc should reimplement is_trap_insn() to use is_trap(insn).

No?

Oleg.

--- x/kernel/events/uprobes.c
+++ x/kernel/events/uprobes.c
@@ -532,6 +532,12 @@ static int copy_insn(struct uprobe *upro
 	return __copy_insn(mapping, filp, uprobe->arch.insn, bytes, uprobe->offset);
 }
 
+bool __weak is_trap_insn(uprobe_opcode_t *insn)
+{
+	// powerpc: should use is_trap()
+	return is_swbp_insn(insn);
+}
+
 static int prepare_uprobe(struct uprobe *uprobe, struct file *file,
 				struct mm_struct *mm, unsigned long vaddr)
 {
@@ -550,7 +556,7 @@ static int prepare_uprobe(struct uprobe 
 		goto out;
 
 	ret = -ENOTSUPP;
-	if (is_swbp_insn((uprobe_opcode_t *)uprobe->arch.insn))
+	if (is_trap_insn((uprobe_opcode_t *)uprobe->arch.insn))
 		goto out;
 
 	ret = arch_uprobe_analyze_insn(&uprobe->arch, mm, vaddr);
@@ -1452,7 +1458,7 @@ static int is_swbp_at_addr(struct mm_str
 	copy_opcode(page, vaddr, &opcode);
 	put_page(page);
  out:
-	return is_swbp_insn(&opcode);
+	return is_trap_insn(&opcode);
 }
 
 static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is_swbp)
