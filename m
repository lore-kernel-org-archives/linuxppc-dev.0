Return-Path: <matt@ozlabs.org>
Message-ID: <4BECBE89.3020108@ozlabs.org>
Date: Fri, 14 May 2010 13:07:53 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: kexec@lists.infradead.org
Subject: [PATCH v2] kexec-tools, ppc64: Fix segfault parsing DR memory property
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	Simon Horman <horms@verge.net.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

add_dyn_reconf_usable_mem_property() iterates over memory spans
in /ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory and intersects
these with usablemem_rgns ranges.  In doing so it used an unchecked
fixed-size array which will overrun on machines with lots of LMBs.

This patch removes the fixed-sized arrays from
add_dyn_reconf_usable_mem_property() and add_usable_mem_property(), in lieu of
malloc/realloc/free.

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 kexec/arch/ppc64/fs2dt.c |   82 +++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 70 insertions(+), 12 deletions(-)

diff --git a/kexec/arch/ppc64/fs2dt.c b/kexec/arch/ppc64/fs2dt.c
index 762bf04..4400f13 100644
--- a/kexec/arch/ppc64/fs2dt.c
+++ b/kexec/arch/ppc64/fs2dt.c
@@ -37,7 +37,7 @@
 #define NAMESPACE 16384		/* max bytes for property names */
 #define INIT_TREE_WORDS 65536	/* Initial num words for prop values */
 #define MEMRESERVE 256		/* max number of reserved memory blocks */
-#define MAX_MEMORY_RANGES 1024
+#define MEM_RANGE_CHUNK_SZ 2048 /* Initial num dwords for mem ranges */
 
 static char pathname[MAXPATH], *pathstart;
 static char propnames[NAMESPACE] = { 0 };
@@ -148,7 +148,8 @@ static void add_dyn_reconf_usable_mem_property(int fd)
 {
 	char fname[MAXPATH], *bname;
 	uint64_t buf[32];
-	uint64_t ranges[2*MAX_MEMORY_RANGES];
+	uint64_t *ranges;
+	int ranges_size = MEM_RANGE_CHUNK_SZ;
 	uint64_t base, end, loc_base, loc_end;
 	size_t i, rngs_cnt, range;
 	int rlen = 0;
@@ -165,6 +166,11 @@ static void add_dyn_reconf_usable_mem_property(int fd)
 		die("unrecoverable error: error seeking in \"%s\": %s\n",
 			pathname, strerror(errno));
 
+	ranges = malloc(ranges_size*8);
+	if (!ranges)
+		die("unrecoverable error: can't alloc %d bytes for ranges.\n",
+		    ranges_size*8);
+
 	rlen = 0;
 	for (i = 0; i < num_of_lmbs; i++) {
 		if (read(fd, buf, 24) < 0)
@@ -180,24 +186,57 @@ static void add_dyn_reconf_usable_mem_property(int fd)
 
 		rngs_cnt = 0;
 		for (range = 0; range < usablemem_rgns.size; range++) {
+			int add = 0;
 			loc_base = usablemem_rgns.ranges[range].start;
 			loc_end = usablemem_rgns.ranges[range].end;
 			if (loc_base >= base && loc_end <= end) {
-				ranges[rlen++] = loc_base;
-				ranges[rlen++] = loc_end - loc_base;
-				rngs_cnt++;
+				add = 1;
 			} else if (base < loc_end && end > loc_base) {
 				if (loc_base < base)
 					loc_base = base;
 				if (loc_end > end)
 					loc_end = end;
+				add = 1;
+			}
+
+			if (add) {
+				if (rlen >= (ranges_size-2)) {
+					ranges_size += MEM_RANGE_CHUNK_SZ;
+					ranges = realloc(ranges, ranges_size*8);
+					if (!ranges)
+						die("unrecoverable error: can't"
+						    " realloc %d bytes for"
+						    " ranges.\n",
+						    ranges_size*8);
+				}
 				ranges[rlen++] = loc_base;
 				ranges[rlen++] = loc_end - loc_base;
 				rngs_cnt++;
 			}
 		}
-		/* Store the count of (base, size) duple */
-		ranges[tmp_indx] = rngs_cnt;
+		if (rngs_cnt == 0) {
+			/* We still need to add a counter for every LMB because
+			 * the kernel parsing code is dumb.  We just have
+			 * a zero in this case, with no following base/len.
+			 */
+			ranges[tmp_indx] = 0;
+			/* rlen is already just tmp_indx+1 as we didn't write
+			 * anything.  Check array size here, as we'll probably
+			 * go on for a while writing zeros now.
+			 */
+			if (rlen >= (ranges_size-1)) {
+				ranges_size += MEM_RANGE_CHUNK_SZ;
+				ranges = realloc(ranges, ranges_size*8);
+				if (!ranges)
+					die("unrecoverable error: can't"
+					    " realloc %d bytes for"
+					    " ranges.\n",
+					    ranges_size*8);
+			}
+		} else {
+			/* Store the count of (base, size) duple */
+			ranges[tmp_indx] = rngs_cnt;
+		}
 	}
 		
 	rlen = rlen * sizeof(uint64_t);
@@ -210,7 +249,8 @@ static void add_dyn_reconf_usable_mem_property(int fd)
 	*dt++ = propnum("linux,drconf-usable-memory");
 	if ((rlen >= 8) && ((unsigned long)dt & 0x4))
 		dt++;
-	memcpy(dt, &ranges, rlen);
+	memcpy(dt, ranges, rlen);
+	free(ranges);
 	dt += (rlen + 3)/4;
 }
 
