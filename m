Message-ID: <B25E2E5A003CD311B61E00902778AF2A02044642@SERVER1>
From: Brian Kuschak <brian.kuschak@skystream.com>
To: "'Eli Chen'" <eli@routefree.com>, Dan Malek <dan@mvista.com>
Cc: Gabriel Paubert <paubert@iram.es>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: dcache BUG()
Date: Mon, 7 May 2001 17:40:48 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The PPC 405GP manual (Aug 2000) from IBM's website states this in Table A1 -
Instruction Syntax Summary:

stwcx.	RS, RA, RB
Store word (RS) in memory at EA=(RA|0) + (RB) only if reservation bit is
set.
if RESERVE = 1 then
	MS(EA,4) <- (RS)
	RESERVE <- 0
	(CR[CR0]) <- 0 || 1 || XERso
else
	(CR[CR0]) <- 0 || 1 || XERso

Looks like the reservation address is not used for the 405.
-Brian


-----Original Message-----
From: Eli Chen [mailto:eli@routefree.com]
Sent: Monday, May 07, 2001 5:16 PM
To: Dan Malek
Cc: Gabriel Paubert; Brian Kuschak; linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()


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
