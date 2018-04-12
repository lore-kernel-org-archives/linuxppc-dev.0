Return-Path: <ldv@altlinux.org>
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 40MJ1207cwzDrLj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 21:03:17 +1000 (AEST)
Date: Thu, 12 Apr 2018 14:03:14 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via
 kill() returns wrong values in si_pid and si_uid
Message-ID: <20180412110314.GA28070@altlinux.org>
References: <20180409152253.GD10489@altlinux.org>
 <20180412013435.GA21219@altlinux.org>
 <20180412095811.GC16141@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
In-Reply-To: <20180412095811.GC16141@n2100.armlinux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2018 at 10:58:11AM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 12, 2018 at 04:34:35AM +0300, Dmitry V. Levin wrote:
> > A similar commit v4.16-rc1~159^2~37
> > ("signal/arm: Document conflicts with SI_USER and SIGFPE") must have
> > introduced a similar ABI regression to compat arm.
>=20
> So, could you explain how can this change cause a regression?
>=20
> +#define FPE_FIXME      0
> -               vfp_raise_sigfpe(0, regs);
> +               vfp_raise_sigfpe(FPE_FIXME, regs);

No, this hunk hasn't caused the regression, but another one did:

diff --git a/arch/arm/include/uapi/asm/siginfo.h b/arch/arm/include/uapi/as=
m/siginfo.h
new file mode 100644
index 0000000..d051388
--- /dev/null
+++ b/arch/arm/include/uapi/asm/siginfo.h
@@ -0,0 +1,13 @@
+#ifndef __ASM_SIGINFO_H
+#define __ASM_SIGINFO_H
+
+#include <asm-generic/siginfo.h>
+
+/*
+ * SIGFPE si_codes
+ */
+#ifdef __KERNEL__
+#define FPE_FIXME      0       /* Broken dup of SI_USER */
+#endif /* __KERNEL__ */
+
+#endif

This is due to FPE_FIXME handling in kernel/signal.c


--=20
ldv

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJazzzyAAoJEAVFT+BVnCUIw1YP/0I5ff8Z4fOIPctdlF7NS3Jh
c2TAv7D40LUzHOnfXWx2Fy8hzScahtMi1FGOhwFCHvQawI1XYYKG1QAKOtOBV/ut
bpPe/p/4Ib0Qjep1MNB+nhfmXHUS/GVGoFDp5cueyKqw9axCjkJGU1zZ1s4Frpme
KMufr8I5JOh7mKh11lHiktGkP4oQFfVhHAnpn3GgsDDr0Lm3ASA759nEHQYSQ0yc
uDNQrSYjdFoWsXoijWOq5zmABNcYi0c3L+6HJQVXH/FEXLDHyxv3uLSLWQ6KZt1G
28vT61+SEko2RWM7ethcXc9J0VEgl20cQ5BLsYhExrje872YillIwAVHrbxE8SZh
u6lHx+VYlHpYP+H3p67/pb1RbMGUNLK8fUv+oOif5FaPwShhRVtJGKhGsg4yyKAz
3Kh6PkeE5LhRo4OUhq8SjeMHSPlgidmcAXZJSsNlW2A1+5IEnd640JfKyP7jcgOg
AZEos39gLXAp0iMIff9IdrLmNtqc/LCKP5bE1PKXdpsyhMI/B3tN6h4DkTcU5X5I
2V4SofWNC084zpxE8fHAQZ+Iwj9AEwCAatCnnoFxFm2AxyiCQmChXoS5RN+hPAOB
6S70Qob9vxMPPPdHPyDvor6DwKUwHiPYAvfxGRq08nkDkkRLy09NCjofMBwvnGZF
5FZOXAQ3wERpSpjaklJH
=kR/I
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
