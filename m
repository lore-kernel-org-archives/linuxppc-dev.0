Date: Tue, 8 May 2001 01:40:09 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Eli Chen <eli@routefree.com>
Cc: Dan Malek <dan@mvista.com>, brian.kuschak@skystream.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()
In-Reply-To: <03a001c0d74e$60022c70$4b00000a@foolio1>
Message-ID: <Pine.HPX.4.10.10105080133000.22253-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 7 May 2001, Eli Chen wrote:

> > How can this happen?  The reservation for the lwarx in 1) has
> > long been broken, so this swtcx. will fail.....
> >
> > -- Dan
>
> Because reservation is held per processor in the "Reservation bit", and it
> doesn't seem like the 405GP checks the reservation address.

I don't think any PPC checks the reservation address on stwcx.; the
reservation address is checked on snoops to clear the reservation
bit, but having the reservation bit set is a necessary and
sufficient condition for stwcx. to actually perform the store.

>
> >From the PPC manual:
> "Because the hardware doesn't compare reservation address when executing the
> stwcx. instruction, operating systems software MUST reset the reservation if
> an exception or other types of interrupt occurs to insure atomic memory
> references of lwarx and stwcx. pairs."

Indeed, but as I said this means that you have to clear the reservation on
_return_ from an interrupt in case a dangling reservation is left.
Clearing the reservation on entry is not necessary since the interrupt
handler will never execute a stwcx. without an earlier lwarx.

	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
