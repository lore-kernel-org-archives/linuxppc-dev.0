Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1FDD367B1B
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Apr 2006 14:56:40 +1000 (EST)
Date: Tue, 4 Apr 2006 14:56:20 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] powerpc: iSeries has only 256 IRQs
Message-Id: <20060404145620.00697fff.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__4_Apr_2006_14_56_20_+1000_n8CcM.noYy1cCwcj"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__4_Apr_2006_14_56_20_+1000_n8CcM.noYy1cCwcj
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The iSeries Hypervisor only allows us to specify IRQ numbers up to 255 (it
has a u8 field to pass it in).  This patch allows platforms to specify a
maximum to the virtual IRQ numbers we will use and has iSeries set that
to 255.  If not set, the maximum is NR_IRQS - 1 (as before).

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/kernel/irq.c              |   36 ++++++++++++++++++++--------=
----
 arch/powerpc/platforms/iseries/setup.c |    7 ++++++
 include/asm-powerpc/irq.h              |    7 ++++++
 3 files changed, 36 insertions(+), 14 deletions(-)

This has been booted on iSeries partitions that have hardware that would
have previously tried to use IRQ numbers above 255.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

7d01c880856bae31502095bc68784c1518a680cb
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index bb5c950..57d560c 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -272,18 +272,26 @@ unsigned int virt_irq_to_real_map[NR_IRQ
  * Don't use virtual irqs 0, 1, 2 for devices.
  * The pcnet32 driver considers interrupt numbers < 2 to be invalid,
  * and 2 is the XICS IPI interrupt.
- * We limit virtual irqs to 17 less than NR_IRQS so that when we
- * offset them by 16 (to reserve the first 16 for ISA interrupts)
- * we don't end up with an interrupt number >=3D NR_IRQS.
+ * We limit virtual irqs to __irq_offet_value less than virt_irq_max so
+ * that when we offset them we don't end up with an interrupt
+ * number > virt_irq_max.
  */
 #define MIN_VIRT_IRQ	3
-#define MAX_VIRT_IRQ	(NR_IRQS - NUM_ISA_INTERRUPTS - 1)
-#define NR_VIRT_IRQS	(MAX_VIRT_IRQ - MIN_VIRT_IRQ + 1)
+
+unsigned int virt_irq_max;
+static unsigned int max_virt_irq;
+static unsigned int nr_virt_irqs;
=20
 void
 virt_irq_init(void)
 {
 	int i;
+
+	if ((virt_irq_max =3D=3D 0) || (virt_irq_max > (NR_IRQS - 1)))
+		virt_irq_max =3D NR_IRQS - 1;
+	max_virt_irq =3D virt_irq_max - __irq_offset_value;
+	nr_virt_irqs =3D max_virt_irq - MIN_VIRT_IRQ + 1;
+
 	for (i =3D 0; i < NR_IRQS; i++)
 		virt_irq_to_real_map[i] =3D UNDEFINED_IRQ;
 }
@@ -308,17 +316,17 @@ int virt_irq_create_mapping(unsigned int
 		return real_irq;
 	}
=20
-	/* map to a number between MIN_VIRT_IRQ and MAX_VIRT_IRQ */
+	/* map to a number between MIN_VIRT_IRQ and max_virt_irq */
 	virq =3D real_irq;
-	if (virq > MAX_VIRT_IRQ)
-		virq =3D (virq % NR_VIRT_IRQS) + MIN_VIRT_IRQ;
+	if (virq > max_virt_irq)
+		virq =3D (virq % nr_virt_irqs) + MIN_VIRT_IRQ;
=20
 	/* search for this number or a free slot */
 	first_virq =3D virq;
 	while (virt_irq_to_real_map[virq] !=3D UNDEFINED_IRQ) {
 		if (virt_irq_to_real_map[virq] =3D=3D real_irq)
 			return virq;
-		if (++virq > MAX_VIRT_IRQ)
+		if (++virq > max_virt_irq)
 			virq =3D MIN_VIRT_IRQ;
 		if (virq =3D=3D first_virq)
 			goto nospace;	/* oops, no free slots */
@@ -330,8 +338,8 @@ int virt_irq_create_mapping(unsigned int
  nospace:
 	if (!warned) {
 		printk(KERN_CRIT "Interrupt table is full\n");
-		printk(KERN_CRIT "Increase NR_IRQS (currently %d) "
-		       "in your kernel sources and rebuild.\n", NR_IRQS);
+		printk(KERN_CRIT "Increase virt_irq_max (currently %d) "
+		       "in your kernel sources and rebuild.\n", virt_irq_max);
 		warned =3D 1;
 	}
 	return NO_IRQ;
@@ -349,8 +357,8 @@ unsigned int real_irq_to_virt_slowpath(u
=20
 	virq =3D real_irq;
=20
-	if (virq > MAX_VIRT_IRQ)
-		virq =3D (virq % NR_VIRT_IRQS) + MIN_VIRT_IRQ;
+	if (virq > max_virt_irq)
+		virq =3D (virq % nr_virt_irqs) + MIN_VIRT_IRQ;
=20
 	first_virq =3D virq;
=20
@@ -360,7 +368,7 @@ unsigned int real_irq_to_virt_slowpath(u
=20
 		virq++;
=20
-		if (virq >=3D MAX_VIRT_IRQ)
+		if (virq >=3D max_virt_irq)
 			virq =3D 0;
=20
 	} while (first_virq !=3D virq);
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platform=
s/iseries/setup.c
index 6ce8a40..a6fd9be 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -54,6 +54,7 @@
 #include <asm/iseries/hv_lp_event.h>
 #include <asm/iseries/lpar_map.h>
 #include <asm/udbg.h>
+#include <asm/irq.h>
=20
 #include "naca.h"
 #include "setup.h"
@@ -684,6 +685,12 @@ static int __init iseries_probe(void)
 	powerpc_firmware_features |=3D FW_FEATURE_ISERIES;
 	powerpc_firmware_features |=3D FW_FEATURE_LPAR;
=20
+	/*
+	 * The Hypervisor only allows us up to 256 interrupt
+	 * sources (the irq number is passed in a u8).
+	 */
+	virt_irq_max =3D 255;
+
 	return 1;
 }
=20
diff --git a/include/asm-powerpc/irq.h b/include/asm-powerpc/irq.h
index 51f87d9..7bc6d73 100644
--- a/include/asm-powerpc/irq.h
+++ b/include/asm-powerpc/irq.h
@@ -54,6 +54,13 @@
  */
 extern unsigned int virt_irq_to_real_map[NR_IRQS];
=20
+/* The maximum virtual IRQ number that we support.  This
+ * can be set by the platform and will be reduced by the
+ * value of __irq_offset_value.  It defaults to and is
+ * capped by (NR_IRQS - 1).
+ */
+extern unsigned int virt_irq_max;
+
 /* Create a mapping for a real_irq if it doesn't already exist.
  * Return the virtual irq as a convenience.
  */
--=20
1.2.4


--Signature=_Tue__4_Apr_2006_14_56_20_+1000_n8CcM.noYy1cCwcj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEMfx0FdBgD/zoJvwRApTNAJ9yi49C++juWGDaR9bjfQKZM+mkbwCdHC9u
42D6mFijB5SRups/cMYnvW8=
=5bsE
-----END PGP SIGNATURE-----

--Signature=_Tue__4_Apr_2006_14_56_20_+1000_n8CcM.noYy1cCwcj--
