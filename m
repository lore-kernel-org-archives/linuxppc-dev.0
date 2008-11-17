Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 9652ADDDEA
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 06:11:02 +1100 (EST)
Message-Id: <20081117191059.408002035@goodmis.org>
References: <20081117190948.619751203@goodmis.org>
Date: Mon, 17 Nov 2008 14:09:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ftrace,ppc: fix test of 24bit jump
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

Impact: fix of test if an address is 26 bits away or not

Paul Mackerras pointed out that the test of the 24bit offset jump was
incorrect. For one thing, it is a 26 bit distance since we multiply
by 4 to account for the alignment. Another is that it may produce an
incorrect result on a negative jump of exactly the offset size.

Reported-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Steven Rostedt <srostedt@redhat.com>
---
 arch/powerpc/kernel/ftrace.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 9360fd1..918a5d2 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -114,12 +114,19 @@ ftrace_modify_code(unsigned long ip, unsigned char *old_code,
  */
 static int test_24bit_addr(unsigned long ip, unsigned long addr)
 {
-	unsigned long diff;
+	long diff;
 
-	/* can we get to addr from ip in 24 bits? */
-	diff = ip > addr ? ip - addr : addr - ip;
+	/*
+	 * Can we get to addr from ip in 24 bits?
+	 *  (26 really, since we mulitply by 4 for 4 byte alignment)
+	 */
+	diff = addr - ip;
 
-	return !(diff & ((unsigned long)-1 << 24));
+	/*
+	 * Return true if diff is less than 1 << 25
+	 *  and greater than -1 << 26.
+	 */
+	return (diff < (1 << 25)) && (diff > (-1 << 26));
 }
 
 static int is_bl_op(unsigned int op)
-- 
1.5.6.5

-- 
