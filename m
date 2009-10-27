Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id D3493B7BC2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Oct 2009 09:52:47 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: Scott Wood <scottwood@freescale.com>
Date: Tue, 27 Oct 2009 16:52:40 -0600
Subject: RE: Accessing flash directly from User Space
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F0330D368E3@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>
	<4AE7545F.80805@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D366B6@midas.usurf.usu.edu>
	<4AE75859.5050108@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D3688B@midas.usurf.usu.edu>
	<4AE774ED.8050502@freescale.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D368AA@midas.usurf.usu.edu>
	<4AE7775D.8080502@freescale.com>
In-Reply-To: <4AE7775D.8080502@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Bill Gatliff <bgat@billgatliff.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Jonathan Haws wrote:
> >>> 	flash[0] =3D 0x1234;
> >>> 	msync(flash, NOR_FLASH_SIZE, MS_SYNC | MS_INVALIDATE);
> >>> 	printf("flash[0] =3D %#04x\n", flash[0]);
> >>>
> >>> That prints flash[0] =3D 0x7f45.  I have verified that I am
> reading
> >> the correct values.  I can display the flash contents in U-Boot
> and
> >> 7f45 is what is in the first 16 bits of flash.
> >>> Why can I not write to flash?  What am I doing wrong?
> >> Flash does not work that way -- you must send it commands to
> erase a
> >> block, and then further commands to program new data.
> >
> > I realize that.  I have a driver written that does exactly that.
> > However, I need to be able to write to certain registers to setup
> the
> > erasure.
>=20
> Will the device respond to 0x1234 being written at offset zero?  You
> generally have to poke these things pretty specifically in order to
> get
> them to go into command mode.
>=20

It should because that is the first data location in flash.  Also, just to =
be sure I am telling the truth, I tried writing to one of the registers to =
setup an erase and got the same results - the value did not get written.

> > The driver works perfectly in VxWorks,
>=20
> Including the 0x1234 thing?

Actually, I have not tried that - I have not had to since the driver worked=
.

> >> It sounds like what you really want is the /dev/mtd or
> /dev/mtdblock
> >> interface, not raw access to the flash chip.
> >
> > As mentioned in my initial post, I need to use my custom driver to
> maintain the interface to the application that uses the flash for
> data storage.
> >
> > I had thought about using MTD, but decided against it because with
> > previous benchmarking that we did with MTD and our custom driver,
> we
> > found that our custom driver was about 10x faster.
>=20
> Ouch.  Any idea where the slowdown is coming from?

>From what I remember (I would have to dig up notes to make sure) it is some=
thing to do with MTD looking for a signal to go high that is processed a bu=
nch before MTD even sees it.  Our flash produces a hardware ready signal th=
at we are triggering off of to move on.  MTD took much longer to report to =
us that the hardware was ready.

Thanks
