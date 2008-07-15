Return-Path: <arnd@arndb.de>
Message-Id: <20080715195739.006221652@arndb.de>
References: <20080715195139.316677337@arndb.de>
Date: Tue, 15 Jul 2008 21:51:40 +0200
From: arnd@arndb.de
To: benh@kernel.crashing.org, cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: [patch 1/9] powerpc/cell/edac: log a syndrome code in case of
	correctable error
Cc: Maxim Shchetynin <maxim@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Maxim Shchetynin <maxim@de.ibm.com>

If correctable error occurs the syndrome code was logged as 0. This patch
lets EDAC to log a correct syndrome code to make problem investigation
easier.

Signed-off-by: Maxim Shchetynin <maxim@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/edac/cell_edac.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/cell_edac.c b/drivers/edac/cell_edac.c
index b54112f..0e024fe 100644
--- a/drivers/edac/cell_edac.c
+++ b/drivers/edac/cell_edac.c
@@ -33,7 +33,7 @@ static void cell_edac_count_ce(struct mem_ctl_info *mci, int chan, u64 ar)
 {
 	struct cell_edac_priv		*priv = mci->pvt_info;
 	struct csrow_info		*csrow = &mci->csrows[0];
-	unsigned long			address, pfn, offset;
+	unsigned long			address, pfn, offset, syndrome;
 
 	dev_dbg(mci->dev, "ECC CE err on node %d, channel %d, ar = 0x%016lx\n",
 		priv->node, chan, ar);
@@ -44,10 +44,11 @@ static void cell_edac_count_ce(struct mem_ctl_info *mci, int chan, u64 ar)
 		address = (address << 1) | chan;
 	pfn = address >> PAGE_SHIFT;
 	offset = address & ~PAGE_MASK;
+	syndrome = (ar & 0x000000001fe00000ul) >> 21;
 
 	/* TODO: Decoding of the error addresss */
 	edac_mc_handle_ce(mci, csrow->first_page + pfn, offset,
-			  0, 0, chan, "");
+			  syndrome, 0, chan, "");
 }
 
 static void cell_edac_count_ue(struct mem_ctl_info *mci, int chan, u64 ar)
-- 
1.5.4.3

-- 
