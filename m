Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 824A72C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2012 23:13:21 +1000 (EST)
Date: Tue, 21 Aug 2012 15:09:30 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH v3 2/2] powerpc: Uprobes port to powerpc
Message-ID: <20120821130930.GA10382@redhat.com>
References: <20120726051902.GA29466@in.ibm.com>
 <20120726052029.GB29466@in.ibm.com> <20120815165931.GA10059@redhat.com>
 <1345066913.11751.4.camel@pasglop> <20120816050030.GA12060@in.ibm.com>
 <20120816152112.GA8874@redhat.com> <20120817051307.GA4782@in.ibm.com>
 <20120817150031.GA5029@redhat.com> <20120821112433.GB3519@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120821112433.GB3519@in.ibm.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, peterz@infradead.org,
 lkml <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/21, Ananth N Mavinakayanahalli wrote:
>
> On Fri, Aug 17, 2012 at 05:00:31PM +0200, Oleg Nesterov wrote:
>
> > > We should also take
> > > care of the in-memory copy, in case gdb had inserted a breakpoint at the
> > > same location, right?
> >
> > gdb (or even the application itself) and uprobes can obviously confuse
> > each other, in many ways, and we can do nothing at least currently.
> > Just we should ensure that the kernel can't crash/hang/etc.
>
> Absolutely. The proper fix for this at least from a breakpoint insertion
> perspective is to educate gdb (possibly ptrace itself) to fail on a
> breakpoint insertion request on an already existing one.

Oh, I don't think this is possible. And there are other problems like
this. Uprobe can confuse gdb too, in many ways. For example,
uprobe_register() can wrongly _remove_ int3 installed by gdb.

The proper fix, I think, is to rework the whole idea about uprobe bps,
but this is really "in the long term". install_breakpoint() should
only unmap the page and mark its pte as "owned by kernel, FOLL_WRITE
should not work". Something like migration or PROT_NONE. The task
itself should install bp during the page fault. And we need the
"backing store" for the pages with uprobes. Yes, this all is very
vague and I can be wrong.

Anyway, this is relatively minor, we have more serious problems.

> > > Updating is_swbp_insn() per-arch where needed will
> > > take care of both the cases, 'cos it gets called before
> > > arch_analyze_uprobe_insn() too.
> >
> > For example. set_swbp()->is_swbp_insn() == T means that (for example)
> > uprobe_register() and uprobe_mmap() raced with each other and there is
> > no need for set_swbp().
>
> This is true for Intel like architectures that have *one* swbp
> instruction. On Powerpc, gdb for instance, can insert a trap variant at
> the address. Therefore, is_swbp_insn() by definition should return true
> for all trap variants.

Not in this case, I think.

OK, I was going to do this later, but this discussion makes me think
I should try to send the patch sooner.

set_swbp()->is_swbp_at_addr() is simply unneeded and in fact should
be considered as unnecessary pessimization.

set_orig_insn()->is_swbp_at_addr() makes more sense, but it can't fix
all races with userpace. Still it should die.

> OK. I will separate out the is_swbp_insn() change into a separate patch.

Great thanks. And if we remove is_swbp_insn() from set_swbp() and
set_orig_insn() then the semantics of is_swbp_insn() will much more
clear, and in this case I powerpc probably really needs to change it.

Oleg.
