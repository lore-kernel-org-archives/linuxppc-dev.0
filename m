Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CDDAF67B64
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 02:46:40 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G3FBN-00083z-R7
	for linuxppc-embedded@ozlabs.org; Wed, 19 Jul 2006 18:45:57 +0200
Received: from rusfw02.rohde-schwarz.com ([80.246.32.40])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 19 Jul 2006 18:45:57 +0200
Received: from euphoria by rusfw02.rohde-schwarz.com with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 19 Jul 2006 18:45:57 +0200
To: linuxppc-embedded@ozlabs.org
From: Florian Boelstler <euphoria@arcor.de>
Subject: Re: MPC8548 PCIe / PCI support with BSP MPC8548CDS 02/24/2006
Date: Wed, 19 Jul 2006 18:45:03 +0200
Message-ID: <e9lnie$voo$1@sea.gmane.org>
References: <3140C9D90FB6D911ABD7000F206DC92603D6E0FC@zhk08exm40.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <3140C9D90FB6D911ABD7000F206DC92603D6E0FC@zhk08exm40.ap.freescale.net>
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Jeffrey,

 > I have done the PCI config cycle under u-boot. This is very simple 
and > able to find the PEX EP attached to the MPC8548.
 > In this log, it is reading a pair of MPC8548E connected together 
using > PEX.
 > Please see the log below:
[ ... ]

thanks for sharing this piece of information.
I will investigate if this matches the way it is done in the kernel.

Thanks,

   Florian

