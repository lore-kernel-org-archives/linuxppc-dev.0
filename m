Return-Path: <keescook@www.outflux.net>
Received: from smtp.outflux.net (smtp.outflux.net
 [IPv6:2001:19d0:2:6:c0de:0:736d:7470])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B89611A00D9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 04:00:22 +1000 (EST)
Date: Tue, 10 Jun 2014 10:54:06 -0700
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/xmon: avoid format string leaking to printk
Message-ID: <20140610175406.GA30672@www.outflux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This makes sure format strings cannot leak into printk (the string has
already been correctly processed for format arguments).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/xmon/nonstdio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/nonstdio.c b/arch/powerpc/xmon/nonstdio.c
index bce3dcfe5058..c98748617896 100644
--- a/arch/powerpc/xmon/nonstdio.c
+++ b/arch/powerpc/xmon/nonstdio.c
@@ -122,7 +122,7 @@ void xmon_printf(const char *format, ...)
 
 	if (n && rc == 0) {
 		/* No udbg hooks, fallback to printk() - dangerous */
-		printk(xmon_outbuf);
+		printk("%s", xmon_outbuf);
 	}
 }
 
-- 
1.7.9.5


-- 
Kees Cook
Chrome OS Security
