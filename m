Return-Path: <benh@kernel.crashing.org>
Subject: RE: [PATCH 15/16] Add device tree for Ebony
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A1BABF@az33exm25.fsl.freescale.net>
References: <20070213060904.GA6214@localhost.localdomain>
	<20070213061026.5837FDDDE9@ozlabs.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>
	<1171470754.4003.101.camel@zod.rchland.ibm.com>
	<6206de08b7f12175bebe669291c66334@kernel.crashing.org>
	<20070214232246.GE16279@localhost.localdomain>
	<fbff2510963c6c5bb9d5ccb0574f97b1@kernel.crashing.org>
	<20070215015316.GL16279@localhost.localdomain>
	<889579906c6fd096a82283d5a3a0227e@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BABF@az33exm25.fsl.freescale.net>
Content-Type: text/plain
Date: Fri, 16 Feb 2007 08:41:08 +1100
Message-Id: <1171575668.5644.42.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Heiko Schick <SCHICKHJ@de.ibm.com>,
	Hartmut Penner <HPENNER@de.ibm.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Is there a DCR binding?  Are the dcr-* properties documented 
> anywhere:
> 
> dcr-reg         // what do these fields mean?
> dcr-parent      // in case there is more than one controller??
> dcr-controller
> dcr-access-method = "native"   // what are the other options?

Yes, we wrote a binding document though I can't find it now. Hartmut or
Heiko, do you have the latest DCR binding document at hand ?

dcr-reg is akin to "reg", it is a list of [dcr numbers, number of dcr]
for a device.

dcr-parent is a phandle to the dcr "controller" or "master" that
generate the DCR cycles

dcr-controller is like "interrupt-controller", it's a property to slap
into any node that is also a dcr-controller. Typically, this can be the
core for a 4xx processor or a separate device for Axon

dcr-access-method can be "native" for 4xx or "mmio" for Axon-type MMIO
mapped DCR bus.

The parent linkage is necessary when using things ike Axon since more
than one Axon can be present in a system, thus more than one MMIO->DCR
"converters" providing each a separate DCR space for controller a
separate set of devices.

Ben
