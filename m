Return-Path: <ldv@altlinux.org>
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 40MSkB5PKtzDqwb
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2018 03:36:00 +1000 (AEST)
Date: Thu, 12 Apr 2018 20:35:58 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via
 kill() returns wrong values in si_pid and si_uid
Message-ID: <20180412173558.GB31781@altlinux.org>
References: <20180409152253.GD10489@altlinux.org>
 <20180412013435.GA21219@altlinux.org>
 <20180412095811.GC16141@n2100.armlinux.org.uk>
 <20180412110314.GA28070@altlinux.org>
 <20180412121949.GD16141@n2100.armlinux.org.uk>
 <20180412124928.GA29458@altlinux.org>
 <20180412131404.GE16141@n2100.armlinux.org.uk>
 <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
In-Reply-To: <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2018 at 09:50:26AM -0700, Linus Torvalds wrote:
> Does this attached patch perhaps fix the ARM case?
>=20
> It just uses FPE_FLTUNK as the default si_code for SIGFPE, which seems
> sane enough. And then gets rid of FPE_FIXME, which should resolve the
> nasty case.
>=20
> Hmm? Entirely untested, and I didn't really look at the test-case in
> question since I can't really run it anyway.
>=20
> Well, I could run it all on x86-64, but it doesn't have that FPE_FIXME
> case at all.
>=20
>                  Linus

>  arch/arm/include/uapi/asm/siginfo.h | 7 -------
>  arch/arm/vfp/vfpmodule.c            | 4 ++--
>  2 files changed, 2 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/arm/include/uapi/asm/siginfo.h b/arch/arm/include/uapi/=
asm/siginfo.h
> index d0513880be21..d87beeedb4c4 100644
> --- a/arch/arm/include/uapi/asm/siginfo.h
> +++ b/arch/arm/include/uapi/asm/siginfo.h
> @@ -3,11 +3,4 @@
> =20
>  #include <asm-generic/siginfo.h>
> =20
> -/*
> - * SIGFPE si_codes
> - */
> -#ifdef __KERNEL__
> -#define FPE_FIXME	0	/* Broken dup of SI_USER */
> -#endif /* __KERNEL__ */
> -
>  #endif

Looks like the whole file should go away.

> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> index 4c375e11ae95..012c6e690303 100644
> --- a/arch/arm/vfp/vfpmodule.c
> +++ b/arch/arm/vfp/vfpmodule.c
> @@ -251,13 +251,13 @@ static void vfp_panic(char *reason, u32 inst)
>   */
>  static void vfp_raise_exceptions(u32 exceptions, u32 inst, u32 fpscr, st=
ruct pt_regs *regs)
>  {
> -	int si_code =3D 0;
> +	int si_code =3D FPE_FLTUNK;

Note that this change would affect the following code
at the end of vfp_raise_exceptions:

	if (si_code)
		vfp_raise_sigfpe(si_code, regs);

>  	pr_debug("VFP: raising exceptions %08x\n", exceptions);
> =20
>  	if (exceptions =3D=3D VFP_EXCEPTION_ERROR) {
>  		vfp_panic("unhandled bounce", inst);
> -		vfp_raise_sigfpe(FPE_FIXME, regs);
> +		vfp_raise_sigfpe(si_code, regs);
>  		return;
>  	}
> =20

To be on the safe side, I'd just change it this way:

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 4c375e1..66a73ba 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -257,7 +257,7 @@ static void vfp_raise_exceptions(u32 exceptions, u32 in=
st, u32 fpscr, struct pt_
=20
 	if (exceptions =3D=3D VFP_EXCEPTION_ERROR) {
 		vfp_panic("unhandled bounce", inst);
-		vfp_raise_sigfpe(FPE_FIXME, regs);
+		vfp_raise_sigfpe(FPE_FLTUNK, regs);
 		return;
 	}

--=20
ldv

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJaz5j+AAoJEAVFT+BVnCUIm/wP/2eq8/68d1NVNF01NjMWDD+u
616rI6HzlbQdNUQP3kS6nytxeySvC+q8e04VUwiuWLXgB9/guf2677kv5CDYeThz
qsma77P4eDxc/DkPHyNbD2/aC658IJIpZiBI/8CMHmPEJ9jaBCs6jndDEHJW2eXp
ExEQVp6XO77VVsekcthmB/ZbpwUzeUdvdWuoYzk0TccYSXlEZjUZCmvv8cfvX8fV
Jb1urXaDWe8Y+9ivBAxCituHY9EBrKuf6Me9ZxY8KA/Vm+bEdlI1JGLpyqrs1CEn
a1kb9ORsffTQ0hDpAr1vGd9ld4PLF2HUQEsYaJeUWSKWjqVyDA0ntTDfizplPMge
nYH6QRC6mhCpD9hJpXf6opNn8cLebycKRkw5nU8LOn70eAKVufkXqz3gfjwLFNxy
M8T41NEPTi61Qa95cWZzogCqclcrlerlF5tSZTDXdjFoUShr99KzZg4zvj2SrcV2
pW12Q7nwRY8tAXBSqezNZHgP+XDfVQyJAQ53+NCevnZ+cttcmAcg8gDNWexX0UCL
k1dkxfBFRnYSpKQQTk+FzcWpUNSbEI5jQo56jcoFEZc5fX7kponVPTQnNyDRbYXf
7CDiYnNNM1ezh0qHQ/gPsEX1bFDyVO2ztRDwGvp4juD8gqpLdRfZa/16QULaTMYT
xlYtF7yblFtBqcwGvlq6
=nbH6
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
