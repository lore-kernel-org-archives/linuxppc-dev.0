To: Gary Byers <gb@gse.com>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: floating-point under ppc/linux
References: <Pine.GSO.4.21.0110291939370.13591-100000@gse.com>
From: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Date: 30 Oct 2001 15:50:29 +0100
In-Reply-To: Gary Byers's message of Tue, 30 Oct 2001 02:42:52 -0800 (PST)
Message-ID: <8xn129dvwq.fsf@s62.informatik.uni-bremen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gary Byers <gb@gse.com> writes:

[...]
> Note that some PPC implementations (e.g., the 750) consider any
> combination of the FE0/FE1 bits other than 00 to imply precise mode;
> it seems like "precise" and "disabled" are the only modes that can be
> portably supported.  I don't what considerations led the 750's
> designers to make this change and don't know whether it's a trend or
> an isolated case.
>
I'd hazard a guess that imprecise floating point exceptions will be
slowly phased out of modern Out-Of-Order RISCs.

In the 750 (and the whole family line from 603 to 7450), there would be
no speed gain from allowing FP exceptions to be signalled imprecisely.
Precise exceptions are basically "free" once you have a queue which enables
you to complete instructions in program order, because you can also do
checking for exceptions in program order.

(Well, there would be a small gain with imprecise FP exceptions because
you wouldn't need to track them in the queue. But in practice you run out
of other resources before you run out of completion queue entries.)

  Holger

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
