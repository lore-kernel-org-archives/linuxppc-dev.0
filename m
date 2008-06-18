Return-Path: <jschopp@austin.ibm.com>
From: jschopp@austin.ibm.com
Date: Wed, 18 Jun 2008 15:23:23 -0500
To: paulus@ozlabs.org
Subject: [PATCH 2/2] 2.06 architecture-vec
Message-ID: <20080618202323.GB23865@gamma>
References: <20080618201124.GA23828@gamma>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080618201124.GA23828@gamma>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the bits to the architecture-vec so that ibm,client-architecture
lets the firmware know we support the 2.06 architecture.

Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>

Index: 2.6.26-rc6/arch/powerpc/kernel/prom_init.c
===================================================================
--- 2.6.26-rc6.orig/arch/powerpc/kernel/prom_init.c
+++ 2.6.26-rc6/arch/powerpc/kernel/prom_init.c
@@ -620,6 +620,7 @@ static void __init early_cmdline_parse(v
 #define OV1_PPC_2_03		0x10	/* set if we support PowerPC 2.03 */
 #define OV1_PPC_2_04		0x08	/* set if we support PowerPC 2.04 */
 #define OV1_PPC_2_05		0x04	/* set if we support PowerPC 2.05 */
+#define OV1_PPC_2_06		0x02	/* set if we support PowerPC 2.06 */
 
 /* Option vector 2: Open Firmware options supported */
 #define OV2_REAL_MODE		0x20	/* set if we want OF in real mode */
@@ -651,6 +652,7 @@ static unsigned char ibm_architecture_ve
 	W(0xfffe0000), W(0x003a0000),	/* POWER5/POWER5+ */
 	W(0xffff0000), W(0x003e0000),	/* POWER6 */
 	W(0xffff0000), W(0x003f0000),	/* POWER7 */
+	W(0xffffffff), W(0x0f000003),	/* all 2.06-compliant */
 	W(0xffffffff), W(0x0f000002),	/* all 2.05-compliant */
 	W(0xfffffffe), W(0x0f000001),	/* all 2.04-compliant and earlier */
 	5 - 1,				/* 5 option vectors */
@@ -659,7 +661,7 @@ static unsigned char ibm_architecture_ve
 	3 - 2,				/* length */
 	0,				/* don't ignore, don't halt */
 	OV1_PPC_2_00 | OV1_PPC_2_01 | OV1_PPC_2_02 | OV1_PPC_2_03 |
-	OV1_PPC_2_04 | OV1_PPC_2_05,
+	OV1_PPC_2_04 | OV1_PPC_2_05 | OV1_PPC_2_06,
 
 	/* option vector 2: Open Firmware options supported */
 	34 - 2,				/* length */
