Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F7C71A066A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 21:12:49 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/6] dump_stack: Support adding to the dump stack arch
 description
Date: Tue,  5 May 2015 21:12:12 +1000
Message-Id: <1430824337-15339-1-git-send-email-mpe@ellerman.id.au>
Cc: tj@kernel.org, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arch code can set a "dump stack arch description string" which is
displayed with oops output to describe the hardware platform.

It is useful to initialise this as early as possible, so that an early
oops will have the hardware description.

However in practice we discover the hardware platform in stages, so it
would be useful to be able to incrementally fill in the hardware
description as we discover it.

This patch adds that ability, by creating dump_stack_add_arch_desc().

If there is no existing string it behaves exactly like
dump_stack_set_arch_desc(). However if there is an existing string it
appends to it, with a leading space.

This makes it easy to call it multiple times from different parts of the
code and get a reasonable looking result.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 include/linux/printk.h |  5 +++++
 kernel/printk/printk.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)


If people are happy with this, ideally we'd take this via the powerpc tree with
the rest of the series.

There also might be a better way to implement it, if so I'm all ears, but I
think what I have here is at least correct.

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 9b30871c9149..7539fd417be0 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -165,6 +165,7 @@ u32 log_buf_len_get(void);
 void log_buf_kexec_setup(void);
 void __init setup_log_buf(int early);
 void dump_stack_set_arch_desc(const char *fmt, ...);
+void dump_stack_add_arch_desc(const char *fmt, ...);
 void dump_stack_print_info(const char *log_lvl);
 void show_regs_print_info(const char *log_lvl);
 #else
@@ -219,6 +220,10 @@ static inline void dump_stack_set_arch_desc(const char *fmt, ...)
 {
 }
 
+static inline void dump_stack_add_arch_desc(const char *fmt, ...)
+{
+}
+
 static inline void dump_stack_print_info(const char *log_lvl)
 {
 }
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c099b082cd02..11d7d587e252 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3028,6 +3028,52 @@ void __init dump_stack_set_arch_desc(const char *fmt, ...)
 }
 
 /**
+ * dump_stack_add_arch_desc - add arch-specific info to show with task dumps
+ * @fmt: printf-style format string
+ * @...: arguments for the format string
+ *
+ * See dump_stack_set_arch_desc() for why you'd want to use this.
+ *
+ * This version adds to any existing string already created with either
+ * dump_stack_set_arch_desc() or dump_stack_add_arch_desc(). If there is an
+ * existing string a space will be prepended to the passed string.
+ */
+void __init dump_stack_add_arch_desc(const char *fmt, ...)
+{
+	va_list args;
+	int pos, len;
+	char *p;
+
+	/*
+	 * If there's an existing string we snprintf() past the end of it, and
+	 * then turn the terminating NULL of the existing string into a space
+	 * to create one string separated by a space.
+	 *
+	 * If there's no existing string we just snprintf() to the buffer, like
+	 * dump_stack_set_arch_desc(), but without calling it because we'd need
+	 * a varargs version.
+	 */
+
+	len = strnlen(dump_stack_arch_desc_str, sizeof(dump_stack_arch_desc_str));
+	pos = len;
+
+	if (len)
+		pos++;
+
+	if (pos >= sizeof(dump_stack_arch_desc_str))
+		return; /* Ran out of space */
+
+	p = &dump_stack_arch_desc_str[pos];
+
+	va_start(args, fmt);
+	vsnprintf(p, sizeof(dump_stack_arch_desc_str) - pos, fmt, args);
+	va_end(args);
+
+	if (len)
+		dump_stack_arch_desc_str[len] = ' ';
+}
+
+/**
  * dump_stack_print_info - print generic debug info for dump_stack()
  * @log_lvl: log level
  *
-- 
2.1.0
