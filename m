Return-Path: <srinivas.surabhi@wipro.com>
Received: from wip-ectls-mx1.wipro.com (wip-ectls-mx1.wipro.com
	[203.101.113.37])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wip-ectls-mx1.wipro.com",
	Issuer "VeriSign Trust Network" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8A1C567A86
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Feb 2005 02:26:54 +1100 (EST)
Received: from wip-ectls-mx1.wipro.com (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with ESMTP id 9315A220352
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 20 Feb 2005 20:57:06 +0530 (IST)
Received: from blr-ec-bh1.wipro.com (blr-ec-bh1.wipro.com [10.200.50.91])
	by wip-ectls-mx1.wipro.com (Postfix) with ESMTP id 86D44220029
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 20 Feb 2005 20:57:06 +0530 (IST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C51760.5978F88E"
Date: Sun, 20 Feb 2005 20:55:03 +0530
Message-ID: <EF9B29C78F41FA488927FCBC7750AF0E011DA65E@hyd-mdp-msg.wipro.com>
From: <srinivas.surabhi@wipro.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Freeing unused kernel memory: 56k init
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

------_=_NextPart_001_01C51760.5978F88E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


When I tried to debug for the reason of  "Freeing unused kernel memory:
56k init " hang problem  the following is the printk outputs...

Entering kernel_read

=0D

Entering elf_map=0D

=0D

map_addr was 0x30026000 =0D

=0D

Failed due to bad address

=0D

Entering padzero

=0D

...

=0D

>From the above can anything be concluded ?

=0D

One more doubt was, is it mandatory that the Virtual memory has to
enabled while building the Mounta Vista linux kernel ? Why because there
was an option to enable the kernel base address and if it is enabled it
asks for what is the address for the Kernel Virtual base address? If I
give 0x0 it works otherwise the Kernel itself is not at all booting.

=0D

Till the statement "Freeing unused kernel memory: 56k init"  is coming
only if and if the 0x0 was given for the kernel virtual base address.

=0D

=0D

Thanks & Regards

-SS

________________________________

From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org]=0D
Sent: Friday, February 18, 2005 2:42 PM
To: linuxppc-embedded@ozlabs.org
Subject: Freeing unused kernel memory: 56k init

=0D

=0D

The latest update is that the init was also found in one of the
packages. So now I am not facing init not found problem . But there was
a hung problem, once the init is invoked .. Please find the output
below...

=0D

RAMDISK: Compressed image found at block 0

Freeing initrd memory: 1235k freed

kjournald starting. Commit interval 5 seconds

EXT3-fs: mounted filesystem with ordered data mode.

VFS: Mounted root (ext3 filesystem) readonly.

Mounted devfs on /dev

Freeing unused kernel memory: 56k init

< there is no output after the above statement.....>=0D

Thanks & Regards

Surabhi Srinivas

=0D

________________________________

From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Thu 2/17/2005 5:12 PM

Subject: Re: Mounta Vista Linux prompt on serial console=0D

In message
<EF9B29C78F41FA488927FCBC7750AF0E08DA14@hyd-mdp-msg.wipro.com> you
wrote:
>
> But the problem is that it was stopping at
>
> "No init found.  Try passing init=3D option to kernel". Before that
there
>  were no errors. Everthing looks fine Mounted VFS root file system was
also

Fine. So you can mount the root filesystem, but it obviously does not
contain all the required files.

>  seen. >From the net I understood is that the fstab file was the
cause. So
>  edited the filesytem parameter for / as /dev/ram earlier it used to
be
>  /dev/root.

No. /etc/fstab has absolutley nothing to do with  your  problem.  The
kernel  cannot  start  the  init  porocess - make sure init is in the
filesystem, plus all required libraries.

> So please tell me whether the given fstab file will suffice? The
filesystem

This is completley unrelated.

> 2. I have one more doubt /sbin/init utility comes with what package?
>  Because in /sbin directory although the init binary is present, not
shown
>  in the file system heirarchy view. For eg. if I select DHCPD package
then
>  able to see dhcpd related binary in the /sbin similarly my question
was
>  which package has to be selected to have init included.

Please contact MV support. I have no  idea  how  they  package  their
distribution,  or  how  their  config  tools might work. You paid for
their stuff, so ask _them_.

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 22 - 24,  Hall 10.0 Booth 310
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The most exciting phrase to hear in science, the one that heralds new
discoveries, is not "Eureka!" (I found it!) but "That's funny ..."
                                                      -- Isaac Asimov



Confidentiality Notice=0D

The information contained in this electronic message and any attachments
to this message are intended
for the exclusive use of the addressee(s) and may contain confidential
or privileged information. If
you are not the intended recipient, please notify the sender at Wipro or
Mailadmin@wipro.com immediately
and destroy all copies of this message and any attachments.
=0D


Confidentiality Notice=0D

The information contained in this electronic message and any attachments
to this message are intended
for the exclusive use of the addressee(s) and may contain confidential
or privileged information. If
you are not the intended recipient, please notify the sender at Wipro or
Mailadmin@wipro.com immediately
and destroy all copies of this message and any attachments.
=0D




Confidentiality Notice=0D

The information contained in this electronic message and any attachments to=
 this message are intended
for the exclusive use of the addressee(s) and may contain confidential or=
 privileged information. If
you are not the intended recipient, please notify the sender at Wipro or=
 Mailadmin@wipro.com immediately
and destroy all copies of this message and any attachments.
------_=_NextPart_001_01C51760.5978F88E
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=
=3D"urn:schemas-microsoft-com:office:office" xmlns:w=
=3D"urn:schemas-microsoft-com:office:word" xmlns:st1=
=3D"urn:schemas-microsoft-com:office:smarttags" xmlns=
=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=
=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<title>Re: Mounta Vista Linux prompt on serial console </title>
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
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
p
	{mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman";}
span.EmailStyle18
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

<p><font size=3D3 face=3D"Times New Roman"><span style=
=3D'font-size:12.0pt'>When I
tried to debug for the reason of &nbsp;&#8220;Freeing unused kernel memory:=
 56k init
&#8220; hang problem&nbsp; the following is the printk=
 outputs&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D3 face=
=3D"Courier New"><span
style=3D'font-size:12.0pt;font-family:"Courier New"'>Entering=
 kernel_read<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D3 face=
=3D"Courier New"><span
style=3D'font-size:12.0pt;font-family:"Courier=
 New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D3 face=
=3D"Courier New"><span
style=3D'font-size:12.0pt;font-family:"Courier New"'>Entering elf_map=
 <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D3 face=
=3D"Courier New"><span
style=3D'font-size:12.0pt;font-family:"Courier=
 New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Courier New"><span style=
=3D'font-size:12.0pt;
font-family:"Courier New"'>map_addr was 0x30026000&nbsp;=
 <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Courier New"><span style=
=3D'font-size:12.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Courier New"><span style=
=3D'font-size:12.0pt;
font-family:"Courier New"'>Failed due to bad=
 address<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Courier New"><span style=
=3D'font-size:12.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Courier New"><span style=
=3D'font-size:12.0pt;
font-family:"Courier New"'>Entering padzero</span></font><font color=3Dnavy
face=3DArial><span style=
=3D'font-family:Arial;color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>From the above can anything be=
 concluded ?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>One more doubt was, is it mandatory=
 that
the Virtual memory has to enabled while building the Mounta Vista linux=
 kernel ?
Why because there was an option to enable the kernel base address and if it=
 is
enabled it asks for what is the address for the Kernel Virtual base=
 address? If
I give 0x0 it works otherwise the Kernel itself is not at all=
 booting.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=
=3D'font-size:
12.0pt'>Till the statement &#8220;Freeing unused kernel memory: 56k=
 init&#8221;
&nbsp;is coming only if and if the 0x0 was given for the kernel virtual=
 base
address.</span></font><font size=3D2 color=3Dnavy face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:navy'><o:p></o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Thanks &amp;=
 Regards<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>-SS<o:p></o:p></span></font></p>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font=
 size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span style=
=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'>
linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] <br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Friday, February 18,=
 2005
2:42 PM<br>
<b><span style=3D'font-weight:bold'>To:</span></b>=
 linuxppc-embedded@ozlabs.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Freeing unused=
 kernel
memory: 56k init</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=
=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<div id=3DidOWAReplyText45834>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=
=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

</div>

<div>

<div id=3DidOWAReplyText29619>

<div>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:black'>The latest update is that the init=
 was
also found in one of the packages. So now I am not facing init not found
problem . But there was a hung problem, once the init is invoked .. Please=
 find
the output below...</span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=
=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p><font size=3D2 face=3D"Times New Roman"><span style=
=3D'font-size:10.0pt'>RAMDISK:
Compressed image found at block 0<o:p></o:p></span></font></p>

<p><font size=3D2 face=3D"Times New Roman"><span style=
=3D'font-size:10.0pt'>Freeing
initrd memory: 1235k freed<o:p></o:p></span></font></p>

<p><font size=3D2 face=3D"Times New Roman"><span style=
=3D'font-size:10.0pt'>kjournald
starting. Commit interval 5 seconds<o:p></o:p></span></font></p>

<p><font size=3D2 face=3D"Times New Roman"><span style=
=3D'font-size:10.0pt'>EXT3-fs:
mounted filesystem with ordered data mode.<o:p></o:p></span></font></p>

<p><font size=3D2 face=3D"Times New Roman"><span style=
=3D'font-size:10.0pt'>VFS:
Mounted root (ext3 filesystem) readonly.<o:p></o:p></span></font></p>

<p><font size=3D2 face=3D"Times New Roman"><span style=
=3D'font-size:10.0pt'>Mounted
devfs on /dev<o:p></o:p></span></font></p>

<p><font size=3D2 face=3D"Times New Roman"><span style=
=3D'font-size:10.0pt'>Freeing
unused kernel memory: 56k init<o:p></o:p></span></font></p>

<p><font size=3D2 face=3D"Times New Roman"><span style=
=3D'font-size:10.0pt'>&lt;
there is no output after the above statement.....&gt;=
 <o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10.0pt;
font-family:Arial'>Thanks &amp; Regards</span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10.0pt;
font-family:Arial'>Surabhi Srinivas</span></font><o:p></o:p></p>

</div>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=
=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font=
 size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabIndex=3D-1>

</span></font></div>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><b><font size=3D2 face=
=3DTahoma><span
style=
=3D'font-size:10.0pt;font-family:Tahoma;font-weight:bold'>From:</span></fon=
t></b><font
size=3D2 face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'>=
 Wolfgang
Denk [mailto:wd@denx.de]<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Thu 2/17/2005 5:12=
 PM<br>
<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Re: Mounta Vista=
 Linux
prompt on serial console </span></font><o:p></o:p></p>

</div>

<div>

<p><font size=3D2 face=3D"Times New Roman"><span style=
=3D'font-size:10.0pt'>In
message=
 &lt;EF9B29C78F41FA488927FCBC7750AF0E08DA14@hyd-mdp-msg.wipro.com&gt;
you wrote:<br>
&gt;<br>
&gt; But the problem is that it was stopping at<br>
&gt;<br>
&gt; &quot;No init found.&nbsp; Try passing init=3D option to kernel&quot;.
Before that there<br>
&gt;&nbsp; were no errors. Everthing looks fine Mounted VFS root file=
 system
was also<br>
<br>
Fine. So you can mount the root filesystem, but it obviously does not<br>
contain all the required files.<br>
<br>
&gt;&nbsp; seen. &gt;From the net I understood is that the fstab file was=
 the
cause. So<br>
&gt;&nbsp; edited the filesytem parameter for / as /dev/ram earlier it used=
 to
be<br>
&gt;&nbsp; /dev/root.<br>
<br>
No. /etc/fstab has absolutley nothing to do with&nbsp; your&nbsp;
problem.&nbsp; The<br>
kernel&nbsp; cannot&nbsp; start&nbsp; the&nbsp; init&nbsp; porocess - make=
 sure
init is in the<br>
filesystem, plus all required libraries.<br>
<br>
&gt; So please tell me whether the given fstab file will suffice? The
filesystem<br>
<br>
This is completley unrelated.<br>
<br>
&gt; 2. I have one more doubt /sbin/init utility comes with what=
 package?<br>
&gt;&nbsp; Because in /sbin directory although the init binary is present,=
 not
shown<br>
&gt;&nbsp; in the file system heirarchy view. For eg. if I select DHCPD=
 package
then<br>
&gt;&nbsp; able to see dhcpd related binary in the /sbin similarly my=
 question
was<br>
&gt;&nbsp; which package has to be selected to have init included.<br>
<br>
Please contact MV support. I have no&nbsp; idea&nbsp; how&nbsp; they&nbsp;
package&nbsp; their<br>
distribution,&nbsp; or&nbsp; how&nbsp; their&nbsp; config&nbsp; tools might
work. You paid for<br>
their stuff, so ask _them_.<br>
<br>
Best regards,<br>
<br>
Wolfgang Denk<br>
<br>
--<br>
See us @ Embedded World, <st1:City w:st=3D"on"><st1:place w:st=
=3D"on">Nuremberg</st1:place></st1:City>,
Feb 22 - 24,&nbsp; Hall 10.0 Booth 310<br>
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de<br>
The most exciting phrase to hear in science, the one that heralds new<br>
discoveries, is not &quot;<st1:City w:st=3D"on"><st1:place w:st=
=3D"on">Eureka</st1:place></st1:City>!&quot;
(I found it!) but &quot;That's funny ...&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
-- Isaac Asimov</span></font><o:p></o:p></p>

</div>

</div>

</div>

</body>

</html>
<table><tr><td bgcolor=3D#ffffff><font color=3D#000000><br>
<br>
Confidentiality Notice <br>
<br>
The information contained in this electronic message and any attachments to=
 this message are intended<br>
for the exclusive use of the addressee(s) and may contain confidential or=
 privileged information. If<br>
you are not the intended recipient, please notify the sender at Wipro or=
 Mailadmin@wipro.com immediately<br>
and destroy all copies of this message and any attachments.<br>
</font></td></tr></table>
<table><tr><td bgcolor=3D#ffffff><font color=3D#000000><br>
<br>
Confidentiality Notice <br>
<br>
The information contained in this electronic message and any attachments to=
 this message are intended<br>
for the exclusive use of the addressee(s) and may contain confidential or=
 privileged information. If<br>
you are not the intended recipient, please notify the sender at Wipro or=
 Mailadmin@wipro.com immediately<br>
and destroy all copies of this message and any attachments.<br>
</font></td></tr></table>
<table><tr><td bgcolor=3D#ffffff><font color=3D#000000><br>
<br>
Confidentiality Notice <br>
<br>
The information contained in this electronic message and any attachments to=
 this message are intended<br>
for the exclusive use of the addressee(s) and may contain confidential or=
 privileged information. If<br>
you are not the intended recipient, please notify the sender at Wipro or=
 Mailadmin@wipro.com immediately<br>
and destroy all copies of this message and any attachments.<br>
</font></td></tr></table>
------_=_NextPart_001_01C51760.5978F88E--
