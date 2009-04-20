Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from IE1EHSOBE003.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id 557C4DDFC5
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2009 15:52:03 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9C17C.1A88CCFD"
Subject: RE: [microblaze-uclinux] [PATCH 11/11] microblaze: Kconfig: Enable
	drivers for Microblaze
Date: Sun, 19 Apr 2009 22:51:52 -0700
References: <764365e7af2e476e43cd674738e51f13b306979b.1239874968.git.monstr@monstr.eu><74c0088dfda1816c21914c0a8da0c42908526c5e.1239874968.git.monstr@monstr.eu><20090417170707.B6C95C4004F@mail150-wa4.bigfish.com><fa686aa40904172249m5e261492w48c8d9d8446600e0@mail.gmail.com><495563870904181941o5a66126dgb59d8cad2b7a66f2@mail.gmail.com>
	<1d3f23370904191603s37a6a34clccc397707394650b@mail.gmail.com>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "John Williams" <john.williams@petalogix.com>,
	<microblaze-uclinux@itee.uq.edu.au>
Message-ID: <20090420055154.3582514D804B@mail157-dub.bigfish.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org,
	John Linn <linnj@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------_=_NextPart_001_01C9C17C.1A88CCFD
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


My thinking is that these drivers are likely to be used as a group,
hence it would be nice to make it easy to get them all visible/enabled some=
how.

Steve

-----Original Message-----
From: John Williams [mailto:john.williams@petalogix.com]
Sent: Sun 4/19/2009 4:03 PM
To: microblaze-uclinux@itee.uq.edu.au
Cc: grant.likely@secretlab.ca; Stephen Neuendorffer; linuxppc-dev; linux-ke=
rnel@vger.kernel.org; John Linn
Subject: Re: [microblaze-uclinux] [PATCH 11/11] microblaze: Kconfig: Enable=
 drivers for Microblaze
 =

On Sun, Apr 19, 2009 at 12:41 PM, Stephen Neuendorffer
<stephen.neuendorffer@gmail.com> wrote:
>
>
> On Fri, Apr 17, 2009 at 10:49 PM, Grant Likely <grant.likely@secretlab.ca=
>
> wrote:
>>
>> On Fri, Apr 17, 2009 at 11:06 AM, Stephen Neuendorffer
>> <stephen.neuendorffer@xilinx.com> wrote:
>> >
>> > Can we have XILINX_DRIVERS, please? =A0That way this can also be enabl=
ed
>> > on any architecture that has FPGA peripherals.
>>
>> I've thought about this more, and I'd really rather not. =A0The list of
>> affected drivers is short and is not a large maintenance burden. =A0I
>> don't think a list of 2 or 3 architecture selects for each driver is
>> unreasonable. =A0A "XILINX_DRIVERS" config item doesn't really help much=

>> anyway. =A0At any given time one of these drivers may be needed on
>> another platform. =A0ie. the SystemACE device is present on at least one=

>> non-virtex, non-spartan platform.
>
> Which is exactly why having it architecture dependent isn't right...=A0 A=
ll of
> these drivers
> could be needed and used on any OF-based platform.=A0 If you have a platf=
orm
> (for instance, a processor connected to an FPGA which has these periphera=
ls
> in the FPGA) then you should be able to enable these drivers.=A0 Just my =
2
> cents...

What about the radical approach of having NO architecture
filters/selectors?  Even if some random i386 user selects one of these
drivers, so what?  It will still compile cleanly (if it doesn't we
have to fix it), but there'll be no platform_device_register() call in
their machine startup to actually cause driver / device binding.

No harm, no foul.  Problem goes away.

Then, as Grant points out, the rare cases where non-Xilinx platforms
do use this stuff, they'll presumably know what they're doing and it's
their responsibility to register the appropriate platform_device
structures and make the magic happen.

John
-- =

John Williams, PhD, B.Eng, B.IT
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com  p: +61-7-30090663  f: +61-7-30090663




This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.


