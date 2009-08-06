Return-Path: <akpm@linux-foundation.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 210A1B8367
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 09:01:06 +1000 (EST)
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 94E1FDDD01
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 09:01:05 +1000 (EST)
Message-Id: <200908062300.n76N0cS2028910@imap1.linux-foundation.org>
Subject: [patch 3/3] powerpc: avoid calculating possibly-invalid address
To: benh@kernel.crashing.org
From: akpm@linux-foundation.org
Date: Thu, 06 Aug 2009 16:00:37 -0700
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, roel.kluin@gmail.com,
	bernd@firmix.at
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Roel Kluin <roel.kluin@gmail.com>

Check whether index is within bounds prior to calculating a
possibly-invalid address.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Cc: Bernd Petrovitsch <bernd@firmix.at>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/char/hvsi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/char/hvsi.c~powerpc-avoid-calculating-possibly-invalid-address drivers/char/hvsi.c
--- a/drivers/char/hvsi.c~powerpc-avoid-calculating-possibly-invalid-address
+++ a/drivers/char/hvsi.c
@@ -1230,11 +1230,12 @@ static struct tty_driver *hvsi_console_d
 
 static int __init hvsi_console_setup(struct console *console, char *options)
 {
-	struct hvsi_struct *hp = &hvsi_ports[console->index];
+	struct hvsi_struct *hp;
 	int ret;
 
 	if (console->index < 0 || console->index >= hvsi_count)
 		return -1;
+	hp = &hvsi_ports[console->index];
 
 	/* give the FSP a chance to change the baud rate when we re-open */
 	hvsi_close_protocol(hp);
_
