Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound2-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id ED1DBDDE3A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Nov 2007 05:28:57 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C82F8F.1A8494FA"
Subject: RE: Xilinx devicetrees
Date: Sun, 25 Nov 2007 10:15:05 -0800
References: <47480CF0.7090105@dlasys.net>
	<fa686aa40711240912r192aba72o2cbdb798370e7b7c@mail.gmail.com>
	<20071125052459.DA8B1EE805F@mail70-blu.bigfish.com>
	<4749425C.5060207@dlasys.net>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Message-Id: <20071125181506.EE2041BA004F@mail141-cpk.bigfish.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C82F8F.1A8494FA
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




-----Original Message-----
From: David H. Lynch Jr. [mailto:dhlii@dlasys.net]
Sent: Sun 11/25/2007 1:37 AM
To: Stephen Neuendorffer
Cc: Grant Likely; linuxppc-embedded
Subject: Re: Xilinx devicetrees
=20
Stephen Neuendorffer wrote:
>
> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org =
on behalf of Grant Likely
> Sent: Sat 11/24/2007 9:12 AM
> To: David H. Lynch Jr.
> Cc: linuxppc-embedded
> Subject: Re: Xilinx devicetrees
> =20
>     Regardless, I think I saw a post of yours on the microblaze list
> about exporting a devicetree list with the firmware.
>     that is probably a better solution that what exists now.

I agree.. that's why I'm working on it. :)  But just to clarify: I don't =
work directly on Xilinx products, but more in advanced development.

>     I am curious - with the firmware is not the same as in the =
firmware.
>     But since you brought up deciphering firmware - to me and to Pico,
> and I gather to alot of others, providing indentity information within
> the firmware is a really really important issue - one which xilinx =
seems
> to be unable to make up its mind about.
>     There are frequent posts addressing issues like this driver only
> works with this version of some IP - but there is no way to query the =
IP
> to enough detail to determine whether the driver will work. It is one
> thing to make version registers an option. It is entirely different to
> just omit them entirely or change the IP without changing the version.
> Our clients beat us up for things like that. DevieTrees do nto solve
> that problem.

I know these issues are high priorities within the EDK development =
group.  One advantage of device trees is that this information can be =
included without using any additional FPGA resources.

>     Anyway, my .02 would be to put the device tree into the firmware. =
In
> a perfect world - litterally in the firmware so that when the firmware
> loads the device tree data is already in the FPGA somewhere that it =
can
> be easily ready - oh and do that without consuming many FPGA =
resources.
>     But in a more likely realworld scenario - append the information =
to
> the .bit file in some fashion so that if can easily be found and =
passed on.

I've experimented with putting this information into BRAM.  Typically =
compressed device trees should easily fit within a single BRAM.  =
However, I think in most scenarios this is actually overkill.  Storing =
the device tree with the bitstream is probably good enough, and likely =
cheaper since the bitstream is likely in bulk storage.  This might be =
configuration flash (which is accessible after booting), SystemAce (in =
which case, the systemace image could load the device tree into a known =
location in memory).  In other systems the bitstream and the device tree =
might be combined into an executable file along with processor code for =
configuring the FPGA.  This might be used with an external processor or =
a partially reconfigured system.

>    Binding it to a kernel, is a non-starter for us.

I agree that this is not the best way of leveraging the power of device =
trees.  The point is that by using a device tree, you haven't lost =
anything you can do currently.  In the future we might have one kernel =
which supports all versions of all our IP, along with all flavors of =
microblaze and powerpc...  You would only ever need to recompile this =
kernel as a final optimization, if at all.

> I am tasked with getting one binary for each
> OS to work with nearly every device(hardware) we make including
> addressing options that change with firmware AND the whim of the user.
>     But life might not be to unpleasant - it might even actually be
> better, if our kernel loader just extracted the devicetree from the =
end
> of the currently executing firmware.

Device trees are a data driven way of doing exactly this.

Steve


------_=_NextPart_001_01C82F8F.1A8494FA
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
<TITLE>RE: Xilinx devicetrees</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>
<BR>
<BR>

