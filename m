Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 80EC7DDF07
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 04:05:07 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3RI5463027934
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 11:05:04 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n3RI53E3012079
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 13:05:03 -0500 (CDT)
Date: Mon, 27 Apr 2009 13:05:03 -0500
From: Scott Wood <scottwood@freescale.com>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH] 83xx: add support for the kmeter1 board.
Message-ID: <20090427180503.GB10292@ld0162-tx32.am.freescale.net>
References: <49F00605.1080605@denx.de>
	<6B76A454-649E-408C-A8DF-AAEEE6011929@kernel.crashing.org>
	<49F544DE.1010307@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49F544DE.1010307@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 27, 2009 at 07:38:38AM +0200, Heiko Schocher wrote:
> 1) add in the soc node an "errata" node and in this "errata" node
>    we can add all CPU specific errata as an example the qe_enet10
>    errata, which above code covers:

What about errata discovered after the device tree is deployed?

>         soc8360@e0000000 {
> 	[...]
>                 errata {
>                         device_type = "errata";

device_type is deprecated except for a couple of legacy uses.  Please do
not add new ones.

>                         compatible = "fsl,mpc83xx_errata";

To be bound to by an "errata driver"? :-P

>                         #address-cells = <1>;
>                         #size-cells = <1>;
> 
>                         qe_enet10@14a8 {
>                                 device_type = "errata";
>                                 compatible = "fsl,mpc83xx_errata_qe_enet10";
>                                 reg = <0x14a8 0x08>;

But that register is part of the "QE parallel I/O port" block (even if it
happens to be undocumented within that block), not part of the "QE ENET10
erratum" block.  The device tree describes the hardware, not what you
want to do with it.

The presence of the erratum itself is indicated by the presence of the
buggy device, possibly in conjunction with SVR if the device tree is not
specific enough.

-Scott
