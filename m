Return-Path: <benh@kernel.crashing.org>
Subject: RE: [PATCH 15/16] Add device tree for Ebony
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A1B8EF@az33exm25.fsl.freescale.net>
References: <20070213060904.GA6214@localhost.localdomain>
	<20070213061026.5837FDDDE9@ozlabs.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>
	<1171470754.4003.101.camel@zod.rchland.ibm.com>
	<6206de08b7f12175bebe669291c66334@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B86F@az33exm25.fsl.freescale.net>
	<9df9bf3adf511f4c1a7945e022fdd447@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B8EF@az33exm25.fsl.freescale.net>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 08:42:40 +1100
Message-Id: <1171489360.20192.184.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> der an "soc" node at the same level.
> > 
> > A "soc" node is meant to contain SoC specific stuff like
> > clock registers or whatnot.  It typically wouldn't have
> > child nodes.
> 
> That's not what booting_without_of.txt says.  It says:
> 
>     The SOC node may contain child nodes for each SOC
>     device that the  platform uses.
> 
> All the dts files in arch/powerpc/boot/dts I've looked at have
> an soc node with a whole bunch of devices under it.

Wel, that was written by FSL not long ago :-)

> The current practice seems to be that an "soc" node contains
> all the on chip devices (regardless of the physical bus internal
> to the soc).

That's the current FSL practice yes. As I said, I'm not too fan of it. I
prefer a more precise representation of the internal bus layout.

> The device_type is typically things like "network" and "serial"
> which don't specify the programming model.   The compatible 
> property is used in driver selection. 

The device type specifies the programming model of the node for OF, that
is the set of words the driver will provide to OF. So that's something
we don't necessarily care much about for non-OF implementation but still
we should avoid going too far from that model either (after all,
somebody can very well want to use a real OF on a board with a SoC).

The device type is also used by the kernel in some areas. For example,
the spec specifies that PCI host controllers and P2P bridges have a
device-type of "pci" and the kernel relies heavily on that. Same for
ISA. It thus makes sense to continue that practice with other bus types.

Ben.
