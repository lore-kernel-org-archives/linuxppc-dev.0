From: dank@kegel.com
Message-ID: <3D3983EB.E4021F2F@kegel.com>
Date: Sat, 20 Jul 2002 08:38:19 -0700
Reply-To: dank@kegel.com
MIME-Version: 1.0
To: Mark Hatle <fray@mvista.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>,
	Jan Olderdissen <jolderdissen@ixiacom.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Dan Kegel <dkegel@ixiacom.com>
Subject: Re: Errata 67/77 / walnut bugs (was: Re: Erratum 51 bugfix?)
References: <3D3901F5.1FEEBB65@kegel.com> <3D397E52.2E5CEE74@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Hatle wrote:
> The atonicity patches had not been submitted back to glibc due to there being
> now way for me to show it was needed

That *is* a problem, isn't it?  We have a test case, but not one we
can distribute.  I'm trying to create a clean one that can be distributed,
but this bug is hard to trigger.

> and also that it ONLY affects the 405 CPU,
> which isn't the main target of glibc.
>
> We are currently working on revising our glibc patches to the current CVS
> version, and if a new patch is required I'll make sure it gets posted here.  I
> really don't know the best way to handle this in a community glibc/gcc realm.
> I'd almost like to wait and see what the GCC maintainers response is.
> Specifically how they are going to accept the patch.  Then we propose a similar
> thing to the glibc folks, explain the problem and hope they accept the patch as
> well.  The biggest problem of course is that if we enable this for all PPCs
> we're going to take a performance penalty for CPUs that don't have the problem.

The patch can be made conditional, so that by default it affects nothing.
The libstdc++ mailing list has already blessed the part of the change
that affects them.

Here's how to do it:

1. Arrange for gcc to define __PPC405__ when appopriate by changing
gcc/config/rs6000/rs6000.h:

-%{mcpu=405: -D_ARCH_PPC} \
+%{mcpu=405: -D_ARCH_PPC -D__PPC405__} \

2. Surround the workaround with #ifdef __PPC405__.  For instance,
in gcc-3.0.2/libstdc++-v3/config/cpu/powerpc/bits/atomicity.h:

+#ifdef __PPC405__
+#define        __LIBSTDCPP_PPC405_ERR77_SYNC   "sync \n\t"
+#else
+#define __LIBSTDCPP_PPC405_ERR77_SYNC
+#endif
+
 static inline _Atomic_word
 __attribute__ ((__unused__))
 __exchange_and_add (volatile _Atomic_word* __mem, int __val)
@@ -42,6 +54,7 @@
        "0:\t"
        "lwarx    %0,0,%2 \n\t"
        "add%I3   %1,%0,%3 \n\t"
+       __LIBSTDCPP_PPC405_ERR77_SYNC

3. Arrange for ppc405-specific libraries to be generated.  I'm
still working on this, but it's something like

--- gcc/config/rs6000/t-ppcos.orig
+++ gcc/config/rs6000/t-ppcos
@@ -1,7 +1,7 @@
 # Multilibs for a powerpc hosted ELF target (linux, SVR4, solaris)

-MULTILIB_OPTIONS       = msoft-float
-MULTILIB_DIRNAMES      = nof
+MULTILIB_OPTIONS       = msoft-float/mcpu=405
+MULTILIB_DIRNAMES      = nof ppc405

4. Arrange to suppress generation of ppc405-specific libraries by default.
I have yet to do this, but it's probably a change to gcc/config-ml.in
to add an --enable-ppc405 option.

I could use help in two areas:
figuring out how to generate many interrupts on the ppc405 to make
a regression test more likely to run into the problem (see my previous
post to linuxppc-embedded), and
figuring out how gcc's MULTILIB_EXCEPTIONS parameter (I'll be posting
to the gcc list about that, so hopefully some expert there will
give me a clue).

Oh, and it'd be nice to hear what you think of my patch to gcc3, too.

It'd be nice to get ppc405 support in the gcc/glibc mainline, glad to hear
you're working on it too!
- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
