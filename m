Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3FE1FB70A0
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jul 2010 06:25:15 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o61KPCWS006935
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Jul 2010 13:25:12 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o61KZWid010785
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Jul 2010 15:35:32 -0500 (CDT)
Message-ID: <4C2CF9A7.7010801@freescale.com>
Date: Thu, 01 Jul 2010 15:25:11 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Shawn Jin <shawnxjin@gmail.com>
Subject: Re: machine check in kernel for a mpc870 board
References: <AANLkTinA2ghLxBU41aFAsLM1oXQ8HMASx1eQMDVvi56n@mail.gmail.com>	<20100629185617.GA24285@schlenkerla.am.freescale.net>	<AANLkTik48Ht-jeq_U1yh9c9WzFYE8yYpALiz_N8SzF4N@mail.gmail.com>	<4C2B6DF5.7030403@freescale.com>	<AANLkTinYnoqfZAJWlYg633VbVyjWXhvFk2p406eP3o0c@mail.gmail.com>	<AANLkTilZm-TRkjgYBc0xj9iFYUJl7bb19Zvrcj2R-wJd@mail.gmail.com>	<4C2CD395.90409@freescale.com>
	<AANLkTikuI49rzT6j9glIB-Vmp6kZSTVT5ri3Hb-JHgKO@mail.gmail.com>
In-Reply-To: <AANLkTikuI49rzT6j9glIB-Vmp6kZSTVT5ri3Hb-JHgKO@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/01/2010 03:17 PM, Shawn Jin wrote:
>>>> How do I find the address, reg, and range for nodes like localbus,
>>>> soc, eth0, cpm, serial etc.?
>>
>> If your CCSRBAR is 0xfa200000, then pretty much anywhere you see 0xff0xxxxx
>> change it to 0xfa2xxxxx.
>
> I'm not sure about the range settings of 0xfe000000. How do you get this?
>
>         localbus@fa200100 {
>                 compatible = "fsl,mpc885-localbus", "fsl,pq1-localbus",
>                              "simple-bus";
>                 #address-cells =<2>;
>                 #size-cells =<1>;
>                 reg =<0xfa200100 0x40>;
>
>                 ranges =<
>                         0 0 0xfe000000 0x01000000    // I'm not sure about this?
>                 >;
>         };

Change 0xfe000000 to wherever u-boot maps your flash, and 0x01000000 to 
whatever the size of the flash localbus mapping is.

Or more generally update this section to hold whatever is connected to 
the localbus on your board.  The first cell is the chipselect.

>> Make sure that you've got Linux platform code enabled that matches the
>> top-level compatible of your device tree.  Try enabling PPC_EARLY_DEBUG_CPM,
>> making sure to update PPC_EARLY_DEBUG_CPM_ADDR to 0xfa202008.
>
> I enabled this early debug feature but don't know this address change.

The address change is for the different IMMR base, only this use is too 
early/hacky to get it from the device tree.

-Scott
