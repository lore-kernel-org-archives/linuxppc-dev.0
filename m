Message-ID: <399C670F.912463EE@sympatico.ca>
Date: Thu, 17 Aug 2000 18:28:31 -0400
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
Reply-To: khendricks@ivey.uwo.ca
MIME-Version: 1.0
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Another signal handling bug?
References: <Pine.LNX.3.96.1000817190341.8005C-100000@deepspace.mklinux.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi David,

Two things:

1. setting the sa_mask to sigemptyset will not mask out any signals in your
handler (see the sigaction man page).  I think you want sigfillset if you want
to mask all signals while in your handler.  Here is a snippet from the sigaction
man page.

       sa_mask gives a mask of signals which  should  be  blocked
       during  execution of the signal handler.  In addition, the
       signal which triggered the handler will be blocked, unless
       the SA_NODEFER or SA_NOMASK flags are used.

2.  You should techically always be calling async signal safe routines
frominside any signal handlers.  Grabbing a mutex lock is not one of these.  You
can sometimes work around this using semaphore posts (which are technically
allowed) inside signal handlers since they are async signal safe.


Hope this helps.

Kevin

.
"David A. Gatwood" wrote:
>
> On Wed, 16 Aug 2000, David A. Gatwood wrote:
>
> > > > I've just noticed something that, unless I've really misunderstood the man
> > > > page, is another significant bug in signal handling.  Put simply, despite
> > > > configuration to the contrary, signals are not being blocked during their
> > > > handlers, i.e. I'm getting nested signal handlers that never return.
> > > >
> > > > The code in question basically does this:
> > > >
> > > > sa.sa_handler = alarm_handler;
> > > > sigemptyset(&sa.sa_mask);
> > > > sa.sa_flags = 0;
> > > > sigaction(SIGALRM, &sa, NULL);
>
> Well, I know why the one handler didn't return -- there was the nasty
> little point of it trying to take a lock twice.  After fixing that, the
> signal handler _happens_ to always return before the next signal gets
> delivered.  However, obviously that doesn't solve the real issue, since
> any heavy system load could cause that "luck" to no longer hold true.
> Fortunately, for my code's purposes, that is good enough, as long as the
> pthreads locks are correct, but it's still somewhat scary.  :-)
>
> Ideas?
> David
>
> ---------------------------------------------------------------------
> A brief Haiku:
>
> Microsoft is bad.
> It seems secure at first glance.
> Then you read your mail.
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
