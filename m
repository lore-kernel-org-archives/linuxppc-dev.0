Return-Path: <Rick.Moleres@xilinx.com>
Received: from outbound8-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C255DDDE18
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Mar 2008 02:25:04 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C88842.F52FC976"
Subject: RE: Compile time error, compiling Xilinx Linux 2.6 for XPS LLTEMAC
Date: Mon, 17 Mar 2008 09:24:13 -0600
In-Reply-To: <BAY115-W53AE071415B85C1E71AAD1B2050@phx.gbl>
References: <BAY115-W186EA84A950C17657AD8D9B20B0@phx.gbl><EDAE140DF1B2FC42B5867C22CA0B333FA99D2F@XMBIL132.northgrum.com><20080316214832.3F77A538046@mail141-sin.bigfish.com>
	<BAY115-W53AE071415B85C1E71AAD1B2050@phx.gbl>
From: "Rick Moleres" <Rick.Moleres@xilinx.com>
To: "Mohammad Sadegh Sadri" <mamsadegh@hotmail.com>,
	"Stephen Neuendorffer" <stephenn@xilinx.com>,
	"Koss, Mike(Mission Systems)" <mike.koss@ngc.com>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080317152417.2A63F51805C@mail63-sin.bigfish.com>
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

------_=_NextPart_001_01C88842.F52FC976
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

You should be able to contact your Xilinx sales rep for details on
Virtex-5 FX as well as roadmap information.  The Virtex-5 FXT product is
coming soon and should be announced within the next month or so.  I
can't provide details, but your technical sales contact should be able
to give you more info on timelines etc...

=20

As for EDK releases, Xilinx typically releases two per year (e.g., EDK
9.1 and 9.2 were both released in 2007).  EDK 10.1 is scheduled for
release before summer, and should be the only release in 2008 (with some
service packs throughout the year).   There shouldn't be any major
differences from EDK 9.2.02 regarding IP/drivers.

=20

-Rick

=20

________________________________

From: linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org] On
Behalf Of Mohammad Sadegh Sadri
Sent: Monday, March 17, 2008 3:04 AM
To: Stephen Neuendorffer; Koss, Mike(Mission Systems);
linuxppc-embedded@ozlabs.org
Subject: RE: Compile time error, compiling Xilinx Linux 2.6 for XPS
LLTEMAC

=20

Ok, thanks for guidance,

by the way it is interesting for me to hear about EDK 10.1 from u steve,

EDK 9.2 has been around just for a little time and you are going to
10.1?

What about future plan of xilinx about Virtex-5 FX? does this tool
consider that?=20
the future plan is really important for our development team. let me
give a simple example, our dev team worked on the design of our system
based on PLB and OPB buses for some thing near 6 month, just then EDK
9.2.02 released and suddenly we forced to change all of the designs and
to define new activities specially focusing on MPMC. we did never
consider MPMC before, but the release of EDK 9.2 changed every thing.=20

Now, that would be nice, if we can know your future plan a little, that
would help us to generate correct and real gant charts. and to assign
human resources correctly. this is also true for the project budget. We
know that Virtex-5 devices are really capable of doing better things
than Virtex-4, specially the PCI express option is great and very usable
for us, but we have not moved to virtex-5 yet, because there is no FX
series or at least we do not know your plan about it. Our managers we
seriously asking us if we have to move to Virtex-5 soon, we did not have
any reasonable answer for them because we do not have any info from u at
all.

thanks

________________________________

Subject: RE: Compile time error, compiling Xilinx Linux 2.6 for XPS
LLTEMAC
Date: Sun, 16 Mar 2008 14:43:33 -0700
From: stephen.neuendorffer@xilinx.com
To: mike.koss@ngc.com; mamsadegh@hotmail.com;
linuxppc-embedded@ozlabs.org


Ah, thanks mike...  you knocked the answer loose out of my brain...

In EDK 9.2., the ll_temac generates either SDMA or FIFO defines, as
necessary.
The platform data structure contains entries for both, with the correct
ones being ignored.  In order to get the code to compile, there are some
defines in xparameters.h which have:

#ifndef XPAR_LLTEMAC_0_LLINK_CONNECTED_FIFO_INTR
#define XPAR_LLTEMAC_0_LLINK_CONNECTED_FIFO_INTR 0xdeadbeef
#endif
#ifndef XPAR_LLTEMAC_0_LLINK_CONNECTED_DMATX_INTR
#define XPAR_LLTEMAC_0_LLINK_CONNECTED_DMATX_INTR 0xdeadbeef
#endif
#ifndef XPAR_LLTEMAC_0_LLINK_CONNECTED_DMARX_INTR
#define XPAR_LLTEMAC_0_LLINK_CONNECTED_DMARX_INTR 0xdeadbeef
#endif

after including xparameter_ml403.h

I'm guessing maybe you overwrote the xparameters.h file and got rid of
these redefines?  You can define it to be whatever you want, since the
value will be ignored if you are using SDMA.

In EDK 10.1, the BSP generator will always generate all the defines
(even ones which are not sensible in the current configuration), which
avoids the above annoyances.

