Message-ID: <3D398985.44957A8C@mvista.com>
Date: Sat, 20 Jul 2002 11:02:13 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: dank@kegel.com
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>,
	Jan Olderdissen <jolderdissen@ixiacom.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Dan Kegel <dkegel@ixiacom.com>
Subject: Re: Errata 67/77 / walnut bugs (was: Re: Erratum 51 bugfix?)
References: <3D3901F5.1FEEBB65@kegel.com> <3D397E52.2E5CEE74@mvista.com> <3D3983EB.E4021F2F@kegel.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


dank@kegel.com wrote:
>
> Mark Hatle wrote:
> > The atonicity patches had not been submitted back to glibc due to there being
> > now way for me to show it was needed
>
> That *is* a problem, isn't it?  We have a test case, but not one we
> can distribute.  I'm trying to create a clean one that can be distributed,
> but this bug is hard to trigger.

Well at least you have hit the problem, so at least it is shown to affect
someone.  BTW what version of the kernel sources are you using?

> The patch can be made conditional, so that by default it affects nothing.
> The libstdc++ mailing list has already blessed the part of the change
> that affects them.
>
> Here's how to do it:
>
> 1. Arrange for gcc to define __PPC405__ when appopriate by changing
> gcc/config/rs6000/rs6000.h:
>
> -%{mcpu=405: -D_ARCH_PPC} \
> +%{mcpu=405: -D_ARCH_PPC -D__PPC405__} \
>
> 2. Surround the workaround with #ifdef __PPC405__.  For instance,
> in gcc-3.0.2/libstdc++-v3/config/cpu/powerpc/bits/atomicity.h:
>

.....

Ya that all makes sense to me, and from the couple of threads I saw on the gcc
mailing list at least it seems to be acceptable to those folks as well.

As far as the multilib stuff goes I'll leave that to the gcc experts, I really
don't understand how the multilib stuff works.  (We don't use it, we rebuild the
compiler to target the architecture itself instead of building one gcc that can
target all of the PPC archs.)

> 3. Arrange for ppc405-specific libraries to be generated.  I'm
> still working on this, but it's something like
> ...
>
> 4. Arrange to suppress generation of ppc405-specific libraries by default.
> I have yet to do this, but it's probably a change to gcc/config-ml.in
> to add an --enable-ppc405 option.

That is probably for the best.

> I could use help in two areas:
> figuring out how to generate many interrupts on the ppc405 to make
> a regression test more likely to run into the problem (see my previous
> post to linuxppc-embedded), and

One suggestion is to create a special kernel that has a hacked timer.c function
to generate a heck of a lot more timer interrupts..  But I don't know the
specifics on the kernel or the 405 CPU line to say if that is really practical
or not.  The other folks in the embedded list would be better then me at that.

> figuring out how gcc's MULTILIB_EXCEPTIONS parameter (I'll be posting
> to the gcc list about that, so hopefully some expert there will
> give me a clue).

It's very much voodoo magic, but unfortunatly I don't really understand it
either.  Sparc, ARM and MIPS might be good examples as they seem to have many
more multilib modes then PPC.  (Arm especially w/ the thumb modes).

> Oh, and it'd be nice to hear what you think of my patch to gcc3, too.

Everything looks fine to me.  It definatly looks correct.  (In addition someone
should suggest that the libjava atomic operation be fixed as well.. not sure how
many people would use the GCC libjava stuff on 405 though....)

> It'd be nice to get ppc405 support in the gcc/glibc mainline, glad to hear
> you're working on it too!

I'm just not holding my breath for glibc support, I'm a bit pesimistic about the
PPC glibc maintainer(s).  I've never had great luck submitting patches and
getting them accepted.  (But it may just be me or the problems I always seem to
run into....)

If you have access to irc, log in to irc.openprojects.net and "#mklinux".

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
