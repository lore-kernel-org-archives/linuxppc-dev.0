Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id BDBD5DDE00
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 17:10:50 +1100 (EST)
Date: Mon, 19 Nov 2007 17:10:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] iSeries: fix sparse warnings in setup.c
Message-Id: <20071119171057.f9c7e68f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/platforms/iseries/setup.c:111:27: warning: constant 0x100000000 is so big it is long
arch/powerpc/platforms/iseries/setup.c:113:23: warning: constant 0x100000000 is so big it is long
arch/powerpc/platforms/iseries/setup.c:117:27: warning: constant 0x000fffffffffffff is so big it is long
arch/powerpc/platforms/iseries/setup.c:127:28: warning: constant 0x100000000 is so big it is long
arch/powerpc/platforms/iseries/setup.c:129:24: warning: constant 0x100000000 is so big it is long
arch/powerpc/platforms/iseries/setup.c:233:5: warning: constant 0x000fffffffffffff is so big it is long
arch/powerpc/platforms/iseries/setup.c:235:5: warning: constant 0x000fffffffffffff is so big it is long
arch/powerpc/platforms/iseries/setup.c:319:6: warning: symbol 'mschunks_alloc' was not declared. Should it be static?
arch/powerpc/platforms/iseries/setup.c:661:6: warning: symbol 'iSeries_early_setup' was not declared. Should it be static?

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/setup.c |   16 ++++++++--------
 arch/powerpc/platforms/iseries/setup.h |    1 +
 2 files changed, 9 insertions(+), 8 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index 8a652da..2175a71 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -108,13 +108,13 @@ static unsigned long iSeries_process_Condor_mainstore_vpd(
 	 * correctly.
 	 */
 	mb_array[0].logicalStart = 0;
-	mb_array[0].logicalEnd = 0x100000000;
+	mb_array[0].logicalEnd = 0x100000000UL;
 	mb_array[0].absStart = 0;
-	mb_array[0].absEnd = 0x100000000;
+	mb_array[0].absEnd = 0x100000000UL;
 
 	if (holeSize) {
 		numMemoryBlocks = 2;
-		holeStart = holeStart & 0x000fffffffffffff;
+		holeStart = holeStart & 0x000fffffffffffffUL;
 		holeStart = addr_to_chunk(holeStart);
 		holeFirstChunk = holeStart;
 		holeSize = addr_to_chunk(holeSize);
@@ -124,9 +124,9 @@ static unsigned long iSeries_process_Condor_mainstore_vpd(
 		mb_array[0].logicalEnd = holeFirstChunk;
 		mb_array[0].absEnd = holeFirstChunk;
 		mb_array[1].logicalStart = holeFirstChunk;
-		mb_array[1].logicalEnd = 0x100000000 - holeSizeChunks;
+		mb_array[1].logicalEnd = 0x100000000UL - holeSizeChunks;
 		mb_array[1].absStart = holeFirstChunk + holeSizeChunks;
-		mb_array[1].absEnd = 0x100000000;
+		mb_array[1].absEnd = 0x100000000UL;
 	}
 	return numMemoryBlocks;
 }
@@ -230,9 +230,9 @@ static unsigned long iSeries_process_Regatta_mainstore_vpd(
 				mb_array[i].logicalEnd,
 				mb_array[i].absStart, mb_array[i].absEnd);
 		mb_array[i].absStart = addr_to_chunk(mb_array[i].absStart &
-				0x000fffffffffffff);
+				0x000fffffffffffffUL);
 		mb_array[i].absEnd = addr_to_chunk(mb_array[i].absEnd &
-				0x000fffffffffffff);
+				0x000fffffffffffffUL);
 		mb_array[i].logicalStart =
 			addr_to_chunk(mb_array[i].logicalStart);
 		mb_array[i].logicalEnd = addr_to_chunk(mb_array[i].logicalEnd);
@@ -316,7 +316,7 @@ struct mschunks_map mschunks_map = {
 };
 EXPORT_SYMBOL(mschunks_map);
 
-void mschunks_alloc(unsigned long num_chunks)
+static void mschunks_alloc(unsigned long num_chunks)
 {
 	klimit = _ALIGN(klimit, sizeof(u32));
 	mschunks_map.mapping = (u32 *)klimit;
diff --git a/arch/powerpc/platforms/iseries/setup.h b/arch/powerpc/platforms/iseries/setup.h
index 0a47ac5..729754b 100644
--- a/arch/powerpc/platforms/iseries/setup.h
+++ b/arch/powerpc/platforms/iseries/setup.h
@@ -17,6 +17,7 @@
 #ifndef	__ISERIES_SETUP_H__
 #define	__ISERIES_SETUP_H__
 
+extern void *iSeries_early_setup(void);
 extern unsigned long iSeries_get_boot_time(void);
 extern int iSeries_set_rtc_time(struct rtc_time *tm);
 extern void iSeries_get_rtc_time(struct rtc_time *tm);
-- 
1.5.3.5
