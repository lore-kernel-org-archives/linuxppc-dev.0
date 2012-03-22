Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 34384B6EEF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 14:44:02 +1100 (EST)
Date: Thu, 22 Mar 2012 14:43:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>
Subject: [PATCH] c6x: remove irq_set_virq_count
Message-Id: <20120322144352.fe7f1840c3958f0496310ec4@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__22_Mar_2012_14_43_52_+1100_/Cr6ucafWh7NLH/c"
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-c6x-dev@linux-c6x.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__22_Mar_2012_14_43_52_+1100_/Cr6ucafWh7NLH/c
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This function was copied over from the powerpc architecture but is not
used at all, so just remove it.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/c6x/include/asm/irq.h |   10 ----------
 arch/c6x/kernel/irq.c      |    9 ---------
 2 files changed, 0 insertions(+), 19 deletions(-)

This was found while cleaning up the PowerPC legacy iSeries platform.

diff --git a/arch/c6x/include/asm/irq.h b/arch/c6x/include/asm/irq.h
index a6ae3c9..7febe9d 100644
--- a/arch/c6x/include/asm/irq.h
+++ b/arch/c6x/include/asm/irq.h
@@ -174,16 +174,6 @@ extern void irq_set_default_host(struct irq_host *host=
);
=20
=20
 /**
- * irq_set_virq_count - Set the maximum number of virt irqs
- * @count: number of linux virtual irqs, capped with NR_IRQS
- *
- * This is mainly for use by platforms like iSeries who want to program
- * the virtual irq number in the controller to avoid the reverse mapping
- */
-extern void irq_set_virq_count(unsigned int count);
-
-
-/**
  * irq_create_mapping - Map a hardware interrupt into linux virq space
  * @host: host owning this hardware interrupt or NULL for default host
  * @hwirq: hardware irq number in that host space
diff --git a/arch/c6x/kernel/irq.c b/arch/c6x/kernel/irq.c
index 0929e4b..e2e4daa 100644
--- a/arch/c6x/kernel/irq.c
+++ b/arch/c6x/kernel/irq.c
@@ -279,15 +279,6 @@ void irq_set_default_host(struct irq_host *host)
 	irq_default_host =3D host;
 }
=20
-void irq_set_virq_count(unsigned int count)
-{
-	pr_debug("irq: Trying to set virq count to %d\n", count);
-
-	BUG_ON(count < NR_PRIORITY_IRQS);
-	if (count < NR_IRQS)
-		irq_virq_count =3D count;
-}
-
 static int irq_setup_virq(struct irq_host *host, unsigned int virq,
 			    irq_hw_number_t hwirq)
 {
--=20
1.7.9.1

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__22_Mar_2012_14_43_52_+1100_/Cr6ucafWh7NLH/c
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPap/4AAoJEECxmPOUX5FE5yUQAKKDQRxhbsNGSteaEs18PAlA
6cQWdq8nVE1L22nQqwNBZfRCBCD+A42i7L/bFN4NWPJeygOUFnhFiTrtrQKs/a0q
CFNJSEemXKQufbMsMrXS98Gfy5x0os9NGqYr76mH1Gw0TgyWXXY1N6tKnpZ5cRoi
N+MiqM92ceTqF9tBZLr/p+RbNga7TDQVHRjk+LGdH3HCjncwCzaZCEmTuieCCK3J
ROlI6lx143qV2TI1XpTxFF1O4qSIGQQYdyUggl5nTIsaWkA0v0JstYi1cNCCPW5R
wmxValUEa2Wp4f5uenIIsVxFTCmqMG9TMpIgb6vHXSU8COkCpHKmwgjqZ2lK9gaC
MPmiTs4Jo5Ejfa3+XEABny4y9H88BI/dwApKbWaYU42sn5qWyFysLlRKkldLNk1F
6PUxsH+zKEGRCDP5Os5zXiEID848DpAQky//t5K4LKZOu1QFAT4LZIS/2muv+ezw
HhZ+tQ1lPqQysXlEptrEC2SvQjchxrV0HK4zcJ3AOwKN5YobrnjsRVdQk92e8cbN
UpBCip7G9sLeCzya+oiUxsZyj11Y38k+01ZKH2v3S9t+G90Ds0B8ugJqPMemgYp8
Dn+gE+MKorq7nXizsmv+s4Ya8naMsH4eHCKCOTloBJLtcO8Lz+b/atoXJItYfyui
SemdgVVPm2LnlH6DkBZq
=Pj22
-----END PGP SIGNATURE-----

--Signature=_Thu__22_Mar_2012_14_43_52_+1100_/Cr6ucafWh7NLH/c--
