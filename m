Message-ID: <3BA801A9.B6311C93@mvista.com>
Date: Tue, 18 Sep 2001 21:23:37 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Errata 67/77 / walnut bugs (was: Re: Erratum 51 bugfix?)
References: <20010917152316.O3851@zax> <3BA62583.55E48A97@mvista.com> <20010918102901.A1183@zax> <3BA7980B.EEBF1F5D@mvista.com> <20010919121954.D13693@zax>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:
>
> Ah, yes, I discovered ATOMIC_SYNC_FIX after I sent that, and have now
> turned it on.  That should certainly fix the atomic ops, however there
> are quite a number of other places where the kernel uses stwcx., which
> ATOMIX_SYNC_FIX doesn't fix - notably arch/ppc/kernel/bitops.c and
> include/asm-ppc/bitops.h.  As well as activating ATOMIX_SYNC_FIX I
> tried inserting a sync before every other stwcx. that I could find,
> and I haven't managed to get a process to lock up yet.

Just as an FYI, we also do this in glibc to be safe.  We have never been
able to pin down a problem in userspace due to this bug, but we thought
it would be better safe then sorry until we can get definative proof
that the bug will not happen in userspace.

The following two files in glibc should be patched:
linuxthreads/sysdeps/powerpc/pt-machine.h
sysdeps/powerpc/atomicity.h

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
