Date: Tue, 30 Oct 2001 19:03:04 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Cc: Gary Byers <gb@gse.com>, Paul Mackerras <paulus@samba.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: floating-point under ppc/linux
In-Reply-To: <8xn129dvwq.fsf@s62.informatik.uni-bremen.de>
Message-ID: <Pine.LNX.4.33.0110301900020.10911-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 30 Oct 2001, Holger Bettag wrote:

> I'd hazard a guess that imprecise floating point exceptions will be
> slowly phased out of modern Out-Of-Order RISCs.
>
> In the 750 (and the whole family line from 603 to 7450), there would be
> no speed gain from allowing FP exceptions to be signalled imprecisely.
> Precise exceptions are basically "free" once you have a queue which enables
> you to complete instructions in program order, because you can also do
> checking for exceptions in program order.
>
> (Well, there would be a small gain with imprecise FP exceptions because
> you wouldn't need to track them in the queue. But in practice you run out
> of other resources before you run out of completion queue entries.)

That's also my feeling. However, divide and square roots may prevent
instruction progress for a long time. Ignoring the case of the precision
exception, checking early for exceptions on square root is trivial, but
not for divisions when you are close to the limit on under/overflow.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
