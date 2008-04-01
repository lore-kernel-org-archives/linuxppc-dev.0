Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 781DDDDE24
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 22:55:56 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCHv3 2/4] cpm-serial: Relocate CPM buffer descriptors and SMC
	parameter ram.
Date: Tue, 1 Apr 2008 13:55:40 +0200
References: <200803311834.42327.laurentp@cse-semaphore.com>
	<200803311836.08142.laurentp@cse-semaphore.com>
	<47F13735.40207@freescale.com>
In-Reply-To: <47F13735.40207@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart20463270.284uqVR1sD";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804011355.51007.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart20463270.284uqVR1sD
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 31 March 2008 21:10, Scott Wood wrote:
> Laurent Pinchart wrote:
> > This patch relocates the buffer descriptors and the SMC parameter RAM a=
t the
> > end of the first CPM muram chunk, as described in the device tree. This=
 allows
> > device trees to stop excluding SMC parameter ram allocated by the boot =
loader
> > from the CPM muram node.
>=20
> It's usually a good idea to state that something is untested if that's=20
> the case. :-)

Sorry. I'll state it clearly next time.

> This patch cannot work as is.
>=20
> > +static int cpm_get_virtual_address(void *devp, void **addr, int ncells)
> > +{
> > +	unsigned long xaddr;
> > +	int n;
> > +
> > +	n =3D getprop(devp, "virtual-reg", addr, ncells * sizeof *addr);
> > +	if (n < ncells * sizeof *addr) {
>=20
> You must cast the sizeof to a signed int; otherwise, a negative return=20
> from getprop will be "bigger" than the unsigned size, and you'll return=20
> garbage as the address.
>=20
> > +		for (n =3D 0; n < ncells; n++) {
> > +			if (!dt_xlate_reg(devp, n, &xaddr, NULL))
> > +				return -1;
> > +
> > +			addr[n] =3D (void*)xaddr;
>=20
> (void *)
>=20
> > +		}
> > +	}
> > +
> > +	return ncells;
> > +}
>=20
> This could be a generic bootwrapper function.  It should return the=20
> number of resources (ncells is a misnomer) actually found, though,=20
> rather than failing if there are fewer than asked for.  Let the caller=20
> decide if it's fatal.

Ok. I'll move it to devtree.c.

> > @@ -202,63 +243,62 @@ int cpm_console_init(void *devp, struct serial_co=
nsole_data *scdp)
> >  	else
> >  		do_cmd =3D cpm1_cmd;
> > =20
> > -	n =3D getprop(devp, "fsl,cpm-command", &cpm_cmd, 4);
> > -	if (n < 4)
> > +	if (getprop(devp, "fsl,cpm-command", &cpm_cmd, 4) < sizeof cpm_cmd)
> >  		return -1;
>=20
> Standard kernel style is sizeof(foo), not sizeof foo.

Ok.

> Plus, if you're going to replace 4 with sizeof(cpm_cmd), do it both=20
> places.  I don't really see the need, though; a cell is always 4 bytes.

Ok, I'll keep 4.

> > -	n =3D getprop(parent, "virtual-reg", reg_virt, sizeof(reg_virt));
> > -	if (n < (int)sizeof(reg_virt)) {
> > -		if (!dt_xlate_reg(parent, 0, &reg_phys, NULL))
> > -			return -1;
> > -
> > -		reg_virt[0] =3D (void *)reg_phys;
> > -	}
> > -
> > -	cpcr =3D reg_virt[0];
> > +	if (cpm_get_virtual_address(devp, &cpcr, 1) < 0)
> > +		return -1;
>=20
> s/devp/parent/
>=20
> >  	muram =3D finddevice("/soc/cpm/muram/data");
> >  	if (!muram)
> >  		return -1;
> > =20
> >  	/* For bootwrapper-compatible device trees, we assume that the first
> > -	 * entry has at least 18 bytes, and that #address-cells/#data-cells
> > +	 * entry has at least 128 bytes, and that #address-cells/#data-cells
> >  	 * is one for both parent and child.
> >  	 */
> > =20
> > -	n =3D getprop(muram, "virtual-reg", reg_virt, sizeof(reg_virt));
> > -	if (n < (int)sizeof(reg_virt)) {
> > -		if (!dt_xlate_reg(muram, 0, &reg_phys, NULL))
> > -			return -1;
> > +	if (cpm_get_virtual_address(devp, &muram_addr, 1) < 0)
> > +		return -1;
>=20
> s/devp/muram/
>=20
> > +=09
> > +	if (getprop(muram, "reg", reg, sizeof reg) < sizeof reg)
> > +		return -1;
>=20
> Should read into array of u32, not void *.

Ok.

> > +	if (is_cpm2 && is_smc) {
> > +		u16 *smc_base =3D (u16*)param;
>=20
> (u16 *)
>=20
> > +		u16 pram_offset;
> > =20
> > -	muram_start =3D reg_virt[0];
> > +		pram_offset =3D cbd_offset - 64;
> > +		pram_offset =3D _ALIGN_DOWN(pram_offset, 64);
> > +		*smc_base =3D pram_offset;
>=20
> Use out_be16().
>=20
> The SMC should be stopped before you do this.

Right.

New patch comming.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=C3=A9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart20463270.284uqVR1sD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH8iLG8y9gWxC9vpcRAn2CAJ9DK8di/M9c6X6gCTTgy/TxeSyqpACgkxzf
4/z3t5Ht0i3F+p0Tppm+yVk=
=JeLR
-----END PGP SIGNATURE-----

--nextPart20463270.284uqVR1sD--
