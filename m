Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 20/20] powerpc/xmon: Fallback to printk() in xmon_printf() if
 udbg is not setup
Date: Wed, 10 Oct 2012 01:20:47 +1100
Message-Id: <1349792447-15714-20-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1349792447-15714-1-git-send-email-michael@ellerman.id.au>
References: <1349792447-15714-1-git-send-email-michael@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is possible to configure a kernel which has xmon enabled, but has no
udbg backend to provide IO. This can make xmon rather confusing, as it
produces no output, blocks for two seconds, and then returns.

As a last resort we can instead try to printk(), which may deadlock or
otherwise crash, but tries quite hard not to.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/xmon/nonstdio.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/nonstdio.c b/arch/powerpc/xmon/nonstdio.c
index 942d0f6..bce3dcf 100644
--- a/arch/powerpc/xmon/nonstdio.c
+++ b/arch/powerpc/xmon/nonstdio.c
@@ -111,13 +111,19 @@ char *xmon_gets(char *str, int nb)
 void xmon_printf(const char *format, ...)
 {
 	va_list args;
-	int n;
 	static char xmon_outbuf[1024];
+	int rc, n;
 
 	va_start(args, format);
 	n = vsnprintf(xmon_outbuf, sizeof(xmon_outbuf), format, args);
 	va_end(args);
-	xmon_write(xmon_outbuf, n);
+
+	rc = xmon_write(xmon_outbuf, n);
+
+	if (n && rc == 0) {
+		/* No udbg hooks, fallback to printk() - dangerous */
+		printk(xmon_outbuf);
+	}
 }
 
 void xmon_puts(const char *str)
-- 
1.7.9.5
