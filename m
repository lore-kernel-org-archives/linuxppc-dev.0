Message-ID: <01139FC052A0D411900B00508B9535FC04957C2E@ZCH07EXM04.corp.mot.com>
From: Liu HongXun-a16975 <a16975@motorola.com>
To: Peter Desnoyers <pdesnoyers@chinook.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Question on the pcmcia module for ppc
Date: Mon, 7 Jan 2002 11:02:57 +0800 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Peter and all,
Could you give me some more detailed hints?
The return value from m8xx_get_status()/m8xx_pcmcia.c is 0x190, which means
the current status of the PCMCIA card is : SS_POWERON + SS_DETECT + SS_BATDEAD.
It seems that the problem coming from SS_BATDEAD.
In function m8xx_get_status()/m8xx_pcmcia.c, there are the following statements:
	if (s->state.flags & SS_IOCARD)
		*value |= (pipr & M8XX_PCMCIA_BVD1(_slot_)) ? SS_STSCHG : 0;
	else {
		*value |= (pipr & M8XX_PCMCIA_RDY(_slot_)) ? SS_READY : 0;
		*value |= (pipr & M8XX_PCMCIA_BVD1(_slot_)) ? SS_BATDEAD : 0;
		*value |= (pipr & M8XX_PCMCIA_BVD2(_slot_)) ? SS_BATWARN : 0;
	}
My card is a Prism2 WLAN card, a IOCARD. Why  "(s->state.flags  & SS_IOCARD)"
returns FALSE?
Who should set the s->state.flags to state this is a IO CARD, not a memory only card?

As to the IO space, I defined

#define  _IO_BASE              0x80000000
#define  _IO_BASE_SIZE   0x1000
in the header file for my board.
And I use ioremap() in function  arch/ppc/mm/init.c/MMU_init().
ioremap( _IO_BASE, _IO_BASE_SIZE);
Is that OK for PCMCIA IO base access?

Thanks a lot
rolf

-----Original Message-----
From: Peter Desnoyers [mailto:pdesnoyers@chinook.com]
Sent: 2002?1?4? 22:21
To: Liu HongXun-a16975
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Question on the pcmcia module for ppc


Liu HongXun-a16975 wrote:
>
> When I inserted ds.o, the driver tells me that "cs: socket 0 timed out during reset"
> I looked through the source code and the debug info.
> I found that a lot of the same messages as follows:
> GetStatus(0) = 0x190
> ...
> Such info come from m8xx_pcmcia.c/m8xx_get_status. It seems that someone
> is not satisfied with the above return value and " get status " again and again.
> Then it quit.

To look at it a different way - the driver was unhappy with the value of
the first inb() on an address in the card's I/O space.

My first guess (been there myself) is that inb() and outb() aren't
working to your card's I/O space.


--
.....................................................................
 Peter Desnoyers            (781) 457-1165   pdesnoyers@chinook.com
 Chinook Communications     (617) 661-1979   pjd@fred.cambridge.ma.us
 100 Hayden Ave, Lexington MA 02421

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
