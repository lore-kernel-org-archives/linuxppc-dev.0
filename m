Return-Path: <devurandom@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by ozlabs.org (Postfix) with ESMTP id 002762C0177
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 22:01:23 +1000 (EST)
Received: from mailout-de.gmx.net ([10.1.76.17]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0MLDZP-1UUt1c34vx-000Il2 for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 14:01:21 +0200
Date: Tue, 23 Apr 2013 14:01:16 +0200
From: Dennis Schridde <devurandom@gmx.net>
To: arnd@arndb.de, linuxppc-dev@lists.ozlabs.org, cbe-oss-dev@lists.ozlabs.org
Subject: Re: PROBLEM: Only 2 of 4 cores used on IBM Cell blades and no
 threads shown in spufs
Message-ID: <20130423140116.0a40c2c6@samson>
In-Reply-To: <1470334.YUWOQ37ijW@ernie>
References: <1470334.YUWOQ37ijW@ernie>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_//AUdSGKWtAmiYK=nwx=/s/3"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_//AUdSGKWtAmiYK=nwx=/s/3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Mon, 22 Apr 2013 18:44:13 +0200
schrieb Dennis Schridde <devurandom@gmx.net>:
> [4.] Kernel information
>=20
> [4.1.] Kernel version (from /proc/version):
> I am using the Linux 3.8.8 kernel (vanilla-sources-3.8.8 on
> Gentoo/Linux): # cat /proc/version=20
> Linux version 3.8.8 (root@blade00) (gcc version 4.7.2 (Gentoo
> 4.7.2-r1 p1.5, pie-0.5.5) ) #2 SMP Mon Apr 22 18:21:20 CEST 2013

Actually this is only partially correct.

I applied following patch by Grant Likely
<grant.likely@secretlab.ca> to fix some IRQ mapping problems:

diff --git a/arch/powerpc/platforms/cell/pmu.c
b/arch/powerpc/platforms/cell/pmu.c index 59c1a16..348a27b 100644
--- a/arch/powerpc/platforms/cell/pmu.c
+++ b/arch/powerpc/platforms/cell/pmu.c
@@ -382,7 +382,7 @@ static int __init cbe_init_pm_irq(void)
        unsigned int irq;
        int rc, node;

-       for_each_node(node) {
+       for_each_online_node(node) {
                irq =3D irq_create_mapping(NULL, IIC_IRQ_IOEX_PMI |
                                               (node <<
  IIC_IRQ_NODE_SHIFT)); if (irq =3D=3D NO_IRQ) {


And now I also applied the patch by Michael Ellerman
<michael@ellerman.id.au> that supposedly fixes the
all-processes-running-on-CPU0 issue - I will report back with results
later.

--Dennis

--Sig_//AUdSGKWtAmiYK=nwx=/s/3
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlF2eAwACgkQjqfyF1DtJW6yAQCfcEx8GAnugFpEHmue1K7zIEuP
nZ8AoIgMY247iNJOnZQSqIHUPut1a4iv
=KmBv
-----END PGP SIGNATURE-----

--Sig_//AUdSGKWtAmiYK=nwx=/s/3--
