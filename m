Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from mail185-wa4-R.bigfish.com (mail-wa4.bigfish.com
	[216.32.181.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7D8C3DDD0B
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 13:45:55 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8DA63.C60FBCF0"
Subject: RE: [PATCH] [POWERPC] Xilinx: add compatibility for 'simple-bus'.
Date: Sun, 29 Jun 2008 20:42:13 -0700
References: <20080508161529.65566FB805F@mail185-va3.bigfish.com><1210271125-11559-1-git-send-email-stephen.neuendorffer@xilinx.com><20080603214232.E0A8D1488061@mail55-wa4.bigfish.com><fa686aa40806060829h52c5d27fvcec8c02c2eee3c7@mail.gmail.com><20080606161932.0650C1500054@mail96-sin.bigfish.com>
	<fa686aa40806281333i5ae1833fg561622640b5d3a4e@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20080630034548.AA682FE005B@mail185-wa4.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, git <git@xilinx.com>, dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------_=_NextPart_001_01C8DA63.C60FBCF0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Is there really much of a chance of that, given the differences with the bo=
otwrappers?
Does anyone care enough about legacy_serial for this to matter?   My impres=
sion was that legacy serial was not preferred anyway...

Steve

-----Original Message-----
From: glikely@secretlab.ca on behalf of Grant Likely
Sent: Sat 6/28/2008 1:33 PM
To: Stephen Neuendorffer
Cc: dwg@au1.ibm.com; jwboyer@linux.vnet.ibm.com; linuxppc-dev@ozlabs.org; g=
it
Subject: Re: [PATCH] [POWERPC] Xilinx: add compatibility for 'simple-bus'.
 =

On Fri, Jun 6, 2008 at 10:16 AM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
>
> legacy_serial identifies a valid ns16550 on a simple-bus, but the
> legacy_serial driver doesn't understand the shift and offset flags
> necessary to get it to work, which results in no console.
>
> I think the easiest solution is to change the Kconfig so that
> PPC_UDBG_16550 is only selected based on !XILINX_VIRTEX.  I've done this
> in my tree, but I've been swamped with other things at the moment, so I
> haven't verified it.

This is an easy solution, but it is not a good one.  Doing so would
break UDBG on other 405 boards when building multiplatform kernels.
It would be better to teach legacy serial about the shift and offset.
Alternately, add code to add_legacy_soc_port() to skip it if the
shift/offset properties are present.

Cheers,
g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.




This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.


------_=_NextPart_001_01C8DA63.C60FBCF0
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
<TITLE>RE: [PATCH] [POWERPC] Xilinx: add compatibility for 'simple-bus'.</T=
ITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Is there really much of a chance of that, given the diffe=
rences with the bootwrappers?<BR>
Does anyone care enough about legacy_serial for this to matter?&nbsp;&nbsp;=
 My impression was that legacy serial was not preferred anyway...<BR>
<BR>
Steve<BR>
<BR>
-----Original Message-----<BR>
From: glikely@secretlab.ca on behalf of Grant Likely<BR>
Sent: Sat 6/28/2008 1:33 PM<BR>
To: Stephen Neuendorffer<BR>
Cc: dwg@au1.ibm.com; jwboyer@linux.vnet.ibm.com; linuxppc-dev@ozlabs.org; g=
it<BR>
Subject: Re: [PATCH] [POWERPC] Xilinx: add compatibility for 'simple-bus'.<=
BR>
<BR>
On Fri, Jun 6, 2008 at 10:16 AM, Stephen Neuendorffer<BR>
&lt;stephen.neuendorffer@xilinx.com&gt; wrote:<BR>
&gt;<BR>
&gt; legacy_serial identifies a valid ns16550 on a simple-bus, but the<BR>
&gt; legacy_serial driver doesn't understand the shift and offset flags<BR>=

&gt; necessary to get it to work, which results in no console.<BR>
&gt;<BR>
&gt; I think the easiest solution is to change the Kconfig so that<BR>
&gt; PPC_UDBG_16550 is only selected based on !XILINX_VIRTEX.&nbsp; I've do=
ne this<BR>
&gt; in my tree, but I've been swamped with other things at the moment, so =
I<BR>
&gt; haven't verified it.<BR>
<BR>
This is an easy solution, but it is not a good one.&nbsp; Doing so would<BR=
>
break UDBG on other 405 boards when building multiplatform kernels.<BR>
It would be better to teach legacy serial about the shift and offset.<BR>
Alternately, add code to add_legacy_soc_port() to skip it if the<BR>
shift/offset properties are present.<BR>
<BR>
Cheers,<BR>
g.<BR>
<BR>
--<BR>
Grant Likely, B.Sc., P.Eng.<BR>
Secret Lab Technologies Ltd.<BR>
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


------_=_NextPart_001_01C8DA63.C60FBCF0--
