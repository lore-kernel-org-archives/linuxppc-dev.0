Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc1-s2.bay0.hotmail.com (bay0-omc1-s2.bay0.hotmail.com
	[65.54.246.74]) by ozlabs.org (Postfix) with ESMTP id 94771DDE20
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Mar 2008 20:03:59 +1100 (EST)
Message-ID: <BAY115-W53AE071415B85C1E71AAD1B2050@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_382475b5-fb75-4b43-a89e-386cc88ffaa2_"
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>, "Koss, Mike
	(Mission Systems)" <mike.koss@ngc.com>, <linuxppc-embedded@ozlabs.org>
Subject: RE: Compile time error, compiling Xilinx Linux 2.6 for XPS LLTEMAC
Date: Mon, 17 Mar 2008 09:03:58 +0000
In-Reply-To: <20080316214832.3F77A538046@mail141-sin.bigfish.com>
References: <BAY115-W186EA84A950C17657AD8D9B20B0@phx.gbl>
	<EDAE140DF1B2FC42B5867C22CA0B333FA99D2F@XMBIL132.northgrum.com>
	<20080316214832.3F77A538046@mail141-sin.bigfish.com>
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--_382475b5-fb75-4b43-a89e-386cc88ffaa2_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Ok, thanks for guidance,

by the way it is interesting for me to hear about EDK 10.1 from u steve,=20
EDK 9.2 has been around just for a little time and you are going to 10.1?

What about future plan of xilinx about Virtex-5 FX? does this tool consider=
 that?=20
the future plan is really important for our development team. let me give a=
 simple example, our dev team worked on the design of our system based on P=
LB and OPB buses for some thing near 6 month, just then EDK 9.2.02 released=
 and suddenly we forced to change all of the designs and to define new acti=
vities specially focusing on MPMC. we did never consider MPMC before, but t=
he release of EDK 9.2 changed every thing.=20

Now, that would be nice, if we can know your future plan a little, that wou=
ld help us to generate correct and real gant charts. and to assign human re=
sources correctly. this is also true for the project budget. We know that V=
irtex-5 devices are really capable of doing better things than Virtex-4, sp=
ecially the PCI express option is great and very usable for us, but we have=
 not moved to virtex-5 yet, because there is no FX series or at least we do=
 not know your plan about it. Our managers we seriously asking us if we hav=
e to move to Virtex-5 soon, we did not have any reasonable answer for them =
because we do not have any info from u at all.

thanks

Subject: RE: Compile time error, compiling Xilinx Linux 2.6 for XPS LLTEMAC
Date: Sun, 16 Mar 2008 14:43:33 -0700
From: stephen.neuendorffer@xilinx.com
To: mike.koss@ngc.com; mamsadegh@hotmail.com; linuxppc-embedded@ozlabs.org





RE: Compile time error, compiling Xilinx Linux 2.6 for XPS LLTEMAC









Ah, thanks mike...  you knocked the answer loose out of my brain...



In EDK 9.2., the ll_temac generates either SDMA or FIFO defines, as necessa=
ry.

The platform data structure contains entries for both, with the correct one=
s being ignored.  In order to get the code to compile, there are some defin=
es in xparameters.h which have:



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



I'm guessing maybe you overwrote the xparameters.h file and got rid of thes=
e redefines?  You can define it to be whatever you want, since the value wi=
ll be ignored if you are using SDMA.



In EDK 10.1, the BSP generator will always generate all the defines (even o=
nes which are not sensible in the current configuration), which avoids the =
above annoyances.



Steve



-----Original Message-----

From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org on b=
ehalf of Koss, Mike (Mission Systems)

Sent: Sat 3/15/2008 9:12 PM

To: Mohammad Sadegh Sadri; linuxppc-embedded@ozlabs.org

Subject: RE: Compile time error, compiling Xilinx Linux 2.6 for XPS LLTEMAC



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








_________________________________________________________________
Like solving puzzles? Then you'll love Flexicon! Play now!
http://g.msn.ca/ca55/213=

--_382475b5-fb75-4b43-a89e-386cc88ffaa2_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'>
Ok, thanks for guidance,<br><br>by the way it is interesting for me to hear=
 about EDK 10.1 from u steve, <br>EDK 9.2 has been around just for a little=
 time and you are going to 10.1?<br><br>What about future plan of xilinx ab=
out Virtex-5 FX? does this tool consider that? <br>the future plan is reall=
y important for our development team. let me give a simple example, our dev=
 team worked on the design of our system based on PLB and OPB buses for som=
