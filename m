Return-Path: <srs0=pnns=jo=redhat.com=dgibson@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41GT2c0zGQzF1NW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 15:33:12 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41GT2c0J5lz8sv6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 15:33:12 +1000 (AEST)
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41GT2b1zbXz9s31
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2018 15:33:11 +1000 (AEST)
Date: Thu, 28 Jun 2018 15:32:56 +1000
From: David Gibson <dgibson@redhat.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>, Dave Young <dyoung@redhat.com>, Mahesh J
 Salgaonkar <mahesh@linux.ibm.com>
Subject: Re: [PATCH] powerpc/kdump: handle crashkernel memory reservation
 failure
Message-ID: <20180628153256.7848bd3a@umbus.fritz.box>
In-Reply-To: <153016319642.8584.7868984232962915832.stgit@hbathini.in.ibm.com>
References: <153016319642.8584.7868984232962915832.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xjvsL0C4cpXfRfTJQpJ6pUT"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/xjvsL0C4cpXfRfTJQpJ6pUT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Jun 2018 10:49:56 +0530
Hari Bathini <hbathini@linux.ibm.com> wrote:

> Memory reservation for crashkernel could fail if there are holes around
> kdump kernel offset (128M). Fail gracefully in such cases and print an
> error message.
>=20
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

Tested-by: David Gibson <dgibson@redhat.com>

> ---
>  arch/powerpc/kernel/machine_kexec.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/ma=
chine_kexec.c
> index 936c7e2..6181442 100644
> --- a/arch/powerpc/kernel/machine_kexec.c
> +++ b/arch/powerpc/kernel/machine_kexec.c
> @@ -188,7 +188,12 @@ void __init reserve_crashkernel(void)
>  			(unsigned long)(crashk_res.start >> 20),
>  			(unsigned long)(memblock_phys_mem_size() >> 20));
> =20
> -	memblock_reserve(crashk_res.start, crash_size);
> +	if (!memblock_is_region_memory(crashk_res.start, crash_size) ||
> +	    memblock_reserve(crashk_res.start, crash_size)) {
> +		printk(KERN_ERR "Failed to reserve memory for crashkernel!\n");
> +		crashk_res.start =3D crashk_res.end =3D 0;
> +		return;
> +	}
>  }
> =20
>  int overlaps_crashkernel(unsigned long start, unsigned long size)
>=20


--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/xjvsL0C4cpXfRfTJQpJ6pUT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls0cwgACgkQbDjKyiDZ
s5LxDA//foU6cBr8JS+LHlLW1IJv0zm5yMw/lDUEPi6/sp+L5naKoeMXnrXq9z61
HrDjCf8jn4jftmbl+dnaE6Pc2G2+3fT10q+0bSVyjWvIuQrU5o+8vNnUjk7yhGIl
dfaFtA5WSNve8cyb8yUQm6g4WsbStb1VfIvB3ULDM2xK+CjzC8qpvoSmfO0ICCKM
FQOGZcEa+54J6lKogINWHiFR5f7lI7L+Q5GHr3GH6nbXxk3WF5Fn46ScXjAwN4Lq
XK6tyf1Ejk6MDwsUd4L1FOzxXz5SKfT6iIM9KCKYtIi7LpsqPcpGw3CfQP3wkrwy
7wWG1zS8KxTtvyYo3WtfveYf4sbZOG9rrsDveuwZokjkSQ16QOS+ZMp3zrxth9BW
XWdzx4faV55SrlMfktrM8MFNq8xoYBiOct6gZEJlL5yPv8tGmFAMMNa1wet/RNSR
1IaUy5+3vXdXONVyCCw/scN18Vgc7B6dret0gWbWSciMeQIb39Ad9EoqTaRq1CK9
lulL9rFZO1qGrgOzH3Dand4et0vhjfHEmIj3tWUv9YwaJ/oU4lj1eKi2QTX2D5gl
HwbZ5eupq4y4D/U/+AdblJ/RxMelHE0hgEDkfjv6RWuAMFxpdirHcJMR+9WSf8Fb
Pg0vIMJ/hV0HMJ998WGUEkLre4Fp7mhda/q13XLPecCDWOiphc4=
=G2Gg
-----END PGP SIGNATURE-----

--Sig_/xjvsL0C4cpXfRfTJQpJ6pUT--
