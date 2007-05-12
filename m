Return-Path: <tnt@246tNt.com>
Received: from mailgate103.isp.belgacom.be (mailgate103.isp.belgacom.be
	[195.238.6.84]) by ozlabs.org (Postfix) with ESMTP id F24CEDDEC5
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 06:32:25 +1000 (EST)
From: Sylvain Munaut <tnt@246tNt.com>
To: Linux PPC dev ML <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/9] powerpc/ppc32: Update mpc52xx_psc structure with B
	revision changes
Date: Sat, 12 May 2007 22:31:51 +0200
Message-Id: <11790019223925-git-send-email-tnt@246tNt.com>
In-Reply-To: <11790019223880-git-send-email-tnt@246tNt.com>
References: <11790019171838-git-send-email-tnt@246tNt.com>
	<11790019223299-git-send-email-tnt@246tNt.com>
	<11790019223880-git-send-email-tnt@246tNt.com>
Cc: Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On the mpc5200b the ccr register is 32 bits wide while on the
mpc5200 it's only 16 bits. It's up to the driver to use the
correct format depending on the chip it's running on.

The 5200b also offers some more registers & status in AC97
mode. Again, if not running on a 5200b the driver should not
use those.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 include/asm-ppc/mpc52xx_psc.h |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/asm-ppc/mpc52xx_psc.h b/include/asm-ppc/mpc52xx_psc.h
index 9d850b2..c82b8d4 100644
--- a/include/asm-ppc/mpc52xx_psc.h
+++ b/include/asm-ppc/mpc52xx_psc.h
@@ -28,6 +28,10 @@
 #define MPC52xx_PSC_MAXNUM	6
 
 /* Programmable Serial Controller (PSC) status register bits */
+#define MPC52xx_PSC_SR_UNEX_RX	0x0001
+#define MPC52xx_PSC_SR_DATA_VAL	0x0002
+#define MPC52xx_PSC_SR_DATA_OVR	0x0004
+#define MPC52xx_PSC_SR_CMDSEND	0x0008
 #define MPC52xx_PSC_SR_CDE	0x0080
 #define MPC52xx_PSC_SR_RXRDY	0x0100
 #define MPC52xx_PSC_SR_RXFULL	0x0200
@@ -132,8 +136,10 @@ struct mpc52xx_psc {
 	u8		reserved5[3];
 	u8		ctlr;		/* PSC + 0x1c */
 	u8		reserved6[3];
-	u16		ccr;		/* PSC + 0x20 */
-	u8		reserved7[14];
+	u32		ccr;		/* PSC + 0x20 */
+	u32		ac97_slots;	/* PSC + 0x24 */
+	u32		ac97_cmd;	/* PSC + 0x28 */
+	u32		ac97_data;	/* PSC + 0x2c */
 	u8		ivr;		/* PSC + 0x30 */
 	u8		reserved8[3];
 	u8		ip;		/* PSC + 0x34 */
-- 
1.5.1.2
