From: Benjamin Herrenschmidt <benjamin.herrenschmidt@wanadoo.fr>
To: Stefan Roese <stefan.roese@esd-electronics.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
Subject: Re: status of linuxppc_2_4_devel for ppc405gp
Date: Wed, 22 Aug 2001 15:41:55 +0200
Message-Id: <20010822134155.4105@mailhost.mipsys.com>
In-Reply-To: <EFEAIMDCOOOHIEPHDNFJAEHDDBAA.stefan.roese@esd-electronics.com>
References: <EFEAIMDCOOOHIEPHDNFJAEHDDBAA.stefan.roese@esd-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>Our system crashes in the function "ppc4xx_gdb_init()" in file
>"ppc4xx_setup.c". Without this call bootup look much better ;-). Any
>comments on this?

The function dereferences the regs of the init.task which no longer
exist. (And was previously not properly initialized anyway).

>I noticed that the ppc405_enet driver is not compiled and not started
>(Makefile and Space.c in drivers/net). Is there a patch missing?

Probably. In my tree, I changed it to use the initcalls.

>Is anybody running this linuxppc_2_4_devel on a walnut board or custom
>ppc405 board? What is the "official status" of the ppc405 support in this
>linux tree?

I have the kernel booting with a custom board but userland doesn't work,
I'm still tracking this.

Ben.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
