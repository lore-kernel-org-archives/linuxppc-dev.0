Return-Path: <john.bonesio@xilinx.com>
Received: from outbound1-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CB12067E19
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Oct 2006 03:17:28 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6E7D8.F278C161"
Subject: RE: booting 2.6 kernel on ML403
Date: Wed, 4 Oct 2006 10:17:18 -0700
Message-ID: <2FE3DBF1797A1443AAB3FA0EF6BF4EEC02300D10@XSJ-EXCHVS1.xlnx.xilinx.com>
From: "John Bonesio" <john.bonesio@xilinx.com>
To: "Pradeep Sampath" <pradeepsampath@yahoo.com>,
	"Ming Liu" <eemingliu@hotmail.com>, <ammubhai@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
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

------_=_NextPart_001_01C6E7D8.F278C161
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

A quick amendment to my previous email:

The device name you should use in the CONFIG_CMDLINE  "root=3D..." can =
be found in the routine call to register_blkdev() in the driver source =
code. The first parameter to register_blkdev() is the major number of =
the device. The second parameter is the name of the device, as in =
/dev/xsda2, or /dev/xsysace2. This second parameter will contain just =
the 'xsda' or 'xsysace' in it, and it may be a preprocessor constant =
defined earlier in the file, such as #define MAJOR_NAME "xsda", but it =
might not be a constant either. It depends on the code.

=20

Hopefully this clears things up a bit.

=20

- John

=20

________________________________

From: linuxppc-embedded-bounces+jbonesio=3Dxilinx.com@ozlabs.org =
[mailto:linuxppc-embedded-bounces+jbonesio=3Dxilinx.com@ozlabs.org] On =
Behalf Of Pradeep Sampath
Sent: Wednesday, October 04, 2006 10:35 AM
To: Ming Liu; ammubhai@gmail.com
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: booting 2.6 kernel on ML403

=20

Hello Ameet/Ming,

=20

First of all really appreciate your inputs on this...=20

Problem 1 :

I was using the factory shipped compact flash as is which comes with a =
DOS FAT16 partition and a linux 83 partition with ext3 filesystem. I =
tried it on 2 factory shipped CFs and its the same behavior - . When i =
plug-in the CF card reader to the linux box it always reads it as "sda" =
and in the linux2.6.17.1/Documentation/devices.txt - sda is the device =
file for SCSI disk devices. Wonerding how you guys configured the root =
option as "/dev/xsa".

=20

Now i re-formatted my CF, created a ext2 filesystem using busybox-1.1.0 =
like the BYU instructions. Created 2 partitions on CF card 1. FAT16 =
partition & 2. linux partition and then created 1. dos file system using =
mkdosfs and 2. linux ext2 filesystem using mke2fs.

=20

But the problem still persists and i get "Please append a correct =
"root=3D" boot option :"

