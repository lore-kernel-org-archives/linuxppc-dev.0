Return-Path: <Rick.Moleres@xilinx.com>
Received: from outbound9-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 94722DDF91
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Apr 2008 01:44:37 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C89E46.2894B572"
Subject: RE: XPS_LL_TEMAC works correctly?
Date: Mon, 14 Apr 2008 09:42:33 -0600
In-Reply-To: <BAY115-W23ED8F42C0F097D8A7864AB2E80@phx.gbl>
References: <D3C541E264C021479BFB60B3B790C0FB30A657@etoilenoire.STARWARS.local>
	<BAY115-W23ED8F42C0F097D8A7864AB2E80@phx.gbl>
From: "Rick Moleres" <Rick.Moleres@xilinx.com>
To: "Mohammad Sadegh Sadri" <mamsadegh@hotmail.com>,
	"Rami WEHBI" <rwehbi@wirecom-tech.com>, <linuxppc-embedded@ozlabs.org>
Message-Id: <20080414154236.64322C88074@mail166-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C89E46.2894B572
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

There are a couple of bugs in the v1.00b version of xps_ll_temac (one in =
checksum offload, one in multicast address reception).  You should try =
dropping back to v1.00a of the core and give that a try, or if you have =
EDK 10.1 you can move to v1.01a of the core.

=20

-Rick

=20

________________________________

From: linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org =
[mailto:linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org] On =
Behalf Of Mohammad Sadegh Sadri
Sent: Monday, April 14, 2008 3:10 AM
To: Rami WEHBI; linuxppc-embedded@ozlabs.org
Subject: RE: XPS_LL_TEMAC works correctly?

=20

Rami,

Thanks for reply,

But if u study the kernel log I posted carefully, you can simply see =
that Kernel has mounted the root file system,=20
Look at this line in my prev post : VFS: Mounted root (nfs filesystem). =
then init has began and after that nothing more happens.=20

the NFS is working correctly and the folder can be mounted easily from =
other computers. I personally think that the problem can be with NFS or =
the root file system of ELDK.=20

I have done the same things with older versions of EDK using PLB_TEMAC =
and every thing has worked correctly.



________________________________

Subject: RE: XPS_LL_TEMAC works correctly?
Date: Mon, 14 Apr 2008 10:31:31 +0200
From: rwehbi@wirecom-tech.com
To: mamsadegh@hotmail.com

Hi,

=20

I would suggest that you verify that your system file is already mounted =
on the host PC (where your server NFS is installed), and that the =
/etc/exports file (configuration file of the nfs server) permit to your =
board to mount the system file.

=20

example of an /etc/exports file:

=20

/opt/ml403/rootfs

192.168.206.223/24(rw,no_root_squash,sync,subtree_check)

=20

where the ip addresse is that of nfs client, and the path indicates =
where I mounted the system file.

=20

Good luck,

=20

Rami

=20

________________________________

De : linuxppc-embedded-bounces+rami.wehbi=3Dwirecom-tech.com@ozlabs.org =
[mailto:linuxppc-embedded-bounces+rami.wehbi=3Dwirecom-tech.com@ozlabs.or=
g] De la part de Mohammad Sadegh Sadri
Envoy=E9 : lundi 14 avril 2008 10:16
=C0 : linuxppc-embedded@ozlabs.org
Objet : XPS_LL_TEMAC works correctly?

Hi all,

Using:=20
EDK 9.2.02,=20
Xilinx Linux 2.6.24-rc8-xlnx
XPS_LL_TEMAC version 1.00.b

I bring up the Linux kernel on ML403 -Rev04 board,
LL_TEMAC buffer size 128kbits, and set to use SG DMA

I encounter the following messages when the kernel wants to mount the =
root file system, as one can see the kernel has mounter the nfs root =
file system and init is initiated, but after that a Link carrier lost =
happens and it stops working.=20

is this behavior natural? ( the PC has attansic gigabit ethernet port =
with kernel 2.6.24.4 running, nfs works very well in other tests)

thanks

.............
eth0: XLlTemac: speed set to 1000Mb/s
eth0: XLlTemac: Send Threshold =3D 24, Receive Threshold =3D 4
eth0: XLlTemac: Send Wait bound =3D 254, Receive Wait bound =3D 254
IP-Config: Complete:
      device=3Deth0, addr=3D10.10.10.11, mask=3D255.255.255.0, =
gw=3D10.10.10.10,
     host=3D10.10.10.11, domain=3D, nis-domain=3D(none),
     bootserver=3D10.10.10.10, rootserver=3D10.10.10.10, rootpath=3D
Looking up port of RPC 100003/2 on 10.10.10.10
Looking up port of RPC 100005/1 on 10.10.10.10
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 88k init
eth0: XLlTemac: PHY Link carrier lost.
eth0: XLlTemac: speed set to 1000Mb/s
eth0: XLlTemac: PHY Link carrier restored.
( KERNEL STOPS WORKING HERE!!!!!!!!)




________________________________

Sign in today. When you sign in to Windows Live Messenger you could win =
$1000 a day until May 12th. Learn more at SignInAndWIN.ca =
<http://g.msn.ca/ca55/209> =20

