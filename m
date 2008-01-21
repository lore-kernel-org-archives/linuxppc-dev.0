Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound1-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2CF03DDE11
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Jan 2008 05:42:35 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Xilinx XPS_LL_TEMAC vs PLB_TEMAC
Date: Mon, 21 Jan 2008 10:42:23 -0800
In-Reply-To: <BAY115-W344A18C61627B3075C6281B23D0@phx.gbl>
References: <BAY115-W17ECE16AB6FA79B2D4DBBDB23D0@phx.gbl><440abda90801202354l5a0ce4caq382af5991e36f775@mail.gmail.com>
	<BAY115-W344A18C61627B3075C6281B23D0@phx.gbl>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Mohammad Sadegh Sadri" <mamsadegh@hotmail.com>,
	"David Baird" <dhbaird@gmail.com>, <linuxppc-embedded@ozlabs.org>
Message-Id: <20080121184228.931C2F4005D@mail122-dub.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Basically, git.xilinx.com has a tree with most of the xilinx-related
support already integrated and ported forward to a current kernel.  It
also includes ongoing work to unify microblaze and powerpc device
drivers through flat device trees.

See:
http://www.mail-archive.com/linuxppc-embedded@ozlabs.org/msg28690.html

To use the git.xilinx.com tree you should *not* generate the driver code
directly into the Linux tree.  Instead, you should generate the driver
code in a dummy directory and copy
arch/ppc/platforms/4xx/xparameters_ml*.h into the kernel tree.

The BSP generation process is designed older 2.6.10-era kernels and will
not work with recent kernels. =20

Steve

> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of Mohammad
Sadegh Sadri
> Sent: Monday, January 21, 2008 12:54 AM
> To: David Baird; linuxppc-embedded@ozlabs.org
> Subject: RE: Xilinx XPS_LL_TEMAC vs PLB_TEMAC
>=20
> thanks for you reply david,
>=20
> As far as I know the Linux driver for Xilinx PLB TEMAC was two parts :
1- adapter.c and 2- the rest
> of the driver files
>=20
> Only adapter.c was really a linux related file and the rest of the
files were Xilinx generic driver
> code for PLB TEMAC.
>=20
> correct?
>=20
> then now, I know EDK 9.2 generates the needed Linux support package
and needed related files, so if
> this is the case can we use these files as the needed driver in our
linux kernel?
>=20
> by the way, i did never hear about this git repository before...can
you describe us, where is it and
> how we can access it and which projects are now hosted by it?
>=20
>=20
> thanks
>=20
>=20
> > Date: Mon, 21 Jan 2008 00:54:30 -0700
> > From: dhbaird@gmail.com
> > To: mamsadegh@hotmail.com
> > Subject: Re: Xilinx XPS_LL_TEMAC vs PLB_TEMAC
> >
> > On Jan 21, 2008 12:36 AM, Mohammad Sadegh Sadri
<mamsadegh@hotmail.com> wrote:
> > > As you know Xilinx PLB TEMAC is a module which connects Hard TEMAC
in
> > > Virtex-4 FX devices to PLB bus,
> > > now, in the new release of EDK , EDK 9.2 Xilinx has added a new
interface
> > > core , which is called XPS_LL_TEMAC and has a different structure
than
> > > normal PLB TEMAC. spacially it has some additional data transfer
buses.
> > >
> > > Now the question is,... is there any linux driver available for
this new
> > > core?
> >
> > Yes there is, but I had to use the git sources at:
> >
> > git.xilinx.com
>=20
>=20
> ________________________________
