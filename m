Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0AF40B7BDD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Oct 2009 09:42:15 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n9RMgCRs000750 for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Oct 2009 15:42:13 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n9RMjgtE005573
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Oct 2009 17:45:43 -0500 (CDT)
Message-ID: <4AE7775D.8080502@freescale.com>
Date: Tue, 27 Oct 2009 17:42:37 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Subject: Re: Accessing flash directly from User Space
References: <BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>	<4AE7545F.80805@billgatliff.com>	<BB99A6BA28709744BF22A68E6D7EB51F0330D366B6@midas.usurf.usu.edu>	<4AE75859.5050108@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D3688B@midas.usurf.usu.edu>
	<4AE774ED.8050502@freescale.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D368AA@midas.usurf.usu.edu>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F0330D368AA@midas.usurf.usu.edu>
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
>>> 	flash[0] = 0x1234;
>>> 	msync(flash, NOR_FLASH_SIZE, MS_SYNC | MS_INVALIDATE);
>>> 	printf("flash[0] = %#04x\n", flash[0]);
>>>
>>> That prints flash[0] = 0x7f45.  I have verified that I am reading
>> the correct values.  I can display the flash contents in U-Boot and
>> 7f45 is what is in the first 16 bits of flash.
>>> Why can I not write to flash?  What am I doing wrong?
>> Flash does not work that way -- you must send it commands to erase a
>> block, and then further commands to program new data.
> 
> I realize that.  I have a driver written that does exactly that.
> However, I need to be able to write to certain registers to setup the
> erasure. 

Will the device respond to 0x1234 being written at offset zero?  You 
generally have to poke these things pretty specifically in order to get 
them to go into command mode.

> The driver works perfectly in VxWorks,

Including the 0x1234 thing?

>> It sounds like what you really want is the /dev/mtd or /dev/mtdblock
>> interface, not raw access to the flash chip.
> 
> As mentioned in my initial post, I need to use my custom driver to maintain the interface to the application that uses the flash for data storage.
> 
> I had thought about using MTD, but decided against it because with
> previous benchmarking that we did with MTD and our custom driver, we
> found that our custom driver was about 10x faster.

Ouch.  Any idea where the slowdown is coming from?

-Scott
