Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 9046EDF45A
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 09:48:26 +1000 (EST)
Date: Fri, 1 May 2009 03:48:24 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/9] spi_mpc83xx: Add small delay after asserting
	chip-select line
Message-ID: <20090430234824.GC7901@oksana.dev.rtsoft.ru>
References: <20090430234739.GA27709@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090430234739.GA27709@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is needed for some underlaying GPIO controllers that may be
a bit slow, or if chip-select signal need some time to stabilize.

For what it's worth, we already have the similar delay for
chip-select de-assertion case.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/spi/spi_mpc83xx.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index 08b49d2..d378d5e 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -383,8 +383,10 @@ static void mpc83xx_spi_work(struct work_struct *work)
 					break;
 			}
 
-			if (cs_change)
+			if (cs_change) {
 				mpc83xx_spi_chipselect(spi, BITBANG_CS_ACTIVE);
+				ndelay(nsecs);
+			}
 			cs_change = t->cs_change;
 			if (t->len)
 				status = mpc83xx_spi_bufs(spi, t);
-- 
1.6.2.2
