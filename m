Return-Path: <galak@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 4278467A6D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Mar 2005 08:31:09 +1000 (EST)
Date: Tue, 29 Mar 2005 16:30:37 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050329201209.GB30850@gate.ebshome.net>
Message-ID: <Pine.LNX.4.61.0503291627130.16284@blarg.somerset.sps.mot.com>
References: <20050329201209.GB30850@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, shall@mvista.com,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: CPM2 PIC cleanup irq_to_siubit array
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrew,

Cleaned up irq_to_siubit array so we no longer need to do 1 << (31-bit), 
just 1 << bit.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---

diff -Nru a/arch/ppc/syslib/cpm2_pic.c b/arch/ppc/syslib/cpm2_pic.c
--- a/arch/ppc/syslib/cpm2_pic.c	2005-03-29 16:25:34 -06:00
+++ b/arch/ppc/syslib/cpm2_pic.c	2005-03-29 16:25:34 -06:00
@@ -33,14 +33,14 @@
 };
 
 static	u_char	irq_to_siubit[] = {
-	31, 16, 17, 18, 19, 20, 21, 22,
-	23, 24, 25, 26, 27, 28, 29, 30,
-	29, 30, 16, 17, 18, 19, 20, 21,
-	22, 23, 24, 25, 26, 27, 28, 31,
-	 0,  1,  2,  3,  4,  5,  6,  7,
-	 8,  9, 10, 11, 12, 13, 14, 15,
-	15, 14, 13, 12, 11, 10,  9,  8,
-	 7,  6,  5,  4,  3,  2,  1,  0
+	 0, 15, 14, 13, 12, 11, 10,  9, 
+	 8,  7,  6,  5,  4,  3,  2,  1, 
+	 2,  1, 15, 14, 13, 12, 11, 10, 
+	 9,  8,  7,  6,  5,  4,  3,  0, 
+	31, 30, 29, 28, 27, 26, 25, 24, 
+	23, 22, 21, 20, 19, 18, 17, 16, 
+	16, 17, 18, 19, 20, 21, 22, 23, 
+	24, 25, 26, 27, 28, 29, 30, 31, 
 };
 
 static void cpm2_mask_irq(unsigned int irq_nr)
@@ -54,7 +54,7 @@
 	word = irq_to_siureg[irq_nr];
 
 	simr = &(cpm2_immr->im_intctl.ic_simrh);
-	ppc_cached_irq_mask[word] &= ~(1 << (31 - bit));
+	ppc_cached_irq_mask[word] &= ~(1 << bit);
 	simr[word] = ppc_cached_irq_mask[word];
 }
 
@@ -69,7 +69,7 @@
 	word = irq_to_siureg[irq_nr];
 
 	simr = &(cpm2_immr->im_intctl.ic_simrh);
-	ppc_cached_irq_mask[word] |= (1 << (31 - bit));
+	ppc_cached_irq_mask[word] |= 1 << bit;
 	simr[word] = ppc_cached_irq_mask[word];
 }
 
@@ -85,9 +85,9 @@
 
 	simr = &(cpm2_immr->im_intctl.ic_simrh);
 	sipnr = &(cpm2_immr->im_intctl.ic_sipnrh);
-	ppc_cached_irq_mask[word] &= ~(1 << (31 - bit));
+	ppc_cached_irq_mask[word] &= ~(1 << bit);
 	simr[word] = ppc_cached_irq_mask[word];
-	sipnr[word] = 1 << (31 - bit);
+	sipnr[word] = 1 << bit;
 }
 
 static void cpm2_end_irq(unsigned int irq_nr)
@@ -103,7 +103,7 @@
 		word = irq_to_siureg[irq_nr];
 
 		simr = &(cpm2_immr->im_intctl.ic_simrh);
-		ppc_cached_irq_mask[word] |= (1 << (31 - bit));
+		ppc_cached_irq_mask[word] |= 1 << bit;
 		simr[word] = ppc_cached_irq_mask[word];
 	}
 }
