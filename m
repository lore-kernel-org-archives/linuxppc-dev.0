Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id 7B960B7BC6
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Oct 2009 06:59:41 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 27 Oct 2009 13:59:31 -0600
Subject: Accessing flash directly from User Space
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I know this is probably a really dumb question, but a wise man once said th=
at the only stupid question is the one that is not asked.

So, I have written a flash driver in VxWorks that simply addresses the flas=
h directly and handles all the hardware accesses just fine.  I am porting t=
hat to Linux and need it to run in user space (mainly to simplify the inter=
face with the user - I want to keep it the same as in VxWorks).  Here is a =
snippet of what my question is:

static uint8_t bflashEraseSector(int sa, int verbose)
{
	uint16_t * flash =3D (uint16_t *) NOR_FLASH_BASE_ADRS;
	uint32_t offset;

	...

	/* We divide by 2 here to adjust for the 16-bit offset into the address */
	offset =3D sa * NOR_FLASH_SECTOR_SIZE / 2;
	flash[BFLASH_SECTOR_ERASE_ADDR1] =3D BFLASH_SECTOR_ERASE_BYTE1;

	...

}

I am trying to get a pointer to NOR_FLASH_BASE_ADRS which is defined to be =
0xFC000000.  I then dereference that directly to write to the flash.

How can I get that pointer?  Unfortunately I cannot simply use the address =
of the flash.  Is there some magical function call that gives me access to =
that portion of the memory space?

Thanks for the help!

Jonathan

PS - I know that I could simply use the MTD driver provided by the kernel, =
but I need to be able to keep the interface the same so we can use previous=
ly written code.
