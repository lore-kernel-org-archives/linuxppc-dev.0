Message-ID: <3844857F.82698A18@netx4.com>
Date: Tue, 30 Nov 1999 21:18:39 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Claude Robitaille <crobitaille@videotron.ca>
CC: Graham Stoney <greyham@research.canon.com.au>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Real Time response/latency question
References: <Pine.LNX.4.10.9911301917280.1860-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Claude Robitaille wrote:

> .... so I have a question: how about interrupt? I guess a very
> simple driver which kicks some userland waiting thread is good enough in
> most cases. Or is there a way to register some userland code?

Interrupts are the reason to write the driver.  The open()/close()
can perform some hardware initialization and shutdown to enable
and disable the interrupt source.  The interrupt handler may
need to do something to remove the pending interrupt, and then
I usually use select() for the user thread synchronization.

The difficulty registering some user function as the interrupt
handler is it must run with interrupts disabled.....there are
a number of complexities associated with allowing this to
occur.  The reason for interrupts disabled is that the handler
must do something to remove the interrupt state before you can
enable interrupts again.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
