From: dank@kegel.com
Message-ID: <3D39A487.6CFD6A8A@kegel.com>
Date: Sat, 20 Jul 2002 10:57:27 -0700
Reply-To: dank@kegel.com
MIME-Version: 1.0
To: Mark Hatle <fray@mvista.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>,
	Jan Olderdissen <jolderdissen@ixiacom.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Dan Kegel <dkegel@ixiacom.com>
Subject: Re: Errata 67/77 / walnut bugs (was: Re: Erratum 51 bugfix?)
References: <3D3901F5.1FEEBB65@kegel.com> <3D397E52.2E5CEE74@mvista.com> <3D3983EB.E4021F2F@kegel.com> <3D398985.44957A8C@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Hatle wrote:
> dank@kegel.com wrote:
> > We have a test case, but not one we can distribute....
>
> Well at least you have hit the problem, so at least it is shown to affect
> someone.  BTW what version of the kernel sources are you using?

We're using 2.4.17 from linuxppc_2_4_devel as of late December 2001.
We do not yet have confirmation that we're running into erratum 77, but
it seems likely.

> > The patch can be made conditional, so that by default it affects nothing.
> >
> > 1. Arrange for gcc to define __PPC405__ when appopriate by changing
> > gcc/config/rs6000/rs6000.h:
> >
> > -%{mcpu=405: -D_ARCH_PPC} \
> > +%{mcpu=405: -D_ARCH_PPC -D__PPC405__} \
> >
> > 2. Surround the workaround with #ifdef __PPC405__.  For instance,
> > in gcc-3.0.2/libstdc++-v3/config/cpu/powerpc/bits/atomicity.h:
> .....
>
> Ya that all makes sense to me, and from the couple of threads I saw on the gcc
> mailing list at least it seems to be acceptable to those folks as well.
>
> As far as the multilib stuff goes I'll leave that to the gcc experts, I really
> don't understand how the multilib stuff works.  (We don't use it, we rebuild the
> compiler to target the architecture itself instead of building one gcc that can
> target all of the PPC archs.)

We don't use multilib, either -- well, that's not quite true.  When we
build gcc for the ppc405, we grab the libraries from the 'nof' directory.
Turns out that's multilib in action.  So all I'm doing is arranging
for a second directory, ppc405, to be generated next to nof.  Like nof,
it has softfloat, but it also will have __PPC405__ turned on during library
build, which will trigger the workaround.

> > I could use help in two areas:
> > figuring out how to generate many interrupts on the ppc405 to make
> > a regression test more likely to run into the problem (see my previous
> > post to linuxppc-embedded), and
>
> One suggestion is to create a special kernel that has a hacked timer.c function
> to generate a heck of a lot more timer interrupts..  But I don't know the
> specifics on the kernel or the 405 CPU line to say if that is really practical
> or not.  The other folks in the embedded list would be better then me at that.

OK.  Can some ppc405 expert speak up?

> > Oh, and it'd be nice to hear what you think of my patch to gcc3, too.
>
> Everything looks fine to me.  It definatly looks correct.  (In addition someone
> should suggest that the libjava atomic operation be fixed as well.. not sure how
> many people would use the GCC libjava stuff on 405 though....)

Thanks.  If I get a chance, I'll look at libjava/sysdep/powerpc/locks.h, too.

> > It'd be nice to get ppc405 support in the gcc/glibc mainline, glad to hear
> > you're working on it too!
>
> I'm just not holding my breath for glibc support ...

glibc is notoriously difficult to contribute to.  I would be satisfied
with a separately maintained patch that applies to the latest glibc,
but I am optimistic that if I dot all my i's and cross my t's, I
can get a patch accepted.

- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
