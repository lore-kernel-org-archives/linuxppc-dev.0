In-Reply-To: <19990222143657.28939.rocketmail@send206.yahoomail.com>
Date: Mon, 22 Feb 1999 19:53:04 +0100
To: "D.J. Barrow" <barrow_dj@yahoo.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: I believe I found a bug in /arch/ppc/kernel/signal.c
Message-Id: <19990222195304.000021@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Feb 22, 1999, D.J. Barrow <barrow_dj@yahoo.com> wrote:

>The bug manifested itself in tftp, when longjmp'ing out
>of the signal handler on timeouts.
>
>Resulting in....
>a )sys_sigreturn not get called 
>b) signals queued & trampoline stuff on the user stack being trashed.
>c) SIGALRM being blocked forever.

Note also that the people doing ShapeShifter (Mac runtime) told they are
having problem with alternate signal stacks. I didn't look very in depth
at the code, it looks like it's here but I didn't tested. I don't have
more details about their exact problem but if someone is going to look at
the signal stuffs, then think about eventually testing the alt stack.

(I think they need this because parts of MacOS ROM code will use R1 for
something else than stack, I love Apple ;-)

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
