Message-ID: <000701c206d8$14338ae0$1a11efcb@industrialDiv.hanasys.co.kr>
Reply-To: "Sangmoon Kim" <dogoil@etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: "David Gibson" <david@gibson.dropbear.id.au>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <022501c20633$cbeb4f10$1a11efcb@industrialDiv.hanasys.co.kr> <20020528062351.A2267@home.com> <002b01c206cd$59f7a760$1a11efcb@industrialDiv.hanasys.co.kr> <20020529054737.GE16537@zax>
Subject: Re: map iomem in linux_2_4_dev
Date: Wed, 29 May 2002 15:14:24 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


OK,
I understand.
Thank you.

----- Original Message -----
From: "David Gibson" <david@gibson.dropbear.id.au>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, May 29, 2002 2:47 PM
Subject: Re: map iomem in linux_2_4_dev


>
> On Wed, May 29, 2002 at 01:57:34PM +0900, Sangmoon Kim wrote:
> >
> > Hi,
> > >
> > > You don't need io_block_mapping.  Follow one of the many examples to
> > > use early_serial_init with an ioremap call for your UART.
> > >
> > > The only reason your method works is that the io_block_mapping is
> > > actually using a BAT on our classic PPC platform.  ioremap will
> > > look for an existent BAT mapping and just return the translated
> > > virtual address in this case.  Relying on this is bad practice
> > > since it will not work on other PPC systems.
> > >
> > Right, I exactly wanted to do that.
> > I called io_block_mapping() on initialization code.
> > More precisly on <board name>_map_io(),
> > which is in arch/ppc/platforms/<board_name>_setup().
> > It has nothing to do with competibility.
> > And... Is there any ppc without BAT?
> > I didn't know that.
>
> Yes there are PPCs without BATs.  e.g. 4xx.
>
> > > As David correctly pointed out, only use io_block_mapping when
> > > you absolutely must control the placement of the virtual address.
> > Than, if the system initialization code is changed,
> > the driver code should be changed too.
>
> That's exactly why ioremap() is preferred - then the initialization
> code doesn't need to touch it at all.
>
> > > There are cases when this is necessary since the hardware engineers
> > > always send us garbage to support.  Mapping a UART at init time is
> > > not one of these.
> > >
> > Actually, I'm a hardware guy.
> > In most cases, mapping UART is not needed,
> > but on the hardware I designed, it is needed.
> > Because its physical addres is 0x78000000.
> > Don't blame us too much.
> > It takes much money to change hardware.
>
> Rubbish.  Having a *physical* address of 0x78000000 is no problem at
> all, ioremap() will map that (like any other physical address) into a
> sensible virtual address.
>
> --
> David Gibson | For every complex problem there is a
> david@gibson.dropbear.id.au | solution which is simple, neat and
> | wrong.  -- H.L. Mencken
> http://www.ozlabs.org/people/dgibson
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
