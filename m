Return-Path: <g.jaeger@sysgo.com>
Received: from mailgate.sysgo.de (ns.sysgo.de [213.68.67.98])
	by ozlabs.org (Postfix) with ESMTP id CB2BF2BDA1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Sep 2004 18:02:38 +1000 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org
Date: Tue, 28 Sep 2004 09:38:55 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200409280938.55734.g.jaeger@sysgo.com>
Cc: 
Subject: [PATCH][PPC32] Fix PFC1_EPS and PFC1_EPS_SHIFT definitions for
	IBM440GX
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Matt,

while writing some BSP code for a 440GX custom board, I noticed, that
the DCRN_SDR_PFC1_EPS and DCRN_SDR_PFC1_EPS_SHIFT definitions are wrong and
therefore the functions ibm440gx_get_eth_grp() and ibm440gx_set_eth_grp() 
won't 
work correctly.
This patch will fix this, please apply.

TIA,
  Gerhard

PPC440GX: Fix DCRN_SDR_PFC1_EPS and DCRN_SDR_PFC1_EPS_SHIFT definitions

Signed-off-by: Gerhard Jaeger <gjaeger@sysgo.com>

--- linux-2.6.9-rc2/include/asm-ppc/ibm44x.h.orig       2004-09-22 
16:41:30.000000000 +0200
+++ linux-2.6.9-rc2/include/asm-ppc/ibm44x.h    2004-09-28 09:08:11.000000000 
+0200
@@ -94,8 +94,8 @@
 #define DCRN_SDR_CONFIG_DATA   0xf
 #define DCRN_SDR_PFC0          0x4100
 #define DCRN_SDR_PFC1          0x4101
-#define DCRN_SDR_PFC1_EPS      0x1c000000
-#define DCRN_SDR_PFC1_EPS_SHIFT        26
+#define DCRN_SDR_PFC1_EPS      0x1c00000
+#define DCRN_SDR_PFC1_EPS_SHIFT        22
 #define DCRN_SDR_PFC1_RMII     0x02000000
 #define DCRN_SDR_MFR           0x4300
 #define DCRN_SDR_MFR_TAH0      0x80000000      /* TAHOE0 Enable */
	
-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com
