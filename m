Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 02723DDDF8
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Oct 2007 08:25:32 +1000 (EST)
Received: from pd3mr5so.prod.shaw.ca (pd3mr5so-qfe3.prod.shaw.ca [10.0.141.12])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPT004A1KYJ3RA0@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 12 Oct 2007 16:25:31 -0600 (MDT)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
	by pd3mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPT00MJ6KYJ4180@pd3mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 12 Oct 2007 16:25:31 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPT008VIKYGBLV0@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 12 Oct 2007 16:25:28 -0600 (MDT)
Date: Fri, 12 Oct 2007 16:25:31 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 3/7] mpc52xx: Update mpc52xx_psc structure with B revision
	changes
In-reply-to: <20071012222309.12648.82234.stgit@trillian.cg.shawcable.net>
To: galak@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org,
	tnt@246tnt.com
Message-id: <20071012222531.12648.47004.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071012222309.12648.82234.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Sylvain Munaut <tnt@246tNt.com>

On the mpc5200b the ccr register is 32 bits wide while on the
mpc5200 it's only 16 bits. It's up to the driver to use the
correct format depending on the chip it's running on.

The 5200b also offers some more registers & status in AC97
mode. Again, if not running on a 5200b the driver should not
use those.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
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