Ho Jeffrey-r26191 schrieb:
> Hi Florian,
> 
> 
> U-Boot 1.1.4 (Apr 12 2006 - 11:40:53)
> 
> CPU:   8548_E, Version: 1.1, (0x80390011)
> Core:  e500v2, Version: 1.0, (0x80210010)
> Clock Configuration:
>        CPU:1333 MHz, CCB: 533 MHz,
>        DDR: 266 MHz, LBC:  33 MHz
> L1:    D-cache 32 kB enabled
>        I-cache 32 kB enabled
> 
> Board: MPC85xx Processor Card Rev. A.
>        -- Boot Flash is U30
> 
> SRIO:  X4 2.5Gbps
> PEX :  X4 2.5Gbps
> PCI1:  32 bit, async
> PCI2:  disabled
> I2C:   ready
> DRAM:  Initializing
> DDR:   256 MB
> FLASH: 16 MB
> L2 cache 512KB: enabled
> In:    serial
> Out:   serial
> Err:   serial
> Net:   eTSEC0: PHY is Marvell 88E1111S (1410cc1)
> eTSEC1: PHY is Realtek RTL821x (1cc912)
> eTSEC2: PHY is Marvell 88E1111S (1410cc1)
> eTSEC3: PHY id ffffffff is not supported!
> eTSEC0, eTSEC1, eTSEC2 [PRIME], eTSEC3
> eTSEC0 & eTSEC1 in Reduce mode
> eTSEC2 & eTSEC3 in Reduce mode
> Hit any key to stop autoboot:  0
> MPC8548E_Rev1.1=> mm e000a000      	<-setup command register
> e000a000: 8000f800 ? 80000004		   Bus master, SERR, Memory space
> e000a004: 02001000 ? 06011000
> e000a008: 00000000 ? .
> MPC8548E_Rev1.1=> mm e000a000	<-Set secondary bus num = 1	
> e000a000: 80000004 ? 80000018		  Subordinate bus num = 3
> e000a004: 00000000 ? 00010300
> e000a008: 00000000 ? .
> MPC8548E_Rev1.1=> mm e000a000	<-Check PEX agent ID
> e000a000: 80000018 ? 80010000
> e000a004: 57191200 ? .
> MPC8548E_Rev1.1=> mm e000a000	<-Set PEX agent BAR0 (PEXCSRBAR) 
> e000a000: 80010010 ? 80010010		  PEXCSRBAR = 0x80000000
> e000a004: 00000000 ? 00000080		  This is the PCI address space
> e000a008: 00000000 ? .
> MPC8548E_Rev1.1=> mm e000a000	<-Set PEX agent command register
> e000a000: 80010014 ? 80010004		   Bus master, SERR, Memory space
> e000a004: 00001000 ? 06011000
> e000a008: 00000000 ? .
> MPC8548E_Rev1.1=> 
> mw e000ac20 00080000;		<-Set TAR = 0x80000000 (PCI address space)
> mw e000ac24 0;				<-Set 32:64bit TAR = 0x0 (PCI address space)
> mw e000ac28 000a0000;		<-Set WBA = 0xa0000000 (ECM, e500 address space) 
> mw e000ac30 8004401A			<-Set normal R/W, enable Outbound window
> MPC8548E_Rev1.1=>
> MPC8548E_Rev1.1=>
> MPC8548E_Rev1.1=> mm e000a000	<-check PEX agent BAR0 if written
> e000a000: 80010010 ?
> e000a004: 00000080 ? .
> MPC8548E_Rev1.1=> md a0000000	<-read PEX agent CCSRBAR address use 0xa0000000
> a0000000: 000ff700 00000000 00000000 00000000    ................
> a0000010: 00000000 00000000 00000000 00000000    ................
> a0000020: 00000000 00000000 00000000 00000000    ................
> a0000030: 00000000 00000000 00000000 00000000    ................
> a0000040: 00000000 00000000 00000000 00000000    ................
> a0000050: 00000000 00000000 00000000 00000000    ................
> a0000060: 00000000 00000000 00000000 00000000    ................
> a0000070: 00000000 00000000 00000000 00000000    ................
> a0000080: 00000000 00000000 00000000 00000000    ................
> a0000090: 00000000 00000000 00000000 00000000    ................
> a00000a0: 00000000 00000000 00000000 00000000    ................
> a00000b0: 00000000 00000000 00000000 00000000    ................
> a00000c0: 00000000 00000000 00000000 00000000    ................
> a00000d0: 00000000 00000000 00000000 00000000    ................
> a00000e0: 00000000 00000000 00000000 00000000    ................
> a00000f0: 00000000 00000000 00000000 00000000    ................ 
> 
> Regards,
> Jeffrey Ho
> Freescale Semiconductor HK Ltd
> Tel: 852-26668050
>  
> 
>> -----Original Message-----
>> From: 
>> linuxppc-embedded-bounces+r26191=freescale.com@ozlabs.org 
>> [mailto:linuxppc-embedded-bounces+r26191=freescale.com@ozlabs.
>> org] On Behalf Of Florian Boelstler
>> Sent: Monday, June 26, 2006 6:48 PM
>> To: linuxppc-embedded@ozlabs.org
>> Subject: MPC8548 PCIe / PCI support with BSP MPC8548CDS 02/24/2006
>>
>> Hi,
>>
>> I am currently working on a MPC8548-based development system.
>> Linux kernel version is 2.6.11 with patches delivered from 
>> Freescale (BSP MPC8548CDS 02/24/2006).
>>
>> Kernel configuration contains a warning message for CONFIG_PEX:
>> "This requires hardware modification to work correctly if 
>> your CPU version < 2.0 and will break the PCI bus. [...]"
>>
>> I was wondering whether enabling PCIe makes PCI bus 
>> functionality unusable at all (including kernel functionality 
>> for detecting devices behind a transparent PCI-to-PCI bridge).
>>
>> Our setup connects a transparent PLX8516 PCI-to-PCI bridge to 
>> the PCIe port of the MPC8548 daughter board. Behind that 
>> bridge is another PCIe capable device.
>> MPC8548 is configured to run as PCIe host mode.
>>
>> When trying to lookup the PCIe devices using lspci I can only 
>> see the PPC itself and the bridge.
>> However I cannot see the device(s) behind the bridge.
>>
>> Is there another method for detecting PCI(e) devices?
>> Is "BSP MPC8548CDS 02/24/2006" the latest version 
>> corresponding to that hardware?
>>
>> Thanks in advance,
>>
>>    Florian
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
