Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound7-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0BB5BDDDED
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 15:51:53 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C84068.87B3AB1C"
Subject: RE: [PATCH 7/7] [POWERPC] Xilinx: Update booting-without-of.
Date: Sun, 16 Dec 2007 20:48:59 -0800
References: <1197589413-5965-1-git-send-email-stephen.neuendorffer@xilinx.com><1197589413-5965-2-git-send-email-stephen.neuendorffer@xilinx.com><1197589413-5965-3-git-send-email-stephen.neuendorffer@xilinx.com><1197589413-5965-4-git-send-email-stephen.neuendorffer@xilinx.com><1197589413-5965-5-git-send-email-stephen.neuendorffer@xilinx.com><1197589413-5965-6-git-send-email-stephen.neuendorffer@xilinx.com><20071213234151.D0B3DE80061@mail20-sin.bigfish.com><20071217041455.GA3477@localhost.localdomain>
	<fa686aa40712162030q6f0e6d87j5e6e5379cbd0d54e@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>, <simekm2@fel.cvut.cz>,
	<jwilliams@itee.uq.edu.au>, <linuxppc-dev@ozlabs.org>
Message-Id: <20071217045149.286161758054@mail101-blu.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C84068.87B3AB1C
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Compound devices that actually have their own shared registers should do =
something different.  Likely they'll need some sort of data =
synchronization anyway.  It seems that by far the common case here is to =
going to be to just have aggregation, and I don't see any reason that =
can't be handled by a common 'pseudo-bus'.


Steve

-----Original Message-----
From: glikely@secretlab.ca on behalf of Grant Likely
Sent: Sun 12/16/2007 8:30 PM
To: Stephen Neuendorffer; grant.likely@secretlab.ca; =
simekm2@fel.cvut.cz; jwilliams@itee.uq.edu.au; linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 7/7] [POWERPC] Xilinx: Update booting-without-of.
=20
On 12/16/07, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Thu, Dec 13, 2007 at 03:43:33PM -0800, Stephen Neuendorffer wrote:
> > This now better describes what the UBoot device tree generator =
actually does.  In particular:
> >
> > 1) Nodes have a label derived from the device name, and a node name
> > derived from the device type.
> > 2) Usage of compound nodes (representing more than one device in the =
same IP) which actually works.  This requires having a valid compatible =
node, and all the other things that a bus normally has.  I've chosen =
'xlnx,compound' as the bus name to describe these compound nodes.
>
> I'm not sure I like this xlnx,compound business, although maybe it's
> the best you can do.

I'd prefer something like "xlnx,<ip-name>-group".  "xlnx,compound" is
a very bad idea because it will be reused for very different types of
devices.  What happens when a device appears that has both
per-instance properties and 'top level' registers accessed by both
devices?

------_=_NextPart_001_01C84068.87B3AB1C
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
<TITLE>RE: [PATCH 7/7] [POWERPC] Xilinx: Update =
booting-without-of.</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>
<BR>

<P><FONT SIZE=3D2>Compound devices that actually have their own shared =
registers should do something different.&nbsp; Likely they'll need some =
sort of data synchronization anyway.&nbsp; It seems that by far the =
common case here is to going to be to just have aggregation, and I don't =
see any reason that can't be handled by a common 'pseudo-bus'.<BR>
<BR>
<BR>
Steve<BR>
<BR>
-----Original Message-----<BR>
From: glikely@secretlab.ca on behalf of Grant Likely<BR>
Sent: Sun 12/16/2007 8:30 PM<BR>
To: Stephen Neuendorffer; grant.likely@secretlab.ca; =
simekm2@fel.cvut.cz; jwilliams@itee.uq.edu.au; =
linuxppc-dev@ozlabs.org<BR>
Subject: Re: [PATCH 7/7] [POWERPC] Xilinx: Update =
booting-without-of.<BR>
<BR>
On 12/16/07, David Gibson &lt;david@gibson.dropbear.id.au&gt; wrote:<BR>
&gt; On Thu, Dec 13, 2007 at 03:43:33PM -0800, Stephen Neuendorffer =
wrote:<BR>
&gt; &gt; This now better describes what the UBoot device tree generator =
actually does.&nbsp; In particular:<BR>
&gt; &gt;<BR>
&gt; &gt; 1) Nodes have a label derived from the device name, and a node =
name<BR>
&gt; &gt; derived from the device type.<BR>
&gt; &gt; 2) Usage of compound nodes (representing more than one device =
in the same IP) which actually works.&nbsp; This requires having a valid =
compatible node, and all the other things that a bus normally has.&nbsp; =
I've chosen 'xlnx,compound' as the bus name to describe these compound =
nodes.<BR>
&gt;<BR>
&gt; I'm not sure I like this xlnx,compound business, although maybe =
it's<BR>
&gt; the best you can do.<BR>
<BR>
I'd prefer something like &quot;xlnx,&lt;ip-name&gt;-group&quot;.&nbsp; =
&quot;xlnx,compound&quot; is<BR>
a very bad idea because it will be reused for very different types =
of<BR>
devices.&nbsp; What happens when a device appears that has both<BR>
per-instance properties and 'top level' registers accessed by both<BR>
devices?<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C84068.87B3AB1C--
