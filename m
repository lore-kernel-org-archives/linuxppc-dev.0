Return-Path: <galak@somerset.sps.mot.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id 052182BE83
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Nov 2004 16:32:09 +1100 (EST)
Received: from il06exr04.mot.com (il06exr04.mot.com [129.188.137.134])
	by motgate8.mot.com (Motorola/Motgate8) with ESMTP id iA95XbnQ013427
	for <linuxppc-embedded@ozlabs.org>; Mon, 8 Nov 2004 22:33:37 -0700 (MST)
Date: Mon, 8 Nov 2004 23:32:03 -0600 (CST)
From: Kumar Gala <galak@somerset.sps.mot.com>
To: akpm@osdl.org
Message-ID: <Pine.LNX.4.61.0411082327570.13565@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Updated reporting of CPU rev & freq for e500 CPUs
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

Fixes up the reporting of the e500 core revision.  Additionally, it 
changes the reporting of CPU frequency to match what other PPC systems do.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

--

diff -Nru a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
--- a/arch/ppc/kernel/setup.c	2004-11-08 22:18:31 -06:00
+++ b/arch/ppc/kernel/setup.c	2004-11-08 22:18:31 -06:00
@@ -226,6 +226,10 @@
  		maj = ((pvr >> 8) & 0xFF) - 1;
  		min = pvr & 0xFF;
  		break;
+	case 0x8020:	/* e500 */
+		maj = PVR_MAJ(pvr);
+		min = PVR_MIN(pvr);
+		break;
  	default:
  		maj = (pvr >> 8) & 0xFF;
  		min = pvr & 0xFF;
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_ads_common.c b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_ads_common.c	2004-11-08 22:18:31 -06:00
+++ b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c	2004-11-08 22:18:31 -06:00
@@ -142,8 +142,7 @@
  		seq_printf(m, "Machine\t\t: unknown\n");
  		break;
  	}
-	seq_printf(m, "bus freq\t: %u.%.6u MHz\n", freq / 1000000,
-		   freq % 1000000);
+	seq_printf(m, "clock\t\t: %dMHz\n", freq / 1000000);
  	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
  	seq_printf(m, "SVR\t\t: 0x%x\n", svid);

diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2004-11-08 22:18:31 -06:00
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2004-11-08 22:18:31 -06:00
@@ -172,8 +172,7 @@

          seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
  	seq_printf(m, "Machine\t\t: CDS (%x)\n", cadmus[CM_VER]);
-        seq_printf(m, "bus freq\t: %u.%.6u MHz\n", freq / 1000000,
-                   freq % 1000000);
+	seq_printf(m, "clock\t\t: %dMHz\n", freq / 1000000);
          seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
          seq_printf(m, "SVR\t\t: 0x%x\n", svid);

diff -Nru a/arch/ppc/platforms/85xx/sbc85xx.c b/arch/ppc/platforms/85xx/sbc85xx.c
--- a/arch/ppc/platforms/85xx/sbc85xx.c	2004-11-08 22:18:31 -06:00
+++ b/arch/ppc/platforms/85xx/sbc85xx.c	2004-11-08 22:18:31 -06:00
@@ -142,8 +142,7 @@
  		seq_printf(m, "Machine\t\t: unknown\n");
  		break;
  	}
-	seq_printf(m, "bus freq\t: %u.%.6u MHz\n", freq / 1000000,
-		   freq % 1000000);
+	seq_printf(m, "clock\t\t: %dMHz\n", freq / 1000000);
  	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
  	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
