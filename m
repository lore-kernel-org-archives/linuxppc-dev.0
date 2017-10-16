Return-Path: <dgibson@ozlabs.org>
Date: Mon, 16 Oct 2017 17:46:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Greg Kurz <groug@kaod.org>,
 Balbir Singh <bsingharora@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, slof@lists.ozlabs.org
Subject: Re: [PATCH kernel] RFC: prom_init: Fetch flatten device tree from
 the system firmware
Message-ID: <20171016064633.GE2776@umbus.fritz.box>
References: <20171016054917.21577-1-aik@ozlabs.ru>
 <20171016061125.GD2776@umbus.fritz.box>
 <00ec0e99-45dd-dbe0-d75f-4413253e8093@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Mjqg7Yu+0hL22rav"
In-Reply-To: <00ec0e99-45dd-dbe0-d75f-4413253e8093@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Mjqg7Yu+0hL22rav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2017 at 05:22:55PM +1100, Alexey Kardashevskiy wrote:
> On 16/10/17 17:11, David Gibson wrote:
> > On Mon, Oct 16, 2017 at 04:49:17PM +1100, Alexey Kardashevskiy wrote:
> >> At the moment, on 256CPU + 256 PCI devices guest, it takes the guest
> >> about 8.5sec to read the entire device tree. Some explanation can be
> >> found here: https://patchwork.ozlabs.org/patch/826124/ but mostly it is
> >> because the kernel traverses the tree twice and it calls "getprop" for
> >> each properly which is really SLOF as it searches from the linked list
> >> beginning every time.
> >>
> >> Since SLOF has just learned to build FDT and this takes less than 0.5s=
ec
> >> for such a big guest, this makes use of the proposed client interface
> >> method - "fdt-fetch".
> >>
> >> If "fdt-fetch" is not available, the old method is used.
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >=20
> > I like the concept, few details though..
> >=20
> >> ---
> >>  arch/powerpc/kernel/prom_init.c | 26 ++++++++++++++++++++++++++
> >>  1 file changed, 26 insertions(+)
> >>
> >> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/pro=
m_init.c
> >> index 02190e90c7ae..daa50a153737 100644
> >> --- a/arch/powerpc/kernel/prom_init.c
> >> +++ b/arch/powerpc/kernel/prom_init.c
> >> @@ -2498,6 +2498,31 @@ static void __init flatten_device_tree(void)
> >>  		prom_panic("Can't allocate initial device-tree chunk\n");
> >>  	mem_end =3D mem_start + room;
> >> =20
> >> +	if (!call_prom_ret("fdt-fetch", 2, 1, NULL, mem_start,
> >> +			   room - sizeof(mem_reserve_map))) {
> >> +		u32 size;
> >> +
> >> +		hdr =3D (void *) mem_start;
> >> +
> >> +		/* Fixup the boot cpuid */
> >> +		hdr->boot_cpuid_phys =3D cpu_to_be32(prom.cpu);
> >=20
> > If SLOF is generating a tree it really should get this header field
> > right as well.
>=20
>=20
> Ah, I did not realize it is just a phandle from /chosen/cpu. Will
> fix.

It's not a phandle.  It's just the "address" (i.e. reg value) of the
boot cpu.

> >> +		/* Append the reserved map to the end of the blob */
> >> +		hdr->off_mem_rsvmap =3D hdr->totalsize;
> >> +		size =3D be32_to_cpu(hdr->totalsize);
> >> +		rsvmap =3D (void *) hdr + size;
> >> +		hdr->totalsize =3D cpu_to_be32(size + sizeof(mem_reserve_map));
> >> +		memcpy(rsvmap, mem_reserve_map, sizeof(mem_reserve_map));
> >=20
> > .. and the reserve map for that matter.  I don't really understand
> > what you're doing here.=20
>=20
> ? Get the blob, increase the FDT size by sizeof(mem_reserve_map), fix up
> totalsize and off_mem_rsvmap, copy mem_reserve_map to the end of the blob
> (the actual order is slightly different, may be a bit confusing).

Right.. but where is mem_reserve_map coming from, if it hasn't come
=66rom an FDT?

> Asking SLOF to reserve the space seems to be unnecessary complication of
> the interface - SLOF does not provide any reserved memory records.

Ah.. right, the reservations are coming from the pre-prom kernel, not
=66rom the firmware itself.  Yeah, that makes sense.  Ok, this makes
sense then...

> > Note also that the reserve map is required to
> > be 8-byte aligned, which totalsize might not be.
>=20
> Ah, good point.

=2E.at least with that fixed and maybe some comments to make what's
gonig on clearer.

>=20
>=20
> >=20
> >> +		/* Store the DT address */
> >> +		dt_header_start =3D mem_start;
> >> +
> >> +#ifdef DEBUG_PROM
> >> +		prom_printf("Fetched DTB: %d bytes to @%x\n", size, mem_start);
> >> +#endif
> >> +		goto print_exit;
> >> +	}
> >> +
> >>  	/* Get root of tree */
> >>  	root =3D call_prom("peer", 1, 1, (phandle)0);
> >>  	if (root =3D=3D (phandle)0)
> >> @@ -2548,6 +2573,7 @@ static void __init flatten_device_tree(void)
> >>  	/* Copy the reserve map in */
> >>  	memcpy(rsvmap, mem_reserve_map, sizeof(mem_reserve_map));
> >> =20
> >> +print_exit:
> >>  #ifdef DEBUG_PROM
> >>  	{
> >>  		int i;
> >=20
>=20
>=20




--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Mjqg7Yu+0hL22rav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnkVckACgkQbDjKyiDZ
s5Jpyg//d8Vq96ZMc+8xgKPwogiFek1olQIVB1i+ODyQIQANlJbmQsBqUomYDhO1
bYj8t+dmL+iRKAqzGpm6M5cXnRVL/iSKskEGwq+ouWe4fPjf6FTmVqt0af8KfIWg
PvFbGCu344PTXtrKH2wPP+vU36A9jjx12UZwaRNHagNjlIXBq7roIE+RYCYcCgv7
qHhDVIf0kcKZXZT+MJTYBs56k3sW+NS0H3d78VSDcEMiuRA+sjM++Nf4qsIIC7qs
a75wnFzsEkg2SHEKKz71hLUBdhruxZbks/9GsaZXbCv0CfAWnDPY9f6KT2vP1OWG
WDNfl6ahK3RCeJKCYUJcx0V7/4ceYYs72rklmrIGth7/UU4wqaSuPuuNr52/lnAj
75gd3shnflQMAH4WgSBnlyj9+m2MFtXdYHN8dVBp2CLM2+gH65rsM8tenSHF8WcK
D1sqgaQKCF/bOGv5DH2nck0alHZT8fXvQMquRHLVn0ibYyn3BAfqmzT2njGMIUT6
ly9OWUvKI0EURWKmDAh8vu9Eo46hgQUuqba7g1uO8HxgFgK6hSeY+whnWHiL/H5B
/HUn9+zvBEAg5dozJR4Wj2SPOwr7joR79bUiQdBTUHCHS21CJ7+e5HqOCx0Wq9m8
4QF+EkvMrHiDrJWNq0Ju1MJ4egznCzMpXURg9hiYjapw99ff5C0=
=nrvq
-----END PGP SIGNATURE-----

--Mjqg7Yu+0hL22rav--
