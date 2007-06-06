Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 77034DE124
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 12:59:57 +1000 (EST)
Message-ID: <46662326.4030706@am.sony.com>
Date: Tue, 05 Jun 2007 19:59:50 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [patch 05/18] PS3: Fix sparse warnings
References: <20070606024407.786638029@am.sony.com>>
In-Reply-To: <20070606024407.786638029@am.sony.com>>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix some PS3 build warnings reported by `make C=1'.  You need to
install sparse:
  git://git.kernel.org/pub/scm/devel/sparse/sparse.git

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/os-area.c |    4 ++--
 arch/powerpc/platforms/ps3/spu.c     |    3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

--- a/arch/powerpc/platforms/ps3/os-area.c
+++ b/arch/powerpc/platforms/ps3/os-area.c
@@ -133,7 +133,7 @@ struct saved_params {
 } static saved_params;
 
 #define dump_header(_a) _dump_header(_a, __func__, __LINE__)
-static void _dump_header(const struct os_area_header __iomem *h, const char* func,
+static void _dump_header(const struct os_area_header *h, const char* func,
 	int line)
 {
 	pr_debug("%s:%d: h.magic_num:         '%s'\n", func, line,
@@ -151,7 +151,7 @@ static void _dump_header(const struct os
 }
 
 #define dump_params(_a) _dump_params(_a, __func__, __LINE__)
-static void _dump_params(const struct os_area_params __iomem *p, const char* func,
+static void _dump_params(const struct os_area_params *p, const char* func,
 	int line)
 {
 	pr_debug("%s:%d: p.boot_flag:       %u\n", func, line, p->boot_flag);
--- a/arch/powerpc/platforms/ps3/spu.c
+++ b/arch/powerpc/platforms/ps3/spu.c
@@ -190,7 +190,8 @@ static int __init setup_areas(struct spu
 		goto fail_ioremap;
 	}
 
-	spu->local_store = ioremap(spu->local_store_phys, LS_SIZE);
+	spu->local_store = (__force void *)ioremap(spu->local_store_phys,
+						   LS_SIZE);
 	if (!spu->local_store) {
 		pr_debug("%s:%d: ioremap local_store failed\n",
 			__func__, __LINE__);

-- 
