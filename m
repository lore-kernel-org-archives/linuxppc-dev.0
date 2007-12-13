Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound1-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CC20FDDE19
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Dec 2007 15:52:21 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C83D43.EE0DFE84"
Subject: RE: Xilinx devicetrees
Date: Wed, 12 Dec 2007 20:52:14 -0800
References: <47480CF0.7090105@dlasys.net>	<fa686aa40711240912r192aba72o2cbdb798370e7b7c@mail.gmail.com>	<47493D4F.4070605@dlasys.net><fa686aa40711251421q38f53ee3hb2a308cc5f93183f@mail.gmail.com><4749FD5E.7000408@dlasys.net>
	<20071125235855.95B9999804D@mail138-cpk.bigfish.com>
	<EDAE140DF1B2FC42B5867C22CA0B333F0A58E4@XMBIL132.northgrum.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>,
	"David H. Lynch Jr." <dhlii@dlasys.net>,
	"Grant Likely" <grant.likely@secretlab.ca>,
	"linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Message-Id: <20071213045215.DA8BAFB8060@mail11-blu.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C83D43.EE0DFE84
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




-----Original Message-----
From: Koss, Mike (Mission Systems) [mailto:mike.koss@ngc.com]
Sent: Mon 11/26/2007 7:31 AM
To: Stephen Neuendorffer; David H. Lynch Jr.; Grant Likely; =
linuxppc-embedded
Subject: RE: Xilinx devicetrees
=20
Time for my $.02, since I am heavily weighting my future designs on the
use of the device trees. :) (and b/c I don't check my work e-mail from
home ;P)

________________________________


SN> As Grant says, the dynamic detection doesn't have to be done in the
boot loader, it could be done in the platform code.  You can largely
ignore=20
SN> the device trees, or always boot with a core device tree and figure
it all out later (perhaps using version registers).  I anticipate that=20
SN> the 'standard flow' will have standard platform code for any board
that uses a complete device tree.  If you have the need to do something=20
SN> extraordinary, then you should feel free to hack away...  However,
It doesn't seem to me to be really necessary in your case, assuming that

SN> the device tree is packaged (somehow, TBD) along with the bitstream.
=20
> I don't know if packaging the device tree with the bitstream is the =
best
> way to go. It's possible that it could lead to headaches for certain
> systems that have security restrictions. The same could be said for
> using it w/ the SystemACE to load it into RAM after the image. (which =
is
> what I'm currently doing for my 2 linux images in lieu of a true =
on-chip
> bootloader). I am already taking the security concerns into account =
for
> future revisions of the hardware wrt to using a SystemACE, and am
> planning on moving the device trees into NV storage like FLASH.

'with' not 'in'. either using SystemAce, or a flash image.

> One solution I've been thinking through (in lieu of direct support =
from
> EDK) is to use a tcl script with xps to traverse the hardware tree and
> generate the device tree. It seems like it should be relatively =
trivial
> to obtain the information. It's just going to be a pain to write all =
the
> handlers for each different linux driver: temac, interrupt controller,
> DMA controller, etc.
> In reality the best way to handle this would be to have EDK generate =
the
> device tree as part of the library/bsp build process.=20
We have a python script to do this.  The main problem with just looking =
at the mhs file is that you lose all the defaults for each IP.  Hence, =
we've also written a BSP generator to do this.  both are at =
git://git.xilinx.com/gen-mhs-devtree.py
Once I can verify that they work in the mainline tree, I'll be sending =
out the patches that make this all work.

> Now, what I'd like
> to see with regards to this is the ability to change the handler for =
the
> generating a specific device information. An example could be the =
temac.
> If at some point in the future the temac needs new/more information to
> support its configuration/run-time then having to get a patch from
> Xilinx for a EDK is way too slow. The developers should be giving the
> opportunity to inject a new handler into the various parts of the =
device
> tree generation. That way when the kernel patch is submitted, an EDK
> device generator patch will be submitted at the same time to keep
> everything in sync.

Interesting idea..  I've been trying to figure out how to architect this =
better, but it requires some information passing within EDK that isnot =
today supported.  I don't see at all how to synchronize this with =
patches to the kernel, tho.  My approach is to describe the hardware as =
completely and faithfully as we can (given the information in EDK), and =
let the drivers do whatever with it that they want to.

Steve



------_=_NextPart_001_01C83D43.EE0DFE84
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
<TITLE>RE: Xilinx devicetrees</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>
<BR>
<BR>

