From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ralph Blach <rcblach@raleigh.ibm.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: ppc LE questions (seeking help hand info pointers)
Date: Fri, 21 Sep 2001 22:29:29 +0200
Message-Id: <20010921202929.7340@smtp.wanadoo.fr>
In-Reply-To: <3BAB727D.C85E5CB@raleigh.ibm.com>
References: <3BAB727D.C85E5CB@raleigh.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>There are two things that make it superior.
>1)Not turning off translation when an interrupt is taken
>2)The IVOR registers which allow the system interrupts to be place
>correctly.
>
>If one stops to think about it, running Linux out of Ram on a PCI card
>becomes very easy.  This is because the processor does NOT have to fetch
>all interrupts from
>physical location 0.  And now the interrupt routines run with protection
>ON, so protection of task by bad operations in the interrupt handler is
>now possible.
>This will lead to a more secure OS.

While I don't want to take a side in the LE vs. not LE debate, I don't
agree with you on this specific point about interrupts running with MMU
enabled.

First of all, on Linux, and I beleive any sane OS, the exceptions vectors
do their job of saving the context, and then jump to the high level (read
"C") exception handling with the MMU turned back on. So except for the
exception handler low level code itself, there's no security gain here.
And if the exception handler itself is bogus or has holes, then there's
nothing we can do against programmer incompetence.

On the other side, running with MMU ON makes that small task of setting
up the kernel environement on exception entry and unwiding it on
exception exit a lot more tricky. It prevents using MMU off as an
efficient way of using SRR0/SRR1 without caring about taking TLB misses
during critical code patBeWell, I won't argue with you on this ;)

While I don't say the Book E is better or worse than other PPCs (I didn't
look at the specs well enough to say, it might actually be the "killer"
architecture you are talking about ;), I don't agree on the benefit of
the feature outlined above.

Regards,
Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
