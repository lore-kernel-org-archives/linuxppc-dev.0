Date: Fri, 04 Jan 2002 09:00:56 -0800 (PST)
From: jaf <jaf@lcsaudio.com>
Subject: Re: Having linking problems with atomic_inc(),
 atomic_dec_and_test() in user app, help!
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: linuxppc-dev@lists.linuxppc.org,
	linuxppc-user@lists.linuxppc.org, jeffk@jdkoftinoff.com
Message-id: <60823947811-BeMail@sugoi>
MIME-version: 1.0
Content-type: text/plain; charset=Windows-1252
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Michael,

>> Also, what does "relocation truncated to fit: R_PPC_REL24
atomic_inc(atomic_t
>> *)" mean?
>
>About as much as 'unresolved external reference'. atomic_inc isn't
defined
>in the scope of your code. Look at the kernel headers; it might be
inside
>#ifdef __KRENEL__ (actually it is).

I see... when I wrote the code using Red Hat, this was not the case.  I
assumed
things would be similar under all Linuxes... apparently a bad
assumption.

>Why do you think you need to use atomic_inc directly instead of some
>pthreads wrapper?

I wasn't able to find a decent equivalent to atomic_t in the pthreads
API.
The closest thing I could see would be to wrap my counter increments/
decrements in a pthread_mutex_t to serialize them, but creating a
separate mutex for each atomic counter seems a bit expensive/
inefficient, considering there may be thousands of such atomic counters
active at once.  Is there some other way to use pthreads to get an
atomic counter?  Or is a pthread_mutex_t really efficient enough to
make a decent atomic counter out of?  Or do I need to redesign how my
application works, because there is no good way to do a cheap, portable
user-land atomic counter under Linux?  :^(

Jeremy

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
