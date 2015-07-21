Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 31B291A0018
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 17:21:29 +1000 (AEST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
	kernel@pengutronix.de
Subject: [PATCH] powerpc: mpc512x: drop bogus and unused psc register bit
 definitions
Date: Tue, 21 Jul 2015 09:21:13 +0200
Message-Id: <1437463273-24742-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These were introduced in commit 25ae3a0739c6 ("[POWERPC] mpc512x: Add
MPC512x PSC support to MPC52xx psc driver") and never used. Moreover
according to the datasheet[1] MEMERROR is bit 25 (0x40) and ORERR is
bit 27 (0x10).

[1] MPC5125RM Rev. 2; 11/2009

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/powerpc/include/asm/mpc52xx_psc.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx_psc.h b/arch/powerpc/include/asm/mpc52xx_psc.h
index d0ece257d310..92806c24c2c5 100644
--- a/arch/powerpc/include/asm/mpc52xx_psc.h
+++ b/arch/powerpc/include/asm/mpc52xx_psc.h
@@ -258,8 +258,6 @@ struct mpc52xx_psc_fifo {
 #define MPC512x_PSC_FIFO_FULL		0x2
 #define MPC512x_PSC_FIFO_ALARM		0x4
 #define MPC512x_PSC_FIFO_URERR		0x8
-#define MPC512x_PSC_FIFO_ORERR		0x01
-#define MPC512x_PSC_FIFO_MEMERROR	0x02
 
 struct mpc512x_psc_fifo {
 	u32		reserved1[10];
-- 
2.1.4