=20

________________________________

Sign in now! Windows Live Messenger is giving you a chance to win $1000 =
a day until May 12th Check out SignInAndWIN.ca today! =
<http://g.msn.ca/ca55/214>=20


------_=_NextPart_001_01C89E46.2894B572
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
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
<![endif]--><o:SmartTagType
 namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags" =
name=3D"PlaceName"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PlaceType"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
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
	{font-family:Batang;
	panose-1:2 3 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@Batang";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
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
	{color:blue;
	text-decoration:underline;}
p
	{mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman";}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:.5in .5in .5in .5in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dblue>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>There are a couple of bugs in the =
v1.00b
version of xps_ll_temac (one in checksum offload, one in multicast =
address
reception). =A0You should try dropping back to v1.00a of the core and =
give that a
try, or if you have EDK 10.1 you can move to v1.01a of the =
core.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>-Rick<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div>

<div class=3DMsoNormal align=3Dcenter =
style=3D'margin-left:.5in;text-align:center'><font
size=3D3 face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><b><font size=3D2 =
face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma;font-weight:bold'>From:</spa=
n></font></b><font
size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;font-family:Tahoma'>
linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org] =
<b><span
style=3D'font-weight:bold'>On Behalf Of </span></b>Mohammad Sadegh =
Sadri<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Monday, April 14, =
2008 3:10 AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> Rami WEHBI;
linuxppc-embedded@ozlabs.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> RE: XPS_LL_TEMAC =
works
correctly?</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:0in;margin-right:0in;margin-bottom:
12.0pt;margin-left:.5in'><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma'>Rami,<br>
<br>
Thanks for reply,<br>
<br>
But if u study the kernel log I posted carefully, you can simply see =
that
Kernel has mounted the root file system, <br>
Look at this line in my prev post : VFS: Mounted root (nfs filesystem). =
then
init has began and after that nothing more happens. <br>
<br>
the NFS is working correctly and the folder can be mounted easily from =
other
computers. I personally think that the problem can be with NFS or the =
root file
system of ELDK. <br>
<br>
I have done the same things with older versions of EDK using PLB_TEMAC =
and
every thing has worked correctly.<br>
<br>
<o:p></o:p></span></font></p>

<div class=3DMsoNormal align=3Dcenter =
style=3D'margin-left:.5in;text-align:center'><font
size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;font-family:Tahoma'>

<hr size=3D2 width=3D"100%" align=3Dcenter>

</span></font></div>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:0in;margin-right:0in;margin-bottom:
12.0pt;margin-left:.5in'><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma'>Subject: RE: XPS_LL_TEMAC works correctly?<br>
Date: Mon, 14 Apr 2008 10:31:31 +0200<br>
From: rwehbi@wirecom-tech.com<br>
To: mamsadegh@hotmail.com<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><span =
class=3Dec768232108-14042008><font
size=3D2 color=3Dblue face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial;
color:blue'>Hi,</span></font></span><font size=3D2 face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma'><o:p></o:p></span></font></=
p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma'>&nbsp;<o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><span =
class=3Dec768232108-14042008><font
size=3D2 color=3Dblue face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial;
color:blue'>I would suggest that you verify that your system file is =
already mounted
on the host PC (where your server NFS is installed), and that the =
/etc/exports
file (configuration file of the nfs server) permit to your board to =
mount the
system file.</span></font></span><font size=3D2 face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma'><o:p></o:p></span></font></=
p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma'>&nbsp;<o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><span =
class=3Dec768232108-14042008><font
size=3D2 color=3Dblue face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial;
color:blue'>example of an /etc/exports file:</span></font></span><font =
size=3D2
face=3DTahoma><span =
style=3D'font-size:10.0pt;font-family:Tahoma'><o:p></o:p></span></font></=
p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma'>&nbsp;<o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma'>/opt/ml403/rootfs<o:p></o:p=
></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma'>192.168.206.223/24(rw,no_ro=
ot_squash,sync,subtree_check)<o:p></o:p></span></font></p>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma'>&nbsp;<o:p></o:p></span></f=
ont></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><span =
class=3Dec768232108-14042008><font
size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;font-family:Tahoma'>where the
ip addresse is that of nfs client, and the path indicates where I =
mounted the
system file.</span></font></span><font size=3D2 face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma'><o:p></o:p></span></font></=
p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma'>&nbsp;<o:p></o:p></span></f=
ont></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><span =
class=3Dec768232108-14042008><font
size=3D2 color=3Dblue face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial;
color:blue'>Good luck,</span></font></span><font size=3D2 =
face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma'><o:p></o:p></span></font></=
p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma'>&nbsp;<o:p></o:p></span></f=
ont></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><span =
class=3Dec768232108-14042008><font
size=3D2 color=3Dblue face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial;
color:blue'>Rami</span></font></span><font size=3D2 face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma'><o:p></o:p></span></font></=
p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma'><o:p>&nbsp;</o:p></span></f=
ont></p>

</div>

