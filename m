Return-Path: <sfr@canb.auug.org.au>
Date: Thu, 22 Mar 2012 15:09:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: remove NO_IRQ_IGNORE
Message-Id: <20120322150951.c72802434bbb9d8a5b5562f2@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__22_Mar_2012_15_09_51_+1100_8BFW=qc6J5igXU1c"
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__22_Mar_2012_15_09_51_+1100_8BFW=qc6J5igXU1c
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Now that legacy iSeries is gone, this is no longer used.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/asm/irq.h     |    6 ------
 arch/powerpc/include/asm/machdep.h |    4 +---
 arch/powerpc/kernel/irq.c          |    4 ++--
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index c0e1bc3..22064be 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -26,12 +26,6 @@ extern atomic_t ppc_n_lost_interrupts;
 /* This number is used when no interrupt has been assigned */
 #define NO_IRQ			(0)
=20
-/* This is a special irq number to return from get_irq() to tell that
- * no interrupt happened _and_ ignore it (don't count it as bad). Some
- * platforms like iSeries rely on that.
- */
-#define NO_IRQ_IGNORE		((unsigned int)-1)
-
 /* Total number of virq in the platform */
 #define NR_IRQS		CONFIG_NR_IRQS
=20
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/=
machdep.h
index bf37931..42ce570 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -99,9 +99,7 @@ struct machdep_calls {
=20
 	void		(*init_IRQ)(void);
=20
-	/* Return an irq, or NO_IRQ to indicate there are none pending.
-	 * If for some reason there is no irq, but the interrupt
-	 * shouldn't be counted as spurious, return NO_IRQ_IGNORE. */
+	/* Return an irq, or NO_IRQ to indicate there are none pending. */
 	unsigned int	(*get_irq)(void);
=20
 	/* PCI stuff */
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 45b367c..4ec471a 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -445,9 +445,9 @@ void do_IRQ(struct pt_regs *regs)
 	may_hard_irq_enable();
=20
 	/* And finally process it */
-	if (irq !=3D NO_IRQ && irq !=3D NO_IRQ_IGNORE)
+	if (irq !=3D NO_IRQ)
 		handle_one_irq(irq);
-	else if (irq !=3D NO_IRQ_IGNORE)
+	else
 		__get_cpu_var(irq_stat).spurious_irqs++;
=20
 	irq_exit();
--=20
1.7.9.1

--=20
Stephen Rothwell <sfr@canb.auug.org.au>

--Signature=_Thu__22_Mar_2012_15_09_51_+1100_8BFW=qc6J5igXU1c
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPaqYPAAoJEECxmPOUX5FEjvcP/2MVx5WTaeVTXEh1d2mO72Pd
ONa01HbaliiXqIeufdLSQh7uUd6Zn94y5/xKIezGE29k7qyGC5g4G13x0Mv2QkCr
9Fd0KqyctFIKJch9lLRswYNghIMO9+g1pllH/JcqYaaU7QqQVCpitxpaLZa9Ii/y
O3Q04LcY9IvJCUlchC2B9AJezFDeFScmfe9S2GcJ+YQ0GKPNOd6wdzkPCFudE/Zn
GkE+xVyBJ/g685SEQauSAvg+65YcsBsZeqeESRDVZ5PtoJC45RN3xUbZoRplVcIe
g6yZvrOaYzJG5GjxktjfpiNpdUkUs/X2Jx5BM/Wn+U54QKZnKd+/Sv33zKz4u/A4
FEcY8JjYdGacltWdnZdsjigyg5EjxTLtgmMB+LEYRM/lmIrX3eo8y9M2sp5HV2MN
jPb1p03p1AzoRuTtGpMvMniWKMzkSYasWX+e0oE+6sKpa2YVJR74+5ztVsRfFbL8
7SqNVjXlVbS8QHIsFxeFFm/4rkZrqOZHwYkPrCrMSku9h7DFDBUK/67xXIvyrxer
6B8kMLjIKBM2UTTg2WCfKsUlYp2T6bdoPzswPLcXV8DNEIJs5QQ8QNlSO5LAH9Ax
v2dXtTC1W7rco7kzD2hwzQdHCxO9SyOjm6BhtwogsL+mV7nqtzG0KY5Gx26URB7G
YtFwIFNcqR7Az5hUM0ao
=PVSb
-----END PGP SIGNATURE-----

--Signature=_Thu__22_Mar_2012_15_09_51_+1100_8BFW=qc6J5igXU1c--
