Return-Path: <roel.kluin@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 5A149DDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 08:21:41 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id 17so3144574ugm.14
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Dec 2008 13:21:39 -0800 (PST)
Message-ID: <4935A6E7.3070704@gmail.com>
Date: Tue, 02 Dec 2008 22:21:43 +0100
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: paulus@samba.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH v2] hv{c,cs,si}_struct make *count signed
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Otherwise count < 0 will fail

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
This was not tested. Is this how it should be fixed?

the locations where the failures occur are in the functions hv*_close, on:

vi drivers/char/hvcs.c +1251

vi drivers/char/hvsi.c +911

vi drivers/char/drivers/char/hvc_console.c +387

diff --git a/drivers/char/hvc_console.h b/drivers/char/hvc_console.h
index 8297dbc..3c85d78 100644
--- a/drivers/char/hvc_console.h
+++ b/drivers/char/hvc_console.h
@@ -48,7 +48,7 @@ struct hvc_struct {
 	spinlock_t lock;
 	int index;
 	struct tty_struct *tty;
-	unsigned int count;
+	int count;
 	int do_wakeup;
 	char *outbuf;
 	int outbuf_size;
diff --git a/drivers/char/hvcs.c b/drivers/char/hvcs.c
index 473d9b1..6e6eb44 100644
--- a/drivers/char/hvcs.c
+++ b/drivers/char/hvcs.c
@@ -269,7 +269,7 @@ struct hvcs_struct {
 	unsigned int index;
 
 	struct tty_struct *tty;
-	unsigned int open_count;
+	int open_count;
 
 	/*
 	 * Used to tell the driver kernel_thread what operations need to take
diff --git a/drivers/char/hvsi.c b/drivers/char/hvsi.c
index 59c6f9a..af05528 100644
--- a/drivers/char/hvsi.c
+++ b/drivers/char/hvsi.c
@@ -75,7 +75,7 @@ struct hvsi_struct {
 	spinlock_t lock;
 	int index;
 	struct tty_struct *tty;
-	unsigned int count;
+	int count;
 	uint8_t throttle_buf[128];
 	uint8_t outbuf[N_OUTBUF]; /* to implement write_room and chars_in_buffer */
 	/* inbuf is for packet reassembly. leave a little room for leftovers. */
