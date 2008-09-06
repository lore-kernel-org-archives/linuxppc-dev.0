Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 5D262DDDDF
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Sep 2008 15:09:08 +1000 (EST)
Message-Id: <20080906050905.931087594@goodmis.org>
References: <20080906050602.409299112@goodmis.org>
Date: Sat, 06 Sep 2008 01:06:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ftrace: use ftrace_release for all dynamic ftrace
	functions
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ftrace_release is necessary for all uses of dynamic ftrace and not just
the archs that have CONFIG_FTRACE_MCOUNT_RECORD defined.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
---
 include/linux/ftrace.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: linux-tip.git/include/linux/ftrace.h
===================================================================
--- linux-tip.git.orig/include/linux/ftrace.h	2008-09-05 16:04:34.000000000 -0700
+++ linux-tip.git/include/linux/ftrace.h	2008-09-05 20:10:47.000000000 -0700
@@ -77,8 +77,10 @@ extern void mcount_call(void);
 
 extern int skip_trace(unsigned long ip);
 
-void ftrace_disable_daemon(void);
-void ftrace_enable_daemon(void);
+extern void ftrace_release(void *start, unsigned long size);
+
+extern void ftrace_disable_daemon(void);
+extern void ftrace_enable_daemon(void);
 
 #else
 # define skip_trace(ip)				({ 0; })
@@ -86,6 +88,7 @@ void ftrace_enable_daemon(void);
 # define ftrace_set_filter(buf, len, reset)	do { } while (0)
 # define ftrace_disable_daemon()		do { } while (0)
 # define ftrace_enable_daemon()			do { } while (0)
+static inline void ftrace_release(void *start, unsigned long size) { }
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 /* totally disable ftrace - can not re-enable after this */
@@ -199,12 +202,10 @@ static inline void ftrace_dump(void) { }
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 extern void ftrace_init(void);
 extern void ftrace_init_module(unsigned long *start, unsigned long *end);
-extern void ftrace_release(void *start, unsigned long size);
 #else
 static inline void ftrace_init(void) { }
 static inline void
 ftrace_init_module(unsigned long *start, unsigned long *end) { }
-static inline void ftrace_release(void *start, unsigned long size) { }
 #endif
 
 

-- 
