Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7EA8FB6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Apr 2012 04:53:54 +1000 (EST)
Subject: Re: pci node question
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E1503346013@039-SN1MPN1-002.039d.mgd.msft.net>
Date: Fri, 20 Apr 2012 13:53:57 -0500
Message-Id: <D04C6167-5286-4675-A6D8-32BA63305424@kernel.crashing.org>
References: <9F6FE96B71CF29479FF1CDC8046E1503346013@039-SN1MPN1-002.039d.mgd.msft.net>
To: Yoder Stuart-B08248 <B08248@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 20, 2012, at 1:37 PM, Yoder Stuart-B08248 wrote:

> There was refactoring change a while back that moved=20
> the interrupt map down into the virtual pci bridge.
>=20
> example:=20
> 42 /* controller at 0x200000 */
> 43 &pci0 {
> 44         compatible =3D "fsl,p2041-pcie", "fsl,qoriq-pcie-v2.2";
> 45         device_type =3D "pci";
> 46         #size-cells =3D <2>;
> 47         #address-cells =3D <3>;
> 48         bus-range =3D <0x0 0xff>;
> 49         clock-frequency =3D <33333333>;
> 50         interrupts =3D <16 2 1 15>;
> 51         pcie@0 {
> 52                 reg =3D <0 0 0 0 0>;
> 53                 #interrupt-cells =3D <1>;
> 54                 #size-cells =3D <2>;
> 55                 #address-cells =3D <3>;
> 56                 device_type =3D "pci";
> 57                 interrupts =3D <16 2 1 15>;
> 58                 interrupt-map-mask =3D <0xf800 0 0 7>;
> 59                 interrupt-map =3D <
> 60                         /* IDSEL 0x0 */
> 61                         0000 0 0 1 &mpic 40 1 0 0
> 62                         0000 0 0 2 &mpic 1 1 0 0
> 63                         0000 0 0 3 &mpic 2 1 0 0
> 64                         0000 0 0 4 &mpic 3 1 0 0
> 65                         >;
> 66         };
> 67 };
>=20
> Why was the interrupt-map moved here?

Its been a while, but I think i moved it down because of which node is =
used for interrupt handling in linux.

> Do we really need the error interrupt specified twice?

I put it twice because it has multiple purposes, one has to do with =
interrupts defined by the PCI spec vs ones defined via FSL controller.

> Why is there a zeroed out reg property: reg =3D <0 0 0 0 0> ??

scratching my head, what happens if you remove it?

- k
