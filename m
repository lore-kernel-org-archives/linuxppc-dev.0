Date: Thu, 17 Aug 2000 20:26:00 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: khendricks@ivey.uwo.ca
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Another signal handling bug?
In-Reply-To: <399C6F3D.1CFE185E@sympatico.ca>
Message-ID: <Pine.LNX.3.96.1000817201404.8005G-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 17 Aug 2000, Kevin B. Hendricks wrote:

> Hi David,
>
> > > 2.  You should techically always be calling async signal safe routines
> > > frominside any signal handlers.  Grabbing a mutex lock is not one of these.
> >
> > Wait a sec... how can taking a lock be an atomic operation, but not async
> > signal safe?  That seems a little odd.
>
> Here is what the pthread_mutex_lock page says:
>
> ASYNC-SIGNAL SAFETY
>        The mutex functions are not async-signal safe.  What  this
>        means is that they should not be called from a signal han<AD>
>        dler.  In  particular,   calling   pthread_mutex_lock   or
>        pthread_mutex_unlock  from  a  signal handler may deadlock
>        the calling thread.
>
> You have already experienced the deadlock problem first hand!

Actually, the deadlock was my stupidity.  I took the lock and then
proceeded to call a function that took the lock, which is a no-no with
non-debugging locks.  :-)

Well, I'm rewriting the heck out of this thing, adding Yet Another Thread
(tm) to deal with the signal handling, using nanosleep, which I hope is
interruptable by an alarm, since using sleep is potentially incompatible
with the use of setitimer....  Getting really ugly, but hopefully I can
get all these issues worked out, one way or another.

So anybody know why someone doesn't just write a thread/signal-safe Xlib?
:-)


David

---------------------------------------------------------------------
A brief Haiku:

Microsoft is bad.
It seems secure at first glance.
Then you read your mail.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
