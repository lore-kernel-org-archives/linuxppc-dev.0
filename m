From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14976.38302.725479.486320@diego.linuxcare.com.au>
Date: Wed, 7 Feb 2001 11:23:58 +1100 (EST)
To: Dan Malek <dan@mvista.com>
Cc: Gabriel Paubert <paubert@iram.es>, tom_gall@vnet.ibm.com,
        linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
In-Reply-To: <3A808560.6FF96E3C@mvista.com>
References: <3A6CCBDC.3D7B722A@mvista.com>
	<Pine.HPX.4.10.10101231050450.3872-100000@gra-ux1.iram.es>
	<14975.55035.835724.234984@tango.linuxcare.com.au>
	<3A806D89.16B31EA0@mvista.com>
	<14976.30150.97137.755604@tango.linuxcare.com.au>
	<3A808560.6FF96E3C@mvista.com>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek writes:

> No.  Simply that the PowerPC allows us to utilize a greater than
> 32-bit address and an MMU context should represent that and allow
> us to manage it.

I think would need to see a more concrete proposal to really
understand what you're getting at.

> > And saying "lazy TLB reloader" is misleading.  Lazy TLB reloading is
> > what you do when your MMU doesn't have any support for MMU contexts,
> > in order to try to minimize TLB flushes.
>
> That's exactly what we are doing on PowerPC.  We use the VSIDs as a
> kind of context register, not as an extension of virtual space addressing.

No, let's be clear, we are *not* doing lazy TLB switching as the term
is used in the linux kernel.  As I understand it, on x86 the kernel
avoids switching the page tables on a context switch if possible, so
in fact a process running in the kernel can in some cases be running
using the page tables of another task.  This is a win in the cases
where you switch to a task which does a small amount of processing
(and doesn't access its userspace area) then goes back to sleep.

> We minimize TLB flushes by using different VSIDs for Linux MMU contexts.
> When switching MMU contexts, we simply allow the new VSIDs to miss
> and cause a TLB reload.  It's not misleading, it is exactly what
> we are doing.  We aren't actually minimizing anything, just postponing
> the TLB reloads.  Actively switching MMU contexts allows the ability
> to preload TLB entries, minimizing misses upon the context switch,

Preloading TLB entries just means you take the hit now instead of
later, how does that help?  In general it's better to take the hit
later because you can't predict with 100% accuracy which TLB entries
will be needed.  If you preload an entry which isn't then used, you've
wasted time.

> > ....  We really don't want to go
> > down the path of trying to use the segment registers like the bank
> > registers you used to get on 16-bit systems 25 years ago.
>
> We already have.  That is basically what CONFIG_HIGHMEM does...just
> a horse of a different color.

No, the point about bank registers, or segment registers, is that
there are only a few of them, whereas there are lots of pages.  That's
why it is better to map in high memory pages using PTEs instead of
segment registers.

You talk about "utilizing a greater than 32 bit address".  But on a
32-bit platform you have to do some kind of mapping in order to access
that.  You can do that mapping with PTEs or with segment registers,
but the trouble with segment registers is that there are far too few
of them to be useful.

> But that is effectively what we are (Linus is :-) doing.  It is
> competition for a finite resource.  My only suggestion is we take
> advantage of the PowerPC hardware to do it for us, and then have
> a cleaner path to a 64-bit (or simply larger physical address space)
> implementations (like the 7450).

Sounds nice, got a concrete proposal?  It's easy to criticise.

> I've known about that trade off for about 25 years, and I am sure it
> was discussed long before that.  From experience, I tend to favor
> the other direction.  The user/kernel spaces are separate and you
> should design a system that treats them as such.  If you want to

Linux does, that's why there is copy_to/from_user, get/put_user etc.
The sparc64 port has separate user and kernel spaces, but there at
least you have the lda and sta instructions (load/store to/from
alternate address space) which can access the user space with no
overhead.

--
Paul Mackerras, Open Source Research Fellow, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
