Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id 508B267AB8
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Feb 2005 11:10:11 +1100 (EST)
Date: Mon, 31 Jan 2005 17:10:09 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org, jgarzik@pobox.com
Message-ID: <20050131171009.F25809@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: netdev@oss.sgi.com, linuxppc-embedded@ozlabs.org
Subject: [PATCH][NET] Add PPC440SP support to IBM EMAC driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Configures EMAC thresholds appropriately for the EMAC on the
PPC440SP.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== drivers/net/ibm_emac/ibm_emac.h 1.3 vs edited =====
--- 1.3/drivers/net/ibm_emac/ibm_emac.h	2004-08-24 12:19:41 -07:00
+++ edited/drivers/net/ibm_emac/ibm_emac.h	2005-01-31 17:08:40 -07:00
@@ -237,6 +237,10 @@
 #define EMAC_RWMR_DEFAULT		0x1000a200
 #define EMAC_TMR0_DEFAULT		EMAC_TMR0_TFAE_2_32
 #define EMAC_TMR1_DEFAULT		0xa00f0000
+#elif defined(CONFIG_440SP)
+#define EMAC_RWMR_DEFAULT		0x08002000
+#define EMAC_TMR0_DEFAULT		EMAC_TMR0_TFAE_128_2048
+#define EMAC_TMR1_DEFAULT		0xf8200000
 #else
 #define EMAC_RWMR_DEFAULT		0x0f002000
 #define EMAC_TMR0_DEFAULT		0x00000000
