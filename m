Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound8-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DCD16DDE17
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 17:05:33 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C84072.C83285F0"
Subject: RE: Device Tree updates for xilinx.
Date: Sun, 16 Dec 2007 22:04:46 -0800
References: <20071204012811.AD70CEF004D@mail134-dub.bigfish.com>
	<20071213233945.E8FFAA6007C@mail180-sin.bigfish.com>
	<20071216070404.GK21311@localhost.localdomain>
	<20071217045726.DD1881298046@mail127-sin.bigfish.com>
	<20071217052101.GC3477@localhost.localdomain>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "David Gibson" <david@gibson.dropbear.id.au>
Message-Id: <20071217060512.36E9DB88046@mail181-blu.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, Michal Simek <simekm2@fel.cvut.cz>,
	git <git@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C84072.C83285F0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Thanks, I've updated the generator to reflect this.

Steve

-----Original Message-----
From: David Gibson [mailto:david@gibson.dropbear.id.au]
Sent: Sun 12/16/2007 9:21 PM
To: Stephen Neuendorffer
Cc: linuxppc-dev@ozlabs.org; Michal Simek; git
Subject: Re: Device Tree updates for xilinx.
=20
On Sun, Dec 16, 2007 at 08:58:18PM -0800, Stephen Neuendorffer wrote:
>=20
> Since there don't seem to be any examples of this in the tree: do
> you have a format preference?  For the rest of the compatible lists,
> I'm using something like: xlnx,ipname-version.  So for the
> microblaze, I'd prefer something like:
>=20
> xlnx,microblaze-6.00.b

Sounds reasonable.

> For the powerpc, either ibm,ppc405 or ibm.ppc-405 would seem to be
> more in character than PowerPC,405.

Well, we could list both forms, but PowerPC,405 should be included
since it's an established name.  There's some history behind this:
before the generic names convention, the node name was used to encode
the most specific register interface for the device, and "compatible"
was used to describe any other interfaces it was also compatible with.

With the generic names convention, the name came to represent the
general type of device, and "compatible" alone was used to describe
the programming interface(s).  In Apple and IBM device trees, while
most things reflect the generic names convention, it seems the cpu
nodes were left using the old convention - which is why that approach
was copied and is currently used in all the dts files.  So when
converting nodes to the generic names convention, the old content of
the node name should go into "compatible" verbatim as the first entry.

In practice of course, I don't think anything looks at either the name
or the compatible property for cpu nodes (nor do I think they should)
- they'll just use the PVR.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ =
_other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson



------_=_NextPart_001_01C84072.C83285F0
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
<TITLE>RE: Device Tree updates for xilinx.</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Thanks, I've updated the generator to reflect =
this.<BR>
<BR>
Steve<BR>
<BR>
-----Original Message-----<BR>
From: David Gibson [<A =
HREF=3D"mailto:david@gibson.dropbear.id.au">mailto:david@gibson.dropbear.=
id.au</A>]<BR>
Sent: Sun 12/16/2007 9:21 PM<BR>
To: Stephen Neuendorffer<BR>
Cc: linuxppc-dev@ozlabs.org; Michal Simek; git<BR>
Subject: Re: Device Tree updates for xilinx.<BR>
<BR>
On Sun, Dec 16, 2007 at 08:58:18PM -0800, Stephen Neuendorffer =
wrote:<BR>
&gt;<BR>
&gt; Since there don't seem to be any examples of this in the tree: =
do<BR>
&gt; you have a format preference?&nbsp; For the rest of the compatible =
lists,<BR>
&gt; I'm using something like: xlnx,ipname-version.&nbsp; So for the<BR>
&gt; microblaze, I'd prefer something like:<BR>
&gt;<BR>
&gt; xlnx,microblaze-6.00.b<BR>
<BR>
Sounds reasonable.<BR>
<BR>
&gt; For the powerpc, either ibm,ppc405 or ibm.ppc-405 would seem to =
be<BR>
&gt; more in character than PowerPC,405.<BR>
<BR>
Well, we could list both forms, but PowerPC,405 should be included<BR>
since it's an established name.&nbsp; There's some history behind =
this:<BR>
before the generic names convention, the node name was used to =
encode<BR>
the most specific register interface for the device, and =
&quot;compatible&quot;<BR>
was used to describe any other interfaces it was also compatible =
with.<BR>
<BR>
With the generic names convention, the name came to represent the<BR>
general type of device, and &quot;compatible&quot; alone was used to =
describe<BR>
the programming interface(s).&nbsp; In Apple and IBM device trees, =
while<BR>
most things reflect the generic names convention, it seems the cpu<BR>
nodes were left using the old convention - which is why that =
approach<BR>
was copied and is currently used in all the dts files.&nbsp; So when<BR>
converting nodes to the generic names convention, the old content of<BR>
the node name should go into &quot;compatible&quot; verbatim as the =
first entry.<BR>
<BR>
In practice of course, I don't think anything looks at either the =
name<BR>
or the compatible property for cpu nodes (nor do I think they =
should)<BR>
- they'll just use the PVR.<BR>
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
------_=_NextPart_001_01C84072.C83285F0--
