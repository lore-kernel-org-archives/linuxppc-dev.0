Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSg022sx2zDqCg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 12:34:42 +1100 (AEDT)
Date: Wed, 22 Feb 2017 11:58:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: advertise Hot Plug Event support to
 firmware
Message-ID: <20170222005847.GC12577@umbus.fritz.box>
References: <1487639538-25922-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
In-Reply-To: <1487639538-25922-1-git-send-email-mdroth@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 07:12:18PM -0600, Michael Roth wrote:
> With the inclusion of:
>=20
>   powerpc/pseries: Implement indexed-count hotplug memory remove
>   powerpc/pseries: Implement indexed-count hotplug memory add
>=20
> we now have complete handling of the RTAS hotplug event format
> as described by PAPR via ACR "PAPR Changes for Hotplug RTAS Events".
>=20
> This capability is indicated by byte 6, bit 5 of architecture
> option vector 5, and allows for greater control over cpu/memory/pci
> hot plug/unplug operations.
>=20
> Existing pseries kernels will utilize this capability based on the
> existence of the /event-sources/hot-plug-events DT property, so we
> only need to advertise it via CAS and do not need a corresponding
> FW_FEATURE_* value to test for.
>=20
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/prom.h | 1 +
>  arch/powerpc/kernel/prom_init.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/p=
rom.h
> index 2c8001c..4a90634 100644
> --- a/arch/powerpc/include/asm/prom.h
> +++ b/arch/powerpc/include/asm/prom.h
> @@ -153,6 +153,7 @@ struct of_drconf_cell {
>  #define OV5_XCMO		0x0440	/* Page Coalescing */
>  #define OV5_TYPE1_AFFINITY	0x0580	/* Type 1 NUMA affinity */
>  #define OV5_PRRN		0x0540	/* Platform Resource Reassignment */
> +#define OV5_HP_EVT		0x0604	/* Hot Plug Event support */
>  #define OV5_RESIZE_HPT		0x0601	/* Hash Page Table resizing */
>  #define OV5_PFO_HW_RNG		0x1180	/* PFO Random Number Generator */
>  #define OV5_PFO_HW_842		0x1140	/* PFO Compression Accelerator */
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_i=
nit.c
> index f3c8799..1a835e7 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -839,7 +839,7 @@ struct ibm_arch_vec __cacheline_aligned ibm_architect=
ure_vec =3D {
>  		0,
>  #endif
>  		.associativity =3D OV5_FEAT(OV5_TYPE1_AFFINITY) | OV5_FEAT(OV5_PRRN),
> -		.bin_opts =3D OV5_FEAT(OV5_RESIZE_HPT),
> +		.bin_opts =3D OV5_FEAT(OV5_RESIZE_HPT) | OV5_FEAT(OV5_HP_EVT),
>  		.micro_checkpoint =3D 0,
>  		.reserved0 =3D 0,
>  		.max_cpus =3D cpu_to_be32(NR_CPUS),	/* number of cores supported */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrOJHAAoJEGw4ysog2bOS4kUP/i++M6rqwrqA35+SDrgX/CBd
DE+QcWw0sQEGWNgUUQs2vgdUP7nFaS5GcDAEGehRgw+sb8zQ20OoB8ExDzrtrjy8
VHEpOA9U2WAQP0QK+PMBM89aAEZ1UNmF1agaDsYW143mgiPxGEz5/e+AviZBvyY1
5B0UhL4Yh9a1Wl/Zy9RrrglvT3tHpwYqKncWUqke/KVDbT4XFK31DByhJ4oZqf5x
1sJ+7bM8FQ9R8Cgg85eR5M5ZepNjwGeMwwKRm4w+5brzeSJSHH56VnLIvZCi9ow5
GElbvXDPCFoMB4oweqVHdvfVIqQbDSfQsz+9A/DN8AGhovjnRhGEztl1gy+D/SFY
qDemPJwa7oGkaxdfHvlmLq8HFMa/q522guS0IkNj813qGHMFWs/pn+0VyI4X5o7B
QFUVoCFzleMlJOqAfRtlsBAT9u0J/2MmnUlC1SHMe+kuENwF4AyWssbUnxta1d7F
Nvk/tHOn0i+Ypxa8Vc0zZPrIrEjGhY9ojI70WkSz0UeinPAcZ4f2mn/LrKRyCRDk
f7LFQOagiEQQAL/x7X3ErwDV/Ve0X6ihqRJsWYCYgyFbBckJN17CHbijCJGlZhLn
4DO4acDeSDYdVmIxKFFH2TsxiGKQUFAFvFcTd4IQFK6m++YgUSZmJ8pX/QSWiWdS
oaYYpGsrBuuIpK0eUGim
=4BVa
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--