e thing near 6 month, just then EDK 9.2.02 released and suddenly we forced =
to change all of the designs and to define new activities specially focusin=
g on MPMC. we did never consider MPMC before, but the release of EDK 9.2 ch=
anged every thing. <br><br>Now, that would be nice, if we can know your fut=
ure plan a little, that would help us to generate correct and real gant cha=
rts. and to assign human resources correctly. this is also true for the pro=
ject budget. We know that Virtex-5 devices are really capable of doing bett=
er things than Virtex-4, specially the PCI express option is great and very=
 usable for us, but we have not moved to virtex-5 yet, because there is no =
FX series or at least we do not know your plan about it. Our managers we se=
riously asking us if we have to move to Virtex-5 soon, we did not have any =
reasonable answer for them because we do not have any info from u at all.<b=
r><br>thanks<br><br><blockquote><hr>Subject: RE: Compile time error, compil=
ing Xilinx Linux 2.6 for XPS LLTEMAC<br>Date: Sun, 16 Mar 2008 14:43:33 -07=
00<br>From: stephen.neuendorffer@xilinx.com<br>To: mike.koss@ngc.com; mamsa=
degh@hotmail.com; linuxppc-embedded@ozlabs.org<br><br>


<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dunicode">
<meta name=3D"Generator" content=3D"Microsoft SafeHTML"><title>RE: Compile =
time error, compiling Xilinx Linux 2.6 for XPS LLTEMAC</title>






<br>

<font size=3D"2">Ah, thanks mike...&nbsp; you knocked the answer loose out =
of my brain...<br>
<br>
In EDK 9.2., the ll_temac generates either SDMA or FIFO defines, as necessa=
ry.<br>
The platform data structure contains entries for both, with the correct one=
s being ignored.&nbsp; In order to get the code to compile, there are some =
defines in xparameters.h which have:<br>
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
I'm guessing maybe you overwrote the xparameters.h file and got rid of thes=
e redefines?&nbsp; You can define it to be whatever you want, since the val=
ue will be ignored if you are using SDMA.<br>
<br>
In EDK 10.1, the BSP generator will always generate all the defines (even o=
nes which are not sensible in the current configuration), which avoids the =
above annoyances.<br>
<br>
Steve<br>
<br>
-----Original Message-----<br>
From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org on b=
ehalf of Koss, Mike (Mission Systems)<br>
Sent: Sat 3/15/2008 9:12 PM<br>
To: Mohammad Sadegh Sadri; linuxppc-embedded@ozlabs.org<br>
Subject: RE: Compile time error, compiling Xilinx Linux 2.6 for XPS LLTEMAC=
<br>
<br>
That interrupt is defined if you build a xps_ll_temac with the<br>
xps_ll_fifo interface. Since you already stated that you're using the<br>
mpmc, I'm going to assume that you have it connected to a SDMA<br>
controller on the mpmc. As such the driver should be looking for that<br>
definition, and not the FIFO interrupt. I don't have your version of the<br=
>
virtex_devices.c to have a reference as to how the platform device is<br>
being defined, so hopefully either Stephen N can chime in w/ more<br>
information, or point me to the version of the virtex_devices.c that<br>
you're using and I can try to provide some more assistance.<br>
<br>
-- Mike<br>
<br>
________________________________<br>
<br>
From: Mohammad Sadegh Sadri [<a href=3D"mailto:mamsadegh@hotmail.com">mailt=
o:mamsadegh@hotmail.com</a>]<br>
Sent: Saturday, March 15, 2008 4:31 AM<br>
To: linuxppc-embedded@ozlabs.org<br>
Subject: Compile time error, compiling Xilinx Linux 2.6 for XPS LLTEMAC<br>
<br>
<br>
All,<br>
<br>
that should be a small problem, and i think that its solution should be<br>
simple,<br>
<br>
I generate a base system using EDK 9.2.02 , the base system contains<br>
XPS_LL_TEMAC , MPMC and other components,<br>
I generate the software libraries and copy xparameters file into proper<br>
kernel folder. I configure that kernel and add kernel support for<br>
XPS_LL_TEMAC.<br>
<br>
while doing make I encounter this error:<br>
<br>
arch/ppc/syslib/virtex_devices.c:455: error:<br>
'XPAR_LLTEMAC_0_LLINK_CONNECTED_FIFO_INTR' undeclared here (not in a<br>
function)<br>
<br>
I think that this definition should be available in xparameters_ml403.h<br>
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
Access your files from anywhere with Windows Live SkyDrive! Sign up now<br>
and get 5GB of space FREE! &lt;<a href=3D"http://g.msn.ca/ca55/209" target=
=3D"_blank">http://g.msn.ca/ca55/209</a>&gt;&nbsp;<br>
<br>
</font>
<BR>


</blockquote><br /><hr />Is your lingo strong enough to ace these new word =
puzzles from Live Search Games?  <a href=3D'http://g.msn.ca/ca55/214' targe=
t=3D'_new'>Click here to test your vocab!</a></body>
</html>=

--_382475b5-fb75-4b43-a89e-386cc88ffaa2_--
