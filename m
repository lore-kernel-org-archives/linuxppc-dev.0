Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <bdf32a463da3cf9603c0b0bd257ac5deedcbbfe0.1208505275.git.michael@ellerman.id.au>
In-Reply-To: <fbb91d0892c720d6f28501e1830028c78eb6664f.1208505275.git.michael@ellerman.id.au>
References: <fbb91d0892c720d6f28501e1830028c78eb6664f.1208505275.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 02/11] Add udbg_console_anytime() which sets udbg console to
	CON_ANYTIME
Date: Fri, 18 Apr 2008 17:54:34 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In theory the udbg console should be safe to call basically at any time
after boot. It does not need any per-cpu resources or for the cpu to be
online, as long as there is a udbg_putc routine hooked up it should
work. So it should be able to be marked as CON_ANYTIME.

Verifying this will take a bit of time and testing though, so instead of
marking udbg console as CON_ANYTIME for all platforms, add a routine so
that a platform can opt-in to having udbg console called early.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/udbg.c |    5 +++++
 include/asm-powerpc/udbg.h |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index 9ac5f3a..7b1fd86 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -158,6 +158,11 @@ static struct console udbg_console = {
 	.index	= 0,
 };
 
+void udbg_console_anytime(void)
+{
+	udbg_console.flags |= CON_ANYTIME;
+}
+
 static int early_console_initialized;
 
 /*
diff --git a/include/asm-powerpc/udbg.h b/include/asm-powerpc/udbg.h
index 6418cee..102fa91 100644
--- a/include/asm-powerpc/udbg.h
+++ b/include/asm-powerpc/udbg.h
@@ -23,6 +23,7 @@ extern int udbg_write(const char *s, int n);
 extern int udbg_read(char *buf, int buflen);
 
 extern void register_early_udbg_console(void);
+extern void udbg_console_anytime(void);
 extern void udbg_printf(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 extern void udbg_progress(char *s, unsigned short hex);
-- 
1.5.5
