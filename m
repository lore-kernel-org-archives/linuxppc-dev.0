Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id BB1DBDECDD
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 May 2008 01:06:47 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: linux powerpc and device trees
Date: Fri, 23 May 2008 17:06:41 +0200
References: <BAY101-W39CE5CDB63DCE2DC056AAFBEC10@phx.gbl>
In-Reply-To: <BAY101-W39CE5CDB63DCE2DC056AAFBEC10@phx.gbl>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8913353.FWuAmkRZoc";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200805231706.43614.laurentp@cse-semaphore.com>
Cc: - Reyneke <reynekejunk@hotmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart8913353.FWuAmkRZoc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jan,

On Friday 23 May 2008 16:53, - Reyneke wrote:
>=20
> Hi All,
>=20
> I am busy with a platform move from the arch/ppc to arch/powerpc tree of =
the=20
linux kernel. Being relatively new to device trees, I'm trying to ensure I=
=20
have all the steps covered. The platform is very similar to the AMCC Sequio=
a=20
(440EPx) and that board has been used as reference for the code changes=20
required. Kernel version is 2.6.25, using u-boot 1.2.0 (CONFIG_OF_xxx=20
enabled, debug output on).
>=20
> My understanding of the whole powerpc branch boot process is as follows:
>=20
> 1. Add platform to arch/powerpc/platforms/4xx
> 2. Create a .dts in arch/powerpc/boot/dts
> 3. Setup .config and compile uImage
> 4. Compile device tree blob using dtc
> 5. As test, tftp uImage, RootFS, and deviceblob to system memory
> 6. Use u-boot's bootm command to boot kernel
>=20
> Every seems OK, until you get to the boot part. The boot hangs:
>=20
> Verifying Checksum ... OK
> Booting using flat device tree at 0x3000000
> ## initrd at 0x02000040 ... 0x027FEDF7 (len=3D8383928=3D0x7FEDB8)
> Loading Ramdisk to 0f332000, end 0fb30db8 ... OK
> ## Transferring control to Linux (at address 00000000) ...
>=20
>=20
> Using various diagnostics like BDI, ft_dump_blob etc I can see that u-boot
> does what I expect it to do, and the device tree blob looks valid. Tracing
> into the kernel init all looks fine until you hit MMU_init - at this point
> it looks like the total memory is calculated as 0. Evaluating the .dts fi=
le
> the following lines are immediately suspect:   =20
>=20
> memory {
> device_type =3D "memory";
> reg =3D ; /* Filled in by zImage */
> };
>=20
> This is where I am unclear as to how to prepare the device tree. Is step =
(4)
> correct since I'm using uImage? Where is the memory information suppose to
> come from? Previously U-boot passes this kind of data to the kernel via
> bd_t - how does it work now using device trees?  =20

U-Boot has to fill the device tree. This is done in the ft_board_setup()=20
function that every board has to implement. Here is what mine looks like (f=
or=20
an MPC8248).

void ft_board_setup(void *blob, bd_t *bd)
{
        DECLARE_GLOBAL_DATA_PTR;

        ft_cpu_setup(blob, bd);
        fdt_fixup_ethernet(blob, bd);
        fdt_fixup_memory(blob, (u64)bd->bi_memstart, (u64)bd->bi_memsize);

        do_fixup_by_compat_u32(blob, "fsl,cpm-brg", "clock-frequency",
                gd->brg_clk, 1);
}

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart8913353.FWuAmkRZoc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBINt2D8y9gWxC9vpcRAsQLAJwNGOdneiClMx1P0MQQNFUe0V5wmQCg0Ae3
O4f3iFInUY09bpDej71ELec=
=Prjm
-----END PGP SIGNATURE-----

--nextPart8913353.FWuAmkRZoc--
