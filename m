Date: Thu, 17 Aug 2000 19:46:26 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: khendricks@ivey.uwo.ca
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Another signal handling bug?
In-Reply-To: <399C670F.912463EE@sympatico.ca>
Message-ID: <Pine.LNX.3.96.1000817193728.8005E-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 17 Aug 2000, Kevin B. Hendricks wrote:

> Hi David,
>
> Two things:
>
> 1. setting the sa_mask to sigemptyset will not mask out any signals in your
> handler (see the sigaction man page).  I think you want sigfillset if you want
> to mask all signals while in your handler.  Here is a snippet from the sigaction
> man page.
>
>        sa_mask gives a mask of signals which  should  be  blocked
>        during  execution of the signal handler.  In addition, the
>        signal which triggered the handler will be blocked, unless
>        the SA_NODEFER or SA_NOMASK flags are used.

However, I'm not setting SA_NODEFER, and it's the signal that triggered
the handler that's recurring, which _is_ supposed to be blocked.


> 2.  You should techically always be calling async signal safe routines
> frominside any signal handlers.  Grabbing a mutex lock is not one of these.

Wait a sec... how can taking a lock be an atomic operation, but not async
signal safe?  That seems a little odd.


Later,
David

---------------------------------------------------------------------
A brief Haiku:

Microsoft is bad.
It seems secure at first glance.
Then you read your mail.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
