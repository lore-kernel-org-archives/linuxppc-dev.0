Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0E8B4DE556
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 08:22:32 +1000 (EST)
Message-ID: <46730240.5000200@am.sony.com>
Date: Fri, 15 Jun 2007 14:18:56 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 05/33] PS3: Use ioremap_flags
References: <20070615204749.629571012@am.sony.com>>
In-Reply-To: <20070615204749.629571012@am.sony.com>>
Content-Type: text/plain; charset=UTF-8
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	Masato Noguchi <Masato.Noguchi@jp.sony.com>, linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use ioremap_flags() to map SPU regions as non-guarded.
Change the use of _ioremap() to ioremap_flags().

CC: Arnd Bergmann <arnd.bergmann@de.ibm.com>
CC: Masato Noguchi <Masato.Noguchi@jp.sony.com>
CC: Takao Shinohara <shin@sm.sony.co.jp>
Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
  o After a number of revisions, I think everyone agrees this is now correct.

 arch/powerpc/platforms/ps3/htab.c |    2 +-
 arch/powerpc/platforms/ps3/spu.c  |   13 +++++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

--- a/arch/powerpc/platforms/ps3/htab.c
+++ b/arch/powerpc/platforms/ps3/htab.c
@@ -273,7 +273,7 @@ void __init ps3_map_htab(void)
 
 	result = lv1_map_htab(0, &htab_addr);
 
-	htab = (hpte_t *)__ioremap(htab_addr, htab_size,
+	htab = (__force hpte_t *)ioremap_flags(htab_addr, htab_size,
 				   pgprot_val(PAGE_READONLY_X));
 
 	DBG("%s:%d: lpar %016lxh, virt %016lxh\n", __func__, __LINE__,
--- a/arch/powerpc/platforms/ps3/spu.c
+++ b/arch/powerpc/platforms/ps3/spu.c
@@ -182,15 +182,18 @@ static int __init setup_areas(struct spu
 {
 	struct table {char* name; unsigned long addr; unsigned long size;};
 
-	spu_pdata(spu)->shadow = __ioremap(
-		spu_pdata(spu)->shadow_addr, sizeof(struct spe_shadow),
-		pgprot_val(PAGE_READONLY) | _PAGE_NO_CACHE | _PAGE_GUARDED);
+	spu_pdata(spu)->shadow = ioremap_flags(spu_pdata(spu)->shadow_addr,
+					       sizeof(struct spe_shadow),
+					       pgprot_val(PAGE_READONLY) |
+					       _PAGE_NO_CACHE);
 	if (!spu_pdata(spu)->shadow) {
 		pr_debug("%s:%d: ioremap shadow failed\n", __func__, __LINE__);
 		goto fail_ioremap;
 	}
 
-	spu->local_store = ioremap(spu->local_store_phys, LS_SIZE);
+	spu->local_store = (__force void *)ioremap_flags(spu->local_store_phys,
+		LS_SIZE, _PAGE_NO_CACHE);
+
 	if (!spu->local_store) {
 		pr_debug("%s:%d: ioremap local_store failed\n",
 			__func__, __LINE__);
@@ -199,6 +202,7 @@ static int __init setup_areas(struct spu
 
 	spu->problem = ioremap(spu->problem_phys,
 		sizeof(struct spu_problem));
+
 	if (!spu->problem) {
 		pr_debug("%s:%d: ioremap problem failed\n", __func__, __LINE__);
 		goto fail_ioremap;
@@ -206,6 +210,7 @@ static int __init setup_areas(struct spu
 
 	spu->priv2 = ioremap(spu_pdata(spu)->priv2_addr,
 		sizeof(struct spu_priv2));
+
 	if (!spu->priv2) {
 		pr_debug("%s:%d: ioremap priv2 failed\n", __func__, __LINE__);
 		goto fail_ioremap;

-- 
