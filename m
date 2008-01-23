Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D3E9FDDE2A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Jan 2008 06:36:01 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Xilinx XPS_LL_TEMAC vs PLB_TEMAC
Date: Wed, 23 Jan 2008 11:35:58 -0800
In-Reply-To: <BAY115-W393608FBCB3E1070428538B23F0@phx.gbl>
References: <BAY115-W17ECE16AB6FA79B2D4DBBDB23D0@phx.gbl><440abda90801202354l5a0ce4caq382af5991e36f775@mail.gmail.com><BAY115-W344A18C61627B3075C6281B23D0@phx.gbl><EDAE140DF1B2FC42B5867C22CA0B333F0A5952@XMBIL132.northgrum.com><BAY115-W415137ADEA0BE4A33D2BAEB23F0@phx.gbl><EDAE140DF1B2FC42B5867C22CA0B333F0A5959@XMBIL132.northgrum.com>
	<BAY115-W393608FBCB3E1070428538B23F0@phx.gbl>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Mohammad Sadegh Sadri" <mamsadegh@hotmail.com>,
	"Koss, Mike (Mission Systems)" <mike.koss@ngc.com>,
	"David Baird" <dhbaird@gmail.com>, <linuxppc-embedded@ozlabs.org>
Message-Id: <20080123193557.AF0C8670018@mail194-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


The LL_TEMAC can be connected in two topologies.  One connects the
locallink directly to the SDMA port of the MPMC3.  The other topology
connects to a PLB46 bus using an XPS_LL_FIFO, which (most likely)
connects to the plb bus port of the mpmc.  The easiest way to decipher
the connection pattern is to use Base System Builder in EDK to generate
both topologies (which is determined by the 'use DMA' parameter when
selecting the LL_TEMAC device.  The Linux driver in git.xilinx.com
supports both topologies.

Steve

> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of Mohammad
Sadegh Sadri
> Sent: Wednesday, January 23, 2008 7:13 AM
> To: Koss, Mike (Mission Systems); David Baird;
linuxppc-embedded@ozlabs.org
> Subject: RE: Xilinx XPS_LL_TEMAC vs PLB_TEMAC
>=20
> So, in this case, our base system, created with EDK 9.2 will not be
the same as previous systems, as
> shown in
> http://www.xilinx.com/esp/wired/optical/xlnx_net/mpmc.htm
> PLB and OPB usage is limited to a small area of design...
>=20
>=20
>=20
> ________________________________
>=20
> 	Subject: RE: Xilinx XPS_LL_TEMAC vs PLB_TEMAC
> 	Date: Wed, 23 Jan 2008 07:43:14 -0600
> 	From: mike.koss@ngc.com
> 	To: mamsadegh@hotmail.com; dhbaird@gmail.com;
linuxppc-embedded@ozlabs.org
>=20
>=20
> 	Actually, with the MPMC3 the XPS_LL_TEMAC still can directly
connect to the MPMC. You set one
> of the ports' type to SDMA and it instantiates what is similar to the
old CDMAC.
>=20
> ________________________________
>=20
> 	From: Mohammad Sadegh Sadri [mailto:mamsadegh@hotmail.com]
> 	Sent: Wednesday, January 23, 2008 2:36 AM
> 	To: Koss, Mike (Mission Systems); David Baird;
linuxppc-embedded@ozlabs.org
> 	Subject: RE: Xilinx XPS_LL_TEMAC vs PLB_TEMAC
>=20
>=20
> 	Hi
>=20
> 	Well, As you know, we now need a PLB version, XPS_LL_TEMAC is
connected to PLB not MPMC2...yes
> I remember those days of Xilinx GSRD and MPMC2 however it seems that
the current architecture has
> slight changes.
>=20
> 	about the git repository of Xilinx, Although I do not believe on
it, I'll give it a
> try...thanks for info.
>=20
> 	well, what about Grant Likely... and his git tree?
>=20
>=20
>=20
> ________________________________
>=20
> 		Subject: RE: Xilinx XPS_LL_TEMAC vs PLB_TEMAC
> 		Date: Mon, 21 Jan 2008 11:44:14 -0600
> 		From: mike.koss@ngc.com
> 		To: mamsadegh@hotmail.com; dhbaird@gmail.com;
linuxppc-embedded@ozlabs.org
>=20
>=20
> 		In case anyone is interested, I'm currently working on
an almost-kernel-ready version
> that will be self-contained based on the LL-DMA version (the native
MPMC port, not the PLB). It's
> based upon the old adapter from MontaVista, that I originally ported
to 2.6 and the MPMC2.
> Unfortunately, it won't be ready for another few weeks since I'm
working on hardware images
> currently.
>=20
> 		-- Mike
>=20
>=20
> ________________________________
>=20
> 		From: Mohammad Sadegh Sadri
[mailto:mamsadegh@hotmail.com]
> 		Sent: Monday, January 21, 2008 3:54 AM
> 		To: David Baird; linuxppc-embedded@ozlabs.org
> 		Subject: RE: Xilinx XPS_LL_TEMAC vs PLB_TEMAC
>=20
>=20
> 		thanks for you reply david,
>=20
> 		As far as I know the Linux driver for Xilinx PLB TEMAC
was two parts : 1- adapter.c and
> 2- the rest of the driver files
>=20
> 		Only adapter.c was really a linux related file and the
rest of the files were Xilinx
> generic driver code for PLB TEMAC.
>=20
> 		correct?
>=20
> 		then now, I know EDK 9.2 generates the needed Linux
support package and needed related
> files, so if this is the case can we use these files as the needed
driver in our linux kernel?
>=20
> 		by the way, i did never hear about this git repository
before...can you describe us,
> where is it and how we can access it and which projects are now hosted
by it?
>=20
>=20
> 		thanks
>=20
>=20
> 		> Date: Mon, 21 Jan 2008 00:54:30 -0700
> 		> From: dhbaird@gmail.com
> 		> To: mamsadegh@hotmail.com
> 		> Subject: Re: Xilinx XPS_LL_TEMAC vs PLB_TEMAC
> 		>
> 		> On Jan 21, 2008 12:36 AM, Mohammad Sadegh Sadri
<mamsadegh@hotmail.com> wrote:
> 		> > As you know Xilinx PLB TEMAC is a module which
connects Hard TEMAC in
> 		> > Virtex-4 FX devices to PLB bus,
> 		> > now, in the new release of EDK , EDK 9.2 Xilinx has
added a new interface
> 		> > core , which is called XPS_LL_TEMAC and has a
different structure than
> 		> > normal PLB TEMAC. spacially it has some additional
data transfer buses.
> 		> >
> 		> > Now the question is,... is there any linux driver
available for this new
> 		> > core?
> 		>
> 		> Yes there is, but I had to use the git sources at:
> 		>
> 		> git.xilinx.com
>=20
>=20
> ________________________________
>=20
> 		<http://>
>=20
>=20
> ________________________________
>=20
> 	<http://>
>=20
>=20
> ________________________________
