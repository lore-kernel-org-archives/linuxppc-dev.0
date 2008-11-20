Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id C9DDDDDE1E
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 06:11:51 +1100 (EST)
Message-Id: <20081120191149.285359258@goodmis.org>
References: <20081120190948.057007623@goodmis.org>
Date: Thu, 20 Nov 2008 14:09:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] powerpc: ftrace, convert to new dynamic ftrace arch API
Cc: Thomas Gleixner <tglx@linutronix.de>, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Steven Rostedt <srostedt@redhat.com>

Impact: update to PowerPC ftrace arch API

This patch converts PowerPC to use the new dynamic ftrace arch API.

Thanks to Paul Mackennas for pointing out the mistakes of my original
test_24bit_addr function.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
---
 arch/powerpc/include/asm/ftrace.h |   14 +++++++-
 arch/powerpc/kernel/ftrace.c      |   67 ++++++++++++++++++++++++++++++++++---
 2 files changed, 75 insertions(+), 6 deletions(-)

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
index f4b006e..24c023a 100644
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
@@ -113,6 +113,62 @@ ftrace_modify_code(unsigned long ip, unsigned char *old_code,
 	return faulted;
 }
 
+static int test_24bit_addr(unsigned long ip, unsigned long addr)
+{
+	long diff;
+
+	/*
+	 * Can we get to addr from ip in 24 bits?
+	 *  (26 really, since we mulitply by 4 for 4 byte alignment)
+	 */
+	diff = addr - ip;
+
+	/*
+	 * Return true if diff is less than 1 << 25
+	 *  and greater than -1 << 26.
+	 */
+	return (diff < (1 << 25)) && (diff > (-1 << 26));
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
@@ -128,9 +184,10 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 
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
