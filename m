Date: Wed, 16 Aug 2000 22:44:41 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Another signal handling bug?
Message-ID: <Pine.LNX.3.96.1000816224408.30198N-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've just noticed something that, unless I've really misunderstood the man
page, is another significant bug in signal handling.  Put simply, despite
configuration to the contrary, signals are not being blocked during their
handlers, i.e. I'm getting nested signal handlers that never return.

The code in question basically does this:

sa.sa_handler = alarm_handler;
sigemptyset(&sa.sa_mask);
sa.sa_flags = 0;
sigaction(SIGALRM, &sa, NULL);


Note that sa.sa_flags should have to be OR'ed with SA_NOMASK in order for
the behaviour seen to occur, unless I'm drastically misreading the
sigaction man page or unless it's incorrect.

The alarm handler's first statement is a print statement, as is the last
statement.  There are no return statements anywhere in the handler.  I'm
getting results that look like

In handler (should be ignoring SIGALRM signals).
Got Lock!
Leaving handler.
In handler (should be ignoring SIGALRM signals).
Got Lock!
In handler (should be ignoring SIGALRM signals).
We're in trouble.
Leaving handler.
In handler (should be ignoring SIGALRM signals).
We're in trouble.
Leaving handler.
In handler (should be ignoring SIGALRM signals).
We're in trouble.
Leaving handler.

And so forth.  IOW, the first few times, it's fine, but then under heavy
load, the signal handler never returns, but yet the kernel is allowing
SIGALRM to be delivered, resulting in a nested handler.

Any ideas?  BTW, this is with kernel 2.2.12.  A similar bug was found and
fixed under MkLinux about a year ago, but I haven't heard of the problem
in the monolithic kernel.  I can't see any other way it could occur,
though.  It certainly shouldn't be happening in any other thread, as
SIGALRM is blocked before threads are created, and only unblocked in the
thread in question.  I've tried both sigprocmask and pthread_setmask for
the initial block, both with the same results.

Any ideas?


Later,
David

---------------------------------------------------------------------
A brief Haiku:

Microsoft is bad.
It seems secure at first glance.
Then you read your mail.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
