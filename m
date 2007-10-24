Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 782FDDDEBB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Oct 2007 08:39:12 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so438540wag
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Oct 2007 15:39:09 -0700 (PDT)
Message-ID: <fa686aa40710241539r792380dam62ea820a48dab62e@mail.gmail.com>
Date: Wed, 24 Oct 2007 16:39:04 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Matt Mackall" <mpm@selenic.com>
Subject: Re: Apparent kernel bug with GDB on ppc405
In-Reply-To: <20071024223250.GI19691@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071024194640.GB19691@waste.org>
	<fa686aa40710241328x77435cc1lf09cac730b0ce5ac@mail.gmail.com>
	<20071024204215.GC19691@waste.org> <20071024215421.GF19691@waste.org>
	<fa686aa40710241527j1a316760lf36d512eb625810f@mail.gmail.com>
	<20071024223250.GI19691@waste.org>
Cc: gdb@sourceware.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 10/24/07, Matt Mackall <mpm@selenic.com> wrote:
> On Wed, Oct 24, 2007 at 04:27:52PM -0600, Grant Likely wrote:
> > On 10/24/07, Matt Mackall <mpm@selenic.com> wrote:
> > > On Wed, Oct 24, 2007 at 03:42:16PM -0500, Matt Mackall wrote:
> > > > On Wed, Oct 24, 2007 at 02:28:14PM -0600, Grant Likely wrote:
> > > > > On 10/24/07, Matt Mackall <mpm@selenic.com> wrote:
> > > > > > I'm trying to debug a trivial statically-linked hello world program on
> > > > > > a Xilinx PPC 405 and I'm seeing the following behavior:
> > > > > >
> > > > > <snip>
> > > > > >
> > > > > > Any suggestions?
> > > > >
> > > > > http://thread.gmane.org/gmane.linux.ports.ppc.embedded/11202
> > > > >
> > > > > I was fighting with a similar problem almost 2 years ago.  Looks like
> > > > > it might be related.  At some point the problem seemed to go away and
> > > > > I determined what the root cause was.  :-(
> > > > >
> > > > > I haven't been using gdb lately, so I don't know if it's the same
> > > > > problem.  Nobody I had talked to had seen the issue on other 405
> > > > > platforms.  It could very well be something virtex-specific.
> > > >
> > > > Could be the same problem, but I'm seeing only your symptom 3 so far.
> > > >
> > > > I've tried throwing some larger hammers at the problem. Flushing all
> > > > of the dcache and icache (flush_dcache_all and
> > > > flush_instruction_cache) isn't helping. But printk(".") does!
> > >
> > > Well there was one remaining cache - the TLB. This patch seems to make
> > > things work, but don't ask me why:
> > >
> > > --- include/asm-ppc/cacheflush.h        (revision 10439)
> > > +++ include/asm-ppc/cacheflush.h        (working copy)
> > > @@ -11,6 +11,7 @@
> > >  #define _PPC_CACHEFLUSH_H
> > >
> > >  #include <linux/mm.h>
> > > +#include <asm/tlbflush.h>
> > >
> > >  /*
> > >   * No cache flushing is required when address mappings are
> > > @@ -35,10 +36,23 @@
> > >  extern void flush_icache_user_range(struct vm_area_struct *vma,
> > >                 struct page *page, unsigned long addr, int len);
> > >
> > >  #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
> > >  do { memcpy(dst, src, len); \
> > >       flush_icache_user_range(vma, page, vaddr, len); \
> > > +     _tlbia(); \
> > >  } while (0)
> >
> > Hmmm; thinking out loud here...
> >
> > - so tlbia invalidates all TLB entries
> > - When gdb inserts a breakpoint the .text pages are marked as read
> > only, so the kernel does a copy on write so that gdb can modify the
> > instruction.  The kernel also updates the page tables so that the test
> > process now uses the new page.
> > - This means that there are now 2 pages for that one section of
> > executable code; the original and the one with the breakpoint.
> > - However, the program is still in memory, and there is probably
> > already a TLB entry pointing to the original page for that range of
> > addresses.
> >
> > Could it be that the kernel page tables are getting updated to the new
> > page; but active set of TLB entries is not getting updated?
> >
> > If so, then printk(".") probably solves the problem simply because it
> > touches enough pages in its execution path that the old TLB entry gets
> > overwritten?  There are only 64 TLB entries afterall.
> >
> > Thoughts?
>
> Not completely implausible, but a) why isn't this seen on basically
> every machine with software TLB? b) why does -local- GDB, which is
> presumably doing much less work than gdbserver + network stack, not fail?

a) I don't know.... very odd.

b) gdb is big.  It probably touches far more pages (via library calls)
than gdbserver.  The network stack is also big, but it's probably more
localized too.

Niceing down the host also makes sense because if the PC is being slow
then the target may go off and run other things while between setting
the breakpoint and getting the 'go' command.

Can you grab a snapshot of the TLB before and after setting the breakpoint?

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