<P><FONT SIZE=3D2>-----Original Message-----<BR>
From: Koss, Mike (Mission Systems) [<A =
HREF=3D"mailto:mike.koss@ngc.com">mailto:mike.koss@ngc.com</A>]<BR>
Sent: Mon 11/26/2007 7:31 AM<BR>
To: Stephen Neuendorffer; David H. Lynch Jr.; Grant Likely; =
linuxppc-embedded<BR>
Subject: RE: Xilinx devicetrees<BR>
<BR>
Time for my $.02, since I am heavily weighting my future designs on =
the<BR>
use of the device trees. :) (and b/c I don't check my work e-mail =
from<BR>
home ;P)<BR>
<BR>
________________________________<BR>
<BR>
<BR>
SN&gt; As Grant says, the dynamic detection doesn't have to be done in =
the<BR>
boot loader, it could be done in the platform code.&nbsp; You can =
largely<BR>
ignore<BR>
SN&gt; the device trees, or always boot with a core device tree and =
figure<BR>
it all out later (perhaps using version registers).&nbsp; I anticipate =
that<BR>
SN&gt; the 'standard flow' will have standard platform code for any =
board<BR>
that uses a complete device tree.&nbsp; If you have the need to do =
something<BR>
SN&gt; extraordinary, then you should feel free to hack away...&nbsp; =
However,<BR>
It doesn't seem to me to be really necessary in your case, assuming =
that<BR>
<BR>
SN&gt; the device tree is packaged (somehow, TBD) along with the =
bitstream.<BR>
<BR>
&gt; I don't know if packaging the device tree with the bitstream is the =
best<BR>
&gt; way to go. It's possible that it could lead to headaches for =
certain<BR>
&gt; systems that have security restrictions. The same could be said =
for<BR>
&gt; using it w/ the SystemACE to load it into RAM after the image. =
(which is<BR>
&gt; what I'm currently doing for my 2 linux images in lieu of a true =
on-chip<BR>
&gt; bootloader). I am already taking the security concerns into account =
for<BR>
&gt; future revisions of the hardware wrt to using a SystemACE, and =
am<BR>
&gt; planning on moving the device trees into NV storage like FLASH.<BR>
<BR>
'with' not 'in'. either using SystemAce, or a flash image.<BR>
<BR>
&gt; One solution I've been thinking through (in lieu of direct support =
from<BR>
&gt; EDK) is to use a tcl script with xps to traverse the hardware tree =
and<BR>
&gt; generate the device tree. It seems like it should be relatively =
trivial<BR>
&gt; to obtain the information. It's just going to be a pain to write =
all the<BR>
&gt; handlers for each different linux driver: temac, interrupt =
controller,<BR>
&gt; DMA controller, etc.<BR>
&gt; In reality the best way to handle this would be to have EDK =
generate the<BR>
&gt; device tree as part of the library/bsp build process.<BR>
We have a python script to do this.&nbsp; The main problem with just =
looking at the mhs file is that you lose all the defaults for each =
IP.&nbsp; Hence, we've also written a BSP generator to do this.&nbsp; =
both are at git://git.xilinx.com/gen-mhs-devtree.py<BR>
Once I can verify that they work in the mainline tree, I'll be sending =
out the patches that make this all work.<BR>
<BR>
&gt; Now, what I'd like<BR>
&gt; to see with regards to this is the ability to change the handler =
for the<BR>
&gt; generating a specific device information. An example could be the =
temac.<BR>
&gt; If at some point in the future the temac needs new/more information =
to<BR>
&gt; support its configuration/run-time then having to get a patch =
from<BR>
&gt; Xilinx for a EDK is way too slow. The developers should be giving =
the<BR>
&gt; opportunity to inject a new handler into the various parts of the =
device<BR>
&gt; tree generation. That way when the kernel patch is submitted, an =
EDK<BR>
&gt; device generator patch will be submitted at the same time to =
keep<BR>
&gt; everything in sync.<BR>
<BR>
Interesting idea..&nbsp; I've been trying to figure out how to architect =
this better, but it requires some information passing within EDK that =
isnot today supported.&nbsp; I don't see at all how to synchronize this =
with patches to the kernel, tho.&nbsp; My approach is to describe the =
hardware as completely and faithfully as we can (given the information =
in EDK), and let the drivers do whatever with it that they want to.<BR>
<BR>
Steve<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C83D43.EE0DFE84--