@@ -218,7 +258,8 @@ static void add_usable_mem_property(int fd, size_t len)
 {
 	char fname[MAXPATH], *bname;
 	uint64_t buf[2];
-	uint64_t ranges[2*MAX_MEMORY_RANGES];
+	uint64_t *ranges;
+	int ranges_size = MEM_RANGE_CHUNK_SZ;
 	uint64_t base, end, loc_base, loc_end;
 	size_t range;
 	int rlen = 0;
@@ -247,17 +288,33 @@ static void add_usable_mem_property(int fd, size_t len)
 	base = buf[0];
 	end = base + buf[1];
 
+	ranges = malloc(ranges_size*8);
+	if (!ranges)
+		die("unrecoverable error: can't alloc %d bytes for ranges.\n",
+		    ranges_size*8);
+
 	for (range = 0; range < usablemem_rgns.size; range++) {
+		int add = 0;
 		loc_base = usablemem_rgns.ranges[range].start;
 		loc_end = usablemem_rgns.ranges[range].end;
 		if (loc_base >= base && loc_end <= end) {
-			ranges[rlen++] = loc_base;
-			ranges[rlen++] = loc_end - loc_base;
+			add = 1;
 		} else if (base < loc_end && end > loc_base) {
 			if (loc_base < base)
 				loc_base = base;
 			if (loc_end > end)
 				loc_end = end;
+			add = 1;
+		}
+		if (add) {
+			if (rlen >= (ranges_size-2)) {
+				ranges_size += MEM_RANGE_CHUNK_SZ;
+				ranges = realloc(ranges, ranges_size*8);
+				if (!ranges)
+					die("unrecoverable error: can't realloc"
+					    "%d bytes for ranges.\n",
+					    ranges_size*8);
+			}
 			ranges[rlen++] = loc_base;
 			ranges[rlen++] = loc_end - loc_base;
 		}
@@ -283,7 +340,8 @@ static void add_usable_mem_property(int fd, size_t len)
 	*dt++ = propnum("linux,usable-memory");
 	if ((rlen >= 8) && ((unsigned long)dt & 0x4))
 		dt++;
-	memcpy(dt,&ranges,rlen);
+	memcpy(dt, ranges, rlen);
+	free(ranges);
 	dt += (rlen + 3)/4;
 }
 
-- 
1.6.3.3
