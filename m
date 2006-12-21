Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id B5E94DDEB6
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Dec 2006 23:57:18 +1100 (EST)
Date: Thu, 21 Dec 2006 13:57:16 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] ps3_free_io_irq: inverted error check
Message-ID: <Pine.LNX.4.62.0612211355150.20731@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ps3_free_io_irq: Fix inverted error check after calling
lv1_destruct_io_irq_outlet()

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

---
 arch/powerpc/platforms/ps3/interrupt.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- ps3-linux-src.orig/arch/powerpc/platforms/ps3/interrupt.c
+++ ps3-linux-src/arch/powerpc/platforms/ps3/interrupt.c
@@ -71,7 +71,7 @@ int ps3_free_io_irq(unsigned int virq)
 
 	result = lv1_destruct_io_irq_outlet(virq_to_hw(virq));
 
-	if (!result)
+	if (result)
 		pr_debug("%s:%d: lv1_destruct_io_irq_outlet failed: %s\n",
 			__func__, __LINE__, ps3_result(result));
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
