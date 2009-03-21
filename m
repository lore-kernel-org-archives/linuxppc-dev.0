Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 5674ADDE1B
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2009 11:09:36 +1100 (EST)
Message-ID: <49C42E1F.6030701@denx.de>
Date: Sat, 21 Mar 2009 01:00:31 +0100
From: Anatolij Gustschin <agust@denx.de>
MIME-Version: 1.0
To: Eduard Fuchs <edfuchs@uni-kassel.de>
Subject: Re: Problem with radeonfb on PowerPC 7448&MV64560
References: <200903171630.25340.edfuchs@uni-kassel.de>	<200903191051.37875.edfuchs__31387.3780928136$1237456433$gmane$org@uni-kassel.de>	<m2bprw79i8.fsf@ohwell.denx.de>
	<200903201635.03017.edfuchs@uni-kassel.de>
In-Reply-To: <200903201635.03017.edfuchs@uni-kassel.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Eduard Fuchs wrote:

<snip>
>>> Can I initialize the video card in uboot too?
>> Yes, indeed you can.  In a recent version of U-Boot, search for
>> 'CONFIG_BIOSEMU' in include/configs/*.  We tested this on a sequoia
>> board, so include/configs/sequoia.h should be a good start for this.
> 
> Thanks.
> 
> I tried to include BIOSEMU and RADEON_FB in my u-boot. Bios emulator seems to 
> be properly loaded, but when u-boot attempt to read or write Radeon's 
> registers, the board freezes.

>From the U-Boot output below it seems that the Radeon register access
works already. At least one register read access succeeded before
"videoboot: Booting PCI video card bus 0, function 0, device 7" output.

> What means exactly the value of "VIDEO_IO_OFFSET" in the config file? 

It is the base address of an address range accesses to which are
translated to an I/O access on PCI by the PCI bridge.

> There is a u-boot's output when I init the VIDEO_IO_OFFSET with PCI's I/O base 
> address:
> 
> 
> INFO : PCI0_IO : base - 0xd8000000 size - 1M bytes
> INFO : PCI0_MEM0: base - 0x80000000 size - 1024M bytes
> INFO : PCI0_MEM1: base - 0xc0000000 size - 128M bytes
> INFO : PCI0_MEM2: base - 0xc8000000 size - 128M bytes
> INFO : PCI0_MEM3: base - 0xd0000000 size - 128M bytes
> .....
> PCI Scan: Found Bus 0, Device 7, Function 0
> PCI Scan: Found Bus 0, Device 7, Function 1
> PCI Scan: Found Bus 0, Device 9, Function 0
> PCI Scan: Found Bus 0, Device 10, Function 0
> Video: ATI Radeon video card (1002, 5960) found @(0:7:0)
> videoboot: Booting PCI video card bus 0, function 0, device 7
> E 0000 0 F00P0F000NI00PMS0EG 0F00

Is the address translation for PCI I/O configured by some BAT?

Best regards,
Anatolij
