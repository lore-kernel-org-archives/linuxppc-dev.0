Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 03/20] powerpc/xmon: Remove empty xmon_map_scc()
Date: Wed, 10 Oct 2012 01:20:30 +1100
Message-Id: <1349792447-15714-3-git-send-email-michael@ellerman.id.au>
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

This has been empty since 2005, commit 51d3082 "Unify udbg (#2)".

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/xmon/nonstdio.h |    1 -
 arch/powerpc/xmon/start.c    |    4 ----
 arch/powerpc/xmon/xmon.c     |    1 -
 3 files changed, 6 deletions(-)

diff --git a/arch/powerpc/xmon/nonstdio.h b/arch/powerpc/xmon/nonstdio.h
index d8cec38..8799ccf 100644
--- a/arch/powerpc/xmon/nonstdio.h
+++ b/arch/powerpc/xmon/nonstdio.h
@@ -8,6 +8,5 @@ extern int xmon_getchar(void);
 extern void xmon_puts(const char *);
 extern char *xmon_gets(char *, int);
 extern void xmon_printf(const char *, ...);
-extern void xmon_map_scc(void);
 extern int xmon_write(const void *ptr, int nb);
 extern int xmon_readchar(void);
diff --git a/arch/powerpc/xmon/start.c b/arch/powerpc/xmon/start.c
index 84f3a15..7769cb5 100644
--- a/arch/powerpc/xmon/start.c
+++ b/arch/powerpc/xmon/start.c
@@ -10,10 +10,6 @@
 #include <asm/udbg.h>
 #include "nonstdio.h"
 
-void xmon_map_scc(void)
-{
-}
-
 int xmon_write(const void *ptr, int nb)
 {
 	return udbg_write(ptr, nb);
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 3a56a63..67d36ab 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2943,7 +2943,6 @@ static void xmon_init(int enable)
 		__debugger_dabr_match = NULL;
 		__debugger_fault_handler = NULL;
 	}
-	xmon_map_scc();
 }
 
 #ifdef CONFIG_MAGIC_SYSRQ
-- 
1.7.9.5
