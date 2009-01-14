Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 14 Jan 2009 17:01:28 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [PATCH 05/13] powerpc/ps3: ps3_repository_read_mm_info takes u64 *
	arguments
Message-Id: <20090114170128.797f5795.sfr@canb.auug.org.au>
In-Reply-To: <20090114165450.ebbc11a7.sfr@canb.auug.org.au>
References: <20090114165450.ebbc11a7.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fixes compiler warnings:

arch/powerpc/platforms/ps3/mm.c:1205: warning: passing argument 2 of 'ps3_repository_read_mm_info' from incompatible pointer type
arch/powerpc/platforms/ps3/mm.c:1205: warning: passing argument 3 of 'ps3_repository_read_mm_info' from incompatible pointer type

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/ps3/mm.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/mm.c b/arch/powerpc/platforms/ps3/mm.c
index 5c8d066..715508c 100644
--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -80,7 +80,7 @@ enum {
 
 struct mem_region {
 	u64 base;
-	unsigned long size;
+	u64 size;
 	unsigned long offset;
 };
 
@@ -103,7 +103,7 @@ struct mem_region {
  */
 
 struct map {
-	unsigned long total;
+	u64 total;
 	u64 vas_id;
 	u64 htab_size;
 	struct mem_region rm;
@@ -114,13 +114,13 @@ struct map {
 static void __maybe_unused _debug_dump_map(const struct map *m,
 	const char *func, int line)
 {
-	DBG("%s:%d: map.total     = %lxh\n", func, line, m->total);
-	DBG("%s:%d: map.rm.size   = %lxh\n", func, line, m->rm.size);
+	DBG("%s:%d: map.total     = %llxh\n", func, line, m->total);
+	DBG("%s:%d: map.rm.size   = %llxh\n", func, line, m->rm.size);
 	DBG("%s:%d: map.vas_id    = %llu\n", func, line, m->vas_id);
 	DBG("%s:%d: map.htab_size = %llxh\n", func, line, m->htab_size);
 	DBG("%s:%d: map.r1.base   = %llxh\n", func, line, m->r1.base);
 	DBG("%s:%d: map.r1.offset = %lxh\n", func, line, m->r1.offset);
-	DBG("%s:%d: map.r1.size   = %lxh\n", func, line, m->r1.size);
+	DBG("%s:%d: map.r1.size   = %llxh\n", func, line, m->r1.size);
 }
 
 static struct map map;
@@ -240,10 +240,9 @@ static int ps3_mm_region_create(struct mem_region *r, unsigned long size)
 	r->size = _ALIGN_DOWN(size, 1 << PAGE_SHIFT_16M);
 
 	DBG("%s:%d requested  %lxh\n", __func__, __LINE__, size);
-	DBG("%s:%d actual     %lxh\n", __func__, __LINE__, r->size);
-	DBG("%s:%d difference %lxh (%luMB)\n", __func__, __LINE__,
-		(unsigned long)(size - r->size),
-		(size - r->size) / 1024 / 1024);
+	DBG("%s:%d actual     %llxh\n", __func__, __LINE__, r->size);
+	DBG("%s:%d difference %llxh (%lluMB)\n", __func__, __LINE__,
+		size - r->size, (size - r->size) / 1024 / 1024);
 
 	if (r->size == 0) {
 		DBG("%s:%d: size == 0\n", __func__, __LINE__);
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
