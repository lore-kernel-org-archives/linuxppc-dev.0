Return-Path: <dja@axtens.net>
Received: from mail-pd0-x229.google.com (mail-pd0-x229.google.com
 [IPv6:2607:f8b0:400e:c02::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 060A51A045E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 15:05:20 +1000 (AEST)
Received: by pdrg1 with SMTP id g1so132232749pdr.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 22:05:16 -0700 (PDT)
Message-ID: <1437541404.30906.43.camel@axtens.net>
Subject: Re: [PATCH v5 7/7] powerpc/powernv: nest pmu cpumask and cpu
 hotplug support
From: Daniel Axtens <dja@axtens.net>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Peter
 Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Preeti U Murthy <preetium@andrew.cmu.edu>, Sukadev Bhattiprolu
 <sukadev@linux.vnet.ibm.com>,  Ingo Molnar <mingo@kernel.org>, Anshuman
 Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 22 Jul 2015 15:03:24 +1000
In-Reply-To: <1437045206-7491-8-git-send-email-maddy@linux.vnet.ibm.com>
References: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1437045206-7491-8-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-jHstorbYGIgS/giXn/Lm"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-jHstorbYGIgS/giXn/Lm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> +static void nest_change_cpu_context(int old_cpu, int new_cpu)
> +{
> +	int i;
> +
> +	for (i =3D 0; per_nest_pmu_arr[i] !=3D NULL; i++)
> +		perf_pmu_migrate_context(&per_nest_pmu_arr[i]->pmu,
> +						old_cpu, new_cpu);
=46rom patch 4, I see per_nest_pmu_arr is defined as:
 +static struct nest_pmu *per_nest_pmu_arr[P8_NEST_MAX_PMUS];

Therefore, does this loop need to have a check that=20
i < P8_NEST_MAX_PMUS?


--=20
Regards,
Daniel

--=-jHstorbYGIgS/giXn/Lm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVryQcAAoJEPC3R3P2I92FdCkP/1lyVhSzMyLcjjEDRiq64996
kGwMUTZSlaCq0Go/wSsKd7bai8/3CTWqTlXCTKfTErjoX5fqPGfRJV9TxzMdxfb3
RP5lpQLX92BKAhfDvAWfBou5itEKPIHdhfrQAH4yramEWcZ0DqXX5gPLLZYGsXIA
iOA9g2IZsR4A8iLGceJSAsw+tzLFdHFHEWAwP6CJPWLvOUkvKA9oGr5lbvtigNKw
vTTV1e8hf2bPIXXYMSIoa9mp4kz4ZumdP5vLz8x9+vvAUXvxgFxAXuA35hhov36g
2QSen+1psZ7GaIf4Fl++llZmkwnQfY2yzlVYCplNGYgZPxdhElsRtnAqtnKsdjhI
d12DSLc5AXj/r8sDDwsTc/fYZyzQS1yl9tP4vkHNXCBkxBrYJrg4+P63TwjT1whV
88DyUKRhX1oHqb+bPZTUMH4CRzoAxHZWwpeWN1uMbmbEbjsIeGhylpWoxcx5Gky0
mMnZM4lwtbCbgvSmPqtXPO8rh8B9ob2r2/ol0TiOM/EMg58ILX65K089NBi/TQBh
jbw04vg3SuFuUdVc0/vdIXC9+843DAW/aC7EZh1CB8RkABV6KRKvMXGVi6+p2IJ7
0g9r+dOGRYPOUIduF2DrUUv7g9sQB+b+wwQFphYri7OynB9YSTN2TreEG6f0f8e/
3lDGTrq1xG5LRc/QI+31
=2o1G
-----END PGP SIGNATURE-----

--=-jHstorbYGIgS/giXn/Lm--
