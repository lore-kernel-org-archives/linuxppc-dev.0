Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound4-wa4-R.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 629E5DDF17
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 14:46:56 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8B0C6.881F3D46"
Subject: RE: [PATCH 4/4] [POWERPC] Xilinx: Framebuffer: Usedcrinfrastructure.
Date: Wed, 7 May 2008 21:46:51 -0700
References: <20080421080353.5d2b3bb9@zod.rchland.ibm.com>
	<1210010201-28436-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1210010201-28436-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1210010201-28436-3-git-send-email-stephen.neuendorffer@xilinx.com>
	<1210010201-28436-4-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080505175647.4F3AC1C9004A@mail57-sin.bigfish.com>
	<fa686aa40805052155q43a7ebd8x14c1711bd4c6bbfa@mail.gmail.com>
	<20080506061444.GB17798@yookeroo.seuss>
	<20080506174352.52C857D805C@mail62-va3.bigfish.com>
	<20080508015948.GG5156@yookeroo.seuss>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "David Gibson" <david@gibson.dropbear.id.au>
Message-Id: <20080508044652.98467AA8064@mail133-wa4.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8B0C6.881F3D46
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


The problem is that the tft driver currently in mainline assumes that =
the dcr control registers
are accessed through mmio, and probes for a reg=3D<> property.  Since =
the device is actually a dcr device,
it can be connected via mmio through a bride, or to the native dcr bus =
of the processor.  For the time being,
I'd like to generate device trees compatible with either mechanism.

so, the problem is that the tree-parents of the tft node all have =
ranges, and if the dcr-parent of the node is a bridge, then it has a =
reg=3D<> property,
But if the dcr-parent is also a tree-parent, then it has to have ranges; =
and a reg=3D<> property, which seems very strange, and not something I =
think is
a good thing to do.

Steve

