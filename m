Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 553041A0DEB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 13:21:40 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: rostedt@goodmis.org
Subject: [PATCH] powerpc/xmon: Add 'dt' command to dump trace buffers
Date: Fri,  6 Nov 2015 13:21:17 +1100
Message-Id: <1446776477-2604-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is a nice interface for asking ftrace to dump all its tracing
buffers. The only down side for use in xmon is that it uses printk.
Depending on circumstances printk may not work when in xmon, but it also
may, so add a 'dt' command which dumps the ftrace buffers, and add a
note to the help to mentiont that it uses printk.

Calling this routine also disables tracing, which is problematic if you
return from xmon and expect the system to keep operating normally. So
after we do the dump turn tracing back on.

Both functions already have nop versions defined for when ftrace is not
enabled, so we don't need any extra #ifdefs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 786bf01691c9..31e0d63d2442 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -10,6 +10,8 @@
  *      as published by the Free Software Foundation; either version
  *      2 of the License, or (at your option) any later version.
  */
+
+#include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
@@ -201,7 +203,9 @@ Commands:\n\
   di	dump instructions\n\
   df	dump float values\n\
   dd	dump double values\n\
-  dl    dump the kernel log buffer\n"
+  dl    dump the kernel log buffer\n\
+  dt    dump the tracing buffers (uses printk)\n\
+  "
 #ifdef CONFIG_PPC64
   "\
   dp[#]	dump paca for current cpu, or cpu #\n\
@@ -2255,6 +2259,9 @@ dump(void)
 		last_cmd = "di\n";
 	} else if (c == 'l') {
 		dump_log_buf();
+	} else if (c == 't') {
+		ftrace_dump(DUMP_ALL);
+		tracing_on();
 	} else if (c == 'r') {
 		scanhex(&ndump);
 		if (ndump == 0)
-- 
2.5.0
