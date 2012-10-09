Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 154BF2C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2012 10:21:59 +1100 (EST)
Date: Wed, 10 Oct 2012 10:21:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: linux-next: build failure after merge of the origin tree
Message-Id: <20121010102150.81c192c6fdf60689dc823b20@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__10_Oct_2012_10_21_50_+1100_dVUeUcEMgQzVSk.2"
Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
 linux-next@vger.kernel.org, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__10_Oct_2012_10_21_50_+1100_dVUeUcEMgQzVSk.2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

In Linus' tree, today's linux-next build (powerpc ppc64_defconfig) failed
like this:

arch/powerpc/platforms/pseries/hotplug-memory.c: In function 'pseries_remov=
e_memblock':
arch/powerpc/platforms/pseries/hotplug-memory.c:103:17: error: unused varia=
ble 'pfn' [-Werror=3Dunused-variable]

Caused by commit d760afd4d257 ("memory-hotplug: suppress "Trying to free
nonexistent resource <XXXXXXXXXXXXXXXX-YYYYYYYYYYYYYYYY>" warning").

I can't see what the point of the "pfn" variable is and this patch never
appeared in linux-next before being merged.  :-(

I have reverted that commit for today.

If this patch truly was authored yesterday (according the Author Date in
git), why was it merged yesterday while still under discussion?  And the
latest update to it still has this build problem ... did anyone even try
to build this for powerpc (since that architecture was obviously
affected)?  (Cross compilers available here
http://www.kernel.org/pub/tools/crosstool/).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Wed__10_Oct_2012_10_21_50_+1100_dVUeUcEMgQzVSk.2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQdLGOAAoJEECxmPOUX5FEswcP/01NYzXpn4Nom9jpiJNY9C4f
8a4xRjXK/yd8XuRzMUJ3qtrjp3nV3hDROkpiRWwCGjDLxelBS7LonmJoNgGvBC+W
pDbHRAGIN0asiVF2Kmvl2Fbj8qWJEwPCLO84uPY7iL8HS0f2+3tJHBZYn8AtIm+u
M9UKGT/DlRB3yZkaE3XOgTRCSs8QT4Q77EgBTPlBVJ02RsO5tWYvK4f/JgPqCFJ7
D0vBpww3U7iRH0V6gTrSsUIr4oOOHTEFxCEavdTyBHtidw2zZkV8Eu9sPw0e+hNG
tBBKtoNrayu2Wty2ho+d8LWnc0YD6v1n6Uzp8mAW4ELpm1vsHziO7Q81h1CfimCs
3qcdeYXImWBwMGwqmEAnXecMmt80HCrilgjSbO+FZM5CEPzdyyUqqVBvddagK4oh
FvPFnhNKKvm1GUZQ/96Ch2JAR5K2mDvDwirVnqA8QJZAg1jD12apFZo0aCXDuPh+
TzurycGCY5ajt55sq7RKB/sibf57oBL5WWmrfPlwt8ICJD7mo9vQi5uspwrt2TEj
6tiVQjrTvlNes3Ts0Gs9Nwc/xPwGx0MhXCMYq1KkZFvkW1NEAzKU0vWip+zPIVrP
UfRPkpDkc0ihFqEFJX2MBXRZUpMk40sk3fgN2G72QH2bdV5hOp+QDYHY5jIiWpS1
GwmF8zuvcnF3a1mxYMsY
=o7kK
-----END PGP SIGNATURE-----

--Signature=_Wed__10_Oct_2012_10_21_50_+1100_dVUeUcEMgQzVSk.2--
