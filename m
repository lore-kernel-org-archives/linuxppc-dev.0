Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjjld1P3YzDrbB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 15:25:01 +1100 (AEDT)
Date: Fri, 24 Nov 2017 15:24:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com, yilzhang@redhat.com
Subject: Re: [PATCH] powerpc/kexec: Fix kexec/kdump in P9 guest kernels
Message-ID: <20171124042455.GB18727@umbus.fritz.box>
References: <20171124035102.28051-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
In-Reply-To: <20171124035102.28051-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2017 at 02:51:02PM +1100, Michael Ellerman wrote:
> The code that cleans up the IAMR/AMOR before kexec'ing failed to
> remember that when we're running as a guest AMOR is not writable, it's
> hypervisor privileged.
>=20
> They symptom is that the kexec stops before entering purgatory and
> nothing else is seen on the console. If you examine the state of the
> system all threads will be in the 0x700 program check handler.
>=20
> Fix it by making the write to AMOR dependent on HV mode.
>=20
> Fixes: 1e2a516e89fc ("powerpc/kexec: Fix radix to hash kexec due to IAMR/=
AMOR")
> Cc: stable@vger.kernel.org # v4.10+
> Reported-by: Yilin Zhang <yilzhang@redhat.com>
> Debugged-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Tested-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/kernel/misc_64.S | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
> index 8ac0bd2bddb0..3280953a82cf 100644
> --- a/arch/powerpc/kernel/misc_64.S
> +++ b/arch/powerpc/kernel/misc_64.S
> @@ -623,7 +623,9 @@ BEGIN_FTR_SECTION
>  	 * NOTE, we rely on r0 being 0 from above.
>  	 */
>  	mtspr	SPRN_IAMR,r0
> +BEGIN_FTR_SECTION_NESTED(42)
>  	mtspr	SPRN_AMOR,r0
> +END_FTR_SECTION_NESTED_IFSET(CPU_FTR_HVMODE, 42)
>  END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
> =20
>  	/* save regs for local vars on new stack.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloXnxUACgkQbDjKyiDZ
s5LhzxAAgjsaztQtBRHj8hKLGpzUy8EKgYqcbFIcxegII5WydYZ84wEaU288RP1g
GJejEv34nbGzjGkBAO+dpsHAGxxvHK8oUdYv7K4Ieypc/DuW5F5sYlYquKAP/C2C
6SfnJ2Nq6JO0pWnYX3U4mLBmr2kiz7qvIWDDpqYZCAfWeEF/NqxFw00b+/VeO0qL
TnZd+bWYU6+zZJyPwkKgexen6r8CuMYBXRErIhOhsE6/Cmip+c6wBQ+DmwF/rcFp
Vnm1TSCXiYw73QK5qS8UplvZtEyrdKQ/Q3dEDvZp5pkb+gfnR3WqGqfygtmj9HNS
flC4yOhn08B7WB12u3xIlQglOUIIJOeRB1EKoj6UXccPvetnf5irg8iblosn1SUv
LeCdSHpR/I+H0ypA/D1UUwkLXLp4tB71R7NYZDsGWty5osuQvtsSj+X2SG+ooVqx
L/8ujsKuPGH4R6TdNqq3hAPUrkQcji5is/2h02X6BG4kvb7Q26+gp4jZ13FqKhTH
UJDETj2tEyYmYoeM6j0YQUjDdKv3a/IgyMJ8caBChQSbYHwnkNFyDL0sEvn8JhSY
ai7DOaicFGK8XsWuFN0TsJuaA48CcbegpaoMKIX1IQEzMtEJUqlMl4bwTONWgf+k
YqU5SN8qeDW5yJFpqHO+ja0TsBmZ4gc8aMu4VP9uwAi7W8E9CXY=
=8mOr
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
