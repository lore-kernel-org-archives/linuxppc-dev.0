Message-ID: <01139FC052A0D411900B00508B9535FC049C82DE@ZCH07EXM04.corp.mot.com>
From: Liu HongXun-a16975 <a16975@motorola.com>
To: Peter Desnoyers <pdesnoyers@chinook.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Question on the pcmcia module for ppc
Date: Wed, 9 Jan 2002 19:40:25 +0800 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Peter,
>From the debug info, what you said should be right.
The PCMCIA card is a WLAN card (Prism2), using PCMCIA interface.
And there is no PCI bus on my board.
Now, the 'cardctl' utility can tell me something about the WLAN card.
The 'cardctl' can read the CIS info on the WLAN card.
Except the attribute memory for CIS, there is no memory windows on WLAN card.
All the operations are done through IO window.
And the problems come from the access of the IO address space in WLAN card
When I want to access the IO address in the WLAN card, there comes the Ooops message:

"Oops: kernel access of bad area ", coming from bad_page_fault()/fault.c.

It seems that MMU don't know how to access the IO space for the WLAN card, which is 0x80000000 + offset.
But I did use ioremap in arch/ppc/mm/init.c to map in the _IO_BASE ( 0x80000000 ) and
_IO_BASE_SIZE ( 0x1000).

I am totally confused here.

Thanks for suggestion

Rolf

-----Original Message-----
From: Peter Desnoyers [mailto:pdesnoyers@chinook.com]
Sent: 2002?1?7? 23:11
To: Liu HongXun-a16975
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Question on the pcmcia module for ppc




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
