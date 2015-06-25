Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C80AA1A06A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 15:03:47 +1000 (AEST)
Received: from mail-pd0-x230.google.com (mail-pd0-x230.google.com
 [IPv6:2607:f8b0:400e:c02::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 52616140306
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 15:03:42 +1000 (AEST)
Received: by pdjn11 with SMTP id n11so45303960pdj.0
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2015 22:03:40 -0700 (PDT)
Message-ID: <1435208534.4286.25.camel@axtens.net>
Subject: Re: [PATCH V9 04/13] powerpc, perf: Restore privilege level filter
 support for BHRB
From: Daniel Axtens <dja@axtens.net>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com,
 mikey@neuling.org
Date: Thu, 25 Jun 2015 15:02:14 +1000
In-Reply-To: <1434370268-19056-5-git-send-email-khandual@linux.vnet.ibm.com>
References: <1434370268-19056-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1434370268-19056-5-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-DRjsa3zAJaeVgfMlIylP"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-DRjsa3zAJaeVgfMlIylP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-boo=
k3s.c
> index 7a03cce..892340e 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -930,7 +930,7 @@ static int power_check_constraints(struct cpu_hw_even=
ts *cpuhw,
>   * added events.
>   */
>  static int check_excludes(struct perf_event **ctrs, unsigned int cflags[=
],
> -			  int n_prev, int n_new)
> +			  int n_prev, int n_new, int bhrb_users)
Shouldn't this be an unsigned int too?

> -	if (ppmu->flags & PPMU_ARCH_207S)
> +	if ((ppmu->flags & PPMU_ARCH_207S) && !bhrb_users)
This is now different to the others. Now that bhrb_users is unsigned,
I'm happy if you want to revert all of them to be like this, I was just
concerned that if bhrb_users is an int, both 1 and -1 evaluate to true
and I wasn't sure that was the desired behaviour.

--=20
Regards,
Daniel

--=-DRjsa3zAJaeVgfMlIylP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVi4tgAAoJEPC3R3P2I92FGbwQAMM7GDl4rtEOl/CrAawj2Wb6
xnaMES4J//kgdtoF+Zq9TnH2Ds6VNM87ytROstgNo+RfPJK8plaDUsVVIXOyzvhj
i6l1wj1hPIInAxCgY1c3ffUY8oDNi5HB27t7k327szLAbBW3m9Vyu1fK3EInpUft
BP/4jLHSJIMW00/Nc/YpFkOIycorE5suP+mBWkKTBg9ZqJz4kw5KltV9CU0vxbjm
546YyhUR1LtUkJ18AITKKkcs/k0h6UD0X14ObGEDtvmxjBEyg9ixCdapmERynA6z
CG29FdCzlTVhJQuY1EcmLELYty4JtuHhDse8WHQHsaNUbc/LUUyDCEyCiJTt3yIn
OcPz6vC40rOFtqOR7T+o7bcFjvTmr8AUI11GE2jKk4qVVV1//mVJtnnLJSecQSK/
Q442mZ/C/rM17xVxSj7ofRgRs+qSOT1gcVky0iHw7GJdpHKt7Q4mMlM2gxZSoL0N
H1VJdN1ieXt3UJmR0V0pCstsk2dcKfCcKJO567Jwf5990XIAEE0VuzQP1LYWvN7n
+QEyEol73uYvAHXHk8uE3/Ft/A0wIfnmXW3Nb7q938GYqlqnL+NMi42z67f52Ncb
++UNciN6Fpth9QjsGwDZx5CH+fzJqSgIMI91cFbZCbCJ9RzL2L1i5BzV7Xx8+mx1
Q4fPoicMSEFL5EWxInyb
=yWq+
-----END PGP SIGNATURE-----

--=-DRjsa3zAJaeVgfMlIylP--
