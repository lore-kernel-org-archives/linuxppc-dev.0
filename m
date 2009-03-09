Return-Path: <leon.woestenberg@gmail.com>
Received: from mail-fx0-f161.google.com (mail-fx0-f161.google.com
	[209.85.220.161]) by ozlabs.org (Postfix) with ESMTP id 46EDDDE034
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 01:50:55 +1100 (EST)
Received: by fxm5 with SMTP id 5so1132913fxm.9
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Mar 2009 07:50:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200812012046.22247.sr@denx.de>
References: <c384c5ea0811280450t3e199da6s1fcdf903f63f9622@mail.gmail.com>
	<1228119152.7356.118.camel@pasglop>
	<c384c5ea0812011119o97adf68l1546c96d5a6696a8@mail.gmail.com>
	<200812012046.22247.sr@denx.de>
Date: Mon, 9 Mar 2009 15:23:40 +0100
Message-ID: <c384c5ea0903090723m2589ebc6scb1280a29ee7c7e0@mail.gmail.com>
Subject: Re: [U-Boot] ppc4xx: u-boot sees PCIe endpoint, linux does not.
From: Leon Woestenberg <leon.woestenberg@gmail.com>
To: Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC <linuxppc-dev@ozlabs.org>, u-boot@lists.denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Stefan,

On Mon, Dec 1, 2008 at 8:46 PM, Stefan Roese <sr@denx.de> wrote:
> On Monday 01 December 2008, Leon Woestenberg wrote:
>> >> Now, if I re-program the end-point FPGA during the u-boot boot
>> >> time-out, Linux will recognize the end-point.
>> >
>> > It's possible that either the reset in between goes bonkers or something
>> > else causes your FPGA to stop responding. It looks like a programming
>> > problem with the FPGA to me.
>>
>> I have verified that the end point does not receive any kind of reset.
>>
>> Also, this problem only happens on the Canyonlands board; on x86 and
>> powerpc MPC8315E it remains properly working after soft/hard resets,
>> u-boot init etc.
>
> This could be because only the 4xx Linux PCI(e) driver really resets the
> endpoint (PHY reset). But you seem to have analyzed this already.
>

Some progress:

Using au-boot  GIT checkout of 9-2-2009 (one month old) I now have
different behaviour:
u-boot does report a link, but no longer the PCIe vendor id:

CPU:   AMCC PowerPC 460EX Rev. A at 800 MHz (PLB=200, OPB=100, EBC=100 MHz)
       Security/Kasumi support
       Bootstrap Option H - Boot ROM Location I2C (Addr 0x52)
       Internal PCI arbiter disabled
       32 kB I-Cache 32 kB D-Cache
Board: Canyonlands - AMCC PPC460EX Evaluation Board, 2*PCIe, Rev. 16
I2C:   ready
DTT:   1 is 44 C
DRAM:  512 MB (ECC not enabled, 400 MHz, CL3)
FLASH: 64 MB
NAND:  128 MiB
PCI:   Bus Dev VenId DevId Class Int
PCIE0: link is not up.
PCIE0: initialization as root-complex failed
PCIE1: successfully set as root-complex

Linux now correctly recognizes the device.
The FPGA with PCIe end point now also survives both a hard reset
(reset button) and soft reset (shutdown -r now in Linux).

Regards,
-- 
Leon