<div class=3DMsoNormal align=3Dcenter =
style=3D'margin-left:.5in;text-align:center'><font
size=3D2 face=3DTahoma><span lang=3DFR =
style=3D'font-size:10.0pt;font-family:Tahoma'>

<hr size=3D2 width=3D"100%" align=3Dcenter>

</span></font></div>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:0in;margin-right:0in;margin-bottom:
12.0pt;margin-left:.5in'><b><font size=3D2 face=3DTahoma><span lang=3DFR
style=3D'font-size:10.0pt;font-family:Tahoma;font-weight:bold'>De&nbsp;:<=
/span></font></b><font
size=3D2 face=3DTahoma><span lang=3DFR =
style=3D'font-size:10.0pt;font-family:Tahoma'>
linuxppc-embedded-bounces+rami.wehbi=3Dwirecom-tech.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+rami.wehbi=3Dwirecom-tech.com@ozlabs.or=
g] <b><span
style=3D'font-weight:bold'>De la part de</span></b> Mohammad Sadegh =
Sadri<br>
<b><span style=3D'font-weight:bold'>Envoy=E9&nbsp;:</span></b> lundi 14 =
avril 2008
10:16<br>
<b><span style=3D'font-weight:bold'>=C0&nbsp;:</span></b>
linuxppc-embedded@ozlabs.org<br>
<b><span style=3D'font-weight:bold'>Objet&nbsp;:</span></b> XPS_LL_TEMAC =
works
correctly?<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:0in;margin-right:0in;margin-bottom:
12.0pt;margin-left:.5in'><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma'>Hi all,<br>
<br>
Using: <br>
EDK 9.2.02, <br>
Xilinx Linux 2.6.24-rc8-xlnx<br>
XPS_LL_TEMAC version 1.00.b<br>
<br>
I bring up the Linux kernel on ML403 -Rev04 board,<br>
LL_TEMAC buffer size 128kbits, and set to use SG DMA<br>
<br>
I encounter the following messages when the kernel wants to mount the =
root file
system, as one can see the kernel has mounter the nfs root file system =
and init
is initiated, but after that a Link carrier lost happens and it stops =
working. <br>
<br>
is this behavior natural? ( the PC has attansic gigabit ethernet port =
with
kernel 2.6.24.4 running, nfs works very well in other tests)<br>
<br>
thanks<br>
<br>
.............<br>
eth0: XLlTemac: speed set to 1000Mb/s<br>
eth0: XLlTemac: Send Threshold =3D 24, Receive Threshold =3D 4<br>
eth0: XLlTemac: Send Wait bound =3D 254, Receive Wait bound =3D 254<br>
IP-Config: Complete:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=3Deth0, addr=3D10.10.10.11,
mask=3D255.255.255.0, gw=3D10.10.10.10,<br>
&nbsp;&nbsp;&nbsp;&nbsp; host=3D10.10.10.11, domain=3D, =
nis-domain=3D(none),<br>
&nbsp;&nbsp;&nbsp;&nbsp; bootserver=3D10.10.10.10, =
rootserver=3D10.10.10.10,
rootpath=3D<br>
Looking up <st1:place w:st=3D"on"><st1:PlaceType =
w:st=3D"on">port</st1:PlaceType>
 of <st1:PlaceName w:st=3D"on">RPC</st1:PlaceName></st1:place> 100003/2 =
on
10.10.10.10<br>
Looking up <st1:place w:st=3D"on"><st1:PlaceType =
w:st=3D"on">port</st1:PlaceType>
 of <st1:PlaceName w:st=3D"on">RPC</st1:PlaceName></st1:place> 100005/1 =
on
10.10.10.10<br>
VFS: Mounted root (nfs filesystem).<br>
Freeing unused kernel memory: 88k init<br>
eth0: XLlTemac: PHY Link carrier lost.<br>
eth0: XLlTemac: speed set to 1000Mb/s<br>
eth0: XLlTemac: PHY Link carrier restored.<br>
( KERNEL STOPS WORKING HERE!!!!!!!!)<br>
<br>
<br>
<o:p></o:p></span></font></p>

<div class=3DMsoNormal align=3Dcenter =
style=3D'margin-left:.5in;text-align:center'><font
size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;font-family:Tahoma'>

<hr size=3D2 width=3D"100%" align=3Dcenter>

</span></font></div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma'>Sign in today. When you =
sign in to
Windows Live Messenger you could win $1000 a day until May 12th. <a
href=3D"http://g.msn.ca/ca55/209" target=3D"_blank">Learn more at =
SignInAndWIN.ca</a>
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma'><o:p>&nbsp;</o:p></span></f=
ont></p>

<div class=3DMsoNormal align=3Dcenter =
style=3D'margin-left:.5in;text-align:center'><font
size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;font-family:Tahoma'>

<hr size=3D2 width=3D"100%" align=3Dcenter>

</span></font></div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma'>Sign in now! Windows Live =
Messenger
is giving you a chance to win $1000 a day until May 12th <a
href=3D"http://g.msn.ca/ca55/214" target=3D"_new">Check out =
SignInAndWIN.ca today!</a><o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C89E46.2894B572--
