Return-Path: <richard@nod.at>
Received: from radon.swed.at (a.ns.miles-group.at [95.130.255.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "radon.swed.at", Issuer "neon.swed.at" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3D556B6EEE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2012 22:19:12 +1100 (EST)
Message-ID: <4F6DAC0C.4010203@nod.at>
Date: Sat, 24 Mar 2012 12:12:12 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Subject: Re: [PATCH 08/10] um: Fix possible race on task->mm
References: <20120324102609.GA28356@lizard> <20120324103050.GH29067@lizard>
In-Reply-To: <20120324103050.GH29067@lizard>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD953513F54FF3AFE747589E6"
Cc: Mike Frysinger <vapier@gentoo.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Paul Mundt <lethal@linux-sh.org>,
 John Stultz <john.stultz@linaro.org>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 uclinux-dist-devel@blackfin.uclinux.org, Russell King <linux@arm.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD953513F54FF3AFE747589E6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 24.03.2012 11:30, schrieb Anton Vorontsov:
> Checking for task->mm is dangerous as ->mm might disappear (exit_mm()
> assigns NULL under task_lock(), so tasklist lock is not enough).
>=20
> We can't use get_task_mm()/mmput() pair as mmput() might sleep,
> so let's take the task lock while we care about its mm.
>=20
> Note that we should also use find_lock_task_mm() to check all process'
> threads for a valid mm, but for uml we'll do it in a separate patch.
>=20
> Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard


--------------enigD953513F54FF3AFE747589E6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPbawQAAoJEN9758yqZn9et8IIAIjjApdHtjO4jbQojJt9/hMC
a2mKqQUILDnbdr7KTCZu3OGUbHpQhvdWYo1ZssGjz9XHSDFIKF8PdmSwPuh46HcO
GZwGZ6gfPRV23gJr1BnT+WkJzRoC4CG/xBzt2YpPMgjLDFAs4mkGX0w0knd/iEYD
hu185ttLe/u2DmU2rbCsEJ9YfxkwQ0+326WxH7D71HwAMpRCtmg1ciPdXMabeNnq
mU6gHLh7JPKWu8QPYWLwF+NRAzqOAENnHZkBEBX3rvapkQhIYdFWBHLhY2Wh9dgL
8cLyhir504HG+JcT5wegeivcMT2YQ/ODRuPqCwUsUEXxjI5caPzyWfsV3d2Y2nI=
=J9Yc
-----END PGP SIGNATURE-----

--------------enigD953513F54FF3AFE747589E6--