Steve

-----Original Message-----
From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org =
on
behalf of Koss, Mike (Mission Systems)
Sent: Sat 3/15/2008 9:12 PM
To: Mohammad Sadegh Sadri; linuxppc-embedded@ozlabs.org
Subject: RE: Compile time error, compiling Xilinx Linux 2.6 for XPS
LLTEMAC

That interrupt is defined if you build a xps_ll_temac with the
xps_ll_fifo interface. Since you already stated that you're using the
mpmc, I'm going to assume that you have it connected to a SDMA
controller on the mpmc. As such the driver should be looking for that
definition, and not the FIFO interrupt. I don't have your version of the
virtex_devices.c to have a reference as to how the platform device is
being defined, so hopefully either Stephen N can chime in w/ more
information, or point me to the version of the virtex_devices.c that
you're using and I can try to provide some more assistance.

-- Mike

________________________________

From: Mohammad Sadegh Sadri [mailto:mamsadegh@hotmail.com]
Sent: Saturday, March 15, 2008 4:31 AM
To: linuxppc-embedded@ozlabs.org
Subject: Compile time error, compiling Xilinx Linux 2.6 for XPS LLTEMAC


All,

that should be a small problem, and i think that its solution should be
simple,

I generate a base system using EDK 9.2.02 , the base system contains
XPS_LL_TEMAC , MPMC and other components,
I generate the software libraries and copy xparameters file into proper
kernel folder. I configure that kernel and add kernel support for
XPS_LL_TEMAC.

while doing make I encounter this error:

arch/ppc/syslib/virtex_devices.c:455: error:
'XPAR_LLTEMAC_0_LLINK_CONNECTED_FIFO_INTR' undeclared here (not in a
function)

I think that this definition should be available in xparameters_ml403.h
file but i see that there is no such definition.
I added a dummy definition for myself there to complete kernel
compilation, don't know the correct value for it of course.

thanks



________________________________

Access your files from anywhere with Windows Live SkyDrive! Sign up now
and get 5GB of space FREE! <http://g.msn.ca/ca55/209>=20



=20

________________________________

Is your lingo strong enough to ace these new word puzzles from Live
Search Games? Click here to test your vocab! <http://g.msn.ca/ca55/214>=20


