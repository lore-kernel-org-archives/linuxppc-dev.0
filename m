Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 8E9B4DDDFE
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 21:17:33 +1100 (EST)
Date: Wed, 19 Dec 2007 11:17:31 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/2] ps3fb: Fix ps3fb free_irq() dev_id
In-Reply-To: <Pine.LNX.4.62.0712191105220.16918@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.62.0712191116440.17591@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0712191105220.16918@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1847472362-1198059451=:17591"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
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

---584337861-1847472362-1198059451=:17591
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

From: Geoff Levand <geoffrey.levand@am.sony.com>

The dev_id arg passed to free_irq() must match that passed to
request_irq().

Fixes this PS3 error message: 

  Trying to free already-free IRQ 44

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -1212,7 +1212,7 @@ err_fb_dealloc:
 err_framebuffer_release:
 	framebuffer_release(info);
 err_free_irq:
-	free_irq(ps3fb.irq_no, dev);
+	free_irq(ps3fb.irq_no, &dev->core);
 	ps3_irq_plug_destroy(ps3fb.irq_no);
 err_iounmap_dinfo:
 	iounmap((u8 __iomem *)ps3fb.dinfo);
@@ -1247,7 +1247,7 @@ static int ps3fb_shutdown(struct ps3_sys
 		kthread_stop(task);
 	}
 	if (ps3fb.irq_no) {
-		free_irq(ps3fb.irq_no, dev);
+		free_irq(ps3fb.irq_no, &dev->core);
 		ps3_irq_plug_destroy(ps3fb.irq_no);
 	}
 	iounmap((u8 __iomem *)ps3fb.dinfo);

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
---584337861-1847472362-1198059451=:17591--
