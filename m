Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id E89AFDDDF2
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 23:00:19 +1100 (EST)
Date: Thu, 15 Nov 2007 13:00:18 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] ps3fb: video memory size cleanups
In-Reply-To: <Pine.LNX.4.62.0711151152290.19455@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.62.0711151259430.19655@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0711151152290.19455@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-2041588535-1195128018=:19655"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-2041588535-1195128018=:19655
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

ps3fb: video memory size cleanups:
  - Limit video memory size to avoid crossing a 256 MiB boundary in IOIF space.
  - Pass the actual amount of video memory used to lv1_gpu_memory_allocate().

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
FIXME Booting with `ps3fb=49M' should work now. Except that on recent
      kernels the system goes out of memory before you get there :-(

 drivers/video/ps3fb.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -51,7 +51,6 @@
 #define L1GPU_DISPLAY_SYNC_HSYNC		1
 #define L1GPU_DISPLAY_SYNC_VSYNC		2
 
-#define DDR_SIZE				(0)	/* used no ddr */
 #define GPU_CMD_BUF_SIZE			(64 * 1024)
 #define GPU_IOIF				(0x0d000000UL)
 #define GPU_ALIGN_UP(x)				_ALIGN_UP((x), 64)
@@ -1060,6 +1059,7 @@ static int __devinit ps3fb_probe(struct 
 	u64 xdr_lpar;
 	int status, res_index;
 	struct task_struct *task;
+	unsigned long max_ps3fb_size;
 
 	status = ps3_open_hv_device(dev);
 	if (status) {
@@ -1085,8 +1085,15 @@ static int __devinit ps3fb_probe(struct 
 
 	ps3fb_set_sync(&dev->core);
 
+	max_ps3fb_size = _ALIGN_UP(GPU_IOIF, 256*1024*1024) - GPU_IOIF;
+	if (ps3fb_videomemory.size > max_ps3fb_size) {
+		dev_info(&dev->core, "Limiting ps3fb mem size to %lu bytes\n",
+			 max_ps3fb_size);
+		ps3fb_videomemory.size = max_ps3fb_size;
+	}
+
 	/* get gpu context handle */
-	status = lv1_gpu_memory_allocate(DDR_SIZE, 0, 0, 0, 0,
+	status = lv1_gpu_memory_allocate(ps3fb_videomemory.size, 0, 0, 0, 0,
 					 &ps3fb.memory_handle, &ddr_lpar);
 	if (status) {
 		dev_err(&dev->core, "%s: lv1_gpu_memory_allocate failed: %d\n",

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584337861-2041588535-1195128018=:19655--
