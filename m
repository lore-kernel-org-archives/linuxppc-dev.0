Return-Path: <ananth@in.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 445D12C009E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 15:48:07 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Fri, 22 Mar 2013 00:48:04 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id CF0376E8020
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 00:47:58 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2M4m1PQ30933230
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 00:48:01 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2M4m0aH011666
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 01:48:00 -0300
Date: Fri, 22 Mar 2013 10:17:47 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] powerpc/uprobes: teach uprobes to ignore gdb breakpoints
Message-ID: <20130322044747.GB26183@in.ibm.com>
References: <20130320104033.GA19844@in.ibm.com>
 <20130320122639.GA29541@redhat.com> <20130320154152.GA8246@in.ibm.com>
 <20130320160644.GA20352@redhat.com> <20130321071545.GA5271@in.ibm.com>
 <20130321155809.GA20865@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130321155809.GA20865@redhat.com>
Cc: ppcdev <linuxppc-dev@lists.ozlabs.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>, stable@vger.kernel.org
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 21, 2013 at 04:58:09PM +0100, Oleg Nesterov wrote:
> On 03/21, Ananth N Mavinakayanahalli wrote:
> >
> > On Wed, Mar 20, 2013 at 05:06:44PM +0100, Oleg Nesterov wrote:
> >
> > > > > But we did not install UPROBE_SWBP_INSN. Is it fine? I hope yes, just to
> > > > > verify. If not, we need 2 definitions. is_uprobe_insn() should still check
> > > > > insns == UPROBE_SWBP_INSN, and is_swbp_insn() should check is_trap().
> >
> > Its fine from gdb's perspective with my patch.
> 
> Yes, but this doesn't look right from uprobe's perspective.
> 
> > > > So, install_breakpoint()->prepare_uprobe()->is_swbp_insn() will return
> > > > ENOTSUPP. In fact, arch_uprobe_analyze_insn() will also do the same.
> > >
> > > Yes and the check in arch_uprobe_analyze_insn() should go away.
> > >
> > > But you missed my point. Please forget about prepare_uprobe(), it is
> > > wrong anyway. And, prepare_uprobe() inspects the _original_ insn from
> > > the file, this has nothing install_breakpoint/etc.
> > >
> > > I meant verify_opcode() called by install_breakpoint/etc.
> >
> > For the case where X already exists, verify_opcode() currently returns 0.
> > IMO, it should return -EEXIST,
> 
> Oh, this is debatable. Currently we assume that uprobe should "win".

And there is that one case where gdb also uses an unconditional trap...
but that's besides the point if we don't care about gdb.

> See below...
> 
> > unless you are proposing that uprobes
> > should ride on the existing trap (even if its a variant).
> 
> Yes. And this is what the current implementation does.
> 
> > If you are proposing that uprobes ride on X if it already exists, that's
> > not always possible and is a big can of worms... see below...
> 
> Sure. Whatever we do uprobe and gdb can confuse each other. Unless we
> rework the vm code completely (not sure this is realistic).

Agreed.

> > > OK. So, if I understand correctly, gdb can use some conditional
> > > breakpoint, and it is possible that this insn won't generate the
> > > trap?
> >
> > Yes it is possible if the condition is not met. If the condition is
> > met, the instruction will generate a trap, and uprobes will do a
> > send_sig(SIGTRAP) from handle_swbp().
> 
> Unless there is uprobe at the same address. Once again, uprobe wins.

In which case, we will need to replace the conditional trap with the
unconditional one when the uprobe register happens. That is doable.

> Your patch only fixes the case when the task hits a non-UPROBE_SWBP_INSN
> breakpoint and there is no uprobe at the same address.

Correct.

> > > Then this patch is not right, or at least we need another change
> > > on top?
> > >
> > > Once again. Suppose that gdb installs the TRAP_IF_R1_GT_R2.
> > >
> > > After that uprobe_register() is called, but it won't change this
> > > insn because verify_opcode() returns 0.
> > >
> > > Then the probed task hits this breakoint with "r1 < r2" and we do
> > > not report this event.
> >
> > At this time, the condition for the trap is not satisfied, so no
> > exception occurs.
> 
> Yes, and thus uprobe->handler() is not called, this was my point.
> 
> > If the expectation is that the trap always trigger,
> > then all such trap variants need to be replaced with the unconditional
> > trap
> 
> Yes. that is why I suggested the patch which doesn't affect verify_opcode().
> uprobe_register() should replace the conditional trap with the unconditional
> UPROBE_SWBP_INSN. uprobes should win.

OK, I see your point.

...

> > But, unlike x86, we cannot
> > expect a uprobe with an underlying trap variant (X) to always trigger.
> 
> And that is why I think write_opcode() should rewrite the conditional
> trap.

OK

> > IMHO, its not a good idea to do that for x86 either,
> 
> This change has no effect fo x86.
> 
> > IMHO, I really think we should not allow uprobe_register() to succeed if
> > the underlying instruction is a breakpoint (or a variant thereof).
> 
> I disagree.
> 
> Just for example. Suppose we change install_breakpoint() so that it fails
> if the underlying instruction is int3. (once again, "underlying" does not
> mean the original insn from vma->vm_file).
> 
> First of all, this is very much nontrivial. I simply do not see how we
> can do this. If nothing else, uprobe_register() can race with uprobe_mmap()
> and install_breakpoint() can be called twice with the same vaddr. With
> this change register or mmap can fail.
> 
> But suppose you can do this. Now you can write the trivial application
> which mmaps glibc and inserts int3 into, say, getpid()'s vaddr. Voila,
> this makes "perf probe -x /lib/libc.so.6" impossible, uprobe_register()
> will fail.
> 
> Whatever you think about this logic, it was desidned to assume that
> install_breakpoint() should be "idempotent", and we ignore the races
> with gdb. We should only ensure that the kernel can't crash/etc.
> 
> And uprobe can "steal" the trap from gdb if they race, again this is by
> design. and your patch can't prevent this but complicates the rules.
> 
> I already said this many times, but let me repeat. is_swbp_isn() and
> its usage is confusing. Lets forget about prepare_uprobe(). Now,
> 
> 	- verify_opcode()->is_swbp_insn() means:
> 
> 		is this insn fine for uprobe? (we do not care about
> 		gdb, we simply ignore this problem)

I will write up a patch for this case.. So, IIUC we do not care to send
gdb a SIGTRAP if we have replaced a conditional trap from gdb with an
unconditional uprobes one, right?

> 	- is_swbp_at_addr()->is_swbp_insn() means:
> 
> 		there is no uprobe, should we send SIGTRAP ?

This part is handled with my patch now...

Thanks for being patient. I'll write up the patches and send across for
review.

Ananth.
