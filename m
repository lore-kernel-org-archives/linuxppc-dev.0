Date: Fri, 16 Aug 2002 11:17:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Compile fix for 4xx wih non-cascaded UICs
Message-ID: <20020816011738.GD8610@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom, can you apply this (unless the bk tree has been fixed).  It looks
like a recent fix for casceded UIC machines broke compile for
non-cascaded ones (UIC0_UIC1NC is not defined).

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/ppc4xx_pic.c linux-grinch/arch/ppc/kernel/ppc4xx_pic.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/ppc4xx_pic.c	2002-08-16 10:21:17.000000000 +1000
+++ linux-grinch/arch/ppc/kernel/ppc4xx_pic.c	2002-08-16 10:53:58.000000000 +1000
@@ -231,12 +231,14 @@
 		mtdcr(DCRN_UIC_ER(UIC0), ppc_cached_irq_mask[word]);
 		mtdcr(DCRN_UIC_SR(UIC0), (1 << (31 - bit)));
 		break;
+#if NR_UICS > 1
 	case 1:
 		mtdcr(DCRN_UIC_ER(UIC1), ppc_cached_irq_mask[word]);
 		mtdcr(DCRN_UIC_SR(UIC1), (1 << (31 - bit)));
 		/* ACK cascaded interrupt in UIC0 */
 		mtdcr(DCRN_UIC_SR(UIC0), (1 << (31 - UIC0_UIC1NC)));
 		break;
+#endif
 	}
 }

@@ -268,11 +270,13 @@
 		case 0:
 			mtdcr(DCRN_UIC_SR(UIC0), 1 << (31 - bit));
 			break;
+#if NR_UICS > 1
 		case 1:
 			mtdcr(DCRN_UIC_SR(UIC1), 1 << (31 - bit));
 			/* ACK cascaded interrupt in UIC0 */
 			mtdcr(DCRN_UIC_SR(UIC0), (1 << (31 - UIC0_UIC1NC)));
 			break;
+#endif
 		}
 	}



--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
