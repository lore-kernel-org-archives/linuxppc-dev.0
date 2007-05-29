Return-Path: <michael@ellerman.id.au>
Subject: Re: [Patch ] Kexec/Kdump support - POWER6
From: Michael Ellerman <michael@ellerman.id.au>
To: sachinp@in.ibm.com
In-Reply-To: <465ABFC9.9020502@in.ibm.com>
References: <4652E088.9080207@in.ibm.com> <4652E109.4020204@in.ibm.com>
	<4652E17C.7080607@in.ibm.com> <20070522153419.GA22047@lixom.net>
	<46540B6F.6030300@in.ibm.com>
	<18004.7556.311264.415721@cargo.ozlabs.ibm.com>
	<20070524121751.GB4547@in.ibm.com> <20070524142133.GA13191@lixom.net>
	<4656A488.2020507@in.ibm.com>
	<1180132987.19517.9.camel@localhost.localdomain>
	<465ABFC9.9020502@in.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-zBLN6mbsj2AWPRYIrCX5"
Date: Tue, 29 May 2007 20:14:44 +1000
Message-Id: <1180433684.5953.1.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Milton Miller II <miltonm@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
	kexec@lists.infradead.org, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-zBLN6mbsj2AWPRYIrCX5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-05-28 at 17:10 +0530, Sachin P. Sant wrote:
> Benjamin Herrenschmidt wrote:
> > If you're going to use the B (1T segment) bit instead of the bolted bit=
,
> > at least define a proper constant in line with the existing naming of
> > the hash table constants in mmu-hash64.h. I would suggest doing the sam=
e
> > with the VRMA_MASK/VALUE thing and calling it HPTE_V_VRMA_MASK or
> > something similar.
> >  =20
> Well i had used them properly in my previous patches. Don't know why
> i changed it in this patch :-(=20
>=20
> Here is the updated patch.=20
>=20
> >> +	}
> >>  }
> >>    =20
> > In addition, I would recommend following Michael's advice and using
> > using the bulk remove Hcall whenever possible.
> >  =20
> Yes will send out a separate patch to use bulk remove Hcall.
>=20
> Thanks
> -Sachin
>=20
>=20
> Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
> Signed-off-by : Mohan Kumar M <mohan@in.ibm.com>
> ---
>=20
>=20
>=20
>=20
> plain text document attachment (kexec-kdump-support-on-POWER6)
> * On Power machines supporting VRMA, Kexec/Kdump does not work.
> * Hypervisor stores VRMA mapping used by the OS, in the hpte hash tables.
> * Make sure these hpte entries are left untouched.
> *
> * This patch also adds plpar_pte_read_raw() on the lines of
> * plpar_pte_remove_raw().
>=20
> Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
> Signed-off-by : Mohan Kumar M <mohan@in.ibm.com>
> ---
>=20
> diff -Naurp a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platfo=
rms/pseries/lpar.c
> --- a/arch/powerpc/platforms/pseries/lpar.c	2007-05-19 09:36:17.000000000=
 +0530
> +++ b/arch/powerpc/platforms/pseries/lpar.c	2007-05-28 16:49:46.000000000=
 +0530
> @@ -369,16 +369,30 @@ static long pSeries_lpar_hpte_remove(uns
>  	return -1;
>  }
> =20
> +#define HPTE_V_1TB_SEG		ASM_CONST(0x4000000000000000)
> +#define HPTE_V_VRMA_MASK	ASM_CONST(0x4001ffffff)
> +
>  static void pSeries_lpar_hptab_clear(void)
>  {
>  	unsigned long size_bytes =3D 1UL << ppc64_pft_size;
>  	unsigned long hpte_count =3D size_bytes >> 4;
> -	unsigned long dummy1, dummy2;
> +	unsigned long dummy1, dummy2, dword0;
> +	long lpar_rc;
>  	int i;
> =20
>  	/* TODO: Use bulk call */
> -	for (i =3D 0; i < hpte_count; i++)
> -		plpar_pte_remove_raw(0, i, 0, &dummy1, &dummy2);
> +	for (i =3D 0; i < hpte_count; i++) {
> +		/* dont remove HPTEs with VRMA mappings */
> +		lpar_rc =3D plpar_pte_remove_raw(H_ANDCOND, i, HPTE_V_1TB_SEG,
> +						&dummy1, &dummy2);
> +		if (lpar_rc =3D=3D H_NOT_FOUND) {
> +			lpar_rc =3D plpar_pte_read_raw(0, i, &dword0, &dummy1);
> +			if (!lpar_rc && (((dword0 >> 24) & HPTE_V_VRMA_MASK) <xxxxxxx

You have trailing whitespace on that line.

Add this to your ~/.vimrc, you do use vim right :)

highlight RedundantWhitespace ctermbg=3Dred guibg=3Dred

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-zBLN6mbsj2AWPRYIrCX5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGW/0UdSjSd0sB4dIRAlJzAJoDPyis4upOWeIKQuARyc1iUsLlLgCglwey
ff2OKzFVvxGkKi2zpDhJhoE=
=4dv+
-----END PGP SIGNATURE-----

--=-zBLN6mbsj2AWPRYIrCX5--