<P><FONT SIZE=3D2>-----Original Message-----<BR>
From: David H. Lynch Jr. [<A =
HREF=3D"mailto:dhlii@dlasys.net">mailto:dhlii@dlasys.net</A>]<BR>
Sent: Sun 11/25/2007 1:37 AM<BR>
To: Stephen Neuendorffer<BR>
Cc: Grant Likely; linuxppc-embedded<BR>
Subject: Re: Xilinx devicetrees<BR>
<BR>
Stephen Neuendorffer wrote:<BR>
&gt;<BR>
&gt; -----Original Message-----<BR>
&gt; From: =
linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org on =
behalf of Grant Likely<BR>
&gt; Sent: Sat 11/24/2007 9:12 AM<BR>
&gt; To: David H. Lynch Jr.<BR>
&gt; Cc: linuxppc-embedded<BR>
&gt; Subject: Re: Xilinx devicetrees<BR>
&gt;&nbsp;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Regardless, I think I saw a post of yours =
on the microblaze list<BR>
&gt; about exporting a devicetree list with the firmware.<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; that is probably a better solution that =
what exists now.<BR>
<BR>
I agree.. that's why I'm working on it. :)&nbsp; But just to clarify: I =
don't work directly on Xilinx products, but more in advanced =
development.<BR>
<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; I am curious - with the firmware is not the =
same as in the firmware.<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; But since you brought up deciphering =
firmware - to me and to Pico,<BR>
&gt; and I gather to alot of others, providing indentity information =
within<BR>
&gt; the firmware is a really really important issue - one which xilinx =
seems<BR>
&gt; to be unable to make up its mind about.<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; There are frequent posts addressing issues =
like this driver only<BR>
&gt; works with this version of some IP - but there is no way to query =
the IP<BR>
&gt; to enough detail to determine whether the driver will work. It is =
one<BR>
&gt; thing to make version registers an option. It is entirely different =
to<BR>
&gt; just omit them entirely or change the IP without changing the =
version.<BR>
&gt; Our clients beat us up for things like that. DevieTrees do nto =
solve<BR>
&gt; that problem.<BR>
<BR>
I know these issues are high priorities within the EDK development =
group.&nbsp; One advantage of device trees is that this information can =
be included without using any additional FPGA resources.<BR>
<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Anyway, my .02 would be to put the device =
tree into the firmware. In<BR>
&gt; a perfect world - litterally in the firmware so that when the =
firmware<BR>
&gt; loads the device tree data is already in the FPGA somewhere that it =
can<BR>
&gt; be easily ready - oh and do that without consuming many FPGA =
resources.<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; But in a more likely realworld scenario - =
append the information to<BR>
&gt; the .bit file in some fashion so that if can easily be found and =
passed on.<BR>
<BR>
I've experimented with putting this information into BRAM.&nbsp; =
Typically compressed device trees should easily fit within a single =
BRAM.&nbsp; However, I think in most scenarios this is actually =
overkill.&nbsp; Storing the device tree with the bitstream is probably =
good enough, and likely cheaper since the bitstream is likely in bulk =
storage.&nbsp; This might be configuration flash (which is accessible =
after booting), SystemAce (in which case, the systemace image could load =
the device tree into a known location in memory).&nbsp; In other systems =
the bitstream and the device tree might be combined into an executable =
file along with processor code for configuring the FPGA.&nbsp; This =
might be used with an external processor or a partially reconfigured =
system.<BR>
<BR>
&gt;&nbsp;&nbsp;&nbsp; Binding it to a kernel, is a non-starter for =
us.<BR>
<BR>
I agree that this is not the best way of leveraging the power of device =
trees.&nbsp; The point is that by using a device tree, you haven't lost =
anything you can do currently.&nbsp; In the future we might have one =
kernel which supports all versions of all our IP, along with all flavors =
of microblaze and powerpc...&nbsp; You would only ever need to recompile =
this kernel as a final optimization, if at all.<BR>
<BR>
&gt; I am tasked with getting one binary for each<BR>
&gt; OS to work with nearly every device(hardware) we make including<BR>
&gt; addressing options that change with firmware AND the whim of the =
user.<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; But life might not be to unpleasant - it =
might even actually be<BR>
&gt; better, if our kernel loader just extracted the devicetree from the =
end<BR>
&gt; of the currently executing firmware.<BR>
<BR>
Device trees are a data driven way of doing exactly this.<BR>
<BR>
Steve<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C82F8F.1A8494FA--
