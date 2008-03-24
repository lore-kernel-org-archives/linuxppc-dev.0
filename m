Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from mail15-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9D39ADDDF5
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Mar 2008 15:34:23 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C88D68.4EF1A3B3"
Subject: RE: dcr stuff.
Date: Sun, 23 Mar 2008 21:34:12 -0700
References: <20080321190524.4F3491CE0087@mail160-dub.bigfish.com>
	<20080321201704.032999c3@zod.rchland.ibm.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Message-Id: <20080324043416.3634316E007A@mail15-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, git-dev <git-dev@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C88D68.4EF1A3B3
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




-----Original Message-----
From: Josh Boyer [mailto:jwboyer@linux.vnet.ibm.com]
Sent: Fri 3/21/2008 6:17 PM
To: Stephen Neuendorffer
Cc: linuxppc-dev@ozlabs.org; git-dev
Subject: Re: dcr stuff.
=20
On Fri, 21 Mar 2008 12:05:40 -0700
"Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com> wrote:

> > Is there a plan here?  (In particular, in FPGA designs, its possible =
to
> > have crazy things like multiple independent dcr busses, some using
> > native access, some using mmio.  Or even if there is one bus, many =
of
> > the existing non-linux drivers we have assume native or mmio access.
> > I'd like to clean this up, obviously.. :)

> Clean it up how?  I'd hate to add bloat to boards with native DCR
> access just because a few require oddities.
>
> If it ain't broke, don't fix it.
>
> josh

Certainly, if it ain't broke don't fix it.  What I'm really trying to do =
is figure out how to clean up alot of non-mainline drivers.
At the moment, several cores use DCR, but the drivers for those cores =
have internal code for DCR, their own ifdefs, etc.  This *is* broken.
I'm looking at the available documentation to figure out the best way of =
approaching the problem.

It might be nice if there was an extra layer of indirection which was =
only enabled if DCR_NATIVE and DCR_MMIO, and which was no cost =
otherwise,
but the bigger problem I see in the short term is that we'll likely have =
to support ARCH ppc for at least some time into the future, and it would =
be
nice if we used the same driver code to do it: it doesn't seem obvious =
how to achieve this.

Steve


------_=_NextPart_001_01C88D68.4EF1A3B3
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DISO-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>RE: dcr stuff.</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>
<BR>
<BR>

<P><FONT SIZE=3D2>-----Original Message-----<BR>
From: Josh Boyer [<A =
HREF=3D"mailto:jwboyer@linux.vnet.ibm.com">mailto:jwboyer@linux.vnet.ibm.=
com</A>]<BR>
Sent: Fri 3/21/2008 6:17 PM<BR>
To: Stephen Neuendorffer<BR>
Cc: linuxppc-dev@ozlabs.org; git-dev<BR>
Subject: Re: dcr stuff.<BR>
<BR>
On Fri, 21 Mar 2008 12:05:40 -0700<BR>
&quot;Stephen Neuendorffer&quot; &lt;stephen.neuendorffer@xilinx.com&gt; =
wrote:<BR>
<BR>
&gt; &gt; Is there a plan here?&nbsp; (In particular, in FPGA designs, =
its possible to<BR>
&gt; &gt; have crazy things like multiple independent dcr busses, some =
using<BR>
&gt; &gt; native access, some using mmio.&nbsp; Or even if there is one =
bus, many of<BR>
&gt; &gt; the existing non-linux drivers we have assume native or mmio =
access.<BR>
&gt; &gt; I'd like to clean this up, obviously.. :)<BR>
<BR>
&gt; Clean it up how?&nbsp; I'd hate to add bloat to boards with native =
DCR<BR>
&gt; access just because a few require oddities.<BR>
&gt;<BR>
&gt; If it ain't broke, don't fix it.<BR>
&gt;<BR>
&gt; josh<BR>
<BR>
Certainly, if it ain't broke don't fix it.&nbsp; What I'm really trying =
to do is figure out how to clean up alot of non-mainline drivers.<BR>
At the moment, several cores use DCR, but the drivers for those cores =
have internal code for DCR, their own ifdefs, etc.&nbsp; This *is* =
broken.<BR>
I'm looking at the available documentation to figure out the best way of =
approaching the problem.<BR>
<BR>
It might be nice if there was an extra layer of indirection which was =
only enabled if DCR_NATIVE and DCR_MMIO, and which was no cost =
otherwise,<BR>
but the bigger problem I see in the short term is that we'll likely have =
to support ARCH ppc for at least some time into the future, and it would =
be<BR>
nice if we used the same driver code to do it: it doesn't seem obvious =
how to achieve this.<BR>
<BR>
Steve<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C88D68.4EF1A3B3--
