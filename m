Message-ID: <040a01c0d754$1bf6d5c0$4b00000a@foolio1>
From: "Eli Chen" <eli@routefree.com>
To: "Dan Malek" <dan@mvista.com>
Cc: "Gabriel Paubert" <paubert@iram.es>,
	<brian.kuschak@skystream.com>, <linuxppc-embedded@lists.linuxppc.org>
References: <Pine.HPX.4.10.10105072359470.22253-100000@gra-ux1.iram.es> <3AF72CA8.52163E55@mvista.com> <03a001c0d74e$60022c70$4b00000a@foolio1> <3AF73161.26986237@mvista.com>
Subject: Re: dcache BUG()
Date: Mon, 7 May 2001 17:16:20 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> F**K...that's what I was looking for.  What manual is that in?
> Everything I have handy (older UISA books), state the granularity
> is implementation dependent.  I couldn't find any 4xx manual that
> stated the granularity of the reservation.  I thought 6xx/7xx at
> least checked cache line granularity in addition to a single
> reservation bit.

The book is titled "PowerPC Microprocessor Family: The Programming
Environments".  It's greenish-blue, dated 3/21/2000.  The quote is from the
stwcx. instruction description.  In section 5-4 however, it has this note:

"When a reservation is made to a word in memory by the lwarx instruction, an
address is saved and a reservation is set.  Both of these are necessary for
the memory coherence mechanism, however, some processors do not implement
the address compare for the stwcx. instruction.  Only the reservation need
be established in order of the stwcx. to be successful.  This requires that
exception handlers clear reservations if control is passed to another
program.  Programmers should read the specifications for each individual
processor."

I searched through the 405GP user manual, and it makes no mention of if it
checks the reservation address or not, just like you said.

Eli


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
