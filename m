Return-Path: <srinivas.surabhi@wipro.com>
Received: from wip-ectls-mx3.wipro.com (wip-ectls-mx3.wipro.com
	[203.101.113.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wip-ectls-mx3.wipro.com",
	Issuer "certserv.wipro.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 62C9667A81
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Feb 2005 16:20:13 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C514B0.57A1C90E"
Date: Thu, 17 Feb 2005 10:50:06 +0530
Message-ID: <EF9B29C78F41FA488927FCBC7750AF0E08DA14@hyd-mdp-msg.wipro.com>
From: <srinivas.surabhi@wipro.com>
To: <wd@denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Mounta Vista Linux prompt on serial console 
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

------_=_NextPart_001_01C514B0.57A1C90E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Sorry if I am eating away your time .. but now it has come to some stage=
 ..able to decompress image of ramdisk image ( with ext2 in it)
=0D

But the problem is that it was stopping at

"No init found.  Try passing init=3D option to kernel". Before that there=
 were no errors. Everthing looks fine Mounted VFS root file system was also=
 seen. From the net I understood is that the fstab file was the cause. So=
 edited the filesytem parameter for / as /dev/ram earlier it used to be=
 /dev/root.

=0D

The fstab file is like this.=0D

=0D

/dev/ram      /            auto         defaults,errors=3Dremount-ro

/proc         /proc        proc         defaults

=0D

So please tell me whether the given fstab file will suffice? The filesystem=
 image was build for ext2. I tried wih CRAMFS but some decompressing error=
 was coming where as the ext2 filesystem image was working fine.

=0D

=0D

2. I have one more doubt /sbin/init utility comes with what package?=
 Because in /sbin directory although the init binary is present, not shown=
 in the file system heirarchy view. For eg. if I select DHCPD package then=
 able to see dhcpd related binary in the /sbin similarly my question was=
 which package has to be selected to have init included.

=0D

Thanks & Regards

Surabhi Srinivas

________________________________

From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Thu 2/17/2005 1:30 AM
To: Srinivas Surabhi (WT01 - EMBEDDED & PRODUCT ENGINEERING SOLUTIONS)
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Mounta Vista Linux prompt on serial console=0D



In message <EF9B29C78F41FA488927FCBC7750AF0E011DA5D1@hyd-mdp-msg.wipro.com>=
 you wrote:
>
> cramfs is 2.7MB where as the RAM size is 32MB. While building ofcourse
> the RAMDISK size was told as 8MB. This I mentioned in the devrocket

What has the ramdisk to do  here?  Either  you  are  using  a  cramfs
filesystem, or a ramdisk (probably with an ext2 filesystem in it).

Putting cramfs filesystem in a ramdisk image is a pretty bad idea.

> Here I have one doubt while building the uBoot image using mkImage with
> multi option where was the FileSystem image getting downloaded ? and how

A multi-file image in U-Boot indeed requires a  ramdisk  image.  Then
you  should  not  use a cramfs filesystem. The method for loading tha
ramdisk image is described in the U-Boot "README"  file;  search  for
"positioning of initrd images".

> the downloaded location was known to the kernel Image for pointing out
> the File System image location. The options -a and -e are applicable
> only for first image, isn't it? First image I mean the kernel Image. I

Yes. Only the kernel is executable code and has an entry point.

> YES. You are right I am building the image on x86 (Windows platform).
> But I checked the build log it used the -r option. The default build was
> cpio format and after that using fstool converting to CRAMS and the
> option -r was present .I believe that devrocket of MountaVista has
> makefiles specific to OS i.e for Windows, because while installation it
> asks for what type of OS do you want to have the Image Development
> environment.

Maybe you should ask MV support, then.

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 22 - 24,  Hall 10.0 Booth 310
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
It is clear that the individual who persecutes a  man,  his  brother,
because he is not of the same opinion, is a monster.       - Voltaire






Confidentiality Notice=0D

The information contained in this electronic message and any attachments to=
 this message are intended
for the exclusive use of the addressee(s) and may contain confidential or=
 privileged information. If
you are not the intended recipient, please notify the sender at Wipro or=
 Mailadmin@wipro.com immediately
and destroy all copies of this message and any attachments.
------_=_NextPart_001_01C514B0.57A1C90E
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=
=3Diso-8859-1">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>

<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version=
 6.5.7232.39">
<TITLE>Re: Mounta Vista Linux prompt on serial console </TITLE>
</HEAD>
<BODY>
<DIV id=3DidOWAReplyText82453 dir=3Dltr>
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>Sorry if I am=
 eating away=0D
your time .. but now it has come to some stage ..able to decompress image=
 of=0D
ramdisk image ( with&nbsp;ext2 in it)</FONT></DIV>
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV dir=3Dltr>
<P class=3DMsoPlainText style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D2><FONT=
=0D
face=3D"Courier New">But the problem is that it was stopping=
 at<?xml:namespace=0D
prefix =3D o ns =3D "urn:schemas-microsoft-com:office:office"=0D
/><o:p></o:p></FONT></FONT></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D2><FONT=
=0D
face=3D"Courier New">"No init found.<SPAN style=3D"mso-spacerun:=
 yes">&nbsp;=0D
</SPAN>Try passing init=3D option to kernel". Before that there were no=
 errors.=0D
Everthing looks fine Mounted VFS root file system was also seen. From the=
 net I=0D
understood is that the fstab file was the cause. So edited the filesytem=0D
parameter for / as /dev/ram earlier it used to be=0D
/dev/root.<o:p></o:p></FONT></FONT></P></DIV>
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></DIV>
<P class=3DMsoPlainText dir=3Dltr style=3D"MARGIN: 0in 0in 0pt"><FONT size=
=3D2><FONT=0D
face=3D"Courier New">The fstab file is like this.=
 <o:p></o:p></FONT></FONT></P>
<P class=3DMsoPlainText dir=3Dltr style=3D"MARGIN: 0in 0in 0pt"><o:p><FONT=
=0D
face=3D"Courier New" size=3D2>&nbsp;</FONT></o:p></P>
<P class=3DMsoPlainText dir=3Dltr style=3D"MARGIN: 0in 0in 0pt"><FONT size=
=3D2><FONT=0D
face=3D"Courier New">/dev/ram<SPAN=0D
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>/<SPAN=0D
style=3D"mso-spacerun:=
 yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0D
</SPAN>auto<SPAN=0D
style=3D"mso-spacerun:=
 yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0D
</SPAN>defaults,errors=3Dremount-ro<o:p></o:p></FONT></FONT></P>
<P class=3DMsoPlainText dir=3Dltr style=3D"MARGIN: 0in 0in 0pt"><FONT size=
=3D2><FONT=0D
face=3D"Courier New">/proc<SPAN=0D
style=3D"mso-spacerun:=
 yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0D
</SPAN>/proc<SPAN=0D
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0D
</SPAN>proc<SPAN=0D
style=3D"mso-spacerun:=
 yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0D
</SPAN>defaults<o:p></o:p></FONT></FONT></P>
<P class=3DMsoPlainText dir=3Dltr style=3D"MARGIN: 0in 0in 0pt"><o:p><FONT=
=0D
face=3D"Courier New" size=3D2>&nbsp;</FONT></o:p></P>
<P class=3DMsoPlainText dir=3Dltr style=3D"MARGIN: 0in 0in 0pt"><FONT size=
=3D2><FONT=0D
face=3D"Courier New">So please tell me whether the given fstab file will=
 suffice?=0D
The filesystem image was build for ext2. I tried wih CRAMFS but some=0D
decompressing error was coming where as the ext2 filesystem image was=
 working=0D
fine.<o:p></o:p></FONT></FONT></P>
<P class=3DMsoPlainText dir=3Dltr style=3D"MARGIN: 0in 0in 0pt"><o:p><FONT=
=0D
face=3D"Courier New" size=3D2></FONT></o:p>&nbsp;</P>
<P class=3DMsoPlainText dir=3Dltr style=3D"MARGIN: 0in 0in 0pt"><o:p><FONT=
=0D
face=3D"Courier New" size=3D2></FONT></o:p>&nbsp;</P>
<P class=3DMsoPlainText dir=3Dltr style=3D"MARGIN: 0in 0in 0pt"><o:p><FONT=
=0D
face=3D"Courier New" size=3D2>2. I have one more doubt /sbin/init utility=
 comes with=0D
what package? Because in /sbin directory although the init binary is=
 present,=0D
not shown in the file system heirarchy view. For eg. if I select DHCPD=
 package=0D
then able to see dhcpd related binary in the /sbin similarly my question=
 was=0D
which package has to be selected to have init included.</FONT></o:p></P>
<P class=3DMsoPlainText dir=3Dltr style=3D"MARGIN: 0in 0in 0pt"><o:p><FONT=
=0D
face=3D"Courier New" size=3D2></FONT></o:p>&nbsp;</P>
<P>Thanks &amp; Regards</P>
<P>Surabhi Srinivas</P>
<P>
<HR tabIndex=3D-1>
</P>
<DIV dir=3Dltr><FONT face=3DTahoma size=3D2><B>From:</B> Wolfgang Denk=0D
[mailto:wd@denx.de]<BR><B>Sent:</B> Thu 2/17/2005 1:30 AM<BR><B>To:</B>=
 Srinivas=0D
Surabhi (WT01 - EMBEDDED &amp; PRODUCT ENGINEERING SOLUTIONS)<BR><B>Cc:</B>=
=0D
linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> Re: Mounta Vista Linux=
 prompt on=0D
serial console <BR></FONT><BR></DIV>
<DIV>
<P><FONT size=3D2>In message=0D
&lt;EF9B29C78F41FA488927FCBC7750AF0E011DA5D1@hyd-mdp-msg.wipro.com&gt; you=
=0D
wrote:<BR>&gt;<BR>&gt; cramfs is 2.7MB where as the RAM size is 32MB. While=
=0D
building ofcourse<BR>&gt; the RAMDISK size was told as 8MB. This I=
 mentioned in=0D
the devrocket<BR><BR>What has the ramdisk to do&nbsp; here?&nbsp;=
 Either&nbsp;=0D
you&nbsp; are&nbsp; using&nbsp; a&nbsp; cramfs<BR>filesystem, or a ramdisk=
=0D
(probably with an ext2 filesystem in it).<BR><BR>Putting cramfs filesystem=
 in a=0D
ramdisk image is a pretty bad idea.<BR><BR>&gt; Here I have one doubt while=
=0D
building the uBoot image using mkImage with<BR>&gt; multi option where was=
 the=0D
FileSystem image getting downloaded ? and how<BR><BR>A multi-file image in=
=0D
U-Boot indeed requires a&nbsp; ramdisk&nbsp; image.&nbsp; Then<BR>you&nbsp;=
=0D
should&nbsp; not&nbsp; use a cramfs filesystem. The method for loading=0D
tha<BR>ramdisk image is described in the U-Boot "README"&nbsp; file;&nbsp;=
=0D
search&nbsp; for<BR>"positioning of initrd images".<BR><BR>&gt; the=
 downloaded=0D
location was known to the kernel Image for pointing out<BR>&gt; the File=
 System=0D
image location. The options -a and -e are applicable<BR>&gt; only for first=
=0D
image, isn't it? First image I mean the kernel Image. I<BR><BR>Yes. Only=
 the=0D
kernel is executable code and has an entry point.<BR><BR>&gt; YES. You are=
 right=0D
I am building the image on x86 (Windows platform).<BR>&gt; But I checked=
 the=0D
build log it used the -r option. The default build was<BR>&gt; cpio format=
 and=0D
after that using fstool converting to CRAMS and the<BR>&gt; option -r was=0D
present .I believe that devrocket of MountaVista has<BR>&gt; makefiles=
 specific=0D
to OS i.e for Windows, because while installation it<BR>&gt; asks for what=
 type=0D
of OS do you want to have the Image Development<BR>&gt;=0D
environment.<BR><BR>Maybe you should ask MV support, then.<BR><BR>Best=0D
regards,<BR><BR>Wolfgang Denk<BR><BR>--<BR>See us @ Embedded World,=
 Nuremberg,=0D
Feb 22 - 24,&nbsp; Hall 10.0 Booth 310<BR>Phone: (+49)-8142-66989-10 Fax:=0D
(+49)-8142-66989-80 Email: wd@denx.de<BR>It is clear that the individual=
 who=0D
persecutes a&nbsp; man,&nbsp; his&nbsp; brother,<BR>because he is not of=
 the=0D
same opinion, is a monster.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -=0D
Voltaire<BR></FONT></P></DIV>

</BODY>
</HTML>
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
------_=_NextPart_001_01C514B0.57A1C90E--
