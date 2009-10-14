Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 581F5B7334
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 08:54:03 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, scottwood@freescale.com, borntraeger@de.ibm.com,
	brueckner@linux.vnet.ibm.com
Subject: [PATCH] hvc_console: returning 0 from put_chars is not an error
Date: Wed, 14 Oct 2009 16:53:46 -0500
Message-Id: <1255557226-4403-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hvc_console_print() calls the HVC client driver's put_chars() callback
to write some characters to the console.  If the callback returns 0, that
indicates that no characters were written (perhaps the output buffer is
full), but hvc_console_print() treats that as an error and discards the
rest of the buffer.

So change hvc_console_print() to just loop and call put_chars() again if it
returns a 0 return code.

This change makes hvc_console_print() behave more like hvc_push(), which does
check for a 0 return code and re-schedules itself.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch might cause a hang in drivers that return 0 in case of error, 
instead of a negative number, but those drivers are broken anyway.  This 
patch might fix drivers that return 0 to indicate that they're busy, such as
arch/powerpc/platforms/pseries/hvconsole.c.  It will break drivers that
return 0 if their output buffer is full, but where those buffers cannot be
emptied while the kernel is in a loop.

 drivers/char/hvc_console.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
index 25ce15b..0c94907 100644
--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -161,7 +161,7 @@ static void hvc_console_print(struct console *co, const char *b,
 			}
 		} else {
 			r = cons_ops[index]->put_chars(vtermnos[index], c, i);
-			if (r <= 0) {
+			if (r < 0) {
 				/* throw away chars on error */
 				i = 0;
 			} else if (r > 0) {
-- 
1.6.5
