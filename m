Message-ID: <399C6F3D.1CFE185E@sympatico.ca>
Date: Thu, 17 Aug 2000 19:03:25 -0400
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
Reply-To: khendricks@ivey.uwo.ca
MIME-Version: 1.0
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
CC: khendricks@ivey.uwo.ca, linuxppc-dev@lists.linuxppc.org
Subject: Re: Another signal handling bug?
References: <Pine.LNX.3.96.1000817193728.8005E-100000@deepspace.mklinux.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi David,

> > 2.  You should techically always be calling async signal safe routines
> > frominside any signal handlers.  Grabbing a mutex lock is not one of these.
>
> Wait a sec... how can taking a lock be an atomic operation, but not async
> signal safe?  That seems a little odd.

Here is what the pthread_mutex_lock page says:

ASYNC-SIGNAL SAFETY
       The mutex functions are not async-signal safe.  What  this
       means is that they should not be called from a signal han<AD>
       dler.  In  particular,   calling   pthread_mutex_lock   or
       pthread_mutex_unlock  from  a  signal handler may deadlock
       the calling thread.

You have already experienced the deadlock problem first hand!

If you use a spinlock and keep track of the current owner you can implement a
simple mutex with recursion allowed and possibly get away with it but in
general, using mutexes in signal handlers are a big no-no.

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
