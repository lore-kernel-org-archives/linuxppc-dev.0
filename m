Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound9-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1B5BADDD0A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Mar 2008 08:48:35 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C887AF.79506FAD"
Subject: RE: Compile time error, compiling Xilinx Linux 2.6 for XPS LLTEMAC
Date: Sun, 16 Mar 2008 14:43:33 -0700
References: <BAY115-W186EA84A950C17657AD8D9B20B0@phx.gbl>
	<EDAE140DF1B2FC42B5867C22CA0B333FA99D2F@XMBIL132.northgrum.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>,
	"Mohammad Sadegh Sadri" <mamsadegh@hotmail.com>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080316214832.3F77A538046@mail141-sin.bigfish.com>
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

------_=_NextPart_001_01C887AF.79506FAD
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Ah, thanks mike...  you knocked the answer loose out of my brain...

In EDK 9.2., the ll_temac generates either SDMA or FIFO defines, as =
necessary.
The platform data structure contains entries for both, with the correct =
ones being ignored.  In order to get the code to compile, there are some =
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

after including xparameter_ml403.h=20

I'm guessing maybe you overwrote the xparameters.h file and got rid of =
these redefines?  You can define it to be whatever you want, since the =
value will be ignored if you are using SDMA.

In EDK 10.1, the BSP generator will always generate all the defines =
(even ones which are not sensible in the current configuration), which =
avoids the above annoyances.

Steve

-----Original Message-----
From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org =
on behalf of Koss, Mike (Mission Systems)
Sent: Sat 3/15/2008 9:12 PM
To: Mohammad Sadegh Sadri; linuxppc-embedded@ozlabs.org
Subject: RE: Compile time error, compiling Xilinx Linux 2.6 for XPS =
LLTEMAC
=20
That interrupt is defined if you build a xps_ll_temac with the
xps_ll_fifo interface. Since you already stated that you're using the
mpmc, I'm going to assume that you have it connected to a SDMA
controller on the mpmc. As such the driver should be looking for that
definition, and not the FIFO interrupt. I don't have your version of the
virtex_devices.c to have a reference as to how the platform device is
being defined, so hopefully either Stephen N can chime in w/ more
information, or point me to the version of the virtex_devices.c that
you're using and I can try to provide some more assistance.
=20
-- Mike

________________________________

From: Mohammad Sadegh Sadri [mailto:mamsadegh@hotmail.com]=20
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
file but i see that there is no such definition.=20
I added a dummy definition for myself there to complete kernel
compilation, don't know the correct value for it of course.

thanks



________________________________

Access your files from anywhere with Windows Live SkyDrive! Sign up now
and get 5GB of space FREE! <http://g.msn.ca/ca55/209> =20


------_=_NextPart_001_01C887AF.79506FAD
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
<TITLE>RE: Compile time error, compiling Xilinx Linux 2.6 for XPS =
LLTEMAC</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Ah, thanks mike...&nbsp; you knocked the answer loose =
out of my brain...<BR>
<BR>
In EDK 9.2., the ll_temac generates either SDMA or FIFO defines, as =
necessary.<BR>
The platform data structure contains entries for both, with the correct =
ones being ignored.&nbsp; In order to get the code to compile, there are =
some defines in xparameters.h which have:<BR>
<BR>
#ifndef XPAR_LLTEMAC_0_LLINK_CONNECTED_FIFO_INTR<BR>
#define XPAR_LLTEMAC_0_LLINK_CONNECTED_FIFO_INTR 0xdeadbeef<BR>
#endif<BR>
#ifndef XPAR_LLTEMAC_0_LLINK_CONNECTED_DMATX_INTR<BR>
#define XPAR_LLTEMAC_0_LLINK_CONNECTED_DMATX_INTR 0xdeadbeef<BR>
#endif<BR>
#ifndef XPAR_LLTEMAC_0_LLINK_CONNECTED_DMARX_INTR<BR>
#define XPAR_LLTEMAC_0_LLINK_CONNECTED_DMARX_INTR 0xdeadbeef<BR>
#endif<BR>
<BR>
after including xparameter_ml403.h<BR>
<BR>
I'm guessing maybe you overwrote the xparameters.h file and got rid of =
these redefines?&nbsp; You can define it to be whatever you want, since =
the value will be ignored if you are using SDMA.<BR>
<BR>
In EDK 10.1, the BSP generator will always generate all the defines =
(even ones which are not sensible in the current configuration), which =
avoids the above annoyances.<BR>
<BR>
Steve<BR>
<BR>
-----Original Message-----<BR>
From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org =
on behalf of Koss, Mike (Mission Systems)<BR>
Sent: Sat 3/15/2008 9:12 PM<BR>
To: Mohammad Sadegh Sadri; linuxppc-embedded@ozlabs.org<BR>
Subject: RE: Compile time error, compiling Xilinx Linux 2.6 for XPS =
LLTEMAC<BR>
<BR>
That interrupt is defined if you build a xps_ll_temac with the<BR>
xps_ll_fifo interface. Since you already stated that you're using =
the<BR>
mpmc, I'm going to assume that you have it connected to a SDMA<BR>
controller on the mpmc. As such the driver should be looking for =
that<BR>
definition, and not the FIFO interrupt. I don't have your version of =
the<BR>
virtex_devices.c to have a reference as to how the platform device =
is<BR>
being defined, so hopefully either Stephen N can chime in w/ more<BR>
information, or point me to the version of the virtex_devices.c that<BR>
you're using and I can try to provide some more assistance.<BR>
<BR>
-- Mike<BR>
<BR>
________________________________<BR>
<BR>
From: Mohammad Sadegh Sadri [<A =
HREF=3D"mailto:mamsadegh@hotmail.com">mailto:mamsadegh@hotmail.com</A>]<B=
R>
Sent: Saturday, March 15, 2008 4:31 AM<BR>
To: linuxppc-embedded@ozlabs.org<BR>
Subject: Compile time error, compiling Xilinx Linux 2.6 for XPS =
LLTEMAC<BR>
<BR>
<BR>
All,<BR>
<BR>
that should be a small problem, and i think that its solution should =
be<BR>
simple,<BR>
<BR>
I generate a base system using EDK 9.2.02 , the base system contains<BR>
XPS_LL_TEMAC , MPMC and other components,<BR>
I generate the software libraries and copy xparameters file into =
proper<BR>
kernel folder. I configure that kernel and add kernel support for<BR>
XPS_LL_TEMAC.<BR>
<BR>
while doing make I encounter this error:<BR>
<BR>
arch/ppc/syslib/virtex_devices.c:455: error:<BR>
'XPAR_LLTEMAC_0_LLINK_CONNECTED_FIFO_INTR' undeclared here (not in a<BR>
function)<BR>
<BR>
I think that this definition should be available in =
xparameters_ml403.h<BR>
file but i see that there is no such definition.<BR>
I added a dummy definition for myself there to complete kernel<BR>
compilation, don't know the correct value for it of course.<BR>
<BR>
thanks<BR>
<BR>
<BR>
<BR>
________________________________<BR>
<BR>
Access your files from anywhere with Windows Live SkyDrive! Sign up =
now<BR>
and get 5GB of space FREE! &lt;<A =
HREF=3D"http://g.msn.ca/ca55/209">http://g.msn.ca/ca55/209</A>&gt;&nbsp;<=
BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C887AF.79506FAD--
