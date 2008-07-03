Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B1B6DDDF08
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 17:10:13 +1000 (EST)
Date: Thu, 3 Jul 2008 17:10:07 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ingo Molnar <mingo@elte.hu>, Jens Axboe <jens.axboe@oracle.com>
Subject: linux-next: generic-ipi tree build failure
Message-Id: <20080703171007.5a17ea25.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__3_Jul_2008_17_10_07_+1000_WS+ih1zms2K5olFz"
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__3_Jul_2008_17_10_07_+1000_WS+ih1zms2K5olFz
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ingo, Jens,

Today's linux-next build (powerpc ppc64_defconfig) failed like this:

arch/powerpc/mm/tlb_64.c: In function 'pgtable_free_now':
arch/powerpc/mm/tlb_64.c:66: error: too many arguments to function 'smp_cal=
l_function'
arch/powerpc/mm/slice.c: In function 'slice_get_unmapped_area':
arch/powerpc/mm/slice.c:559: error: too many arguments to function 'on_each=
_cpu'
arch/powerpc/kernel/machine_kexec_64.c: In function 'kexec_prepare_cpus':
arch/powerpc/kernel/machine_kexec_64.c:175: error: too many arguments to fu=
nction 'smp_call_function'

I applied the patch below.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

>From 8bfda9c27bed42020ad1a9058766c4586eeffd58 Mon Sep 17 00:00:00 2001
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 3 Jul 2008 17:06:46 +1000
Subject: [PATCH] generic-ipi: powerpc fallout fixes

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/machine_kexec_64.c |    2 +-
 arch/powerpc/mm/slice.c                |    2 +-
 arch/powerpc/mm/tlb_64.c               |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/m=
achine_kexec_64.c
index 631dfd6..a168514 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -172,7 +172,7 @@ static void kexec_prepare_cpus(void)
 {
 	int my_cpu, i, notified=3D-1;
=20
-	smp_call_function(kexec_smp_down, NULL, 0, /* wait */0);
+	smp_call_function(kexec_smp_down, NULL, /* wait */0);
 	my_cpu =3D get_cpu();
=20
 	/* check the others cpus are now down (via paca hw cpu id =3D=3D -1) */
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 583be67..db44e02 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -556,7 +556,7 @@ unsigned long slice_get_unmapped_area(unsigned long add=
r, unsigned long len,
 	if (mask.low_slices || mask.high_slices) {
 		slice_convert(mm, mask, psize);
 		if (psize > MMU_PAGE_BASE)
-			on_each_cpu(slice_flush_segments, mm, 0, 1);
+			on_each_cpu(slice_flush_segments, mm, 1);
 	}
 	return addr;
=20
diff --git a/arch/powerpc/mm/tlb_64.c b/arch/powerpc/mm/tlb_64.c
index 509bc56..a01b5c6 100644
--- a/arch/powerpc/mm/tlb_64.c
+++ b/arch/powerpc/mm/tlb_64.c
@@ -63,7 +63,7 @@ static void pgtable_free_now(pgtable_free_t pgf)
 {
 	pte_freelist_forced_free++;
=20
-	smp_call_function(pte_free_smp_sync, NULL, 0, 1);
+	smp_call_function(pte_free_smp_sync, NULL, 1);
=20
 	pgtable_free(pgf);
 }
--=20
1.5.6


--Signature=_Thu__3_Jul_2008_17_10_07_+1000_WS+ih1zms2K5olFz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhse08ACgkQjjKRsyhoI8zeewCeIK5U/WVRGuxInMd9to/3gNZD
SWsAn1N1MC/1G/kcc+6xX5ojKnM3YbM7
=qtWw
-----END PGP SIGNATURE-----

--Signature=_Thu__3_Jul_2008_17_10_07_+1000_WS+ih1zms2K5olFz--
