Return-Path: <B38951@freescale.com>
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [RFC] powerpc/fsl-pci: Document the "fsl,has-isa" property for
 Freescale PCI
Date: Fri, 6 Apr 2012 03:04:50 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D019DBE90@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1333263396-23932-1-git-send-email-B38951@freescale.com>
 <E3DD739D-1EC3-4BCA-AE26-1EAE7A086A1E@kernel.crashing.org>
In-Reply-To: <E3DD739D-1EC3-4BCA-AE26-1EAE7A086A1E@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "devicetree-discuss@lists.ozlabs.org"
 <devicetree-discuss@lists.ozlabs.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
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
> Sent: Wednesday, April 04, 2012 9:09 PM
> To: Jia Hongtao-B38951
> Cc: linuxppc-dev@lists.ozlabs.org; Li Yang-R58472; devicetree-
> discuss@lists.ozlabs.org
> Subject: Re: [RFC] powerpc/fsl-pci: Document the "fsl,has-isa" property
> for Freescale PCI
>=20
>=20
> On Apr 1, 2012, at 1:56 AM, Jia Hongtao wrote:
>=20
> > If PCI is primary bus we should set isa_io/mem_base when parsing PCI
> bridge
> > resources from device tree. The previous way to check the primary bus
> based
> > on a hard-coded address named primary_phb_addr. Now we add a property
> named
> > "fsl,has-isa" into device tree. In kernel we use this property to find
> out
> > the bus is primary or not. This way is more flexible.
> >
> > Signed-off-by: Jia Hongtao <B38951@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> > .../devicetree/bindings/powerpc/fsl/pci.txt        |   36
> ++++++++++++++++++++
> > 1 files changed, 36 insertions(+), 0 deletions(-)
> > create mode 100644
> Documentation/devicetree/bindings/powerpc/fsl/pci.txt
>=20
> This isn't freescale specific, its linux specific.  If anything the
> property should be linux,has-isa.
>=20
> But in general I dont think this is a good idea.  In truth one could
> search the device tree for:
>=20
> 	device_type =3D "isa";
>=20
> to try and set this dynamically.
>=20
> - k
>=20

Yes, it's not Freescale specific, but it's only used by Freescale now in
the kernel. This is why I named the property as "fsl,has-isa".

To indicate PCI bus is primary we have three ways to go and we now like
the 2nd solution:

1. As this patch said, we add a property to device tree manually.

2. Set this property dynamically in uboot when scanning PCI bridge.
Actually we have already done this. The problem is users should update
uboot and kernel together or it's not work. To support old uboot we decide
to add this property into device tree too temporarily. We will remove it
from device tree at an appropriate future.

3. Just as you said we could search the device tree by device_type =3D "isa=
".
   There are two problems here:
	* There is no OF API for searching just in PCI node now. That means
	  we can't easily find whether there is "isa" bridge or not under
	  this PCI controller while scanning it.
	* Boards MPC8541CDS and MPC8555CDS has no "isa" node in device tree
	  but has ISA bridge under PCI controller.

- Jia Hongtao
