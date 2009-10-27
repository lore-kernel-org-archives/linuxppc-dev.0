Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 253DEB7BC5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Oct 2009 09:31:52 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n9RMVmLq028618 for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Oct 2009 15:31:49 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n9RMZ7GB013412
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Oct 2009 17:35:07 -0500 (CDT)
Message-ID: <4AE774ED.8050502@freescale.com>
Date: Tue, 27 Oct 2009 17:32:13 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Subject: Re: Accessing flash directly from User Space
References: <BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>	<4AE7545F.80805@billgatliff.com>	<BB99A6BA28709744BF22A68E6D7EB51F0330D366B6@midas.usurf.usu.edu>	<4AE75859.5050108@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D3688B@midas.usurf.usu.edu>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F0330D3688B@midas.usurf.usu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Jonathan Haws wrote:
> Okay, I now have access to the flash memory, however when I write to it the writes do not take.  I have tried calling msync() on the mapping to no avail.  I have opened the fd with O_SYNC, but cannot get things to work right.
> 
> Here are the calls:
> 
> 	int fd = open("/dev/mem", O_SYNC | O_RDWR);
> 	uint16_t * flash = (uint16_t *)mmap(NULL, NOR_FLASH_SIZE,
> 			(PROT_READ | PROT_WRITE), MAP_PRIVATE, fd,
> 			NOR_FLASH_BASE_ADRS);
> 
> When I do flash[0] = 0x1234, and then check the value, they do not match.
> 
> 	flash[0] = 0x1234;
> 	msync(flash, NOR_FLASH_SIZE, MS_SYNC | MS_INVALIDATE);
> 	printf("flash[0] = %#04x\n", flash[0]);
> 
> That prints flash[0] = 0x7f45.  I have verified that I am reading the correct values.  I can display the flash contents in U-Boot and 7f45 is what is in the first 16 bits of flash.
> 
> Why can I not write to flash?  What am I doing wrong?

Flash does not work that way -- you must send it commands to erase a 
block, and then further commands to program new data.

It sounds like what you really want is the /dev/mtd or /dev/mtdblock 
interface, not raw access to the flash chip.

-Scott
