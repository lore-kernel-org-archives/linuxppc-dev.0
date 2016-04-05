Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qf9ZV5HDnzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 11:02:58 +1000 (AEST)
Date: Tue, 5 Apr 2016 10:52:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Blanchard <anton@samba.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>, Alexander Graf <agraf@suse.de>,
 linuxppc-dev@lists.ozlabs.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH] powerpc: Clear user CPU feature bits if TM is disabled
 at runtime
Message-ID: <20160405005230.GO16485@voom.fritz.box>
References: <20160404164457.539a55f0@kryten> <57021123.6050506@ozlabs.ru>
 <20160404204346.1cf44df8@kryten> <20160404211112.66b0756f@kryten>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="MdEjg5WkSuUg8x46"
In-Reply-To: <20160404211112.66b0756f@kryten>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--MdEjg5WkSuUg8x46
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 04, 2016 at 09:11:12PM +1000, Anton Blanchard wrote:
> In check_cpu_pa_features() we check a number of bits in the
> ibm,pa-features array and set and clear CPU features based on what
> we find. One of these bits is CPU_FTR_TM, the transactional memory
> feature bit.
>=20
> If this does disable TM at runtime, then we need to tell userspace
> about it by clearing the user CPU feature bits.
>=20
> Without this patch userspace processes will think they can execute
> TM instructions and get killed when they try.
>=20
> Signed-off-by: Anton Blanchard <anton@samba.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> Cc: stable@vger.kernel.org
> ---
>=20
> Michael I've added stable here because I'm seeing this on a number
> of distros and would like to get it backported, but I'll leave it up
> to you if it should go there.
>=20
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_6=
4.c
> index f98be83..98c6c86 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -822,4 +822,18 @@ static int __init disable_hardlockup_detector(void)
>  	return 0;
>  }
>  early_initcall(disable_hardlockup_detector);
> +
> +static int __init update_cpu_user_features(void)
> +{
> +	/*
> +	 * Firmware might have disabled TM by clearing the relevant
> +	 * bit in the ibm,pa-features array. In this case we need to
> +	 * tell userspace.
> +	 */
> +	if (!cpu_has_feature(CPU_FTR_TM))
> +		cur_cpu_spec->cpu_user_features2 &=3D ~(PPC_FEATURE2_HTM|PPC_FEATURE2_=
HTM_NOSC);
> +
> +	return 0;
> +}
> +early_initcall(update_cpu_user_features);
>  #endif
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MdEjg5WkSuUg8x46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXAwxOAAoJEGw4ysog2bOS4qIP/3gSAy0T4QLbUbjOjpEAhwe8
AkkcAw4ETf4ONcyllkDvGqlyo0FMd/5QEhc6BF9Mat1AEPXVsgs1tU3h1LFPXqfn
X8in8xGjwKixFQv0HO9HjOsK5HuqGesjsVGhbk3qHs5lXLYk7BR/THNsUDOoKVRZ
MIJeSxTMG8dApBQNh+SaDRiLmN00KlcsCM84QtcnAx5Vvr96fMa7r4T6E53ZltWp
EJPBnjhSaiPIOZ0aGKlo3Xy6fwTAIpB3gndeeNNAvfIAKxBiNdCHKEZPGRgmn5iy
MxaNG1OD4wXIHq0uV8hlhMTDiTfkc0H3CVdjTrHR7vJGAZhsYD28e18bhZLfINd6
3cb27qIy6iG/15ZMCuq7dPnmEoCAQEyKWrh5YAU6pwVjSgn+26WQC4ahVNm5dx2q
73TrrJO0u1Gd6VGD8PBLyIHJyYrvWd/G9iXUbuJD2+DnCuHX/9MuVbPAgXwU0OTA
ZPPgRSVu7HDUnxryn4LZr+9WUJMZTyhNqSlU8kmA6cOwi4SIIvq7MGplJTyc10W4
nXC8Xdvjt7ecwHziQ4BOYSq/si6Y73Zrmn4uBwNMawjbRzsn9dcTBXHuOnAly9ma
t+dZzQismfbbFFd+ecSzZ9agRWe6FKXirTrqXNv/HqhnDcKG5Tj1e9gJoDmaMA6i
KSvbpFG5Cl0CP2GZ+RJd
=F42I
-----END PGP SIGNATURE-----

--MdEjg5WkSuUg8x46--
