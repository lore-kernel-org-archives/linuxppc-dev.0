Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from mail171-va3-R.bigfish.com (mail-va3.bigfish.com
	[216.32.180.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3BB1FDE274
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 14:00:28 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8DA62.ED75E45D"
Subject: RE: [PATCH 12/60] microblaze_v4: Generic dts file for platforms
Date: Sun, 29 Jun 2008 20:39:40 -0700
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz><1214483429-32360-6-git-send-email-monstr@seznam.cz><1214483429-32360-7-git-send-email-monstr@seznam.cz><1214483429-32360-8-git-send-email-monstr@seznam.cz><1214483429-32360-9-git-send-email-monstr@seznam.cz><1214483429-32360-10-git-send-email-monstr@seznam.cz><1214483429-32360-11-git-send-email-monstr@seznam.cz><1214483429-32360-12-git-send-email-monstr@seznam.cz><1214483429-32360-13-git-send-email-monstr@seznam.cz><fa686aa40806272249l7eae0c34k43a20ad41672b77a@mail.gmail.com>
	<1d3f23370806291702g4344a2f9lb62f85cbb475fca4@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "John Williams" <john.williams@petalogix.com>, <grant.likely@secretlab.ca>
Message-Id: <20080630033943.332471860046@mail171-va3.bigfish.com>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
	vapier.adi@gmail.com, arnd@arndb.de, matthew@wil.cx,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	John Linn <linnj@xilinx.com>, monstr@seznam.cz,
	drepper@redhat.com, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------_=_NextPart_001_01C8DA62.ED75E45D
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


In my opionion, we should only include dts files for reference designs, and=
 it must be documented how to get the design that the dts corresponds to.
MD5 hashing might be one way to prevent people from getting the dts file wr=
ong, however without some way of checking it automatically, I don't think
anyone will have the patience to checksum the design they have (even worse,=
 with whitespace changes, the md5 sum will change, so this is pretty fragil=
e.
Having a device tree in the kernel for documentation *shouldn't* be necessa=
ry, since noone should ever write their dts by hand. (right?)
Hence, I'd prefer to not put the dts file in the kernel at all, and but to =
automatically generate the dts and store it in the blockram of the design.
This inextricably associates the dts with the design.

As for the copyright, I haven't been able to find much information on wheth=
er or not generated files are even copyrightable.  One might argue that the=
y
don't have sufficient 'creative value' to be copyrightable.  Or arguably, t=
hey are as copyrightable by the generator author as by the author or the .m=
hs file.
I admit in this case, I've followed the safe route by claiming a copyright,=
 which at least at Xilinx has significant precedent.

Steve

-----Original Message-----
From: John Williams [mailto:john.williams@petalogix.com]
Sent: Sun 6/29/2008 5:02 PM
To: grant.likely@secretlab.ca
Cc: monstr@seznam.cz; linux-kernel@vger.kernel.org; arnd@arndb.de; linux-ar=
ch@vger.kernel.org; Stephen Neuendorffer; John Linn; matthew@wil.cx; will.n=
ewton@gmail.com; drepper@redhat.com; microblaze-uclinux@itee.uq.edu.au; lin=
uxppc-dev@ozlabs.org; vapier.adi@gmail.com; alan@lxorguk.ukuu.org.uk; hpa@z=
ytor.com; Michal Simek
Subject: Re: [PATCH 12/60] microblaze_v4: Generic dts file for platforms
 =

On Sat, Jun 28, 2008 at 3:49 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> On Thu, Jun 26, 2008 at 5:29 AM,  <monstr@seznam.cz> wrote:
>> From: Michal Simek <monstr@monstr.eu>

>>  arch/microblaze/platform/generic/system.dts |  300 ++++++++++++++++++++=
+++++++

> Since this is a generated file, and entirely bitstream specific, does
> it make sense to include it in the kernel tree?  If it does, then is
> it produced from one of the Xilinx reference designs?  Can you add
> documentation to the header that specifies exactly which design
> version this .dts is for?

I think there's value in having a generic DTS as an example or
template, even if it doesn't correspond to any specific machine.
Agreed a comment block explaining this is valuable.

I'd almost oppose any attempt to include a standard DTS for things
like ML401 boards etc - they are just misleading.  Unless we do MD5
hashes on MHS files, and use them as the filenames, any attempt to
define a standard platform will just fail and confuse people.  Better
to show them how to generate the DTS for their system.

>> +/*
>> + * (C) Copyright 2007-2008 Xilinx, Inc.
>> + * (C) Copyright 2007-2008 Michal Simek
>> + *
>> + * Michal SIMEK <monstr@monstr.eu>
>
> If this is a generated file, then is this copyright notice even appropria=
te?

I agree.  I think Michal is just copying Xilinx's habit of putting
copyright headers in generated files, and it's one that we should stop
now.

Regards,

John




This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.


------_=_NextPart_001_01C8DA62.ED75E45D
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-8859-=
1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7652.24"=
>
<TITLE>RE: [PATCH 12/60] microblaze_v4: Generic dts file for platforms</TIT=
LE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>In my opionion, we should only include dts files for refe=
rence designs, and it must be documented how to get the design that the dts=
 corresponds to.<BR>
MD5 hashing might be one way to prevent people from getting the dts file wr=
ong, however without some way of checking it automatically, I don't think<B=
R>
anyone will have the patience to checksum the design they have (even worse,=
 with whitespace changes, the md5 sum will change, so this is pretty fragil=
e.<BR>
Having a device tree in the kernel for documentation *shouldn't* be necessa=
ry, since noone should ever write their dts by hand. (right?)<BR>
Hence, I'd prefer to not put the dts file in the kernel at all, and but to =
automatically generate the dts and store it in the blockram of the design.<=
BR>
This inextricably associates the dts with the design.<BR>
<BR>
As for the copyright, I haven't been able to find much information on wheth=
er or not generated files are even copyrightable.&nbsp; One might argue tha=
t they<BR>
don't have sufficient 'creative value' to be copyrightable.&nbsp; Or arguab=
ly, they are as copyrightable by the generator author as by the author or t=
he .mhs file.<BR>
I admit in this case, I've followed the safe route by claiming a copyright,=
 which at least at Xilinx has significant precedent.<BR>
<BR>
Steve<BR>
<BR>
-----Original Message-----<BR>
From: John Williams [<A HREF=3D"mailto:john.williams@petalogix.com">mailto:=
john.williams@petalogix.com</A>]<BR>
Sent: Sun 6/29/2008 5:02 PM<BR>
To: grant.likely@secretlab.ca<BR>
Cc: monstr@seznam.cz; linux-kernel@vger.kernel.org; arnd@arndb.de; linux-ar=
ch@vger.kernel.org; Stephen Neuendorffer; John Linn; matthew@wil.cx; will.n=
ewton@gmail.com; drepper@redhat.com; microblaze-uclinux@itee.uq.edu.au; lin=
uxppc-dev@ozlabs.org; vapier.adi@gmail.com; alan@lxorguk.ukuu.org.uk; hpa@z=
ytor.com; Michal Simek<BR>
Subject: Re: [PATCH 12/60] microblaze_v4: Generic dts file for platforms<BR=
>
<BR>
On Sat, Jun 28, 2008 at 3:49 PM, Grant Likely &lt;grant.likely@secretlab.ca=
&gt; wrote:<BR>
&gt; On Thu, Jun 26, 2008 at 5:29 AM,&nbsp; &lt;monstr@seznam.cz&gt; wrote:=
<BR>
&gt;&gt; From: Michal Simek &lt;monstr@monstr.eu&gt;<BR>
<BR>
&gt;&gt;&nbsp; arch/microblaze/platform/generic/system.dts |&nbsp; 300 ++++=
+++++++++++++++++++++++<BR>
<BR>
&gt; Since this is a generated file, and entirely bitstream specific, does<=
BR>
&gt; it make sense to include it in the kernel tree?&nbsp; If it does, then=
 is<BR>
&gt; it produced from one of the Xilinx reference designs?&nbsp; Can you ad=
d<BR>
&gt; documentation to the header that specifies exactly which design<BR>
&gt; version this .dts is for?<BR>
<BR>
I think there's value in having a generic DTS as an example or<BR>
template, even if it doesn't correspond to any specific machine.<BR>
Agreed a comment block explaining this is valuable.<BR>
<BR>
I'd almost oppose any attempt to include a standard DTS for things<BR>
like ML401 boards etc - they are just misleading.&nbsp; Unless we do MD5<BR=
>
hashes on MHS files, and use them as the filenames, any attempt to<BR>
define a standard platform will just fail and confuse people.&nbsp; Better<=
BR>
to show them how to generate the DTS for their system.<BR>
<BR>
&gt;&gt; +/*<BR>
&gt;&gt; + * (C) Copyright 2007-2008 Xilinx, Inc.<BR>
&gt;&gt; + * (C) Copyright 2007-2008 Michal Simek<BR>
&gt;&gt; + *<BR>
&gt;&gt; + * Michal SIMEK &lt;monstr@monstr.eu&gt;<BR>
&gt;<BR>
&gt; If this is a generated file, then is this copyright notice even approp=
riate?<BR>
<BR>
I agree.&nbsp; I think Michal is just copying Xilinx's habit of putting<BR>=

copyright headers in generated files, and it's one that we should stop<BR>
now.<BR>
<BR>
Regards,<BR>
<BR>
John<BR>
<BR>
<BR>
</FONT>
</P>

<br clear=3Dall> This email and any attachments are intended for the sole u=
se of the named recipient(s) and contain(s) confidential information that m=
ay be proprietary, privileged or copyrighted under applicable law. If you a=
re not the intended recipient, do not read, copy, or forward this email mes=
sage or any attachments. Delete this email message and any attachments imme=
diately.
</BODY>
</HTML>


------_=_NextPart_001_01C8DA62.ED75E45D--
