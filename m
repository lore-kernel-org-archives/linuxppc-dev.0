Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx015.isp.belgacom.be (outmx015.isp.belgacom.be
	[195.238.4.87])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7BAE567D1F
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Nov 2006 23:13:13 +1100 (EST)
Received: from outmx015.isp.belgacom.be (localhost [127.0.0.1])
	by outmx015.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kA6CD31u012375
	for <linuxppc-embedded@ozlabs.org>; Mon, 6 Nov 2006 13:13:04 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: Adrian Cox <adrian@humboldt.co.uk>
Subject: Re: Flash programming using a BDI2000 on a MPC8248 CPU
Date: Mon, 6 Nov 2006 13:16:47 +0100
References: <200611060942.05419.laurent.pinchart@tbox.biz>
	<1162811478.16089.8.camel@localhost.localdomain>
In-Reply-To: <1162811478.16089.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200611061316.47705.laurent.pinchart@tbox.biz>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Adrian,

> > [INIT]
> > WREG            MSR             0x00000000
> > WM32            0x00010004      0xffff2081      ; SYPCR
> > WM32            0x00010024      0x00000000      ; BCR
> > WM32            0x00010000      0x82240000      ; SIUMCR
> > WM32            0x00010c80      0x00000001      ; SCCR
> > WM32            0x000119c4      0x00000000      ; RCCR
> > ; Initialize the flash memory controller
> > WM32            0x00010100      0x40001001      ; BR0
> > WM32            0x00010104      0xf8000834      ; OR0
>
> It looks like your workspace is in RAM, but there's nothing in the setup
> above to initialise the memory controller banks for your RAM. Check that
> you can read and write the workspace locations with mm and md from the
> BDI command line.

The workspace is in internal RAM, mapped at address 0x00000000 (the hardware 
reset configuration register is 0x00000000). I tried setting IMMR to 
0xf0000000 and mapping the SDRAM at 0x00000000, without success. The BDI2000 
reports successfull flash programming, but the flash is definitely empty.

BDI>prog 0x40000000 u-boot-1.1.4-ucc32.16-0005 BIN
Programming u-boot-1.1.4-ucc32.16-0005 , please wait ....
Programming flash passed
BDI>md 0x40000000
40000000 : ffffffff ffffffff ffffffff ffffffff  ................
40000010 : ffffffff ffffffff ffffffff ffffffff  ................
40000020 : ffffffff ffffffff ffffffff ffffffff  ................
40000030 : ffffffff ffffffff ffffffff ffffffff  ................
40000040 : ffffffff ffffffff ffffffff ffffffff  ................
40000050 : ffffffff ffffffff ffffffff ffffffff  ................
40000060 : ffffffff ffffffff ffffffff ffffffff  ................
40000070 : ffffffff ffffffff ffffffff ffffffff  ................
40000080 : ffffffff ffffffff ffffffff ffffffff  ................
40000090 : ffffffff ffffffff ffffffff ffffffff  ................
400000a0 : ffffffff ffffffff ffffffff ffffffff  ................
400000b0 : ffffffff ffffffff ffffffff ffffffff  ................
400000c0 : ffffffff ffffffff ffffffff ffffffff  ................
400000d0 : ffffffff ffffffff ffffffff ffffffff  ................
400000e0 : ffffffff ffffffff ffffffff ffffffff  ................
400000f0 : ffffffff ffffffff ffffffff ffffffff  ................

I made sure I can write to the workspace at 0x00008000 using mm and md, using 
both internal RAM (IMMR = 0x00000000) or SDRAM (IMMR = 0xf0000000).

Laurent Pinchart
