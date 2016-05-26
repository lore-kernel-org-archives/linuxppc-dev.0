Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rFVtN69sCzDqbw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 May 2016 10:50:20 +1000 (AEST)
Date: Thu, 26 May 2016 10:50:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com,
 aik@au1.ibm.com, mpe@ellerman.id.au
Subject: Re: [FIX PATCH v2 2/2] powerpc,numa: Fix memory_hotplug_max()
Message-ID: <20160526005014.GS17226@voom.fritz.box>
References: <1463060055-24158-1-git-send-email-bharata@linux.vnet.ibm.com>
 <1463060055-24158-3-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="MT9SxUWSsctiw0kG"
In-Reply-To: <1463060055-24158-3-git-send-email-bharata@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--MT9SxUWSsctiw0kG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 12, 2016 at 07:04:15PM +0530, Bharata B Rao wrote:
> memory_hotplug_max() uses hot_add_drconf_memory_max() to get maxmimum
> addressable memory by referring to ibm,dyanamic-memory property. There
> are three problems with the current approach:
>=20
> 1 hot_add_drconf_memory_max() assumes that ibm,dynamic-memory includes
>   all the LMBs of the guest, but that is not true for PowerKVM which
>   populates only DR LMBs (LMBs that can be hotplugged/removed) in that
>   property.
> 2 hot_add_drconf_memory_max() multiplies lmb-size with lmb-count to arrive
>   at the max possible address. Since ibm,dynamic-memory doesn't include
>   RMA LMBs, the address thus obtained will be less than the actual max
>   address. For example, if max possible memory size is 32G, with lmb-size
>   of 256MB there can be 127 LMBs in ibm,dynamic-memory (1 LMB for RMA
>   which won't be present here).  hot_add_drconf_memory_max() would then
>   return the max addressable memory as 127 * 256MB =3D 31.75GB, the max
>   address should have been 32G which is what ibm,lrdr-capacity shows.
> 3 In PowerKVM, there can be a gap between the end of boot time RAM and
>   beginning of hotplug RAM area. So just multiplying lmb-count with
>   lmb-size will not provide the correct max possible address for PowerKVM.
>=20
> This patch fixes 1 by using ibm,lrdr-capacity property to return the max
> addressable memory whenever the property is present. Then it fixes 2 & 3
> by fetching the address of the last LMB in ibm,dynamic-memory property.
>=20
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/mm/numa.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 4a87ccb..f8b1da7 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -1164,17 +1164,33 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
>  static u64 hot_add_drconf_memory_max(void)
>  {
>  	struct device_node *memory =3D NULL;
> +	struct device_node *dn =3D NULL;
>  	unsigned int drconf_cell_cnt =3D 0;
>  	u64 lmb_size =3D 0;
>  	const __be32 *dm =3D NULL;
> +	const __be64 *lrdr =3D NULL;
> +	struct of_drconf_cell drmem;
> +
> +	dn =3D of_find_node_by_path("/rtas");
> +	if (dn) {
> +		lrdr =3D of_get_property(dn, "ibm,lrdr-capacity", NULL);
> +		of_node_put(dn);
> +		if (lrdr)
> +			return be64_to_cpup(lrdr);
> +	}
> =20
>  	memory =3D of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
>  	if (memory) {
>  		drconf_cell_cnt =3D of_get_drconf_memory(memory, &dm);
>  		lmb_size =3D of_get_lmb_size(memory);
> +
> +		/* Advance to the last cell, each cell has 6 32 bit integers */
> +		dm +=3D (drconf_cell_cnt - 1) * 6;
> +		read_drconf_cell(&drmem, &dm);
>  		of_node_put(memory);
> +		return drmem.base_addr + lmb_size;
>  	}
> -	return lmb_size * drconf_cell_cnt;
> +	return 0;
>  }
> =20
>  /*

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MT9SxUWSsctiw0kG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXRkhGAAoJEGw4ysog2bOSoEUP/RIt5kOY/nX5IDU5OoqP04A1
POIQBpKZO7DcZNNQusxinVtvLDs38TTB/YbHNOLrE1TvWWwKXnbn+Gdg3iFr+ffR
xAOshe34AjDgN2iGCpy78KUYjynAY8cjfQ5pQZLSGaScvWLa5MTSGTtSZ83wAR47
3o/KQc5GrohH4Xqsw+3VO9Bfv8nJakhZxf4YJeDSgBf8Kc5Y4gXzcy5t08csPptY
k6fHAzhJFhl6me9kfEXuBg0D2wjCQFoCP1dWwEklOhLn2EtW6TT8xLeG8B4QzJBt
W9v970dZLC+RfP6JNrmW0xVADtAKpPslR4LTFTmgI5xVfRTYP5gzoHgOwdIDk4wv
HT1BTaMp61R+PcBu57zr/F5DPOtBnINjAdZ1CEayG0kGuCra01OVOH1i+iKqerU8
kDyqB4RzdEiRUe8rYGxEsgkalXKXI9NyL0ZQ2NcBl6tgTbbSlRsuMEUIRkR+W5X5
PzaNRU3xGEr7GQrcLq9emBfxmpYllTcm5/UY1F5e9WZ10obsKMrwAnV1TBgI+FWb
nP9awQEPFvC2EqqYFNzNtGqsNkPKCPkeLUKj2F3lE0q0hRWtVj1qlYFQekMfGcZp
7dALHkGbyp+M9PbUDMT0gkAp9Mtwm/mVQPPi2j1Z8Q+/ecKV2pkT5LKDgIueN77G
TwHG3g7iVHSkmJ8S+cgA
=QkJe
-----END PGP SIGNATURE-----

--MT9SxUWSsctiw0kG--
