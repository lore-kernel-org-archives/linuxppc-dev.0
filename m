Date: Wed, 7 Nov 2001 10:40:57 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dan Malek <dan@mvista.com>, <hollis@austin.ibm.com>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	<davidm@amberdata.demon.co.uk>, <Sven.Dickert@planb.de>
Subject: Re: RFC: i8259.c cleanup
In-Reply-To: <Pine.GSO.4.21.0111071030490.11631-100000@mullein.sonytel.be>
Message-ID: <Pine.LNX.4.33.0111071038460.19315-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 7 Nov 2001, Geert Uytterhoeven wrote:

>
> On Wed, 7 Nov 2001, Dan Malek wrote:
> > hollis@austin.ibm.com wrote:
> > > The following patch (to linuxppc_2_4_devel) does exactly that - it reads from
> > > 0xbffffff0 instead of the 8259 directly.
> >
> > Ummmmm.....this probably works OK on PReP, but I don't think it is going
> > to have the desired effect on other systems using an 8259 :-).  You need
> > to find a way to to make the code you changed unique to PReP.
>
> Note that CHRP already has such a thing (chrp_int_ack_special), to be used with
> OpenPIC (it's passed to openpic_init()).

Indeed, what the 8259.c code might do is use the hardware address and
fall back to polling if the address is NULL. But to avoid run time
checking and minmize icache footprint, the two cases could be considered
as different interrupt controllers.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
