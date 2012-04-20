Return-Path: <B08248@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 928F2B6FBB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Apr 2012 05:51:14 +1000 (EST)
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: pci node question
Date: Fri, 20 Apr 2012 19:50:53 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E1503346073@039-SN1MPN1-002.039d.mgd.msft.net>
References: <9F6FE96B71CF29479FF1CDC8046E1503346013@039-SN1MPN1-002.039d.mgd.msft.net>
 <D04C6167-5286-4675-A6D8-32BA63305424@kernel.crashing.org>
In-Reply-To: <D04C6167-5286-4675-A6D8-32BA63305424@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Friday, April 20, 2012 1:54 PM
> To: Yoder Stuart-B08248
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: Re: pci node question
>=20
>=20
> On Apr 20, 2012, at 1:37 PM, Yoder Stuart-B08248 wrote:
>=20
> > There was refactoring change a while back that moved
> > the interrupt map down into the virtual pci bridge.
> >
> > example:
> > 42 /* controller at 0x200000 */
> > 43 &pci0 {
> > 44         compatible =3D "fsl,p2041-pcie", "fsl,qoriq-pcie-v2.2";
> > 45         device_type =3D "pci";
> > 46         #size-cells =3D <2>;
> > 47         #address-cells =3D <3>;
> > 48         bus-range =3D <0x0 0xff>;
> > 49         clock-frequency =3D <33333333>;
> > 50         interrupts =3D <16 2 1 15>;
> > 51         pcie@0 {
> > 52                 reg =3D <0 0 0 0 0>;
> > 53                 #interrupt-cells =3D <1>;
> > 54                 #size-cells =3D <2>;
> > 55                 #address-cells =3D <3>;
> > 56                 device_type =3D "pci";
> > 57                 interrupts =3D <16 2 1 15>;
> > 58                 interrupt-map-mask =3D <0xf800 0 0 7>;
> > 59                 interrupt-map =3D <
> > 60                         /* IDSEL 0x0 */
> > 61                         0000 0 0 1 &mpic 40 1 0 0
> > 62                         0000 0 0 2 &mpic 1 1 0 0
> > 63                         0000 0 0 3 &mpic 2 1 0 0
> > 64                         0000 0 0 4 &mpic 3 1 0 0
> > 65                         >;
> > 66         };
> > 67 };
> >
> > Why was the interrupt-map moved here?
>=20
> Its been a while, but I think i moved it down because of which node is us=
ed for interrupt handling in
> linux.
>=20
> > Do we really need the error interrupt specified twice?
>=20
> I put it twice because it has multiple purposes, one has to do with inter=
rupts defined by the PCI spec
> vs ones defined via FSL controller.
>=20
> > Why is there a zeroed out reg property: reg =3D <0 0 0 0 0> ??
>=20
> scratching my head, what happens if you remove it?

Tried removing the zeroed reg, and get this error when bringing
up an e1000 interface:

[root@kvmtst1 root]# ifconfig eth0 192.168.1.20
e1000e 0000:01:00.0: eth0: Unable to allocate interrupt, Error: -22
SIOCSIFFLAGS: Invalid argument

Stuart
