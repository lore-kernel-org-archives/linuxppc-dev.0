Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 5E57F2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Aug 2012 01:04:20 +1000 (EST)
Date: Fri, 17 Aug 2012 17:00:31 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH v3 2/2] powerpc: Uprobes port to powerpc
Message-ID: <20120817150031.GA5029@redhat.com>
References: <20120726051902.GA29466@in.ibm.com>
 <20120726052029.GB29466@in.ibm.com> <20120815165931.GA10059@redhat.com>
 <1345066913.11751.4.camel@pasglop> <20120816050030.GA12060@in.ibm.com>
 <20120816152112.GA8874@redhat.com> <20120817051307.GA4782@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120817051307.GA4782@in.ibm.com>
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

On 08/17, Ananth N Mavinakayanahalli wrote:
>
> On Thu, Aug 16, 2012 at 05:21:12PM +0200, Oleg Nesterov wrote:
>
> > Hmm, I am not sure. is_swbp_insn(insn), as it is used in the arch agnostic
> > code, should only return true if insn == UPROBE_SWBP_INSN (just in case,
> > this logic needs more fixes but this is offtopic).
>
> I think it does...
>
> > If powerpc has another insn(s) which can trigger powerpc's do_int3()
> > counterpart, they should be rejected by arch_uprobe_analyze_insn().
> > I think.
>
> The insn that gets passed to arch_uprobe_analyze_insn() is copy_insn()'s
> version, which is the file copy of the instruction.

Yes, exactly. And we are going to single-step this saved uprobe->arch.insn,
even if gdb/whatever replaces the original insn later or already replaced.

So arch_uprobe_analyze_insn() should reject the "unsafe" instructions which
we can't step over safely.

> We should also take
> care of the in-memory copy, in case gdb had inserted a breakpoint at the
> same location, right?

gdb (or even the application itself) and uprobes can obviously confuse
each other, in many ways, and we can do nothing at least currently.
Just we should ensure that the kernel can't crash/hang/etc.

> Updating is_swbp_insn() per-arch where needed will
> take care of both the cases, 'cos it gets called before
> arch_analyze_uprobe_insn() too.

For example. set_swbp()->is_swbp_insn() == T means that (for example)
uprobe_register() and uprobe_mmap() raced with each other and there is
no need for set_swbp().

However, find_active_uprobe()->is_swbp_at_addr()->is_swbp_insn() is
different, "true" confirms that this insn has triggered do_int3() and
thus we need send_sig(SIGTRAP) (just in case, this is not strictly
correct too but offtopic again).

We definitely need more changes/fixes/improvements in this area. And
perhaps powerpc requires more changes in the arch-neutral code, I dunno.
In particular, I think is_swbp_insn() should have a single caller,
is_swbp_at_addr(), and this caller should always play with current->mm.
And many, many other changes in the long term.

So far I think that, if powerpc really needs to change is_swbp_insn(),
it would be better to make another patch and discuss this change.
But of course I can't judge.

Oleg.
