Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7A081DE0A9
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 08:08:07 +1000 (EST)
Message-ID: <46730D9B.40808@am.sony.com>
Date: Fri, 15 Jun 2007 15:07:23 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 32/33] PS3: Fix more sparse warnings
References: <20070615204749.629571012@am.sony.com>>
In-Reply-To: <20070615204749.629571012@am.sony.com>>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Fix some PS3 build warnings reported by `make C=1'.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/mm.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -239,7 +239,7 @@ void ps3_mm_vas_destroy(void)
  * @size is rounded down to a multiple of the vas large page size.
  */
 
-int ps3_mm_region_create(struct mem_region *r, unsigned long size)
+static int ps3_mm_region_create(struct mem_region *r, unsigned long size)
 {
 	int result;
 	unsigned long muid;
@@ -280,7 +280,7 @@ zero_region:
  * @r: pointer to struct mem_region
  */
 
-void ps3_mm_region_destroy(struct mem_region *r)
+static void ps3_mm_region_destroy(struct mem_region *r)
 {
 	int result;
 
@@ -893,7 +893,7 @@ static int dma_ioc0_map_area(struct ps3_
  * This is the common dma unmap routine.
  */
 
-int dma_sb_unmap_area(struct ps3_dma_region *r, unsigned long bus_addr,
+static int dma_sb_unmap_area(struct ps3_dma_region *r, unsigned long bus_addr,
 	unsigned long len)
 {
 	unsigned long flags;
@@ -929,8 +929,8 @@ int dma_sb_unmap_area(struct ps3_dma_reg
 	return 0;
 }
 
-int dma_ioc0_unmap_area(struct ps3_dma_region *r, unsigned long bus_addr,
-			unsigned long len)
+static int dma_ioc0_unmap_area(struct ps3_dma_region *r,
+			unsigned long bus_addr, unsigned long len)
 {
 	unsigned long flags;
 	struct dma_chunk *c;

-- 
