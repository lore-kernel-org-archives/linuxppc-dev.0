Date: Fri, 4 Jan 2002 18:44:03 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: jaf <jaf@lcsaudio.com>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	linuxppc-dev@lists.linuxppc.org, jeffk@jdkoftinoff.com
Subject: Re: Having linking problems with atomic_inc(), atomic_dec_and_test()
 in user app, help!
In-Reply-To: <60823947811-BeMail@sugoi>
Message-ID: <Pine.LNX.4.10.10201041821170.19962-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >> Also, what does "relocation truncated to fit: R_PPC_REL24
> atomic_inc(atomic_t
> >> *)" mean?
> >
> >About as much as 'unresolved external reference'. atomic_inc isn't
> defined
> >in the scope of your code. Look at the kernel headers; it might be
> inside
> >#ifdef __KRENEL__ (actually it is).
>
> I see... when I wrote the code using Red Hat, this was not the case.  I
> assumed
> things would be similar under all Linuxes... apparently a bad
> assumption.

It's a kernel or libc header issue - what kernel/libc version was that
on? As far as I can see atomic operations are exported to user programs
except on ppc (not ppc64), mips*, arm and sparc. At least in one case it's
obvious why: MIPS needs to protect against interrupts to guarantee
atomicity.
Another corner case seems to be IBM 405 processors that use what I think
is a privileged instruction as well in order to work around a hardware
bug.

> >Why do you think you need to use atomic_inc directly instead of some
> >pthreads wrapper?
>
> I wasn't able to find a decent equivalent to atomic_t in the pthreads
> API.

pthreadss only came to mind first, there may be other packages. Point
being, on those architectures that cannot guarantee atomic operations
using nonprovileged instructions there has to be some sort of kernel
cooperation (system call?).

> The closest thing I could see would be to wrap my counter increments/
> decrements in a pthread_mutex_t to serialize them, but creating a
> separate mutex for each atomic counter seems a bit expensive/
> inefficient, considering there may be thousands of such atomic counters
> active at once.  Is there some other way to use pthreads to get an
> atomic counter?  Or is a pthread_mutex_t really efficient enough to

I have no experience with pthreads, sorry.

> make a decent atomic counter out of?  Or do I need to redesign how my
> application works, because there is no good way to do a cheap, portable
> user-land atomic counter under Linux?  :^(

Worst-case? The latter. At least for MIPS there doesn't seem to be such a
thing as atomic user land operations. How they would implement a mutex
without those, I wonder ...

You can try to copy the atomic ops from the kernel headers for those
architectures lacking them, hoping it won't break. If it doesn't, you have
a good argument in favor of removing the #ifdef __KERNEL__ :-)

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
