Return-Path: <geert@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 5AEF8DDE40
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 18:37:30 +1000 (EST)
Message-Id: <20070525083632.177254000@sonycom.com>
References: <20070525083607.784351000@sonycom.com>
Date: Fri, 25 May 2007 10:36:08 +0200
From: Geert.Uytterhoeven@sonycom.com
To: linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [patch 1/7] ps3: Preallocate bootmem memory for the PS3 FLASH ROM
	storage driver
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Preallocate 256 KiB of bootmem memory for the PS3 FLASH ROM storage driver.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/setup.c |   19 ++++++++++++++++++-
 include/asm-powerpc/ps3.h          |    1 +
 2 files changed, 19 insertions(+), 1 deletion(-)

--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -99,7 +99,8 @@ static void ps3_panic(char *str)
 	while(1);
 }
 
-#if defined(CONFIG_FB_PS3) || defined(CONFIG_FB_PS3_MODULE)
+#if defined(CONFIG_FB_PS3) || defined(CONFIG_FB_PS3_MODULE) || \
+    defined(CONFIG_PS3_FLASH_MODULE) || defined(CONFIG_PS3_FLASH_MODULE)
 static void prealloc(struct ps3_prealloc *p)
 {
 	if (!p->size)
@@ -115,7 +116,9 @@ static void prealloc(struct ps3_prealloc
 	printk(KERN_INFO "%s: %lu bytes at %p\n", p->name, p->size,
 	       p->address);
 }
+#endif
 
+#if defined(CONFIG_FB_PS3) || defined(CONFIG_FB_PS3_MODULE)
 struct ps3_prealloc ps3fb_videomemory = {
 	.name = "ps3fb videomemory",
 	.size = CONFIG_FB_PS3_DEFAULT_SIZE_M*1024*1024,
@@ -138,6 +141,18 @@ early_param("ps3fb", early_parse_ps3fb);
 #define prealloc_ps3fb_videomemory()	do { } while (0)
 #endif
 
+#if defined(CONFIG_PS3_FLASH) || defined(CONFIG_PS3_FLASH_MODULE)
+struct ps3_prealloc ps3flash_bounce_buffer = {
+	.name = "ps3flash bounce buffer",
+	.size = 256*1024,
+	.align = 256*1024
+};
+EXPORT_SYMBOL_GPL(ps3flash_bounce_buffer);
+#define prealloc_ps3flash_bounce_buffer()	prealloc(&ps3flash_bounce_buffer)
+#else
+#define prealloc_ps3flash_bounce_buffer()	do { } while (0)
+#endif
+
 static int ps3_set_dabr(u64 dabr)
 {
 	enum {DABR_USER = 1, DABR_KERNEL = 2,};
@@ -167,6 +182,8 @@ static void __init ps3_setup_arch(void)
 #endif
 
 	prealloc_ps3fb_videomemory();
+	prealloc_ps3flash_bounce_buffer();
+
 	ppc_md.power_save = ps3_power_save;
 
 	DBG(" <- %s:%d\n", __func__, __LINE__);
--- a/include/asm-powerpc/ps3.h
+++ b/include/asm-powerpc/ps3.h
@@ -442,6 +442,7 @@ struct ps3_prealloc {
 };
 
 extern struct ps3_prealloc ps3fb_videomemory;
+extern struct ps3_prealloc ps3flash_bounce_buffer;
 
 
 #endif

-- 
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
