Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9D73C2C036D
 for <linuxppc-dev@ozlabs.org>; Sat,  7 Jul 2012 04:09:51 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: use the BRx registers to enable indirect
 mode on the P1022DS
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1341500908-22384-1-git-send-email-timur@freescale.com>
Date: Fri, 6 Jul 2012 13:09:54 -0500
Message-Id: <B246E129-76B2-483B-83A7-C6D218C84E2D@kernel.crashing.org>
References: <1341500908-22384-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 5, 2012, at 10:08 AM, Timur Tabi wrote:

> In order to enable the DIU video controller on the P1022DS, the FPGA =
needs
> to be switched to "indirect mode", where the localbus is disabled and
> the FPGA is accessed via writes to localbus chip select signals CS0 =
and CS1.
>=20
> To obtain the address of CS0 and CS1, the platform driver uses an =
"indirect
> pixis mode" device tree node.  This node assumes that the localbus =
'ranges'
> property is sorted in chip-select order.  That is, reg value 0 maps to
> CS0, reg value 1 maps to CS1, etc.  This is how the 'ranges' property =
is
> supposed to be arranged.
>=20
> Unfortunately, the 'ranges' property is often mis-arranged, and not =
just on
> the P1022DS.  Linux normally does not care, since it does not program =
the
> localbus.  But the indirect-mode code on the P1022DS does care.
>=20
> The "proper" fix is to have U-Boot fix the 'ranges' property, but this =
would
> be too cumbersome.  The names and 'reg' properties of all the localbus
> devices would also need to be updated, and determining which localbus =
device
> maps to which chip select is board-specific.
>=20
> Instead, we determine the CS0/CS1 base addresses the same way that =
U-boot
> does -- by reading the BRx registers directly and mapping them to =
physical
> addresses.  This code is simpler and more reliable, and it does not =
require
> a U-boot or device tree change.
>=20
> Since the indirect pixis device tree node is no longer needed, the =
node is
> deleted from the DTS.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/boot/dts/p1022ds.dtsi     |   16 -----
> arch/powerpc/platforms/85xx/p1022_ds.c |  106 =
++++++++++++++++++++++++++++----
> 2 files changed, 93 insertions(+), 29 deletions(-)

applied to next

- k=
