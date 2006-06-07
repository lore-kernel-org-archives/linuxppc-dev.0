Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 07 Jun 2006 17:10:09 +1000
Subject: [PATCH 2/2] powerpc: Cleanup hvc_rtas.c a little
Message-Id: <20060607071009.4E65567B4A@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A few cleanups in hvc_rtas.c:
 1. Remove unused RTASCONS_PUT_ATTEMPTS
 2. Remove unused rtascons_put_delay.
 3. Use i as a loop counter like everyone else on earth.
 4. Remove pointless variables, eg. x = foo; if (x) return something_else;
 5. Whitespace cleanups and formatting.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/char/hvc_rtas.c |   37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

Index: cell/drivers/char/hvc_rtas.c
===================================================================
--- cell.orig/drivers/char/hvc_rtas.c
+++ cell/drivers/char/hvc_rtas.c
@@ -41,37 +41,28 @@
 #define hvc_rtas_cookie 0x67781e15
 struct hvc_struct *hvc_rtas_dev;
 
-#define RTASCONS_PUT_ATTEMPTS  16
-
 static int rtascons_put_char_token = RTAS_UNKNOWN_SERVICE;
 static int rtascons_get_char_token = RTAS_UNKNOWN_SERVICE;
-static int rtascons_put_delay = 100;
-module_param_named(put_delay, rtascons_put_delay, int, 0644);
 
-static inline int hvc_rtas_write_console(uint32_t vtermno, const char *buf, int count)
+static inline int hvc_rtas_write_console(uint32_t vtermno, const char *buf,
+		int count)
 {
-	int done;
+	int i;
 
-	/* if there is more than one character to be displayed, wait a bit */
-	for (done = 0; done < count; done++) {
-		int result;
-		result = rtas_call(rtascons_put_char_token, 1, 1, NULL, buf[done]);
-		if (result)
+	for (i = 0; i < count; i++) {
+		if (rtas_call(rtascons_put_char_token, 1, 1, NULL, buf[i]))
 			break;
 	}
-	/* the calling routine expects to receive the number of bytes sent */
-	return done;
+
+	return i;
 }
 
 static int hvc_rtas_read_console(uint32_t vtermno, char *buf, int count)
 {
-	int i;
+	int i, c;
 
 	for (i = 0; i < count; i++) {
-		int c, err;
-
-		err = rtas_call(rtascons_get_char_token, 0, 2, &c);
-		if (err)
+		if (rtas_call(rtascons_get_char_token, 0, 2, &c))
 			break;
 
 		buf[i] = c;
@@ -106,7 +97,9 @@ static int hvc_rtas_init(void)
 	hp = hvc_alloc(hvc_rtas_cookie, NO_IRQ, &hvc_rtas_get_put_ops);
 	if (IS_ERR(hp))
 		return PTR_ERR(hp);
+
 	hvc_rtas_dev = hp;
+
 	return 0;
 }
 module_init(hvc_rtas_init);
@@ -114,8 +107,8 @@ module_init(hvc_rtas_init);
 /* This will tear down the tty portion of the driver */
 static void __exit hvc_rtas_exit(void)
 {
-	/* Really the fun isn't over until the worker thread breaks down and the
-	 * tty cleans up */
+	/* Really the fun isn't over until the worker thread breaks down and
+	 * the tty cleans up */
 	if (hvc_rtas_dev)
 		hvc_remove(hvc_rtas_dev);
 }
@@ -127,12 +120,14 @@ static int hvc_rtas_console_init(void)
 	rtascons_put_char_token = rtas_token("put-term-char");
 	if (rtascons_put_char_token == RTAS_UNKNOWN_SERVICE)
 		return -EIO;
+
 	rtascons_get_char_token = rtas_token("get-term-char");
 	if (rtascons_get_char_token == RTAS_UNKNOWN_SERVICE)
 		return -EIO;
 
-	hvc_instantiate(hvc_rtas_cookie, 0, &hvc_rtas_get_put_ops );
+	hvc_instantiate(hvc_rtas_cookie, 0, &hvc_rtas_get_put_ops);
 	add_preferred_console("hvc", 0, NULL);
+
 	return 0;
 }
 console_initcall(hvc_rtas_console_init);
