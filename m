Message-ID: <20010819203359.28639.qmail@web20104.mail.yahoo.com>
Date: Sun, 19 Aug 2001 13:33:58 -0700 (PDT)
From: John Francis <johnfrancsis@yahoo.com>
Subject: Re: Using IDMA1 ( or IDMA2 ) on 860
To: Dan Malek <dan@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3B80187C.4743F780@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Dan,

--- Dan Malek <dan@mvista.com> wrote:
> John Francis wrote:
>
>
> > ..... on hardware
> > side I do see the DREQ line going low and I have
> > verified that RCCR register for CPM is set
> correctly
> > to level trigger the interrupt.
> >
> > Any ideas on why IDMA1 interrupt handler is not
> > getting invoked?
>
> The DREQ has nothing to do with generating an
> interrupt, it
> is a data transfer handshake signal.  The
> configuration of
> this pin is determined by the system design,
> connection to
> the peripheral for data transfer and the
> configuration of
> the memory controller.
>
> The configuration of the IDMA channel, including the
> buffer
> descriptors, will determine how and when the CPM
> interrupt
> will occur.
>
> 	-- Dan

May be I should have been more specific, yes I have
setup the PC15 pin to have correct direction.

I have checked and rechecked the IDMA buffer
descriptors and they look "okay".

I have another question may be this is something
related.

I am working with chip whos configuration memory is
accessible and that memory is mapped to chip select 2
( BR2 ).

WHat I have seen is my kernel functions cause panic if
I use first version of GetChipAddress but second
version works?

I mean if I do something like
 *(unsigned long *)(GetChipAddress() + 0x02 ) =
0xABCD;

first version causes panic, second version doesn't.

/* version1 of  GetChipAddress this BREAKS why? */

GetChipAddress()
{

PDA *ppda = (PDA *)(GetIMMR() & IO_MAP_MASK);

return(ppda->memc_br2 & 0xFFFF8000);
}

/* version2 of GetChipAddress this WORKS why? */
unsigned long driver_fifobase;
GetChipAddress()
{
PDA *ppda = (PDA *)(GetIMMR() & IO_MAP_MASK);


if ( driver_fifobase == 0 )
       driver_fifobase =
    (unsigned long)ioremap_nocache( ( ppda->memc_br2
		& 0xffff0000),0x4000 );

return driver_fifobase;

}

Thanks.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
