Date: Wed, 16 Aug 2000 23:15:37 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Another signal handling bug?
In-Reply-To: <Pine.LNX.3.96.1000816224408.30198N-100000@deepspace.mklinux.org>
Message-ID: <Pine.LNX.3.96.1000816231301.30198P-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 16 Aug 2000, David A. Gatwood wrote:

> I've just noticed something that, unless I've really misunderstood the man
> page, is another significant bug in signal handling.  Put simply, despite
> configuration to the contrary, signals are not being blocked during their
> handlers, i.e. I'm getting nested signal handlers that never return.
>
> The code in question basically does this:
>
> sa.sa_handler = alarm_handler;
> sigemptyset(&sa.sa_mask);
> sa.sa_flags = 0;
> sigaction(SIGALRM, &sa, NULL);

<snip>

> Any ideas?  BTW, this is with kernel 2.2.12.  A similar bug was found and
> fixed under MkLinux about a year ago, but I haven't heard of the problem
> in the monolithic kernel.

Well, the good news is that it is not kernel specific.  Same problem under
MkLinux (plus a handful of race conditions that I'm trying to track down
now... :-).

Any idea how to convince sigaction to block the signal from being
delivered within its signal handler (like the man page says it's always
supposed to do)?


David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
