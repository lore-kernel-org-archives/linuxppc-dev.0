Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 26A3DDDE17
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 00:31:16 +1000 (EST)
Date: Sun, 22 Jul 2007 00:31:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] quite section mismatch in hvc_rtas.c
Message-Id: <20070722003128.187f5f28.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

WARNING: vmlinux.o(.text+0x2066f0): Section mismatch: reference to .init.text:.add_preferred_console (between '.hvc_rtas_console_init' and '.hvc_beat_put_chars')

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/char/hvc_rtas.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Built for PowerPC allmodconfig and ppc64_defconfig.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/char/hvc_rtas.c b/drivers/char/hvc_rtas.c
index 4b97eaf..bb09413 100644
--- a/drivers/char/hvc_rtas.c
+++ b/drivers/char/hvc_rtas.c
@@ -115,7 +115,7 @@ static void __exit hvc_rtas_exit(void)
 module_exit(hvc_rtas_exit);
 
 /* This will happen prior to module init.  There is no tty at this time? */
-static int hvc_rtas_console_init(void)
+static int __init hvc_rtas_console_init(void)
 {
 	rtascons_put_char_token = rtas_token("put-term-char");
 	if (rtascons_put_char_token == RTAS_UNKNOWN_SERVICE)
-- 
1.5.2.3
