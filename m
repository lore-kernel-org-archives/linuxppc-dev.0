Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 213492C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 03:01:55 +1100 (EST)
Date: Thu, 21 Mar 2013 16:58:09 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH] powerpc/uprobes: teach uprobes to ignore gdb breakpoints
Message-ID: <20130321155809.GA20865@redhat.com>
References: <20130320104033.GA19844@in.ibm.com>
 <20130320122639.GA29541@redhat.com> <20130320154152.GA8246@in.ibm.com>
 <20130320160644.GA20352@redhat.com> <20130321071545.GA5271@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130321071545.GA5271@in.ibm.com>
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

On 03/21, Ananth N Mavinakayanahalli wrote:
>
> On Wed, Mar 20, 2013 at 05:06:44PM +0100, Oleg Nesterov wrote:
>
> > > > But we did not install UPROBE_SWBP_INSN. Is it fine? I hope yes, just to
> > > > verify. If not, we need 2 definitions. is_uprobe_insn() should still check
> > > > insns == UPROBE_SWBP_INSN, and is_swbp_insn() should check is_trap().
>
> Its fine from gdb's perspective with my patch.

Yes, but this doesn't look right from uprobe's perspective.

> > > So, install_breakpoint()->prepare_uprobe()->is_swbp_insn() will return
> > > ENOTSUPP. In fact, arch_uprobe_analyze_insn() will also do the same.
> >
> > Yes and the check in arch_uprobe_analyze_insn() should go away.
> >
> > But you missed my point. Please forget about prepare_uprobe(), it is
> > wrong anyway. And, prepare_uprobe() inspects the _original_ insn from
> > the file, this has nothing install_breakpoint/etc.
> >
> > I meant verify_opcode() called by install_breakpoint/etc.
>
> For the case where X already exists, verify_opcode() currently returns 0.
> IMO, it should return -EEXIST,

Oh, this is debatable. Currently we assume that uprobe should "win".
See below...

> unless you are proposing that uprobes
> should ride on the existing trap (even if its a variant).

Yes. And this is what the current implementation does.

> If you are proposing that uprobes ride on X if it already exists, that's
> not always possible and is a big can of worms... see below...

Sure. Whatever we do uprobe and gdb can confuse each other. Unless we
rework the vm code completely (not sure this is realistic).

> > OK. So, if I understand correctly, gdb can use some conditional
> > breakpoint, and it is possible that this insn won't generate the
> > trap?
>
> Yes it is possible if the condition is not met. If the condition is
> met, the instruction will generate a trap, and uprobes will do a
> send_sig(SIGTRAP) from handle_swbp().

Unless there is uprobe at the same address. Once again, uprobe wins.

Your patch only fixes the case when the task hits a non-UPROBE_SWBP_INSN
breakpoint and there is no uprobe at the same address.

> > Then this patch is not right, or at least we need another change
> > on top?
> >
> > Once again. Suppose that gdb installs the TRAP_IF_R1_GT_R2.
> >
> > After that uprobe_register() is called, but it won't change this
> > insn because verify_opcode() returns 0.
> >
> > Then the probed task hits this breakoint with "r1 < r2" and we do
> > not report this event.
>
> At this time, the condition for the trap is not satisfied, so no
> exception occurs.

Yes, and thus uprobe->handler() is not called, this was my point.

> If the expectation is that the trap always trigger,
> then all such trap variants need to be replaced with the unconditional
> trap

Yes. that is why I suggested the patch which doesn't affect verify_opcode().
uprobe_register() should replace the conditional trap with the unconditional
UPROBE_SWBP_INSN. uprobes should win.

> and we should either add logic to re-execute the condional trap
> after uprobe handling and send_sig() via handle_swbp() or emulate the
> condition in software and do a send_sig() if needed.

Unlikely this is possible. Or even desirable.

> > So. I still think that we actually need something like below, and
> > powerpc should reimplement is_trap_insn() to use is_trap(insn).
> >
> > No?
>
> I don't see how this will help,

Hmm. This should equally fix this particular problem? handle_swbp()
will send the trap if is_trap() == T?

Again, unless there is uprobe, but this was always true.

> especially since the gdb<->uprobes is
> fraught with races.

They can race anyway, whatever we do.

Unless we rework write_opcode/etc completely.

> With your proposed patch, we refuse to insert a uprobe if the underlying
> instruction is a UPROBE_SWBP_INSTRUCTION;

If "underlying" means the original insn in vma->file, this is already
true. My patch doesn't change this logic.

Otherwise - no, we do not refuse to insert a uprobe if this insn was
already changed by gdb.

> changing is_swbp_at_addr()
> will need changes in handle_swbp() too.

I don't think so. Why?

> But, unlike x86, we cannot
> expect a uprobe with an underlying trap variant (X) to always trigger.

And that is why I think write_opcode() should rewrite the conditional
trap.

> IMHO, its not a good idea to do that for x86 either,

This change has no effect fo x86.

> IMHO, I really think we should not allow uprobe_register() to succeed if
> the underlying instruction is a breakpoint (or a variant thereof).

I disagree.

Just for example. Suppose we change install_breakpoint() so that it fails
if the underlying instruction is int3. (once again, "underlying" does not
mean the original insn from vma->vm_file).

First of all, this is very much nontrivial. I simply do not see how we
can do this. If nothing else, uprobe_register() can race with uprobe_mmap()
and install_breakpoint() can be called twice with the same vaddr. With
this change register or mmap can fail.

But suppose you can do this. Now you can write the trivial application
which mmaps glibc and inserts int3 into, say, getpid()'s vaddr. Voila,
this makes "perf probe -x /lib/libc.so.6" impossible, uprobe_register()
will fail.

Whatever you think about this logic, it was desidned to assume that
install_breakpoint() should be "idempotent", and we ignore the races
with gdb. We should only ensure that the kernel can't crash/etc.

And uprobe can "steal" the trap from gdb if they race, again this is by
design. and your patch can't prevent this but complicates the rules.

I already said this many times, but let me repeat. is_swbp_isn() and
its usage is confusing. Lets forget about prepare_uprobe(). Now,

	- verify_opcode()->is_swbp_insn() means:

		is this insn fine for uprobe? (we do not care about
		gdb, we simply ignore this problem)

	- is_swbp_at_addr()->is_swbp_insn() means:

		there is no uprobe, should we send SIGTRAP ?

And the patch I sent separates these 2 cases.


Finally. If we want to eliminate the gdb/uprobes races/confusions,
we can not simply use a PageAnon() page, we shuld rewrite this code
completely. I can quote the very old email I sent you:

	The proper fix, I think, is to rework the whole idea about uprobe bps,
	but this is really "in the long term". install_breakpoint() should
	only unmap the page and mark its pte as "owned by kernel, FOLL_WRITE
	should not work". Something like migration or PROT_NONE. The task
	itself should install bp during the page fault. And we need the
	"backing store" for the pages with uprobes. Yes, this all is very
	vague and I can be wrong.

IOW, somehow we should ensure that once uprobe changes the page, nobody
else can change it until uprobe_unregister().

Oleg.
