Return-Path: <jonsmirl@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 8E392DDED4
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 23:11:29 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so237686yxg.39
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 06:11:27 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by terra with esmtp (Exim 4.69) (envelope-from <jonsmirl@gmail.com>)
	id 1KKaok-0002Zn-NV
	for linuxppc-dev@ozlabs.org; Sun, 20 Jul 2008 11:27:22 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH] Add more register definitions for the MPC52xx PSC
To: linuxppc-dev@ozlabs.org
Date: Sun, 20 Jul 2008 11:27:22 -0400
Message-ID: <20080720152722.9874.45607.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add more register definitions for the MPC52xx PSC

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---

 include/asm-powerpc/mpc52xx_psc.h |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/asm-powerpc/mpc52xx_psc.h b/include/asm-powerpc/mpc52xx_psc.h
index 0985dc8..4639598 100644
--- a/include/asm-powerpc/mpc52xx_psc.h
+++ b/include/asm-powerpc/mpc52xx_psc.h
@@ -162,8 +162,12 @@ struct mpc52xx_psc {
 	u8		reserved5[3];
 	u8		ctlr;		/* PSC + 0x1c */
 	u8		reserved6[3];
-	u16		ccr;		/* PSC + 0x20 */
-	u8		reserved7[14];
+	/* BitClkDiv field of CCR is byte swapped in 
+	 * the hardware for mpc5200/b compatibility */
+	u32		ccr;		/* PSC + 0x20 */
+	u32		ac97_slots;	/* PSC + 0x24 */
+	u32		ac97_cmd;	/* PSC + 0x28 */
+	u32		ac97_data;	/* PSC + 0x2c */
 	u8		ivr;		/* PSC + 0x30 */
 	u8		reserved8[3];
 	u8		ip;		/* PSC + 0x34 */