------_=_NextPart_001_01C88842.F52FC976
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<title>RE: Compile time error, compiling Xilinx Linux 2.6 for XPS =
LLTEMAC</title>
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
span.EmailStyle18
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
10.0pt;font-family:Arial;color:navy'>You should be able to contact your =
Xilinx
sales rep for details on Virtex-5 FX as well as roadmap information. =
&nbsp;The
Virtex-5 FXT product is coming soon and should be announced within the =
next
month or so. &nbsp;I can&#8217;t provide details, but your technical =
sales
contact should be able to give you more info on timelines =
etc&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>As for EDK releases, Xilinx =
typically
releases two per year (e.g., EDK 9.1 and 9.2 were both released in =
2007). &nbsp;EDK
10.1 is scheduled for release before summer, and should be the only =
release in
2008 (with some service packs throughout the year).&nbsp; &nbsp;There =
shouldn&#8217;t
be any major differences from EDK 9.2.02 regarding =
IP/drivers.<o:p></o:p></span></font></p>

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
<b><span style=3D'font-weight:bold'>Sent:</span></b> Monday, March 17, =
2008 3:04
AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> Stephen Neuendorffer; =
Koss,
Mike(Mission Systems); linuxppc-embedded@ozlabs.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> RE: Compile time =
error,
compiling Xilinx Linux 2.6 for XPS LLTEMAC</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:0in;margin-right:0in;margin-bottom:
12.0pt;margin-left:.5in'><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma'>Ok, thanks for guidance,<br>
<br>
by the way it is interesting for me to hear about EDK 10.1 from u steve, =
<br>
EDK 9.2 has been around just for a little time and you are going to =
10.1?<br>
<br>
What about future plan of xilinx about Virtex-5 FX? does this tool =
consider
that? <br>
the future plan is really important for our development team. let me =
give a
simple example, our dev team worked on the design of our system based on =
PLB
and OPB buses for some thing near 6 month, just then EDK 9.2.02 released =
and
suddenly we forced to change all of the designs and to define new =
activities
specially focusing on MPMC. we did never consider MPMC before, but the =
release
of EDK 9.2 changed every thing. <br>
<br>
Now, that would be nice, if we can know your future plan a little, that =
would
help us to generate correct and real gant charts. and to assign human =
resources
correctly. this is also true for the project budget. We know that =
Virtex-5
devices are really capable of doing better things than Virtex-4, =
specially the
PCI express option is great and very usable for us, but we have not =
moved to
virtex-5 yet, because there is no FX series or at least we do not know =
your
plan about it. Our managers we seriously asking us if we have to move to
Virtex-5 soon, we did not have any reasonable answer for them because we =
do not
have any info from u at all.<br>
<br>
thanks<o:p></o:p></span></font></p>

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
font-family:Tahoma'>Subject: RE: Compile time error, compiling Xilinx =
Linux 2.6
for XPS LLTEMAC<br>
Date: Sun, 16 Mar 2008 14:43:33 -0700<br>
From: stephen.neuendorffer@xilinx.com<br>
To: mike.koss@ngc.com; mamsadegh@hotmail.com; =
linuxppc-embedded@ozlabs.org<br>
<br>
<br>
Ah, thanks mike...&nbsp; you knocked the answer loose out of my =
brain...<br>
<br>
In EDK 9.2., the ll_temac generates either SDMA or FIFO defines, as =
necessary.<br>
The platform data structure contains entries for both, with the correct =
ones being
ignored.&nbsp; In order to get the code to compile, there are some =
defines in
xparameters.h which have:<br>
<br>
#ifndef XPAR_LLTEMAC_0_LLINK_CONNECTED_FIFO_INTR<br>
#define XPAR_LLTEMAC_0_LLINK_CONNECTED_FIFO_INTR 0xdeadbeef<br>
#endif<br>
#ifndef XPAR_LLTEMAC_0_LLINK_CONNECTED_DMATX_INTR<br>
#define XPAR_LLTEMAC_0_LLINK_CONNECTED_DMATX_INTR 0xdeadbeef<br>
#endif<br>
#ifndef XPAR_LLTEMAC_0_LLINK_CONNECTED_DMARX_INTR<br>
#define XPAR_LLTEMAC_0_LLINK_CONNECTED_DMARX_INTR 0xdeadbeef<br>
#endif<br>
<br>
after including xparameter_ml403.h<br>
<br>
I'm guessing maybe you overwrote the xparameters.h file and got rid of =
these
redefines?&nbsp; You can define it to be whatever you want, since the =
value
will be ignored if you are using SDMA.<br>
<br>
In EDK 10.1, the BSP generator will always generate all the defines =
(even ones
which are not sensible in the current configuration), which avoids the =
above
annoyances.<br>
<br>
Steve<br>
<br>
-----Original Message-----<br>
From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org =
on behalf
of Koss, Mike (Mission Systems)<br>
Sent: Sat 3/15/2008 9:12 PM<br>
To: Mohammad Sadegh Sadri; linuxppc-embedded@ozlabs.org<br>
Subject: RE: Compile time error, compiling Xilinx Linux 2.6 for XPS =
LLTEMAC<br>
<br>
That interrupt is defined if you build a xps_ll_temac with the<br>
xps_ll_fifo interface. Since you already stated that you're using =
the<br>
mpmc, I'm going to assume that you have it connected to a SDMA<br>
controller on the mpmc. As such the driver should be looking for =
that<br>
definition, and not the FIFO interrupt. I don't have your version of =
the<br>
virtex_devices.c to have a reference as to how the platform device =
is<br>
being defined, so hopefully either Stephen N can chime in w/ more<br>
information, or point me to the version of the virtex_devices.c that<br>
you're using and I can try to provide some more assistance.<br>
<br>
-- Mike<br>
<br>
________________________________<br>
<br>
From: Mohammad Sadegh Sadri [<a =
href=3D"mailto:mamsadegh@hotmail.com">mailto:mamsadegh@hotmail.com</a>]<b=
r>
Sent: Saturday, March 15, 2008 4:31 AM<br>
To: linuxppc-embedded@ozlabs.org<br>
Subject: Compile time error, compiling Xilinx Linux 2.6 for XPS =
LLTEMAC<br>
<br>
<br>
All,<br>
<br>
that should be a small problem, and i think that its solution should =
be<br>
simple,<br>
<br>
I generate a base system using EDK 9.2.02 , the base system contains<br>
XPS_LL_TEMAC , MPMC and other components,<br>
I generate the software libraries and copy xparameters file into =
proper<br>
kernel folder. I configure that kernel and add kernel support for<br>
XPS_LL_TEMAC.<br>
<br>
while doing make I encounter this error:<br>
<br>
arch/ppc/syslib/virtex_devices.c:455: error:<br>
'XPAR_LLTEMAC_0_LLINK_CONNECTED_FIFO_INTR' undeclared here (not in a<br>
function)<br>
<br>
I think that this definition should be available in =
xparameters_ml403.h<br>
file but i see that there is no such definition.<br>
I added a dummy definition for myself there to complete kernel<br>
compilation, don't know the correct value for it of course.<br>
<br>
thanks<br>
<br>
<br>
<br>
________________________________<br>
<br>
Access your files from anywhere with Windows Live SkyDrive! Sign up =
now<br>
and get 5GB of space FREE! &lt;<a href=3D"http://g.msn.ca/ca55/209"
target=3D"_blank">http://g.msn.ca/ca55/209</a>&gt;&nbsp;<br>
<br>
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
style=3D'font-size:10.0pt;font-family:Tahoma'>Is your lingo strong =
enough to ace
these new word puzzles from Live Search Games? <a
href=3D"http://g.msn.ca/ca55/214" target=3D"_new">Click here to test =
your vocab!</a><o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C88842.F52FC976--
