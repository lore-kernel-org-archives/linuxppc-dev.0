Return-Path: <rick.moleres@xilinx.com>
Received: from outbound1-red-R.bigfish.com (outbound-red.frontbridge.com
	[216.148.222.49])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6879267B92
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jul 2006 04:44:26 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Xilinx hard TEMAC
Date: Fri, 14 Jul 2006 12:43:34 -0600
Message-ID: <689CB232690D8D4E97DA6C76DA098E6C029DC9E5@XCO-EXCHVS1.xlnx.xilinx.com>
From: "Rick Moleres" <rick.moleres@xilinx.com>
To: <dhlii@comcast.net>, "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


David,


<snip>
>=20
>     The choice and configuration of the TEMAC was driven by FPGA
> realestate.
>=20
>     My perception was that the "Hard" Temac was based on silicon
already
> in the FX (much like the PowerPC) while the "Soft" TEMAC is primarily
> implimented within the FPGA (much like the MicroBlaze).
>=20
>     Is that distinction between "soft" and "hard" correct ?
>=20

That is the correct distinction between "soft" and "hard".  Just know
that in this case the "soft" TEMAC (whether LL TEMAC or PLB TEMAC) uses
the "hard" TEMAC, and the "hard" TEMAC by itself is not that useful.

>      If not is the only significant distinction between the PLB_TEMAC
> supported by the EDK and the LL_TEMAC the bus interface ?

Yes, this is one of the distinctions between LL TEMAC and PLB TEMAC. :-)

>      I should not think the difference between different bus
interfaces
> should be radically different in terms of FPGA cells. While
implimenting
> the MAC in the FPGA would likely be expensive in realestate.
>       I can try to argue for the PLB_TEMAC - as something that will
have
> Xilinx/MV support and may get incorporated in the standard Kernel - If
> the cost in cells is not substantial.
>=20

I believe LL_TEMAC is smaller than PLB_TEMAC, and so this could be a
tough sell for you if FPGA space is at a premium.  When put in a system
with other stuff (e.g., memory controller, etc...) the size gets closer,
but I think GSRD is still smaller.  Sorry, I don't have the numbers.
There were improvements to PLB TEMAC in EDK 8.1.2 to address some size
issues, and even more planned down the road to hopefully converge the
two.

>=20
>=20
> > The Linux driver posted for the TEMAC (by MontaVista) is for the
> > PLB_TEMAC.  Updates to this driver may also be released with the EDK
> > (e.g., EDK 8.1.2 updated the driver to include checksum offload).
There
> > is a Linux driver for the LL_TEMAC that comes with GSRD, but my
group's
> > efforts go toward the PLB_TEMAC as that is the EDK IP we want to
promote
> > and whose drivers we'd like to see in kernel.org.
> >
>     How can I get a copy of the GSRD LL_TEMAC ? Is it a 2.4 or 2.6
driver
> ?
>=20

You should be able to go to http://www.xilinx.com/gsrd to get the GSRD
design, and inside of that design somewhere you'll find a Linux 2.4
driver for the LL TEMAC.

> > By the way, there is no relation to the IBM EMAC.
> >
>     These things are worth knowing.
>=20
>     The T still means Tri. is there some specific EMAC that was used
as
> a reference for the design or is the TEMAC entirely a Xilinx creation
?
>=20

It's a Xilinx creation as far as I know.

> > Hope that helps,
> > -Rick
> >
