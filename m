Date: Sat, 10 Nov 2001 00:53:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405 -- a little console help, part 2
Message-ID: <20011110005349.F3141@zax>
References: <3BEA8A5D.50A75CE7@midrivers.com> <3BEAA8D3.51ADDCC8@mvista.com> <20011109114403.J27549@zax> <3BEBDCC9.62669CF1@midrivers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BEBDCC9.62669CF1@midrivers.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Nov 09, 2001 at 06:40:25AM -0700, Mark Pilon wrote:
> David Gibson wrote:
> >
> > Ah, I think I know why this might be - are you using the 2_4_devel
> > tree?
> >
> > All static executables segfaulted before reaching main until very
> > recently: the 4xx's MMU makes it possible to actually enforce the
> > execute permission bit on pages.  Since most processors don't allow
> > this, however, there are heaps of bugs in userland (binutils etc.)
> > where pages aren't marked executable that need to be.  In this case
> > there was instruction just before the got that wasn't marked
> > executable.
> >
> > For now, at least, I've disabled enforcement of the page execute
> > permissions, because there's just too much stuff that breaks with it
> > on.
>
> What's the fix for this?  It sounds like I want to un-do that change
> enforcing page execute permissions -- David, could you give me
> a spot to look and a suggested patch?  anyone?

I've checked the fix into the latest linuxppc_2_4_devel.  Failing
that, look in do_page_fault() in arch/ppc/mm/fault.c, look for a test
against vma->flags & VM_EXEC, and remove it.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