:(

=20

Problem 2: After i included the TEMAC driver and sysace drivers, the =
kernel just hangs. I thought i'll fix problem 1 before i get to problem =
2...=20

=20

With your help i am getting the confidence that i can make this all =
work!

thanks once again.

-Pradeep



Ming Liu <eemingliu@hotmail.com> wrote:

	Hello Ameet,
	I am using that driver very well now. There is only one problem. It =
seems=20
	that the driver for TEMAC only support Gigabit Enet, not 10/100/1000M=20
	adapted. But because I want to use the Gigabit enet, I don't care that. =
So=20
	it's OK, at lease for 1Gbit/s.
=09
	So I don't think Pradeep's problem is caused by Temac. I still suspect =
that=20
	he didn't pass a right parameter to "root=3D", just like what I posted=20
	before.
=09
	Regards
	Ming
=09
=09
	>From: Ameet Patil=20
	>To: Ming Liu=20
	>CC: pradeepsampath@yahoo.com, linuxppc-embedded@ozlabs.org
	>Subject: Re: booting 2.6 kernel on ML403
	>Date: Wed, 04 Oct 2006 09:35:07 +0100
	>
	>Ming Liu wrote:
	> > Hi,
	> >
	> >> [ 3.093694] TCP bic registered
	> >> [ 3.129458] NET: Registered protocol family 8
	> >> [ 3.181412] NET: Registered protocol family 20
	> >> [ 3.236744] VFS: Cannot open root device "xsa2" or =
unknown-block(0,0)
	> >> [ 3.313092] Please append a correct "root=3D" boot option
	> >
	> > It looks that some errors still exist in the parameters you passed =
to
	> > "root=3D". Please double check it, or post it in the maillist for =
deep
	> > analysis.
	> > Regards
	> > Ming
	> >
	> > _________________________________________________________________
	> > =
=CF=ED=D3=C3=CA=C0=BD=E7=C9=CF=D7=EE=B4=F3=B5=C4=B5=E7=D7=D3=D3=CA=BC=FE=CF=
=B5=CD=B3=A1=AA MSN Hotmail=A1=A3 http://www.hotmail.com
	> >=20
	=
------------------------------------------------------------------------
	> >
	> > _______________________________________________
	> > Linuxppc-embedded mailing list
	> > Linuxppc-embedded@ozlabs.org
	> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
	>Hi Ming,
	>IIRC, you are or were using the TEMAC driver along with my System Ace
	>driver, isn't it? Does my driver patch ***-after-TEMAC.patch work for
	>you? I ask this because Pradeep is having some problems using it (see
	>Problem 2 in his email). Could you please update on this?
	>
	>Thanks,
	>-Ameet
=09
	_________________________________________________________________
	=
=D3=EB=C1=AA=BB=FA=B5=C4=C5=F3=D3=D1=BD=F8=D0=D0=BD=BB=C1=F7=A3=AC=C7=EB=CA=
=B9=D3=C3 MSN Messenger: http://messenger.msn.com/cn=20
=09
	_______________________________________________
	Linuxppc-embedded mailing list
	Linuxppc-embedded@ozlabs.org
	https://ozlabs.org/mailman/listinfo/linuxppc-embedded

=20


------_=_NextPart_001_01C6E7D8.F278C161
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>A quick amendment to my previous =
email:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>The device name you should use in =
the
CONFIG_CMDLINE =A0&#8220;root=3D&#8230;&#8221; can be found in the =
routine call to
register_blkdev() in the driver source code. The first parameter to
register_blkdev() is the major number of the device. The second =
parameter is
the name of the device, as in /dev/xsda2, or /dev/xsysace2. This second
parameter will contain just the &#8216;xsda&#8217; or =
&#8216;xsysace&#8217; in
it, and it may be a preprocessor constant defined earlier in the file, =
such as #define
MAJOR_NAME &#8220;xsda&#8221;, but it might not be a constant either. It
depends on the code.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Hopefully this clears things up a =
bit.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>- John<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'> =
linuxppc-embedded-bounces+jbonesio=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+jbonesio=3Dxilinx.com@ozlabs.org] =
<b><span
style=3D'font-weight:bold'>On Behalf Of </span></b>Pradeep Sampath<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Wednesday, October =
04, 2006
10:35 AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> Ming Liu; =
ammubhai@gmail.com<br>
<b><span style=3D'font-weight:bold'>Cc:</span></b> =
linuxppc-embedded@ozlabs.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Re: booting 2.6 =
kernel on
ML403</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Hello Ameet/Ming,<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>First of all really appreciate your inputs on this... =
<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Problem 1 :<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>I was using the factory shipped compact flash as is which comes =
with a
DOS FAT16 partition and a linux 83 partition with ext3 filesystem. =
I&nbsp;tried
it on 2&nbsp;factory shipped CFs and its&nbsp;the same behavior - . When =
i
plug-in the CF card reader to the linux box it always reads it as
&quot;sda&quot; and in the linux2.6.17.1/Documentation/devices.txt - sda =
is the
device file for SCSI disk devices. Wonerding how you guys configured the =
root
option as &quot;/dev/xsa&quot;.<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Now i re-formatted my CF, created a ext2 filesystem using =
busybox-1.1.0
like the BYU instructions. Created 2 partitions on CF card 1. FAT16 =
partition
&amp; 2. linux partition and then created 1. dos file system using =
mkdosfs and 2.
linux ext2 filesystem using mke2fs.<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>But the problem still persists and i get &quot;Please append a =
correct
&quot;root=3D&quot; boot option :&quot;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>:(<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Problem 2: After i included the TEMAC driver and sysace drivers,
the&nbsp;kernel just hangs. I thought i'll fix problem 1 before i get to
problem 2... <o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>With your help i am getting the confidence that i can make this =
all
work!<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>thanks once again.<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>-Pradeep<br>
<br>
<br>
<br>
<b><i><span style=3D'font-weight:bold;font-style:italic'>Ming Liu
&lt;eemingliu@hotmail.com&gt;</span></i></b> =
wrote:<o:p></o:p></span></font></p>

</div>

<blockquote style=3D'border:none;border-left:solid #1010FF =
1.5pt;padding:0in 0in 0in 3.0pt;
margin-left:3.4pt;margin-top:5.0pt;margin-bottom:5.0pt'>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Hello Ameet,<br>
I am using that driver very well now. There is only one problem. It =
seems <br>
that the driver for TEMAC only support Gigabit Enet, not 10/100/1000M =
<br>
adapted. But because I want to use the Gigabit enet, I don't care that. =
So <br>
it's OK, at lease for 1Gbit/s.<br>
<br>
So I don't think Pradeep's problem is caused by Temac. I still suspect =
that <br>
he didn't pass a right parameter to &quot;root=3D&quot;, just like what =
I posted <br>
before.<br>
<br>
Regards<br>
Ming<br>
<br>
<br>
&gt;From: Ameet Patil <br>
<AMMUBHAI@GMAIL.COM>&gt;To: Ming Liu <br>
<EEMINGLIU@HOTMAIL.COM>&gt;CC: pradeepsampath@yahoo.com,
linuxppc-embedded@ozlabs.org<br>
&gt;Subject: Re: booting 2.6 kernel on ML403<br>
&gt;Date: Wed, 04 Oct 2006 09:35:07 +0100<br>
&gt;<br>
&gt;Ming Liu wrote:<br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt;&gt; [ 3.093694] TCP bic registered<br>
&gt; &gt;&gt; [ 3.129458] NET: Registered protocol family 8<br>
&gt; &gt;&gt; [ 3.181412] NET: Registered protocol family 20<br>
&gt; &gt;&gt; [ 3.236744] VFS: Cannot open root device &quot;xsa2&quot; =
or
unknown-block(0,0)<br>
&gt; &gt;&gt; [ 3.313092] Please append a correct &quot;root=3D&quot; =
boot option<br>
&gt; &gt;<br>
&gt; &gt; It looks that some errors still exist in the parameters you =
passed to<br>
&gt; &gt; &quot;root=3D&quot;. Please double check it, or post it in the =
maillist
for deep<br>
&gt; &gt; analysis.<br>
&gt; &gt; Regards<br>
&gt; &gt; Ming<br>
&gt; &gt;<br>
&gt; &gt; =
_________________________________________________________________<br>
&gt; &gt; =
=CF=ED=D3=C3=CA=C0=BD=E7=C9=CF=D7=EE=B4=F3=B5=C4=B5=E7=D7=D3=D3=CA=BC=FE=CF=
=B5=CD=B3=A1=AA MSN Hotmail=A1=A3 http://www.hotmail.com<br>
&gt; &gt; <br>
------------------------------------------------------------------------<=
br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; Linuxppc-embedded mailing list<br>
&gt; &gt; Linuxppc-embedded@ozlabs.org<br>
&gt; &gt; https://ozlabs.org/mailman/listinfo/linuxppc-embedded<br>
&gt;Hi Ming,<br>
&gt;IIRC, you are or were using the TEMAC driver along with my System =
Ace<br>
&gt;driver, isn't it? Does my driver patch ***-after-TEMAC.patch work =
for<br>
&gt;you? I ask this because Pradeep is having some problems using it =
(see<br>
&gt;Problem 2 in his email). Could you please update on this?<br>
&gt;<br>
&gt;Thanks,<br>
&gt;-Ameet<br>
<br>
_________________________________________________________________<br>
=D3=EB=C1=AA=BB=FA=B5=C4=C5=F3=D3=D1=BD=F8=D0=D0=BD=BB=C1=F7=A3=AC=C7=EB=CA=
=B9=D3=C3 MSN Messenger: http://messenger.msn.com/cn <br>
<br>
_______________________________________________<br>
Linuxppc-embedded mailing list<br>
Linuxppc-embedded@ozlabs.org<br>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded<o:p></o:p></span></=
font></p>

</blockquote>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C6E7D8.F278C161--
