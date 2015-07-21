Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BAD351A09A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 18:30:54 +1000 (AEST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-spi@vger.kernel.org,
 kernel@pengutronix.de
Subject: [PATCH] spi: mpc512x-psc: fix compiler warning about uninitialized
 variable
Date: Tue, 21 Jul 2015 10:30:42 +0200
Message-Id: <1437467442-7011-1-git-send-email-u.kleine-koenig@pengutronix.de>
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

This fixes several warnings like:

	drivers/spi/spi-mpc512x-psc.c: In function 'mpc512x_psc_spi_prep_xfer_hw':
	arch/powerpc/include/asm/io.h:163:2: warning: '__ret' may be used uninitialized in this function [-Wmaybe-uninitialized]

introduced in commit 8bf960985dfc for some build configurations.

Fixes: 8bf960985dfc ("spi: mpc512x-psc: add support for Freescale MPC5125")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

didn't check why "my" config doesn't throw this warning, but I could reproduce
and fix it with the .config and toolchain as suggested by the build bot's
report.

An alternatives is to introduce a default case that BUG()s, but I think
there is not much benefit over the NULL pointer exception that I
introduced with my commit.

I expected that giving the enum I introduced a name and using this to
type the variable should do the trick, but this didn't made the compiler
happy.

Best regards
Uwe

 drivers/spi/spi-mpc512x-psc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 280794dd248a..1e75341689a6 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -40,8 +40,8 @@ enum {
  * MPC5121 (which uses a struct mpc52xx_psc) and MPC5125 (using mpc5125_psc).
  */
 #define psc_addr(mps, regname) ({					\
-	void *__ret;							\
-	switch(mps->type) {						\
+	void *__ret = NULL;						\
+	switch (mps->type) {						\
 	case TYPE_MPC5121: {						\
 			struct mpc52xx_psc __iomem *psc = mps->psc;	\
 			__ret = &psc->regname;				\
-- 
2.1.4
