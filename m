Return-Path: <ananth@in.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D51FF2C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 02:42:17 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Wed, 20 Mar 2013 11:42:12 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 7685AC9006C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 11:42:05 -0400 (EDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2KFg3T3234664
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 11:42:04 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2KFfunJ018531
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 09:41:59 -0600
Date: Wed, 20 Mar 2013 21:11:52 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] powerpc/uprobes: teach uprobes to ignore gdb breakpoints
Message-ID: <20130320154152.GA8246@in.ibm.com>
References: <20130320104033.GA19844@in.ibm.com>
 <20130320122639.GA29541@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130320122639.GA29541@redhat.com>
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

On Wed, Mar 20, 2013 at 01:26:39PM +0100, Oleg Nesterov wrote:
> Hi Ananth,
> 
> First of all, let me remind that I know nothing about powerpc ;)
> 
> But iirc we already discussed this a bit, I forgot the details but
> still I have some concerns...
> 
> On 03/20, Ananth N Mavinakayanahalli wrote:
> >
> > GDB uses a variant of the trap instruction that is different from the
> > one used by uprobes. Currently, running gdb on a program being traced
> > by uprobes causes an endless loop since uprobes doesn't understand
> > that the trap is inserted by some other entity and hence a SIGTRAP needs
> > to be delivered.
> 
> Yes, and thus is_swbp_at_addr()->is_swbp_insn() called by handle_swbp()
> should be updated,
>
> > +bool is_swbp_insn(uprobe_opcode_t *insn)
> > +{
> > +	return (is_trap(*insn));
> > +}
> 
> And this patch should fix the problem. (and probably this is fine
> for prepare_uprobe()).

Correct

> But, at the same time, is the new definition fine for verify_opcode()?
> 
> IOW, powerpc has another is_trap() insn(s) used by gdb, lets denote it X.
> X != UPROBE_SWBP_INSN.
> 
> Suppose that gdb installs the trap X at some addr, and then uprobe_register()
> tries to install uprobe at the same address. Then set_swbp() will do nothing,
> assuming the uprobe was already installed.
> 
> But we did not install UPROBE_SWBP_INSN. Is it fine? I hope yes, just to
> verify. If not, we need 2 definitions. is_uprobe_insn() should still check
> insns == UPROBE_SWBP_INSN, and is_swbp_insn() should check is_trap().

is_trap() checks for all trap variants on powerpc, including the one
uprobe uses. It returns true if the instruction is *any* trap variant.
So, install_breakpoint()->prepare_uprobe()->is_swbp_insn() will return
ENOTSUPP. In fact, arch_uprobe_analyze_insn() will also do the same.

This itself should take care of all the cases.

> And I am just curious, could you explain how X and UPROBE_SWBP_INSN
> differ?

Powerpc has numerous variants of the trap instruction based on
comparison of two registers or a regsiter and immediate value and a condition
(less than, greater than, [signed forms thereof], or equal to).

Uprobes uses 0x7fe0008 which is 'tw 31,0,0'  which essentially is an
unconditional trap.

Gdb uses many traps, one of which is 0x7d821008 which is twge r2,r2,
which is basically trap if r2 greater than or equal to r2.

Ananth
