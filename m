Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 28F73DDFDC
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 08:07:49 +1000 (EST)
Message-ID: <46730248.3080703@am.sony.com>
Date: Fri, 15 Jun 2007 14:19:04 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 06/33] PS3: Fix sparse warnings
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

Fix some PS3 build warnings reported by `make C=1'.  You need to
install sparse:
  git://git.kernel.org/pub/scm/devel/sparse/sparse.git

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/os-area.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/platforms/ps3/os-area.c
+++ b/arch/powerpc/platforms/ps3/os-area.c
@@ -133,7 +133,7 @@ struct saved_params {
 } static saved_params;
 
 #define dump_header(_a) _dump_header(_a, __func__, __LINE__)
-static void _dump_header(const struct os_area_header __iomem *h, const char* func,
+static void _dump_header(const struct os_area_header *h, const char *func,
 	int line)
 {
 	pr_debug("%s:%d: h.magic_num:         '%s'\n", func, line,
@@ -151,7 +151,7 @@ static void _dump_header(const struct os
 }
 
 #define dump_params(_a) _dump_params(_a, __func__, __LINE__)
-static void _dump_params(const struct os_area_params __iomem *p, const char* func,
+static void _dump_params(const struct os_area_params *p, const char *func,
 	int line)
 {
 	pr_debug("%s:%d: p.boot_flag:       %u\n", func, line, p->boot_flag);

-- 
