Message-ID: <3C39BA9E.7D2FAD56@chinook.com>
Date: Mon, 07 Jan 2002 10:11:26 -0500
From: Peter Desnoyers <pdesnoyers@chinook.com>
MIME-Version: 1.0
To: Liu HongXun-a16975 <a16975@motorola.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Question on the pcmcia module for ppc
References: <01139FC052A0D411900B00508B9535FC04957C2E@ZCH07EXM04.corp.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Liu HongXun-a16975 wrote:
>
> Hi, Peter and all,
> Could you give me some more detailed hints?

I'll repeat what I said, more slowly and clearly :-)

   I don't think that inb() and outb() are working to your PCMCIA
   card, since it appears that the software does not like the
   return value from what is probably the first inb() read from
   the card's I/O space.

That means that the code for inb() (_IOBASE and all that) doesn't match
the way you're initializing your PCMCIA registers.

> As to the IO space, I defined
>
> #define  _IO_BASE              0x80000000
> #define  _IO_BASE_SIZE   0x1000
> in the header file for my board.
> And I use ioremap() in function  arch/ppc/mm/init.c/MMU_init().
> ioremap( _IO_BASE, _IO_BASE_SIZE);
> Is that OK for PCMCIA IO base access?

You'll have to tell me.  Or else you'll have to provide some information
on how you're initializing the PCMCIA registers.

One very relevant question here - do you have PCI on your board?
Mapping all this stuff properly is a bit harder if you do, but still
doable.

--
.....................................................................
 Peter Desnoyers            (781) 457-1165   pdesnoyers@chinook.com
 Chinook Communications     (617) 661-1979   pjd@fred.cambridge.ma.us
 100 Hayden Ave, Lexington MA 02421

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
