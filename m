Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: jaf <jaf@lcsaudio.com>,
	Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Subject: Re: Having linking problems with atomic_inc(), atomic_dec_and_test() in user app, help!
Date: Fri, 4 Jan 2002 13:57:07 -0500
Cc: linuxppc-dev@lists.linuxppc.org, jeffk@jdkoftinoff.com
References: <60823947811-BeMail@sugoi> <20020104183031.EXQM16876.tomts11-srv.bellnexxia.net@there>
In-Reply-To: <20020104183031.EXQM16876.tomts11-srv.bellnexxia.net@there>
MIME-Version: 1.0
Message-Id: <20020104185405.FRGZ20941.tomts10-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

One other thing, PPC implements synchronization using a reservation bit
for specific address with a special instruction pair that sets and clears
the reservation.  But the address to set/clear the reservation on is only
unique down the the cache line size (in most cases 32 bytes for ppc) i.e.
the reservation granularity.

In English, what this means is that if two counters you want to atomically
increment or decrement are stored within 32 bytes of each other and
different threads are simulataneously trying to increment or decrement
them, the reservation can get spurious clears that prevents either one
from working without more looping (i.e performance starts to suffer).

In practive I have very very rarely ever seen this problem have an impact
on anything.  Others may know more.

Hope this helps,

Kevin



On January 4, 2002 01:33, Kevin B. Hendricks wrote:
> Hi,
>
> There are a number of places you can get atomic increment and decrement
> code:
>
> 1. borrow the implementations from the kernel
>
> 2. look at www.openOffice.org CVS sal/osl/unx/interlck.c
>     for atomic increment and decrement code for both x86 linux and ppc
>     linux, and the proper includes for Solaris.
>
> 3. adapt the code from
> glibc-2.2.4/linuxthreads/sysdeps/powerpc/pt-machine.h for "compare
> _and_swap" and "test_and_set" t do your own "dec_and_test"
>
> 4. simply use a pthread mutex to protect the counter (complete overkill)
>
> 5. look at the implementations of these synchronization functions in the
> IBM/Motorola PowerPC Microprocessor Family: The Programming Environment"
> manual (available as a pdf from the Motorola site).  They have
> implementations for "Fetch and Add", "Test and Set" , "Compare and Swap"
> "Lock Acquisition and Release" and "List Insertion"
>
> I personally recommend using the code from interlck.c from OpenOffice as
> your guide and falling back to using a mutex to protect the count for
> unknown processors.  That way it will always work but if performance is
> an issue, someone can add the support for other processors.  This is
> what OpenOffice does for its refernce counted strings.
>
> Hope this helps,
>
> Kevin
>
> On January 4, 2002 12:00, jaf wrote:
> > Hi Michael,
> >
> > >> Also, what does "relocation truncated to fit: R_PPC_REL24
> >
> > atomic_inc(atomic_t
> >
> > >> *)" mean?
> > >
> > >About as much as 'unresolved external reference'. atomic_inc isn't
> >
> > defined
> >
> > >in the scope of your code. Look at the kernel headers; it might be
> >
> > inside
> >
> > >#ifdef __KRENEL__ (actually it is).
> >
> > I see... when I wrote the code using Red Hat, this was not the case.
> > I assumed
> > things would be similar under all Linuxes... apparently a bad
> > assumption.
> >
> > >Why do you think you need to use atomic_inc directly instead of some
> > >pthreads wrapper?
> >
> > I wasn't able to find a decent equivalent to atomic_t in the pthreads
> > API.
> > The closest thing I could see would be to wrap my counter increments/
> > decrements in a pthread_mutex_t to serialize them, but creating a
> > separate mutex for each atomic counter seems a bit expensive/
> > inefficient, considering there may be thousands of such atomic
> > counters active at once.  Is there some other way to use pthreads to
> > get an atomic counter?  Or is a pthread_mutex_t really efficient
> > enough to make a decent atomic counter out of?  Or do I need to
> > redesign how my application works, because there is no good way to do
> > a cheap, portable user-land atomic counter under Linux?  :^(
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
