Return-Path: <ioannis.kokoris@siemens-enterprise.com>
Received: from senmx12-mx.siemens-enterprise.com
 (senmx12-mx.siemens-enterprise.com [62.134.46.10])
 by ozlabs.org (Postfix) with ESMTP id D0C8B1007DC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2011 03:13:36 +1100 (EST)
From: "Kokoris, Ioannis" <ioannis.kokoris@siemens-enterprise.com>
To: "timur@freescale.com" <timur@freescale.com>
Date: Fri, 11 Nov 2011 17:05:11 +0100
Subject: [PATCH] P1021: set IReady in QE Microcode Upload 
Message-ID: <026483A88B848047A08C3F03E20822D0267B1F4A55@MCHP058A.global-ad.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

QE Microcode Initialization using qe_upload_microcode() does not work on P1=
021 if the IRAM-Ready register is not set after the microcode upload. This =
patch adds a definition for the "I-RAM Ready" register and sets it uppon mi=
crocode upload completion.


Signed-off-by: Ioannis Kokkoris <ioannis.kokoris@siemens-enterprise.com>


diff -Nru a/arch/powerpc/include/asm/immap_qe.h b/arch/powerpc/include/asm/=
immap_qe.h
--- a/arch/powerpc/include/asm/immap_qe.h	2011-11-11 17:47:45.000000000 +02=
00
+++ b/arch/powerpc/include/asm/immap_qe.h	2011-11-11 17:49:31.000000000 +02=
00
@@ -26,7 +26,9 @@
 struct qe_iram {
 	__be32	iadd;		/* I-RAM Address Register */
 	__be32	idata;		/* I-RAM Data Register */
-	u8	res0[0x78];
+	u8	res0[0x04];
+	__be32	iready;		/* I-RAM Ready Register */
+	u8	res1[0x70];
 } __attribute__ ((packed));
=20
 /* QE Interrupt Controller */
diff -Nru a/arch/powerpc/include/asm/qe.h b/arch/powerpc/include/asm/qe.h
--- a/arch/powerpc/include/asm/qe.h	2011-11-11 17:47:57.000000000 +0200
+++ b/arch/powerpc/include/asm/qe.h	2011-11-11 17:49:42.000000000 +0200
@@ -499,6 +499,7 @@
 /* I-RAM */
 #define QE_IRAM_IADD_AIE	0x80000000	/* Auto Increment Enable */
 #define QE_IRAM_IADD_BADDR	0x00080000	/* Base Address */
+#define QE_IRAM_READY           0x80000000      /* Ready */
=20
 /* UPC */
 #define UPGCR_PROTOCOL	0x80000000	/* protocol ul2 or pl2 */
diff -Nru a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe=
.c
--- a/arch/powerpc/sysdev/qe_lib/qe.c	2011-11-11 17:48:44.000000000 +0200
+++ b/arch/powerpc/sysdev/qe_lib/qe.c	2011-11-11 17:49:59.000000000 +0200
@@ -377,6 +377,9 @@
=20
 	for (i =3D 0; i < be32_to_cpu(ucode->count); i++)
 		out_be32(&qe_immr->iram.idata, be32_to_cpu(code[i]));
+=09
+	/* Set I-RAM Ready Register */=09
+	out_be32(&qe_immr->iram.iready, be32_to_cpu(QE_IRAM_READY));
 }
=20
 /*
--

Best Regards,
Ioannis
