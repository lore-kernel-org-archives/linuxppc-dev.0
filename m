Return-Path: <shaggy@linux.vnet.ibm.com>
Subject: Re: [PATCH 05/13] powerpc/476: Add isync after loading mmu and
	debug spr's
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Hollis Blanchard <hollis@penguinppc.org>
In-Reply-To: <fb412d761003071508v15586071wf38bc1ae1ad17480@mail.gmail.com>
References: <20100305204255.18424.85295.sendpatchset@norville.austin.ibm.com>
	<20100305204324.18424.40814.sendpatchset@norville.austin.ibm.com>
	<fb412d761003071508v15586071wf38bc1ae1ad17480@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 10 Mar 2010 15:09:05 -0600
Message-Id: <1268255345.1516.16.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>, Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2010-03-07 at 15:08 -0800, Hollis Blanchard wrote:
> On Fri, Mar 5, 2010 at 12:43 PM, Dave Kleikamp
> <shaggy@linux.vnet.ibm.com> wrote:
> >
> > powerpc/476: Add isync after loading mmu and debug spr's
> >
> > From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> >
> > 476 requires an isync after loading MMU and debug related SPR's.  Some of
> > these are in performance-critical paths and may need to be optimized, but
> > initially, we're playing it safe.
> 
> Why is there sometimes #ifdef CONFIG_PPC_47x, sometimes not, and never
> the cputable infrastructure which was intended for this sort of thing?

The places without an ifdef are either in cpu initialization code, where
the cost of an isync is insignificant or, in one case, in 47x-specific
code.

I was having problems trying to get the cputable infrastructure
compiling in inline assembly in the *.c files, but I could have used
that in some places.  Currently, one can't build with CONFIG_PPC_47x for
a non-47x cpu, and we want to re-evaluate whether we can get by without
these isyncs.  So basically, I plan to clean this up somehow by the time
we have a working unified 44x/47x binary kernel.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center
