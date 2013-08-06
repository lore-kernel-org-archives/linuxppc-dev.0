Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 20/63] powerpc: Make device tree accesses in cache info code
 endian safe
Date: Wed,  7 Aug 2013 02:01:37 +1000
Message-Id: <1375804940-22050-21-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/cacheinfo.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
index 9262cf2..6549327 100644
--- a/arch/powerpc/kernel/cacheinfo.c
+++ b/arch/powerpc/kernel/cacheinfo.c
@@ -196,7 +196,7 @@ static void cache_cpu_set(struct cache *cache, int cpu)
 static int cache_size(const struct cache *cache, unsigned int *ret)
 {
 	const char *propname;
-	const u32 *cache_size;
+	const __be32 *cache_size;
 
 	propname = cache_type_info[cache->type].size_prop;
 
@@ -204,7 +204,7 @@ static int cache_size(const struct cache *cache, unsigned int *ret)
 	if (!cache_size)
 		return -ENODEV;
 
-	*ret = *cache_size;
+	*ret = of_read_number(cache_size, 1);
 	return 0;
 }
 
@@ -222,7 +222,7 @@ static int cache_size_kb(const struct cache *cache, unsigned int *ret)
 /* not cache_line_size() because that's a macro in include/linux/cache.h */
 static int cache_get_line_size(const struct cache *cache, unsigned int *ret)
 {
-	const u32 *line_size;
+	const __be32 *line_size;
 	int i, lim;
 
 	lim = ARRAY_SIZE(cache_type_info[cache->type].line_size_props);
@@ -239,14 +239,14 @@ static int cache_get_line_size(const struct cache *cache, unsigned int *ret)
 	if (!line_size)
 		return -ENODEV;
 
-	*ret = *line_size;
+	*ret = of_read_number(line_size, 1);
 	return 0;
 }
 
 static int cache_nr_sets(const struct cache *cache, unsigned int *ret)
 {
 	const char *propname;
-	const u32 *nr_sets;
+	const __be32 *nr_sets;
 
 	propname = cache_type_info[cache->type].nr_sets_prop;
 
@@ -254,7 +254,7 @@ static int cache_nr_sets(const struct cache *cache, unsigned int *ret)
 	if (!nr_sets)
 		return -ENODEV;
 
-	*ret = *nr_sets;
+	*ret = of_read_number(nr_sets, 1);
 	return 0;
 }
 
-- 
1.8.1.2
