Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound6-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C73ACDDF5B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Mar 2008 02:51:59 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Compile time error, compiling Xilinx Linux 2.6 for XPS LLTEMAC
Date: Mon, 17 Mar 2008 08:49:54 -0700
In-Reply-To: <BAY115-W53AE071415B85C1E71AAD1B2050@phx.gbl>
References: <BAY115-W186EA84A950C17657AD8D9B20B0@phx.gbl>
	<EDAE140DF1B2FC42B5867C22CA0B333FA99D2F@XMBIL132.northgrum.com>
	<20080316214832.3F77A538046@mail141-sin.bigfish.com>
	<BAY115-W53AE071415B85C1E71AAD1B2050@phx.gbl>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Mohammad Sadegh Sadri" <mamsadegh@hotmail.com>,
	"Koss, Mike (Mission Systems)" <mike.koss@ngc.com>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080317154957.9DA1DC98084@mail21-dub.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Sorry, but I'm not in a position to discuss product roadmaps.  The kinds
of technical questions are best handled by regular sales channels.

Steve

> -----Original Message-----
> From: Mohammad Sadegh Sadri [mailto:mamsadegh@hotmail.com]
> Sent: Monday, March 17, 2008 2:04 AM
> To: Stephen Neuendorffer; Koss, Mike (Mission Systems);
linuxppc-embedded@ozlabs.org
> Subject: RE: Compile time error, compiling Xilinx Linux 2.6 for XPS
LLTEMAC
>=20
> Ok, thanks for guidance,
>=20
> by the way it is interesting for me to hear about EDK 10.1 from u
steve,
> EDK 9.2 has been around just for a little time and you are going to
10.1?
>=20
> What about future plan of xilinx about Virtex-5 FX? does this tool
consider that?
> the future plan is really important for our development team. let me
give a simple example, our dev
> team worked on the design of our system based on PLB and OPB buses for
some thing near 6 month, just
> then EDK 9.2.02 released and suddenly we forced to change all of the
designs and to define new
> activities specially focusing on MPMC. we did never consider MPMC
before, but the release of EDK 9.2
> changed every thing.
>=20
> Now, that would be nice, if we can know your future plan a little,
that would help us to generate
> correct and real gant charts. and to assign human resources correctly.
this is also true for the
> project budget. We know that Virtex-5 devices are really capable of
doing better things than Virtex-
> 4, specially the PCI express option is great and very usable for us,
but we have not moved to virtex-
> 5 yet, because there is no FX series or at least we do not know your
plan about it. Our managers we
> seriously asking us if we have to move to Virtex-5 soon, we did not
have any reasonable answer for
> them because we do not have any info from u at all.
>=20
> thanks
>=20
>=20
>=20
> ________________________________
>=20
> 	Subject: RE: Compile time error, compiling Xilinx Linux 2.6 for
XPS LLTEMAC
> 	Date: Sun, 16 Mar 2008 14:43:33 -0700
> 	From: stephen.neuendorffer@xilinx.com
> 	To: mike.koss@ngc.com; mamsadegh@hotmail.com;
linuxppc-embedded@ozlabs.org
>=20
>=20
>=20
> 	Ah, thanks mike...  you knocked the answer loose out of my
brain...
>=20
> 	In EDK 9.2., the ll_temac generates either SDMA or FIFO defines,
as necessary.
> 	The platform data structure contains entries for both, with the
correct ones being ignored.  In
> order to get the code to compile, there are some defines in
xparameters.h which have:
>=20
> 	#ifndef XPAR_LLTEMAC_0_LLINK_CONNECTED_FIFO_INTR
> 	#define XPAR_LLTEMAC_0_LLINK_CONNECTED_FIFO_INTR 0xdeadbeef
> 	#endif
> 	#ifndef XPAR_LLTEMAC_0_LLINK_CONNECTED_DMATX_INTR
> 	#define XPAR_LLTEMAC_0_LLINK_CONNECTED_DMATX_INTR 0xdeadbeef
> 	#endif
> 	#ifndef XPAR_LLTEMAC_0_LLINK_CONNECTED_DMARX_INTR
> 	#define XPAR_LLTEMAC_0_LLINK_CONNECTED_DMARX_INTR 0xdeadbeef
> 	#endif
>=20
> 	after including xparameter_ml403.h
>=20
> 	I'm guessing maybe you overwrote the xparameters.h file and got
rid of these redefines?  You
> can define it to be whatever you want, since the value will be ignored
if you are using SDMA.
>=20
> 	In EDK 10.1, the BSP generator will always generate all the
defines (even ones which are not
> sensible in the current configuration), which avoids the above
annoyances.
>=20
> 	Steve
>=20
> 	-----Original Message-----
> 	From:
linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org on =
behalf
of Koss, Mike
> (Mission Systems)
> 	Sent: Sat 3/15/2008 9:12 PM
> 	To: Mohammad Sadegh Sadri; linuxppc-embedded@ozlabs.org
> 	Subject: RE: Compile time error, compiling Xilinx Linux 2.6 for
XPS LLTEMAC
>=20
> 	That interrupt is defined if you build a xps_ll_temac with the
> 	xps_ll_fifo interface. Since you already stated that you're
using the
> 	mpmc, I'm going to assume that you have it connected to a SDMA
> 	controller on the mpmc. As such the driver should be looking for
that
> 	definition, and not the FIFO interrupt. I don't have your
version of the
> 	virtex_devices.c to have a reference as to how the platform
device is
> 	being defined, so hopefully either Stephen N can chime in w/
more
> 	information, or point me to the version of the virtex_devices.c
that
> 	you're using and I can try to provide some more assistance.
>=20
> 	-- Mike
>=20
> 	________________________________
>=20
> 	From: Mohammad Sadegh Sadri [mailto:mamsadegh@hotmail.com]
> 	Sent: Saturday, March 15, 2008 4:31 AM
> 	To: linuxppc-embedded@ozlabs.org
> 	Subject: Compile time error, compiling Xilinx Linux 2.6 for XPS
LLTEMAC
>=20
>=20
> 	All,
>=20
> 	that should be a small problem, and i think that its solution
should be
> 	simple,
>=20
> 	I generate a base system using EDK 9.2.02 , the base system
contains
> 	XPS_LL_TEMAC , MPMC and other components,
> 	I generate the software libraries and copy xparameters file into
proper
> 	kernel folder. I configure that kernel and add kernel support
for
> 	XPS_LL_TEMAC.
>=20
> 	while doing make I encounter this error:
>=20
> 	arch/ppc/syslib/virtex_devices.c:455: error:
> 	'XPAR_LLTEMAC_0_LLINK_CONNECTED_FIFO_INTR' undeclared here (not
in a
> 	function)
>=20
> 	I think that this definition should be available in
xparameters_ml403.h
> 	file but i see that there is no such definition.
> 	I added a dummy definition for myself there to complete kernel
> 	compilation, don't know the correct value for it of course.
>=20
> 	thanks
>=20
>=20
>=20
> 	________________________________
>=20
> 	Access your files from anywhere with Windows Live SkyDrive! Sign
up now
> 	and get 5GB of space FREE! <http://g.msn.ca/ca55/209>
>=20
>=20
>=20
>=20
>=20
> ________________________________
>=20
> Is your lingo strong enough to ace these new word puzzles from Live
Search Games? Click here to test
> your vocab! <http://g.msn.ca/ca55/214>
