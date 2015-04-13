Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 116391A01A7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 21:20:54 +1000 (AEST)
Date: Mon, 13 Apr 2015 21:20:48 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20150413212048.0db6414f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.jAhx/jos5s_FkjcKlzyLOM"; protocol="application/pgp-signature"
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
 Anton Blanchard <anton@samba.org>, Ulrich Obergfell <uobergfe@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/.jAhx/jos5s_FkjcKlzyLOM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

After merging the akpm-current tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

arch/powerpc/kernel/setup_64.c: In function 'disable_hardlockup_detector':
arch/powerpc/kernel/setup_64.c:796:2: error: implicit declaration of functi=
on 'watchdog_enable_hardlockup_detector' [-Werror=3Dimplicit-function-decla=
ration]
  watchdog_enable_hardlockup_detector(false);
  ^

Caused by commit 069bb95b9e38 ("watchdog: introduce the
hardlockup_detector_disable() function") interacting with commit
c54b2bf1b5e9 ("powerpc: Add ppc64 hard lockup detector support") from
the powerpc-mpe tree.

I applied the following merge fix patch (hopefully that is all that is
required):

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 13 Apr 2015 21:18:01 +1000
Subject: [PATCH] powerpc: merge fix for watchdog_enable_hardlockup_detector=
 API change

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/setup_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 7551e5692597..c69671c03c3b 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -793,7 +793,7 @@ u64 hw_nmi_get_sample_period(int watchdog_thresh)
  */
 static int __init disable_hardlockup_detector(void)
 {
-	watchdog_enable_hardlockup_detector(false);
+	hardlockup_detector_disable();
=20
 	return 0;
 }
--=20
2.1.4

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/.jAhx/jos5s_FkjcKlzyLOM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVK6aUAAoJEMDTa8Ir7ZwVjb0QAIkE5wzBA60xNHSTpcxBqrnW
KsIbwjwqAa/jmRHKK6Zo5H1ehgmvd7ze/m8P7mOpDMbQiZ2Y7S5D56o+z69tzvHs
kaV4Xs6nnoSBiFegnVtr1qC053hexOTWbtwVALpUdXfuQ1SHfvPmV2uGrEj80f5Q
xbQnyrmDX9PzLyXgloG3jQgoxCl0OcNneyFYISlGTNCMROkJ76YeuNl25pklMtZr
YV5tvGSyxBoQ/Lg9XKg/yGNcK7Ol+lF14hsudxVKaBSISsf7xqPufgoEqIhnRGgX
OtxedW7z2CpxOhEwTqQCb9tbZHESkFaMR2rawLJUsxAw7G/s4bNAriMZw1Pb6WqH
zpiCTtdn8QGZkJUvG9SyykWoGJPMXRdOH0ckjaF6qIOvkyV7EUhRXk51Hr5BLc1k
VQVcB1pgBU9Vgkmhm9SGgnGsO6O72BSEDN1/BivLMic+dOjuvjr8PbUJzUVhPCHy
bN1VIED1tPSVIqqIofpiFAmRensF2Pik553hMaBfc9fg0dJbNy+RVEj80ZsCSDy7
+6Zi5CU3xd9Cc6WT58zfQe5ca9qHHg6DZPZFTl/Wop0Chvjmz577TmL3LEhQm8pC
pII00tIotWqOOxPv+9Hvhy7/G6dWFUaEsO+cz22bx6ope1OExZwqruxXY0WJyTzE
ePVA2nylOsRUnblyevnw
=O5gX
-----END PGP SIGNATURE-----

--Sig_/.jAhx/jos5s_FkjcKlzyLOM--
