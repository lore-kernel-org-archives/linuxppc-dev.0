Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A6E84B6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Apr 2012 06:37:00 +1000 (EST)
Subject: Re: pci node question
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4F91B335.4010501@freescale.com>
Date: Fri, 20 Apr 2012 15:37:05 -0500
Message-Id: <EDA55B32-FD14-4B5C-90AF-7FC5F77898E0@kernel.crashing.org>
References: <9F6FE96B71CF29479FF1CDC8046E1503346013@039-SN1MPN1-002.039d.mgd.msft.net>
 <D04C6167-5286-4675-A6D8-32BA63305424@kernel.crashing.org>
 <4F91B335.4010501@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 20, 2012, at 2:04 PM, Scott Wood wrote:

> On 04/20/2012 01:53 PM, Kumar Gala wrote:
>>=20
>> On Apr 20, 2012, at 1:37 PM, Yoder Stuart-B08248 wrote:
>>=20
>>> There was refactoring change a while back that moved=20
>>> the interrupt map down into the virtual pci bridge.
>>>=20
>>> example:=20
>>> 42 /* controller at 0x200000 */
>>> 43 &pci0 {
>>> 44         compatible =3D "fsl,p2041-pcie", "fsl,qoriq-pcie-v2.2";
>>> 45         device_type =3D "pci";
>>> 46         #size-cells =3D <2>;
>>> 47         #address-cells =3D <3>;
>>> 48         bus-range =3D <0x0 0xff>;
>>> 49         clock-frequency =3D <33333333>;
>>> 50         interrupts =3D <16 2 1 15>;
>>> 51         pcie@0 {
>>> 52                 reg =3D <0 0 0 0 0>;
>>> 53                 #interrupt-cells =3D <1>;
>>> 54                 #size-cells =3D <2>;
>>> 55                 #address-cells =3D <3>;
>>> 56                 device_type =3D "pci";
>>> 57                 interrupts =3D <16 2 1 15>;
>>> 58                 interrupt-map-mask =3D <0xf800 0 0 7>;
>>> 59                 interrupt-map =3D <
>>> 60                         /* IDSEL 0x0 */
>>> 61                         0000 0 0 1 &mpic 40 1 0 0
>>> 62                         0000 0 0 2 &mpic 1 1 0 0
>>> 63                         0000 0 0 3 &mpic 2 1 0 0
>>> 64                         0000 0 0 4 &mpic 3 1 0 0
>>> 65                         >;
>>> 66         };
>>> 67 };
>>>=20
>>> Why was the interrupt-map moved here?
>>=20
>> Its been a while, but I think i moved it down because of which node =
is used for interrupt handling in linux.
>=20
> That's not supposed to be how device tree bindings are determined.
>=20
> It's causing us problems with virtualization device assignment, =
because
> if we just assign the parent bus we don't get the interrupt map, but =
if
> we assign the child we need to deal with what it means to assign an
> individual PCI device (e.g. on our internal KVM stuff we get an error =
on
> that reg property).
>=20
> What does this node represent in the first place?  Is there really a
> PCI-to-PCI bridge?  Are all other PCI devices underneath it?

PCIe has this concept of a "virtual" bridge between the root-comples, so =
that is what the node represents.  Its always been a bit confusing to me =
as its not 100% standardized by PCI sig.

Maybe Ben's got some comments to add here from a generic PCIe point of =
view.

>>> Do we really need the error interrupt specified twice?
>>=20
>> I put it twice because it has multiple purposes, one has to do with =
interrupts defined by the PCI spec vs ones defined via FSL controller.
>=20
> There are PCI-defined error conditions that cause a host controller
> interrupt.  What does this have to do with the bridge node?

Think of the "error" IRQ as shared between to classes of interrupts.  =
One set are controller errors defined by FSL, the other are errors =
defined by PCI sig / bus point of view.

I'd expect controller errors to be handled by something like EDAC would =
bind at "fsl,qoriq-pcie-v2.2" level node.  The PCI bus code would looks =
at the virtual bridge down.

>=20
>>> Why is there a zeroed out reg property: reg =3D <0 0 0 0 0> ??
>>=20
>> scratching my head, what happens if you remove it?
>=20
> Sigh.

:)

- k=
