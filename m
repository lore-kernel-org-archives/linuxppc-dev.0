Date: Wed, 15 Mar 2000 20:55:52 -0500 (EST)
From: "Peter M. Jansson" <petej@clickvision.com>
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: SIGALRM can't be delivered after longjmp from handler?
In-Reply-To: <Pine.LNX.3.96.1000315175355.32684C-100000@deepspace.mklinux.org>
Message-ID: <Pine.LNX.4.10.10003152053460.9876-100000@penguin.office.clickvision.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I made this exact change, and the program's behavior is unchanged.  Did
you compile and run the program with your change and observe different
behavior?  I still get only one "Wait interrupted" instead of three.

The signal is being delivered multiple times, it just isn't delivered
anymore after the longjmp, so I'm not sure that resetting the signal
handler is involved in this problem.

Pete.

On Wed, 15 Mar 2000, David A. Gatwood wrote:

> > static void
> > interrupt()
> > {
>
> 	signal(SIGALRM, interrupt);
>
> >         printf ("Interrupt: %d\n", count);
> >         if (count > 2)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
