Return-Path: <B08248@freescale.com>
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Meador Inge <meador_inge@mentor.com>
Subject: RE: [PATCH 1/2] powerpc: document the MPIC device tree binding
Date: Wed, 19 Jan 2011 20:38:51 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E150306BE0A@039-SN1MPN1-004.039d.mgd.msft.net>
References: <4D34E448.8000902@mentor.com>
	<AANLkTi=QX4BfLvPfQDMOgmh90TtX4MQqio6AOZR8JKas@mail.gmail.com>
	<9F6FE96B71CF29479FF1CDC8046E150306A7A2@039-SN1MPN1-004.039d.mgd.msft.net>
	<4D374899.20402@mentor.com>
In-Reply-To: <4D374899.20402@mentor.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "Blanchard, Hollis" <Hollis_Blanchard@mentor.com>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
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
> From: Meador Inge [mailto:meador_inge@mentor.com]
> Sent: Wednesday, January 19, 2011 2:25 PM
> To: Yoder Stuart-B08248
> Cc: linuxppc-dev@lists.ozlabs.org; devicetree-discuss@lists.ozlabs.org;
> Blanchard, Hollis
> Subject: Re: [PATCH 1/2] powerpc: document the MPIC device tree binding
>=20
> On 01/18/2011 02:21 PM, Yoder Stuart-B08248 wrote:
> >>   Documentation/powerpc/dts-bindings/mpic.txt |   78
> >
> > This is really the binding for an open-pic interrupt controller and I
> > think the name should reflect that-- open-pic.txt.
>=20
> Yup, agreed.
>=20
> >> +This binding specifies what properties and child nodes must be
> >> +available on the device tree representation of the "MPIC" interrupt
> >> +controller.  This binding is based on the binding defined for Open
> >> +PIC in [1] and is a superset of that binding.
> >
> > I think it would be better to base this on the ePAPR binding which was
> > based on the original chrp binding.  Properties like "name"
> > and "device_type" are deprecated not being used in flat device trees.
> >
> > <http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pd
> > f>
> >
> > The proposed new properties really should go back into the ePAPR.
>=20
> I read portions of ePAPR while writing this binding and considered that.
>   My only worry was that ePAPR is focused on embedded systems and this
> binding will have to cover non-embedded systems that exist in the kernel.
> However, perhaps that is not a legitimate concern?

The ePAPR tried to codify what was previously implemented in
Linux, so I don't think lack of things like "name" and
"device_type" in the binding are an issue.

> >> +
> >> +** Required properties:
> >> +
> >> +   NOTE: Many of these descriptions were paraphrased from [1] to aid
> >> +         readability.
> >> +
> >> +   - name : Specifies the name of the MPIC.
> >
> > Drop this.  No DTS files use it.
>=20
> Done.
>=20
> >> +   - device_type : Specifies the device type of this MPIC.  The
> >> + value of this
> >> +                   property shall be "open-pic".
> >
> > device_type is deprecated, since this is not real open-firmware.  In
> > practice the kernel is matching on device_type, but we want to move
> > away from that to match on "compatible", just hasn't been implemented
> > yet.
>=20
> I will drop this property with the expectation that the kernel will be
> fixed.  From a quick grep of '.../arch/powerpc' it looks like most uses a=
re
> of the form:
>=20
>      np =3D of_find_node_by_type(NULL, "open-pic");
>      if (np =3D=3D NULL)
>         return;
>=20
> In most of these cases I suppose the 'of_find_node_by_type' calls could
> just be replaced with calls to 'of_find_compatible_node(NULL, "open-pic")=
'.

For backwards compatibility, we should continue to accept
the old/deprecated device_type=3D"open-pic", but in addition
we should accept the compatible=3D"open-pic".

> >> +   - reg : Specifies the base physical address(s) and size(s) of this
> >> + MPIC's
> >> +           addressable register space.
> >> +   - compatible : Specifies the compatibility list for the MPIC.  The
> >> + property
> >> +                  value shall include "chrp,open-pic".
> >
> > In the ePAPR we modified this to just "open-pic", because this has
> > nothing to do with chrp anymore.   I think just "open-pic" is
> > what we want.
>=20
> OK, but as a migration path we should allow the kernel to accept both
> (Scott mentioned this in another reply), but "open-pic" is the
> documented correct way.

Right.

> >> +   - interrupt-controller : The presence of this property identifies
> >> + the node
> >> +                            as a MPIC.  No property value should be
> >> defined.
> >> +   - #address-cells : Specifies the number of cells needed to encode =
an
> >> +                      address.  The value of this property shall alwa=
ys
> >> + be 0
> >> +                      so that 'interrupt-map' nodes do not have to
> >> + specify a
> >> +                      parent unit address.
> >> +   - #interrupt-cells : Specifies the number of cells needed to encod=
e
> >> + an
> >> +                        interrupt source.
> >
> > Should be 2, correct?
>=20
> Yup.
>=20
> >> +** Optional properties:
> >> +
> >> +   - no-reset : The presence of this property indicates that the MPIC
> >> +                should not be reset during runtime initialization.
> >> +   - protected-sources : Specifies a list of interrupt sources that a=
re
> >> + not
> >> +                         available for use and whose corresponding
> >> + vectors
> >> +                         should not be initialized.  A typical use ca=
se
> >> + for
> >> +                         this property is in AMP systems where multip=
le
> >> +                         independent operating systems need to share
> >> + the MPIC
> >> +                         without clobbering each other.
> >
> > I do think you need to include the definition of interrupt
> > specifiers here.   Feel free to cut/paste text from my
> > Freescale mpic binding.
>=20
> OK, I will look into that.  Thanks.

I have a version 2 I hope to send out later today.

Stuart
