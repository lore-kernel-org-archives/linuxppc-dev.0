Message-ID: <002f01c2f4aa$b60b80a0$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: "Till Straumann" <strauman@SLAC.Stanford.EDU>,
	"Tom Rini" <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
References: <IGEFJKJNHJDCBKALBJLLIEHKFLAA.joakim.tjernlund@lumentis.se> <3E81F6FD.2000407@embeddededge.com>
Subject: Re: dcbz works on 862 everywhere!
Date: Thu, 27 Mar 2003 22:49:09 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > hmm, why would not dcbz execute properly? Surely the instruction is restarted
> > when the DTLB Miss/Error handler return?
>
> Write a test to verify it.  I know there were cases in the past when
> it didn't work.  You would notice it when you expected to have some
> zero initialized spaces that weren't.

I think Till's superb analysis show that this is not a problem.

>
> > In a earlier mail you said the there was a case where the "normal" instructions
> > would not set MD_EPN in the DTLB Error handler and that it was documented.
> > What case is this and where can I find this documentation?
>
> Well, it's more of an interpretation of the documentation and discussions
> with Motorola engineers.

So this case is mere speculation and has never been proven?

[SNIP]
> For TLB miss exceptions, the Mx_xxx hardware assist registers work
> properly, as documented, to minimize the number of instructions needed
> to determine what PTE to load.  The TLB miss exception has exactly
> one function, to as quickly as possible locate the PTE from the table
> hierarchy and stuff the bits into the MMU.  That's it and it should
> really be implemented in five lines of code.

Five lines of code, that I would like to see :-) Seriously, why do the
DTLB handlers have two tables, one for kernel space and one for the rest?

Can the DataAccess path be removed in the DTLB Miss handler?

[SNIP]
> > Maybe Till Straumann's suggestion to set the DAR register to a known "bad" address
> > when leaving an exception. Then test for this bad address in the DTLB error handler
> > to decide what register to trust?
>
> Not necessary.
>
> By not "correctly" tracking usage and dirty pages, as we did in the past,
> it caused us to never generate DTLB Error exceptions unless it was truly
> an access to a non-recoverable bad address or if the page was swapped out.
> I would just set 'used' on every instruction page and 'used + dirty' on
> every data page allocation.  A static embedded system would just converge on
> this point anyway, but in more dynamic systems it cost more real memory.

hmm, don't you loose copy-on-write by doing so?

Would the suggested instruction decoding in the DLTB Error handler
be too ugly for your liking?
Since dcbi also causes DTLB Errors with undefined values in DAR and MD_EPN it
might be a good idea.

 Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
