Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Fri, 11 Jan 2008 14:27:10 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/2] ps3fb: prevent use after free of fb_info
In-Reply-To: <Pine.LNX.4.64.0801111417450.12038@vixen.sonytel.be>
Message-ID: <Pine.LNX.4.64.0801111426110.12536@vixen.sonytel.be>
References: <Pine.LNX.4.64.0801111417450.12038@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-891518858-1200058030=:12536"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>, Jeremy Kerr <jk@ozlabs.org>,
	Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>
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

---584349381-891518858-1200058030=:12536
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

From: Jeremy Kerr <jk@ozlabs.org>

In ps3fb_shutdown, freeing the framebuffer will cause fb_info (in
dev->core.driver_data) to be free()ed, which we potentially access
from the ps3fbd kthread.

This change frees the framebuffer after stopping the ps3fbd kthread.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -1234,12 +1234,6 @@ static int ps3fb_shutdown(struct ps3_sys
 	ps3fb_flip_ctl(0, &ps3fb);	/* flip off */
 	ps3fb.dinfo->irq.mask = 0;
 
-	if (info) {
-		unregister_framebuffer(info);
-		fb_dealloc_cmap(&info->cmap);
-		framebuffer_release(info);
-	}
-
 	ps3av_register_flip_ctl(NULL, NULL);
 	if (ps3fb.task) {
 		struct task_struct *task = ps3fb.task;
@@ -1250,6 +1244,12 @@ static int ps3fb_shutdown(struct ps3_sys
 		free_irq(ps3fb.irq_no, &dev->core);
 		ps3_irq_plug_destroy(ps3fb.irq_no);
 	}
+	if (info) {
+		unregister_framebuffer(info);
+		fb_dealloc_cmap(&info->cmap);
+		framebuffer_release(info);
+		info = dev->core.driver_data = NULL;
+	}
 	iounmap((u8 __iomem *)ps3fb.dinfo);
 
 	status = lv1_gpu_context_free(ps3fb.context_handle);

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
---584349381-891518858-1200058030=:12536--
