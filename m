Return-Path: <pppeterpppan@gmail.com>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145])
	by ozlabs.org (Postfix) with ESMTP id 08D98B7D07
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Apr 2010 11:56:22 +1100 (EST)
Received: by qw-out-1920.google.com with SMTP id 4so220820qwk.50
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Mar 2010 17:56:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4BB36EB1.6010105@freescale.com>
References: <48abf2c21003301846h67106ce6h8d51ad167374793f@mail.gmail.com>
	<4BB36EB1.6010105@freescale.com>
Date: Thu, 1 Apr 2010 08:56:19 +0800
Message-ID: <z2l48abf2c21003311756y80262019yc8c1cc4d2cc61b5f@mail.gmail.com>
Subject: Re: I can not get my MII working on MPC8247 with Linux 2.6.32.6
From: Peter Pan <pppeterpppan@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yes, the PHY address is correct, I've checked the schematics, and
2.6.22 is also using this PHY address.
The different between 2.6.22 and 2.6.32.6 is that:
In 2.6.22, we use arch/ppc/8260_io/fcc_enet.c as the driver. IMMR
address 0xf0000000 is directly used.
In 2.6.32.6, cpm2-fcc-enet driver is used. In that driver, the
register address is ioremaped and used. The others are the same.
I've tried to use the dir and data register address directly in
mii-bitbang.c, but that leads to kernel oops.
I've wrote a low level gpio driver for our processor MPC8247, and I
used that for our external hardware watchdog, it works fine. Then I
use the low level driver in the mii-bitbang.c, it still works
incorrect, all I get from MDIO is 1.
I'm really confused.


2010/3/31 Scott Wood <scottwood@freescale.com>:
> Peter Pan wrote:
>>
>> Recently, I'm porting Linux 2.6.32.6 to our customized MPC8247 based
>> board. Everything is fine out except my ethernets. I uses
>> cpm2-scc-enet and cpm2-fcc-enet drivers.
>> My ethernet works fine in U-Boot with the same setting, and our
>> previous Linux 2.6.22 is also working, so there should be nothing
>> wrong with the hardware.
>> The boot log of the MII part is:
>>
>> CPM2 Bitbanged MII: probed
>> mdio_bus f0010d00: error probing PHY at address 0
>> mdio_bus f0010d00: error probing PHY at address 1
>
> Are 0 and 1 the addresses you're expecting the PHYs to be at?
>
> If that's not it, I'd try to examine the specific register accesses that
> 2.6.22 is doing and see what's different.
>
> -Scott
>
