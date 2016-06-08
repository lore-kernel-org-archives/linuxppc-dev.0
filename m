Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPXNw5jwrzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 12:26:08 +1000 (AEST)
Date: Wed, 8 Jun 2016 12:26:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Blanchard <anton@au1.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH 2/2] spapr: Better handling of ibm,pa-features TM bit
Message-ID: <20160608022602.GU9226@voom.fritz.box>
References: <20160404164457.539a55f0@kryten> <57021123.6050506@ozlabs.ru>
 <20160404204346.1cf44df8@kryten> <20160404210928.0d9ae644@kryten>
 <F99A6122-6B6D-45A3-99E2-2F56F143FB50@suse.de>
 <20160430104800.0a7c1d11@kryten> <20160607222842.4a745724@kryten>
 <20160607223210.2b1b42ae@kryten>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ULJ2Z7kCM1hyNsWd"
In-Reply-To: <20160607223210.2b1b42ae@kryten>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ULJ2Z7kCM1hyNsWd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 07, 2016 at 10:32:10PM +1000, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
>=20
> There are a few issues with our handling of the ibm,pa-features
> TM bit:
>=20
> - We don't support transactional memory in PR KVM, so don't tell
>   the OS that we do.
>=20
> - In full emulation we have a minimal implementation of TM that always
>   fails, so for performance reasons lets not tell the OS that we
>   support it either.
>=20
> - In HV KVM mode, we should mirror the host TM enabled state by
>   looking at the AT_HWCAP2 bit.
>=20
> Signed-off-by: Anton Blanchard <anton@samba.org>

So, we certainly need a change like this.  I'm not entirely happy with
the current implementation though.

> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0636642..c403fbb 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -620,7 +620,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void =
*fdt, int offset,
>          0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0,
>          0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
>          0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
> -        0x80, 0x00, 0x80, 0x00, 0x80, 0x00 };
> +        0x80, 0x00, 0x80, 0x00, 0x00, 0x00 };
>      uint8_t *pa_features;
>      size_t pa_size;
> =20
> @@ -697,6 +697,19 @@ static void spapr_populate_cpu_dt(CPUState *cs, void=
 *fdt, int offset,
>      } else /* env->mmu_model =3D=3D POWERPC_MMU_2_07 */ {
>          pa_features =3D pa_features_207;
>          pa_size =3D sizeof(pa_features_207);
> +
> +#ifdef CONFIG_KVM
> +        /* Only enable TM in HV KVM mode */
> +        if (kvm_enabled() &&
> +            !kvm_vm_check_extension(cs->kvm_state, KVM_CAP_PPC_GET_PVINF=
O)) {
> +            unsigned long hwcap2 =3D qemu_getauxval(AT_HWCAP2);
> +
> +            /* Guest should inherit host TM enabled bit */
> +            if (hwcap2 & PPC_FEATURE2_HAS_HTM) {
> +                pa_features[24] |=3D 0x80;
> +            }
> +        }
> +#endif

So first, I think this stanza wants to move into target-ppc/kvm.c -
maybe a kvm_filter_pa_features() call or something.

Second, although using PVINFO to determine if we have HV KVM is a
standard trick, we don't want to use it as our first option.  We
really want to introduce an actual KVM CAP flag for TM support, then
fall back to checking PVINFO if we can't use that.

I wonder if we actually want to just blanket disable TM in one patch -
since it doesn't work at all with PR KVM, and "works" only in the most
rules-lawyering and useless way on TCG.  Then re-enable it on HV KVM
in a second patch.

>      }
>      if (env->ci_large_pages) {
>          pa_features[3] |=3D 0x20;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ULJ2Z7kCM1hyNsWd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXV4I6AAoJEGw4ysog2bOSM4oP/jsvhqZofhQTZ7LLaKZLjSDv
Q1i+uSFnmx/nL4Su006vMLV0HAsF2samabPbTP/AHtXpalI3jVwDF1YRT8i+E5Wo
W7zPjYGcKgWTayypFG0Z2t01DEiaBaMcLZpGKXHcuAaUZlfmjC7V/vNgeHeM8w49
vILy60xQnWt0FUKOT1JHty8d4xeYdxMPOxZt0N0KDHXivPyZwoCm0fwZeCGEThf8
tEKGE101+qreqPytdnBY0TM9lQIzu0aVZMItenpIsu1xo1PqItGAGlSwGYpPI1P0
8c8Z7X8lQ5xRz6qJAuzjdiViycz1bZ3uMrrHovbZ/LrvvRrdQWOYeyp/lttR7OSx
NMTbJM2ZoU3K/JQwIv2RbW7gu7cZDqNYY7K55TI2xY8JN4wwhaeZTdKQ+nYhyQ8W
8W4iqOJ22+le9oH+wLyjjQdwVkk1U/uliltknDUP0SjKjySes5LRm75TD3i3uSVL
TjnX+J5Krci+7ja1SAugcXaY6o/0jDEcZqVXwAPP5+EWWTTofWCPJebOLlpQkmhX
MWemk/4jSLrvWlQTty/thhfZvxTLoYUQDEInRKXfYcqRYEjoES4PG7mkiUM2nhRY
rSwLGjv+Z+45R9Vuq2xPLJkDeVxS5jTRHbKY7FZuczcDhRhoFsRBolexx79TWkhr
0eCA1kRCkQT4qBInuzpf
=e3dq
-----END PGP SIGNATURE-----

--ULJ2Z7kCM1hyNsWd--
