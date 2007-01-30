Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id B4B8ADDF4F
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 04:02:04 +1100 (EST)
Date: Tue, 30 Jan 2007 18:02:02 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: James Simmons <jsimmons@infradead.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 6/10] ps3: Preallocate bootmem memory for ps3fb
In-Reply-To: <Pine.LNX.4.62.0701301754050.29343@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.62.0701301801350.29487@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701301754050.29343@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Preallocate bootmem memory for the PS3 frame buffer device, which needs a
large block of physically-contiguous memory. The size of this memory block is
configurable:
  - The config option CONFIG_FB_PS3_DEFAULT_SIZE_M allows to specify the
    default amount of memory (in MiB) allocated to the virtual frame buffer.
  - The early boot parameter `ps3fb=xxx' allows to override the default value.
    It will be rounded up to a multiple of 1 MiB, if needed.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/setup.c |   42 +++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/ps3.h          |    9 +++++++
 2 files changed, 51 insertions(+)

--- ps3-linux-2.6.20-rc6.orig/arch/powerpc/platforms/ps3/setup.c
+++ ps3-linux-2.6.20-rc6/arch/powerpc/platforms/ps3/setup.c
@@ -24,6 +24,7 @@
 #include <linux/root_dev.h>
 #include <linux/console.h>
 #include <linux/kexec.h>
+#include <linux/bootmem.h>
 
 #include <asm/machdep.h>
 #include <asm/firmware.h>
@@ -80,6 +81,46 @@ static void ps3_panic(char *str)
 	for (;;) ;
 }
 
+
+static void prealloc(struct ps3_prealloc *p)
+{
+	if (!p->size)
+		return;
+
+	p->address = __alloc_bootmem(p->size, p->align, __pa(MAX_DMA_ADDRESS));
+	if (!p->address) {
+		printk(KERN_ERR "%s: Cannot allocate %s\n", __FUNCTION__,
+		       p->name);
+		return;
+	}
+
+	printk(KERN_INFO "%s: %lu bytes at %p\n", p->name, p->size,
+	       p->address);
+}
+
+#ifdef CONFIG_FB_PS3
+struct ps3_prealloc ps3fb_videomemory = {
+    .name = "ps3fb videomemory",
+    .size = CONFIG_FB_PS3_DEFAULT_SIZE_M*1024*1024,
+    .align = 1024*1024			/* the GPU requires 1 MiB alignment */
+};
+#define prealloc_ps3fb_videomemory()	prealloc(&ps3fb_videomemory)
+
+static int __init early_parse_ps3fb(char *p)
+{
+	if (!p)
+		return 1;
+
+	ps3fb_videomemory.size = _ALIGN_UP(memparse(p, &p),
+					   ps3fb_videomemory.align);
+	return 0;
+}
+early_param("ps3fb", early_parse_ps3fb);
+#else
+#define prealloc_ps3fb_videomemory()	do { } while (0)
+#endif
+
+
 static void __init ps3_setup_arch(void)
 {
 	union ps3_firmware_version v;
@@ -101,6 +142,7 @@ static void __init ps3_setup_arch(void)
 	conswitchp = &dummy_con;
 #endif
 
+	prealloc_ps3fb_videomemory();
 	ppc_md.power_save = ps3_power_save;
 
 	DBG(" <- %s:%d\n", __func__, __LINE__);
--- ps3-linux-2.6.20-rc6.orig/include/asm-powerpc/ps3.h
+++ ps3-linux-2.6.20-rc6/include/asm-powerpc/ps3.h
@@ -426,4 +426,13 @@ int ps3_vuart_write(struct ps3_vuart_por
 int ps3_vuart_read(struct ps3_vuart_port_device *dev, void* buf,
 	unsigned int bytes);
 
+struct ps3_prealloc {
+    const char *name;
+    void *address;
+    unsigned long size;
+    unsigned long align;
+};
+
+extern struct ps3_prealloc ps3fb_videomemory;
+
 #endif

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
