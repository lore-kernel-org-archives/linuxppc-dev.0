Date: Thu, 17 Aug 2000 19:08:30 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Another signal handling bug?
In-Reply-To: <Pine.LNX.3.96.1000816232356.30198Q-100000@deepspace.mklinux.org>
Message-ID: <Pine.LNX.3.96.1000817190341.8005C-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 16 Aug 2000, David A. Gatwood wrote:

> > > I've just noticed something that, unless I've really misunderstood the man
> > > page, is another significant bug in signal handling.  Put simply, despite
> > > configuration to the contrary, signals are not being blocked during their
> > > handlers, i.e. I'm getting nested signal handlers that never return.
> > >
> > > The code in question basically does this:
> > >
> > > sa.sa_handler = alarm_handler;
> > > sigemptyset(&sa.sa_mask);
> > > sa.sa_flags = 0;
> > > sigaction(SIGALRM, &sa, NULL);

Well, I know why the one handler didn't return -- there was the nasty
little point of it trying to take a lock twice.  After fixing that, the
signal handler _happens_ to always return before the next signal gets
delivered.  However, obviously that doesn't solve the real issue, since
any heavy system load could cause that "luck" to no longer hold true.
Fortunately, for my code's purposes, that is good enough, as long as the
pthreads locks are correct, but it's still somewhat scary.  :-)


Ideas?
David

---------------------------------------------------------------------
A brief Haiku:

Microsoft is bad.
It seems secure at first glance.
Then you read your mail.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
