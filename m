From: dank@kegel.com
Message-ID: <3D3901F5.1FEEBB65@kegel.com>
Date: Fri, 19 Jul 2002 23:23:49 -0700
Reply-To: dank@kegel.com
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>,
	Mark Hatle <fray@mvista.com>
Cc: Jan Olderdissen <jolderdissen@ixiacom.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Dan Kegel <dkegel@ixiacom.com>
Subject: Re: Errata 67/77 / walnut bugs (was: Re: Erratum 51 bugfix?) 
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Hatle <fray@mvista.com> wrote on 18 Sep 2001:
> David Gibson wrote:
> > Ah, yes, I discovered ATOMIC_SYNC_FIX after I sent that, and have now
> > turned it on. That should certainly fix the atomic ops, however there
> > are quite a number of other places where the kernel uses stwcx., which
> > ATOMIX_SYNC_FIX doesn't fix - notably arch/ppc/kernel/bitops.c and
> > include/asm-ppc/bitops.h. As well as activating ATOMIX_SYNC_FIX I
> > tried inserting a sync before every other stwcx. that I could find,
> > and I haven't managed to get a process to lock up yet.
>
> Just as an FYI, we also do this in glibc to be safe. We have never been
> able to pin down a problem in userspace due to this bug, but we thought
> it would be better safe then sorry until we can get definative proof
> that the bug will not happen in userspace.
>
> The following two files in glibc should be patched:
> linuxthreads/sysdeps/powerpc/pt-machine.h
> sysdeps/powerpc/atomicity.h

We may have an example of a problem in userspace caused by erratum 77.
We've been using a version of gcc3.0.2 running with your patched glibc, and
had a very mysterious crash that happened roughly once in 1000 minutes,
but only with a lucky build of our c++ app.  The problem disappeared
if you looked at it in any way.  Fortunately (?), we had a rack of 100
CPUs running the app, so the MTBF was 10 minutes.

It looks like the following file in gcc3 must be patched:
 gcc-3.0.2/libstdc++-v3/config/cpu/powerpc/bits/atomicity.h
Here's my and Jan's attempt at a patch:
 http://gcc.gnu.org/ml/libstdc++/2002-07/msg00152.html

Have your patches to glibc been contributed back to the mainline yet?
I'm looking carefully about how best to contribute my change;
I think it ought to be a multilib that is explicitly enabled.
- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