------_=_NextPart_001_01C9C17C.1A88CCFD
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-8859-=
1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7654.12"=
>
<TITLE>RE: [microblaze-uclinux] [PATCH 11/11] microblaze: Kconfig: Enable d=
rivers for Microblaze</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>My thinking is that these drivers are likely to be used a=
s a group,<BR>
hence it would be nice to make it easy to get them all visible/enabled some=
how.<BR>
<BR>
Steve<BR>
<BR>
-----Original Message-----<BR>
From: John Williams [<A HREF=3D"mailto:john.williams@petalogix.com">mailto:=
john.williams@petalogix.com</A>]<BR>
Sent: Sun 4/19/2009 4:03 PM<BR>
To: microblaze-uclinux@itee.uq.edu.au<BR>
Cc: grant.likely@secretlab.ca; Stephen Neuendorffer; linuxppc-dev; linux-ke=
rnel@vger.kernel.org; John Linn<BR>
Subject: Re: [microblaze-uclinux] [PATCH 11/11] microblaze: Kconfig: Enable=
 drivers for Microblaze<BR>
<BR>
On Sun, Apr 19, 2009 at 12:41 PM, Stephen Neuendorffer<BR>
&lt;stephen.neuendorffer@gmail.com&gt; wrote:<BR>
&gt;<BR>
&gt;<BR>
&gt; On Fri, Apr 17, 2009 at 10:49 PM, Grant Likely &lt;grant.likely@secret=
lab.ca&gt;<BR>
&gt; wrote:<BR>
&gt;&gt;<BR>
&gt;&gt; On Fri, Apr 17, 2009 at 11:06 AM, Stephen Neuendorffer<BR>
&gt;&gt; &lt;stephen.neuendorffer@xilinx.com&gt; wrote:<BR>
&gt;&gt; &gt;<BR>
&gt;&gt; &gt; Can we have XILINX_DRIVERS, please? =A0That way this can also=
 be enabled<BR>
&gt;&gt; &gt; on any architecture that has FPGA peripherals.<BR>
&gt;&gt;<BR>
&gt;&gt; I've thought about this more, and I'd really rather not. =A0The li=
st of<BR>
&gt;&gt; affected drivers is short and is not a large maintenance burden. =
=A0I<BR>
&gt;&gt; don't think a list of 2 or 3 architecture selects for each driver =
is<BR>
&gt;&gt; unreasonable. =A0A &quot;XILINX_DRIVERS&quot; config item doesn't =
really help much<BR>
&gt;&gt; anyway. =A0At any given time one of these drivers may be needed on=
<BR>
&gt;&gt; another platform. =A0ie. the SystemACE device is present on at lea=
st one<BR>
&gt;&gt; non-virtex, non-spartan platform.<BR>
&gt;<BR>
&gt; Which is exactly why having it architecture dependent isn't right...=
=A0 All of<BR>
&gt; these drivers<BR>
&gt; could be needed and used on any OF-based platform.=A0 If you have a pl=
atform<BR>
&gt; (for instance, a processor connected to an FPGA which has these periph=
erals<BR>
&gt; in the FPGA) then you should be able to enable these drivers.=A0 Just =
my 2<BR>
&gt; cents...<BR>
<BR>
What about the radical approach of having NO architecture<BR>
filters/selectors?&nbsp; Even if some random i386 user selects one of these=
<BR>
drivers, so what?&nbsp; It will still compile cleanly (if it doesn't we<BR>=

have to fix it), but there'll be no platform_device_register() call in<BR>
their machine startup to actually cause driver / device binding.<BR>
<BR>
No harm, no foul.&nbsp; Problem goes away.<BR>
<BR>
Then, as Grant points out, the rare cases where non-Xilinx platforms<BR>
do use this stuff, they'll presumably know what they're doing and it's<BR>
their responsibility to register the appropriate platform_device<BR>
structures and make the magic happen.<BR>
<BR>
John<BR>
--<BR>
John Williams, PhD, B.Eng, B.IT<BR>
PetaLogix - Linux Solutions for a Reconfigurable World<BR>
w: www.petalogix.com&nbsp; p: +61-7-30090663&nbsp; f: +61-7-30090663<BR>
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


------_=_NextPart_001_01C9C17C.1A88CCFD--