-----Original Message-----
From: David Gibson [mailto:david@gibson.dropbear.id.au]
Sent: Wed 5/7/2008 6:59 PM
To: Stephen Neuendorffer
Cc: Grant Likely; linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/4] [POWERPC] Xilinx: Framebuffer: =
Usedcrinfrastructure.
=20
On Tue, May 06, 2008 at 10:43:50AM -0700, Stephen Neuendorffer wrote:
[snip]
> > > Hmmm, something doesn't quite feel right about this.  The node
> > > describing the tft device is a child of the dcr@0 node which is =
the
> > > dcr bus.  However, dcr bindings use dcr-bus and dcr-reg instead of
> > > parent-child relationship to specify how to access the dcr
> registers.
> > > So, in this example; if the device is described by tft@80, and the
> dcr
> > > bus is described by opb2dcr-bridge@40700000, then what does dcr@0
> > > describe?  (I do understand what they really describe in EDK =
terms;
> > > but I'm looking at it through device tree glasses).
> > >
> > > I don't think the presence of a dcr@0 node is a problem, but in =
this
> > > case #size/address-cells doesn't have any meaning (the child =
doesn't
> > > have a reg property) and it looks like it should be a child of the
> > > opb2dcr-bridge node (otherwise, what is it attached to?).
> >=20
> > Yes, indeed.  If dcr@0 is representing the DCR bus / interface it
> > should really have the dcr-access-method property and have all the
> > dcr-parent handles point at it.
>=20
> Hmm, I tend to agree.  Certainly the address-cells and size-cells can
> go.  Part of the nastiness is that I'm trying to maintain a modicum of
> backward compatibility at the moment in the device tree generator.  =
This
> structure allow the dcr@0 node to have ranges; and the tft node to =
have
> a properly translated reg =3D <> property for the existing driver =
which
> only understands mmio.  I don't think it really works for the opb2dcr
> bridge to be a bridge and a dcr-controller at the same time. :)  This
> structure is also very similar to what is generated if the
> dcr-controller is native from the processor (there's just no bridge).

I don't really understand what you're getting at here, sorry.  Perhaps
you could describe what you're doing with the tft device in more
detail?

> > Current standard practice is not to represent the DCR bus as node =
with
> > subnodes for the DCR-controlled devices.  That's because the DCR bus
> > tends to run in addition to other on-chip busses, and some things =
have
> > to go on another on-chip bus to make sense, but still have DCR =
control
> > registers (for example the internal bus bridges on 4xx).
> >=20
> > Arguably for DCR-only devices we should instead have a node
> > representing the DCR bus and just put the devices under it with the
> > DCR number encoded in reg in the normal way.  But then its
> > inconsistent with the devices that need the other DCR =
representation.
>=20
> Yup, it's exactly this problem I'm trying to fix in the case of the =
tft
> driver.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ =
_other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson



------_=_NextPart_001_01C8B0C6.881F3D46
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>RE: [PATCH 4/4] [POWERPC] Xilinx: Framebuffer: =
Usedcrinfrastructure.</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>The problem is that the tft driver currently in =
mainline assumes that the dcr control registers<BR>
are accessed through mmio, and probes for a reg=3D&lt;&gt; =
property.&nbsp; Since the device is actually a dcr device,<BR>
it can be connected via mmio through a bride, or to the native dcr bus =
of the processor.&nbsp; For the time being,<BR>
I'd like to generate device trees compatible with either mechanism.<BR>
<BR>
so, the problem is that the tree-parents of the tft node all have =
ranges, and if the dcr-parent of the node is a bridge, then it has a =
reg=3D&lt;&gt; property,<BR>
But if the dcr-parent is also a tree-parent, then it has to have ranges; =
and a reg=3D&lt;&gt; property, which seems very strange, and not =
something I think is<BR>
a good thing to do.<BR>
<BR>
Steve<BR>
<BR>
-----Original Message-----<BR>
From: David Gibson [<A =
HREF=3D"mailto:david@gibson.dropbear.id.au">mailto:david@gibson.dropbear.=
id.au</A>]<BR>
Sent: Wed 5/7/2008 6:59 PM<BR>
To: Stephen Neuendorffer<BR>
Cc: Grant Likely; linuxppc-dev@ozlabs.org<BR>
Subject: Re: [PATCH 4/4] [POWERPC] Xilinx: Framebuffer: =
Usedcrinfrastructure.<BR>
<BR>
On Tue, May 06, 2008 at 10:43:50AM -0700, Stephen Neuendorffer =
wrote:<BR>
[snip]<BR>
&gt; &gt; &gt; Hmmm, something doesn't quite feel right about =
this.&nbsp; The node<BR>
&gt; &gt; &gt; describing the tft device is a child of the dcr@0 node =
which is the<BR>
&gt; &gt; &gt; dcr bus.&nbsp; However, dcr bindings use dcr-bus and =
dcr-reg instead of<BR>
&gt; &gt; &gt; parent-child relationship to specify how to access the =
dcr<BR>
&gt; registers.<BR>
&gt; &gt; &gt; So, in this example; if the device is described by =
tft@80, and the<BR>
&gt; dcr<BR>
&gt; &gt; &gt; bus is described by opb2dcr-bridge@40700000, then what =
does dcr@0<BR>
&gt; &gt; &gt; describe?&nbsp; (I do understand what they really =
describe in EDK terms;<BR>
&gt; &gt; &gt; but I'm looking at it through device tree glasses).<BR>
&gt; &gt; &gt;<BR>
&gt; &gt; &gt; I don't think the presence of a dcr@0 node is a problem, =
but in this<BR>
&gt; &gt; &gt; case #size/address-cells doesn't have any meaning (the =
child doesn't<BR>
&gt; &gt; &gt; have a reg property) and it looks like it should be a =
child of the<BR>
&gt; &gt; &gt; opb2dcr-bridge node (otherwise, what is it attached =
to?).<BR>
&gt; &gt;<BR>
&gt; &gt; Yes, indeed.&nbsp; If dcr@0 is representing the DCR bus / =
interface it<BR>
&gt; &gt; should really have the dcr-access-method property and have all =
the<BR>
&gt; &gt; dcr-parent handles point at it.<BR>
&gt;<BR>
&gt; Hmm, I tend to agree.&nbsp; Certainly the address-cells and =
size-cells can<BR>
&gt; go.&nbsp; Part of the nastiness is that I'm trying to maintain a =
modicum of<BR>
&gt; backward compatibility at the moment in the device tree =
generator.&nbsp; This<BR>
&gt; structure allow the dcr@0 node to have ranges; and the tft node to =
have<BR>
&gt; a properly translated reg =3D &lt;&gt; property for the existing =
driver which<BR>
&gt; only understands mmio.&nbsp; I don't think it really works for the =
opb2dcr<BR>
&gt; bridge to be a bridge and a dcr-controller at the same time. =
:)&nbsp; This<BR>
&gt; structure is also very similar to what is generated if the<BR>
&gt; dcr-controller is native from the processor (there's just no =
bridge).<BR>
<BR>
I don't really understand what you're getting at here, sorry.&nbsp; =
Perhaps<BR>
you could describe what you're doing with the tft device in more<BR>
detail?<BR>
<BR>
&gt; &gt; Current standard practice is not to represent the DCR bus as =
node with<BR>
&gt; &gt; subnodes for the DCR-controlled devices.&nbsp; That's because =
the DCR bus<BR>
&gt; &gt; tends to run in addition to other on-chip busses, and some =
things have<BR>
&gt; &gt; to go on another on-chip bus to make sense, but still have DCR =
control<BR>
&gt; &gt; registers (for example the internal bus bridges on 4xx).<BR>
&gt; &gt;<BR>
&gt; &gt; Arguably for DCR-only devices we should instead have a =
node<BR>
&gt; &gt; representing the DCR bus and just put the devices under it =
with the<BR>
&gt; &gt; DCR number encoded in reg in the normal way.&nbsp; But then =
its<BR>
&gt; &gt; inconsistent with the devices that need the other DCR =
representation.<BR>
&gt;<BR>
&gt; Yup, it's exactly this problem I'm trying to fix in the case of the =
tft<BR>
&gt; driver.<BR>
<BR>
--<BR>
David Gibson&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | I'll have my music baroque, =
and my code<BR>
david AT gibson.dropbear.id.au&nbsp; | minimalist, thank you.&nbsp; NOT =
_the_ _other_<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | _way_ _around_!<BR>
<A =
HREF=3D"http://www.ozlabs.org/~dgibson">http://www.ozlabs.org/~dgibson</A=
><BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8B0C6.881F3D46--
