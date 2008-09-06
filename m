Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 6E59ADDDE1
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Sep 2008 15:09:08 +1000 (EST)
Message-Id: <20080906050906.111265558@goodmis.org>
References: <20080906050602.409299112@goodmis.org>
Date: Sat, 06 Sep 2008 01:06:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ftrace: fix unlocking of hash
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

This must be brown paper bag week for Steven Rostedt!

While working on ftrace for PPC, I discovered that the hash locking done
when CONFIG_FTRACE_MCOUNT_RECORD is not set, is totally incorrect.

With a cut and paste error, I had the hash lock macro to lock for both
hash_lock _and_ hash_unlock!

This bug did not affect x86 since this bug was introduced when
CONFIG_FTRACE_MCOUNT_RECORD was added to x86.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
---
 kernel/trace/ftrace.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-tip.git/kernel/trace/ftrace.c
===================================================================
--- linux-tip.git.orig/kernel/trace/ftrace.c	2008-09-05 21:53:46.000000000 -0700
+++ linux-tip.git/kernel/trace/ftrace.c	2008-09-05 21:57:57.000000000 -0700
@@ -170,7 +170,8 @@ static int __unregister_ftrace_function(
  */
 static DEFINE_SPINLOCK(ftrace_hash_lock);
 #define ftrace_hash_lock(flags)	  spin_lock_irqsave(&ftrace_hash_lock, flags)
-#define ftrace_hash_unlock(flags) spin_lock_irqsave(&ftrace_hash_lock, flags)
+#define ftrace_hash_unlock(flags) \
+			spin_unlock_irqrestore(&ftrace_hash_lock, flags)
 #else
 /* This is protected via the ftrace_lock with MCOUNT_RECORD. */
 #define ftrace_hash_lock(flags)   do { (void)(flags); } while (0)

-- 
