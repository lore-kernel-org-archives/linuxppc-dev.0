Return-Path: <dgibson@ozlabs.org>
Date: Mon, 16 Oct 2017 17:11:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Greg Kurz <groug@kaod.org>,
 Balbir Singh <bsingharora@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, slof@lists.ozlabs.org
Subject: Re: [PATCH kernel] RFC: prom_init: Fetch flatten device tree from
 the system firmware
Message-ID: <20171016061125.GD2776@umbus.fritz.box>
References: <20171016054917.21577-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="orO6xySwJI16pVnm"
In-Reply-To: <20171016054917.21577-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--orO6xySwJI16pVnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2017 at 04:49:17PM +1100, Alexey Kardashevskiy wrote:
> At the moment, on 256CPU + 256 PCI devices guest, it takes the guest
> about 8.5sec to read the entire device tree. Some explanation can be
> found here: https://patchwork.ozlabs.org/patch/826124/ but mostly it is
> because the kernel traverses the tree twice and it calls "getprop" for
> each properly which is really SLOF as it searches from the linked list
> beginning every time.
>=20
> Since SLOF has just learned to build FDT and this takes less than 0.5sec
> for such a big guest, this makes use of the proposed client interface
> method - "fdt-fetch".
>=20
> If "fdt-fetch" is not available, the old method is used.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

I like the concept, few details though..

> ---
>  arch/powerpc/kernel/prom_init.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_i=
nit.c
> index 02190e90c7ae..daa50a153737 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -2498,6 +2498,31 @@ static void __init flatten_device_tree(void)
>  		prom_panic("Can't allocate initial device-tree chunk\n");
>  	mem_end =3D mem_start + room;
> =20
> +	if (!call_prom_ret("fdt-fetch", 2, 1, NULL, mem_start,
> +			   room - sizeof(mem_reserve_map))) {
> +		u32 size;
> +
> +		hdr =3D (void *) mem_start;
> +
> +		/* Fixup the boot cpuid */
> +		hdr->boot_cpuid_phys =3D cpu_to_be32(prom.cpu);

If SLOF is generating a tree it really should get this header field
right as well.

> +		/* Append the reserved map to the end of the blob */
> +		hdr->off_mem_rsvmap =3D hdr->totalsize;
> +		size =3D be32_to_cpu(hdr->totalsize);
> +		rsvmap =3D (void *) hdr + size;
> +		hdr->totalsize =3D cpu_to_be32(size + sizeof(mem_reserve_map));
> +		memcpy(rsvmap, mem_reserve_map, sizeof(mem_reserve_map));

=2E. and the reserve map for that matter.  I don't really understand
what you're doing here.  Note also that the reserve map is required to
be 8-byte aligned, which totalsize might not be.

> +		/* Store the DT address */
> +		dt_header_start =3D mem_start;
> +
> +#ifdef DEBUG_PROM
> +		prom_printf("Fetched DTB: %d bytes to @%x\n", size, mem_start);
> +#endif
> +		goto print_exit;
> +	}
> +
>  	/* Get root of tree */
>  	root =3D call_prom("peer", 1, 1, (phandle)0);
>  	if (root =3D=3D (phandle)0)
> @@ -2548,6 +2573,7 @@ static void __init flatten_device_tree(void)
>  	/* Copy the reserve map in */
>  	memcpy(rsvmap, mem_reserve_map, sizeof(mem_reserve_map));
> =20
> +print_exit:
>  #ifdef DEBUG_PROM
>  	{
>  		int i;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--orO6xySwJI16pVnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnkTYkACgkQbDjKyiDZ
s5I+zxAAoTT4Zpy+gAU3hZqDZP3Q0un1WWfUVDXpWmZ71Xz1smuSEJrboRStAWuB
vNrK1hhNIADaNjcCoT2i6gJKotyQpFBXuIQemA5hmdeZ8ZCsWHGMv2nbDMwQX+Md
I4LkWyaXzBAaT3wQ2ZJm3X2dDy7JQH3jYNcgRZNE4xtGeVZ6xqgjMJfxVvmddHTi
sg/MmlYeI20+ypLFmhjiYWlY4uNBsjxCuFNnPdp0vIPUgSnfC0VzDbz0ims/2cV7
71N1uLCDCFHgIuwm5sU1UZIDSkq21nCllpYWwC+d1xmDffk5NqQbUIjERelYBiUS
P3j3e8mlkrR+fAK2Lggz8reyB1LNDcO5wsPk70CEEPFsGlimy7Pu9CveyKowE2DZ
RdxPv6WUfhrT6mX8Q3W4vss9klP+rFyuhVLZswCDow/ogeH6x9N4Z8im2XNEIjR7
MgvRcEMuQWNqABwRpHRORBm+6TPvYTLMe4jFbKFcz9WW17aWi4XoWOJQI1LTYgzl
Rt/gYi4UEHeTuYA1I4NI1igtL0AGOEejNuF+Q23bOo+3er1G+n86X5J1TEq3mUq1
vQmC+SkPGO+QYt8oIXqw5sli73l1T7aHEUu6ZRjqbDyUrG3ktvJdl67ibw6cs3Av
e2QvDMFGbVHaQL8z7sAA9TK0HLc+MM9lDZPUAnkmXP+rnLX9Yqs=
=Awx7
-----END PGP SIGNATURE-----

--orO6xySwJI16pVnm--
