Message-ID: <3A808560.6FF96E3C@mvista.com>
Date: Tue, 06 Feb 2001 18:14:40 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: Gabriel Paubert <paubert@iram.es>, tom_gall@vnet.ibm.com,
        linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
References: <3A6CCBDC.3D7B722A@mvista.com>
		<Pine.HPX.4.10.10101231050450.3872-100000@gra-ux1.iram.es>
		<14975.55035.835724.234984@tango.linuxcare.com.au>
		<3A806D89.16B31EA0@mvista.com> <14976.30150.97137.755604@tango.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> Are you saying that when two tasks both have an object mapped, we
> should be using the same virtual address in PPC terms

No.  Simply that the PowerPC allows us to utilize a greater than
32-bit address and an MMU context should represent that and allow
us to manage it.

> You're intent on solving a problem that doesn't exist, just because
> the hardware can solve it.

I think the CONFIG_HIGHMEM is clearly a problem that wasn't
implemented very well.  We are seeing embedded PowerPCs with 1G or
larger real memory, along with lots of PCI busses with devices
that require mapping.  This simply doesn't work today without some
kernel modifications.  Clearly problems that need solutions.


> And saying "lazy TLB reloader" is misleading.  Lazy TLB reloading is
> what you do when your MMU doesn't have any support for MMU contexts,
> in order to try to minimize TLB flushes.

That's exactly what we are doing on PowerPC.  We use the VSIDs as a
kind of context register, not as an extension of virtual space addressing.
We minimize TLB flushes by using different VSIDs for Linux MMU contexts.
When switching MMU contexts, we simply allow the new VSIDs to miss
and cause a TLB reload.  It's not misleading, it is exactly what
we are doing.  We aren't actually minimizing anything, just postponing
the TLB reloads.  Actively switching MMU contexts allows the ability
to preload TLB entries, minimizing misses upon the context switch,
and also provides a more predictable context switch behavior.  Do it
right, get more features and flexibility.



> On a 32-bit PPC you can't ever see more than 4GB of virtual address
> space at once without changing mappings.

Yep.

> ....  We really don't want to go
> down the path of trying to use the segment registers like the bank
> registers you used to get on 16-bit systems 25 years ago.

We already have.  That is basically what CONFIG_HIGHMEM does...just
a horse of a different color.

> .......  For
> example, if we mapped in the highmem pages like this, it would
> drastically limit the number of highmem pages that we could have
> mapped in at once.

But that is effectively what we are (Linus is :-) doing.  It is
competition for a finite resource.  My only suggestion is we take
advantage of the PowerPC hardware to do it for us, and then have
a cleaner path to a 64-bit (or simply larger physical address space)
implementations (like the 7450).


> Let me know when you've rewritten the whole of the Linux generic MM
> layer. :-)

Linus is learning :-).  We don't have to rewrite much of it anymore.
We just need to use it more wisely in our processor specific porting.

> The reason for having the user task space visible....

I've known about that trade off for about 25 years, and I am sure it
was discussed long before that.  From experience, I tend to favor
the other direction.  The user/kernel spaces are separate and you
should design a system that treats them as such.  If you want to
share the space, you end up with empty functions/macros for mapping.
Much easier than trying to go the other way.  You also uncover lots
of programming errors, especially the pointers are not integers, that
makes it much easier to scale up to larger systems.  There are just
way too many advantages to separate user/kernel spaces and the trivial
data copy argument should just never prevail.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
