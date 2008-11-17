Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 2E1934753F
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 06:11:16 +1100 (EST)
Message-Id: <20081117191059.610706327@goodmis.org>
References: <20081117190948.619751203@goodmis.org>
Date: Mon, 17 Nov 2008 14:09:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ftrace,ppc: fix module check in dynamic ftrace code
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pekka Paalanen <pq@iki.fi>, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Paul Mundt <lethal@linux-sh.org>, Paul Mackerras <paulus@samba.org>,
	Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Impact: fix to module check in making nops in dynamic ftrace for PPC

Paul Mackerras pointed out that the mod test in ftrace_make_nop looks
wrong. It is, but it did not trigger because the logic to ftrace just
happens to miss the bad case.

When ftrace first changes all the calls to mcount into nops, it passes
in the "mod" parameter, and the rec->arch.mod is NULL. This case assigns
the rec->arch.mod to mod and succeeds. From then on, ftrace will pass
in a NULL for mod and the check if mod and rec->arch.mod is the same
is skipped.

The failure of the current test may produce a false positive failuer,
which will cause ftrace to shutdown even if the code was correct. This
patch fixes the test.

Reported-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Steven Rostedt <srostedt@redhat.com>
---
 arch/powerpc/kernel/ftrace.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 918a5d2..81e338c 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -354,10 +354,13 @@ int ftrace_make_nop(struct module *mod,
 		}
 		rec->arch.mod = mod;
 	} else if (mod) {
-		printk(KERN_ERR
-		       "Record mod %p not equal to passed in mod %p\n",
-		       rec->arch.mod, mod);
-		return -EINVAL;
+		if (mod != rec->arch.mod) {
+			printk(KERN_ERR
+			       "Record mod %p not equal to passed in mod %p\n",
+			       rec->arch.mod, mod);
+			return -EINVAL;
+		}
+		/* nothing to do if mod == rec->arch.mod */
 	} else
 		mod = rec->arch.mod;
 
-- 
1.5.6.5

-- 
