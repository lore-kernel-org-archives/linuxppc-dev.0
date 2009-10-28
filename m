Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id 051BEB7BE2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Oct 2009 01:39:03 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Date: Wed, 28 Oct 2009 08:38:54 -0600
Subject: RE: Accessing flash directly from User Space
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F0330D36A3D@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>
	<4AE7545F.80805@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D366B6@midas.usurf.usu.edu>
	<4AE75859.5050108@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D3688B@midas.usurf.usu.edu>
	<20091028112430.GO22408@zod.rchland.ibm.com>
In-Reply-To: <20091028112430.GO22408@zod.rchland.ibm.com>
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

> On Tue, Oct 27, 2009 at 04:24:53PM -0600, Jonathan Haws wrote:
> >> >>> How can I get that pointer?  Unfortunately I cannot simply
> use
> >> the
> >> >>>
> >> >> address of the flash.  Is there some magical function call
> that
> >> >> gives me access to that portion of the memory space?
> >> >>
> >> >> $ man 2 mmap
> >> >>
> >> >> You want MAP_SHARED and O_SYNC.
> >> >>
> >> >
> >> >
> >> > To use that I need to have a file descriptor to a device, do I
> >> not?  However, I do not have a base flash driver to give me that
> >> file descriptor.  Am I missing something with that call?
> >> >
> >>
> >> /dev/mem
> >>
> >Okay, I now have access to the flash memory, however when I write
> to it the writes do not take.  I have tried calling msync() on the
> mapping to no avail.  I have opened the fd with O_SYNC, but cannot
> get things to work right.
> >
> >Here are the calls:
> >
> >	int fd =3D open("/dev/mem", O_SYNC | O_RDWR);
> >	uint16_t * flash =3D (uint16_t *)mmap(NULL, NOR_FLASH_SIZE,
> >			(PROT_READ | PROT_WRITE), MAP_PRIVATE, fd,
> >			NOR_FLASH_BASE_ADRS);
>=20
> What board and CPU are you using?  Is your flash really at
> 0xFC800000, or is
> that the virtual address that VxWorks puts it at?

I am using a custom board based on the AMCC Kilauea development board.  It =
uses a 405EX CPU.  Yes, the flash is really at 0xFC000000.
