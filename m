Return-Path: <f.fainelli@gmail.com>
Sender: Florian Fainelli <f.fainelli@gmail.com>
From: Florian Fainelli <florian@openwrt.org>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH 5/5] mv643xx_eth: convert to use the Marvell Orion MDIO
 driver
Date: Tue, 29 Jan 2013 21:41:03 +0100
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
 <1359473048-26551-6-git-send-email-florian@openwrt.org>
 <20130129181306.GF25646@obsidianresearch.com>
In-Reply-To: <20130129181306.GF25646@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201301292141.03931.florian@openwrt.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>, Russell King <linux@arm.linux.org.uk>,
 Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paul Mackerras <paulus@samba.org>, Lennert Buytenhek <buytenh@wantstofly.org>,
 Rob Landley <rob@landley.net>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le mardi 29 janvier 2013 19:13:06, Jason Gunthorpe a =E9crit :
> On Tue, Jan 29, 2013 at 04:24:08PM +0100, Florian Fainelli wrote:
> > This patch converts the Marvell MV643XX ethernet driver to use the
> > Marvell Orion MDIO driver. As a result, PowerPC and ARM platforms
> > registering the Marvell MV643XX ethernet driver are also updated to
> > register a Marvell Orion MDIO driver. This driver voluntarily overlaps
> > with the Marvell Ethernet shared registers because it will use a subset
> > of this shared register (shared_base + 0x4 - shared_base + 0x84). The
> > Ethernet driver is also updated to look up for a PHY device using the
> > Orion MDIO bus driver.
>=20
> Can you finish off this job by making the mv643xx_eth driver accept
> the standard phy-handle OF property instead of using a phy address?

I can certainly do that, at the same time we need to continue supporting th=
e=20
"old" platform device style registration without breaking them (PowerPC in=
=20
particular, and the hopefully yet to be converted orion5x). So the phy_scan=
()=20
as I modified it will probably still be there.

>=20
> Ie the end result should be something like:
>=20
>                 smi0: mdio@72000 {
>                         device_type =3D "mdio";
>                         compatible =3D "marvell,orion-mdio";
>                         reg =3D <0x72004 0x4>;
>=20
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>                         PHY1: ethernet-phy@1 {
>                                 reg =3D <1>;
>                                 device_type =3D "ethernet-phy";
>                                 phy-id =3D <0x01410e90>;
>                         };
>                 };
>=20
>                 egiga0 {
>                         device_type =3D "network";
>                         compatible =3D "marvell,mv643xx-eth";
>                         reg =3D <0x72000 0x4000>;
>                         port_number =3D <0>;
>                         phy-handle =3D <&PHY1>;
>                         interrupts =3D <11>;
>                         local-mac-address =3D [000000000002];  /* Filled =
by
> boot loader */ };
>=20
> Regards,
> Jason

=2D-=20
=46lorian
