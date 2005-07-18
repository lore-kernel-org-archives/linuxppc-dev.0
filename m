Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id 2B2BC67C51
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Jul 2005 01:44:33 +1000 (EST)
Message-ID: <42DBCE60.8090300@anagramm.de>
Date: Mon, 18 Jul 2005 17:44:32 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Fillod Stephane <stephane.fillod@thomson.net>
References: <1CFEB358338412458B21FAA0D78FE86D02CABBE4@rennsmail02.eu.thmulti.com>
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D02CABBE4@rennsmail02.eu.thmulti.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8540 DMA routines (channel 0 broken?)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, Stephane!

>>In the meanwhile, I got channel 0 working. It seems
>>that the DMA#0 machine got stuck in some configuration from any
>>previous (u-boot?) operation which didn't clean up things
>>properly. I had to explicitly abort a (continously running?)
>>transfer to be able to re-program it in the way I need.
> 
> Are you using a BDI2000? 

Nope.

> Some init mode uses the DMA#0 for memory zeroing (see your .cfg file).
> Also the DDR ECC U-boot code may use the DMA#0.
> Isn't it possible to reset the DMA#0 from Linux?

Thank you! Yes, that's true! <ACK>

I've checked the U-Boot code, today. The problem comes up when
U-Boot is built with CONFIG_DDR_ECC.
The DMA #0 is used to initialize the DDR prior enabling ECC.
Maybe the DMA doesn't get cleaned up properly.
(I'll have to re-check the registers).

But I can get my mpc85xx_dma "driver" working now.
However I cannot disable ECC when I am in Linux for testing
yet. :-]
I'll need to customize U-Boot without ECC because I don't want
to use it due to performance issues anyway.
But that's getting OT here.

Greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
