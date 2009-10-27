Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id 34ABDB7BD0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Oct 2009 09:35:41 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: Scott Wood <scottwood@freescale.com>
Date: Tue, 27 Oct 2009 16:35:33 -0600
Subject: RE: Accessing flash directly from User Space
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F0330D368AA@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>
	<4AE7545F.80805@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D366B6@midas.usurf.usu.edu>
	<4AE75859.5050108@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D3688B@midas.usurf.usu.edu>
	<4AE774ED.8050502@freescale.com>
In-Reply-To: <4AE774ED.8050502@freescale.com>
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

> > Okay, I now have access to the flash memory, however when I write
> to it the writes do not take.  I have tried calling msync() on the
> mapping to no avail.  I have opened the fd with O_SYNC, but cannot
> get things to work right.
> >
> > Here are the calls:
> >
> > 	int fd =3D open("/dev/mem", O_SYNC | O_RDWR);
> > 	uint16_t * flash =3D (uint16_t *)mmap(NULL, NOR_FLASH_SIZE,
> > 			(PROT_READ | PROT_WRITE), MAP_PRIVATE, fd,
> > 			NOR_FLASH_BASE_ADRS);
> >
> > When I do flash[0] =3D 0x1234, and then check the value, they do not
> match.
> >
> > 	flash[0] =3D 0x1234;
> > 	msync(flash, NOR_FLASH_SIZE, MS_SYNC | MS_INVALIDATE);
> > 	printf("flash[0] =3D %#04x\n", flash[0]);
> >
> > That prints flash[0] =3D 0x7f45.  I have verified that I am reading
> the correct values.  I can display the flash contents in U-Boot and
> 7f45 is what is in the first 16 bits of flash.
> >
> > Why can I not write to flash?  What am I doing wrong?
>=20
> Flash does not work that way -- you must send it commands to erase a
> block, and then further commands to program new data.

I realize that.  I have a driver written that does exactly that.  However, =
I need to be able to write to certain registers to setup the erasure.  The =
driver works perfectly in VxWorks, now I am porting it to Linux.

> It sounds like what you really want is the /dev/mtd or /dev/mtdblock
> interface, not raw access to the flash chip.

As mentioned in my initial post, I need to use my custom driver to maintain=
 the interface to the application that uses the flash for data storage.

I had thought about using MTD, but decided against it because with previous=
 benchmarking that we did with MTD and our custom driver, we found that our=
 custom driver was about 10x faster.
