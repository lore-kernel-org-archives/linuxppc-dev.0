Return-Path: <ananth@in.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e33.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5224E2C00C5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 18:15:54 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Thu, 21 Mar 2013 01:15:51 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id D0A921FF003E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 01:10:52 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2L7Fmvp156236
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 01:15:48 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2L7FlX8008124
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 01:15:48 -0600
Date: Thu, 21 Mar 2013 12:45:45 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] powerpc/uprobes: teach uprobes to ignore gdb breakpoints
Message-ID: <20130321071545.GA5271@in.ibm.com>
References: <20130320104033.GA19844@in.ibm.com>
 <20130320122639.GA29541@redhat.com> <20130320154152.GA8246@in.ibm.com>
 <20130320160644.GA20352@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130320160644.GA20352@redhat.com>
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

On Wed, Mar 20, 2013 at 05:06:44PM +0100, Oleg Nesterov wrote:
> On 03/20, Ananth N Mavinakayanahalli wrote:
> >
> > On Wed, Mar 20, 2013 at 01:26:39PM +0100, Oleg Nesterov wrote:
> >
> > > But, at the same time, is the new definition fine for verify_opcode()?
> > >
> > > IOW, powerpc has another is_trap() insn(s) used by gdb, lets denote it X.
> > > X != UPROBE_SWBP_INSN.
> > >
> > > Suppose that gdb installs the trap X at some addr, and then uprobe_register()
> > > tries to install uprobe at the same address. Then set_swbp() will do nothing,
> > > assuming the uprobe was already installed.

I think that is not right... see below...

> > > But we did not install UPROBE_SWBP_INSN. Is it fine? I hope yes, just to
> > > verify. If not, we need 2 definitions. is_uprobe_insn() should still check
> > > insns == UPROBE_SWBP_INSN, and is_swbp_insn() should check is_trap().

Its fine from gdb's perspective with my patch.

> > is_trap() checks for all trap variants on powerpc, including the one
> > uprobe uses. It returns true if the instruction is *any* trap variant.
> 
> I understand,
> 
> > So, install_breakpoint()->prepare_uprobe()->is_swbp_insn() will return
> > ENOTSUPP. In fact, arch_uprobe_analyze_insn() will also do the same.
> 
> Yes and the check in arch_uprobe_analyze_insn() should go away.
> 
> But you missed my point. Please forget about prepare_uprobe(), it is
> wrong anyway. And, prepare_uprobe() inspects the _original_ insn from
> the file, this has nothing install_breakpoint/etc.
>
> I meant verify_opcode() called by install_breakpoint/etc.

For the case where X already exists, verify_opcode() currently returns 0.
IMO, it should return -EEXIST, unless you are proposing that uprobes
should ride on the existing trap (even if its a variant).

If you are proposing that uprobes ride on X if it already exists, that's
not always possible and is a big can of worms... see below...

> > This itself should take care of all the cases.
> >
> > > And I am just curious, could you explain how X and UPROBE_SWBP_INSN
> > > differ?
> >
> > Powerpc has numerous variants of the trap instruction based on
> > comparison of two registers or a regsiter and immediate value and a condition
> > (less than, greater than, [signed forms thereof], or equal to).
> >
> > Uprobes uses 0x7fe0008 which is 'tw 31,0,0'  which essentially is an
> > unconditional trap.
> >
> > Gdb uses many traps, one of which is 0x7d821008 which is twge r2,r2,
> > which is basically trap if r2 greater than or equal to r2.
> 
> OK. So, if I understand correctly, gdb can use some conditional
> breakpoint, and it is possible that this insn won't generate the
> trap?

Yes it is possible if the condition is not met. If the condition is
met, the instruction will generate a trap, and uprobes will do a
send_sig(SIGTRAP) from handle_swbp().

> Then this patch is not right, or at least we need another change
> on top?
> 
> Once again. Suppose that gdb installs the TRAP_IF_R1_GT_R2.
> 
> After that uprobe_register() is called, but it won't change this
> insn because verify_opcode() returns 0.
> 
> Then the probed task hits this breakoint with "r1 < r2" and we do
> not report this event.

At this time, the condition for the trap is not satisfied, so no
exception occurs. If the expectation is that the trap always trigger,
then all such trap variants need to be replaced with the unconditional
trap and we should either add logic to re-execute the condional trap
after uprobe handling and send_sig() via handle_swbp() or emulate the
condition in software and do a send_sig() if needed.

> So. I still think that we actually need something like below, and
> powerpc should reimplement is_trap_insn() to use is_trap(insn).
> 
> No?

I don't see how this will help, especially since the gdb<->uprobes is
fraught with races.

With your proposed patch, we refuse to insert a uprobe if the underlying
instruction is a UPROBE_SWBP_INSTRUCTION; changing is_swbp_at_addr()
will need changes in handle_swbp() too. But, unlike x86, we cannot
expect a uprobe with an underlying trap variant (X) to always trigger.

IMHO, its not a good idea to do that for x86 either, since you'll run
into many other complications (what if the entity that put the original
breakpoint, removed it, etc).

IMHO, I really think we should not allow uprobe_register() to succeed if
the underlying instruction is a breakpoint (or a variant thereof).

Ananth
