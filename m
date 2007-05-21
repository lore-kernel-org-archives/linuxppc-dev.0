Return-Path: <Leonid@a-k-a.net>
Received: from mis011-2.exch011.intermedia.net
	(mis011-2.exch011.intermedia.net [64.78.21.129])
	by ozlabs.org (Postfix) with ESMTP id 85F80DDDFA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 May 2007 01:27:50 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: BDI2000 configuration file for MPC8313E-RDB
Date: Mon, 21 May 2007 08:27:48 -0700
Message-ID: <406A31B117F2734987636D6CCC93EE3C018869DE@ehost011-3.exch011.intermedia.net>
In-Reply-To: <29DC34A6B43468409F5A371CFE34E8491768E6@ex01.ads.ubidyne.de>
References: <29DC34A6B43468409F5A371CFE34E8491768E6@ex01.ads.ubidyne.de>
From: "Leonid" <Leonid@a-k-a.net>
To: "Frank Prepelica" <Frank.Prepelica@ubidyne.com>
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

On Monday, May 21, 2007 12:25 AM Frank Prepelica wrote:
> Sorry, but the BDI does not support programming any NAND flash.
> You can write your own driver. Then load the data and the driver into=20
> SDRAM via the BDI and execute it.

> Well, I think I have to try this, if there's really no other way.=20
> I'm not quite sure, maybe you know the PowerTAB Pro JTAG Debugger,
> (it's recommended in the manuals) could this one get directly access
> to NAND memory?

No, I don't but I would like to learn more about NAND flash programmers.

> Uhm, it's possible that achieved that in an "indirect" way that I was
> not aware of. But as I said, the complete flash and ram was empty,
just
> loaded=20
> the corresponding BDI config file to BDI2000 JTAG and I got access to
> flash memory where I placed the bootloader image. Hmm, anyway ;)

> The BDI config: http://www.ultsol.com/config/Emb%20Planet/83xx.cfg

It's still not clear from your description what has been done - "I got
access to flash memory" sounds too vague. It's quite possible that SW
you are using does the trick; at least you have some file, loaded from
the host to RAM:

[HOST]
IP          10.0.0.198
FILE        PCB82xx120.ep

Where did you get this PCB82xx120.ep file from?

In any rate, FLASH section of this configuration file specifies NOR
flash so it's out of question that BDI2000 could program NAND by itself:

[FLASH]
CHIPTYPE    MIRRORX16   ;Flash type: Micron Q-Flash MT28F640J3

Moreover, since workspace is disabled, direct image programming shall be
really slooow - you had to notice that. Did you? Most likely not - SW
burned your flash.


Best regards

Leonid.
