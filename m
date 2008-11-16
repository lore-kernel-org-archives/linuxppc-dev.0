Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 7DA28DDE04
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 08:25:17 +1100 (EST)
Message-Id: <20081116212515.331278109@goodmis.org>
References: <20081116212428.938752312@goodmis.org>
Date: Sun, 16 Nov 2008 16:24:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] ftrace, ppc: convert to new dynamic ftrace arch API
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

Impact: change PPC to use new ftrace arch API

This patch converts PPC to use the new dynamic ftrace arch API.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
---
 arch/powerpc/include/asm/ftrace.h |   14 ++++++++-
 arch/powerpc/kernel/ftrace.c      |   60 +++++++++++++++++++++++++++++++++---
 2 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index b298f7a..17efecc 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -7,7 +7,19 @@
 
 #ifndef __ASSEMBLY__
 extern void _mcount(void);
-#endif
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+static inline unsigned long ftrace_call_adjust(unsigned long addr)
+{
+       /* reloction of mcount call site is the same as the address */
+       return addr;
+}
+
+struct dyn_arch_ftrace {
+	/* nothing yet */
+};
+#endif /*  CONFIG_DYNAMIC_FTRACE */
+#endif /* __ASSEMBLY__ */
 
 #endif
 
diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index f4b006e..aa5d0b2 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -33,12 +33,12 @@ static unsigned int ftrace_calc_offset(long ip, long addr)
 	return (int)(addr - ip);
 }
 
-unsigned char *ftrace_nop_replace(void)
+static unsigned char *ftrace_nop_replace(void)
 {
 	return (char *)&ftrace_nop;
 }
 
-unsigned char *ftrace_call_replace(unsigned long ip, unsigned long addr)
+static unsigned char *ftrace_call_replace(unsigned long ip, unsigned long addr)
 {
 	static unsigned int op;
 
@@ -68,7 +68,7 @@ unsigned char *ftrace_call_replace(unsigned long ip, unsigned long addr)
 # define _ASM_PTR	" .long "
 #endif
 
-int
+static int
 ftrace_modify_code(unsigned long ip, unsigned char *old_code,
 		   unsigned char *new_code)
 {
@@ -113,6 +113,55 @@ ftrace_modify_code(unsigned long ip, unsigned char *old_code,
 	return faulted;
 }
 
+static int test_24bit_addr(unsigned long ip, unsigned long addr)
+{
+	unsigned long diff;
+
+	/* can we get to addr from ip in 24 bits? */
+	diff = ip > addr ? ip - addr : addr - ip;
+
+	return !(diff & ((unsigned long)-1 << 24));
+}
+
+int ftrace_make_nop(struct module *mod,
+		    struct dyn_ftrace *rec, unsigned long addr)
+{
+	unsigned char *old, *new;
+
+	/*
+	 * If the calling address is more that 24 bits away,
+	 * then we had to use a trampoline to make the call.
+	 * Otherwise just update the call site.
+	 */
+	if (test_24bit_addr(rec->ip, addr)) {
+		/* within range */
+		old = ftrace_call_replace(rec->ip, addr);
+		new = ftrace_nop_replace();
+		return ftrace_modify_code(rec->ip, old, new);
+	}
+
+	return 0;
+}
+
+int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+{
+	unsigned char *old, *new;
+
+	/*
+	 * If the calling address is more that 24 bits away,
+	 * then we had to use a trampoline to make the call.
+	 * Otherwise just update the call site.
+	 */
+	if (test_24bit_addr(rec->ip, addr)) {
+		/* within range */
+		old = ftrace_nop_replace();
+		new = ftrace_call_replace(rec->ip, addr);
+		return ftrace_modify_code(rec->ip, old, new);
+	}
+
+	return 0;
+}
+
 int ftrace_update_ftrace_func(ftrace_func_t func)
 {
 	unsigned long ip = (unsigned long)(&ftrace_call);
@@ -128,9 +177,10 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 
 int __init ftrace_dyn_arch_init(void *data)
 {
-	/* This is running in kstop_machine */
+	/* caller expects data to be zero */
+	unsigned long *p = data;
 
-	ftrace_mcount_set(data);
+	*p = 0;
 
 	return 0;
 }
-- 
1.5.6.5

-- 
