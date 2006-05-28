Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8AF5E67A3D
	for <linuxppc-dev@ozlabs.org>; Sun, 28 May 2006 20:46:27 +1000 (EST)
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id BA279F012
	for <linuxppc-dev@ozlabs.org>; Sun, 28 May 2006 12:46:21 +0200 (CEST)
Date: Sun, 28 May 2006 12:46:21 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: add dmesg command to xmon
Message-ID: <20060528104621.GA7126@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Based on work by Linas Vepstas:
dump dmesg buffer in xmon, with a new 'D' command.
Use kallsyms to lookup the symbols to avoid touching generic code in printk.c

Signed-off-by: Olaf Hering <olh@suse.de>

---
 arch/powerpc/xmon/xmon.c |  112 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

Index: linux-2.6/arch/powerpc/xmon/xmon.c
===================================================================
--- linux-2.6.orig/arch/powerpc/xmon/xmon.c
+++ linux-2.6/arch/powerpc/xmon/xmon.c
@@ -143,6 +143,7 @@ void dump_segments(void);
 static void symbol_lookup(void);
 static void xmon_print_symbol(unsigned long address, const char *mid,
 			      const char *after);
+static void xmon_show_dmesg(void);
 static const char *getvecname(unsigned long vec);
 
 extern int print_insn_powerpc(unsigned long, unsigned long, int);
@@ -192,6 +193,7 @@ Commands:\n\
   df	dump float values\n\
   dd	dump double values\n\
   dr	dump stream of raw bytes\n\
+  D	show dmesg (printk) buffer\n\
   e	print exception information\n\
   f	flush cache\n\
   la	lookup symbol+offset of specified address\n\
@@ -781,6 +783,9 @@ cmds(struct pt_regs *excp)
 		case 'd':
 			dump();
 			break;
+		case 'D':
+			xmon_show_dmesg();
+			break;
 		case 'l':
 			symbol_lookup();
 			break;
@@ -2488,6 +2493,113 @@ static void xmon_print_symbol(unsigned l
 	printf("%s", after);
 }
 
+#ifdef CONFIG_KALLSYMS
+static const char *xmon_log_buf;
+static int xmon_log_buf_len;
+static unsigned long xmon_log_end, xmon_logged_chars;
+
+static int xmon_init_dmesg(void)
+{
+	const char **p;
+	const int *i;
+	const unsigned long *l;
+
+	if (!xmon_log_buf && setjmp(bus_error_jmp) == 0) {
+		catch_memory_errors = 1;
+		sync();
+
+		p = (const char **)kallsyms_lookup_name("log_buf");
+		if (p) {
+			xmon_log_buf = *p;
+			sync();
+			__delay(200);
+		}
+
+		i = (const int *)kallsyms_lookup_name("log_buf_len");
+		if (i) {
+			xmon_log_buf_len = *i;
+			sync();
+			__delay(200);
+		}
+
+		l = (const unsigned long *)kallsyms_lookup_name("log_end");
+		if (l) {
+			xmon_log_end = *l;
+			sync();
+			__delay(200);
+		}
+
+		l = (const unsigned long *)kallsyms_lookup_name("logged_chars");
+		if (l) {
+			xmon_logged_chars = *l;
+			sync();
+			__delay(200);
+		}
+
+	}
+	catch_memory_errors = 0;
+	return !!xmon_log_buf;
+}
+#else
+static inline int xmon_init_dmesg(void)
+{
+	return 0;
+}
+#endif
+
+static void xmon_show_dmesg(void)
+{
+	if (xmon_init_dmesg()) {
+		const char *p_start, *p_end, *l_start, *l_end, *start, *end;
+		char c;
+
+		p_start = xmon_log_buf;
+		p_end = p_start + xmon_log_buf_len;
+		l_start = p_start + xmon_log_end - (xmon_logged_chars < xmon_log_buf_len ? xmon_logged_chars : xmon_log_buf_len);
+		l_end = p_start + xmon_log_end;
+		if (l_start == l_end)
+			return;
+		start = p_start + (l_start - p_start) % xmon_log_buf_len;
+		end = p_start + (l_end - p_start) % xmon_log_buf_len;
+		c = '\0';
+		while (1) {
+			const char *p;
+			int chars = 0;
+			if (!*start) {
+				while (!*start) {
+					start++;
+					if (start < p_start)
+						start = p_end - 1;
+					else if (start >= p_end)
+						start = p_start;
+					if (start == end)
+						break;
+				}
+				if (start == end)
+					break;
+			}
+			p = start;
+			while (*start && chars < 200) {
+				c = *start;
+				chars++;
+				start++;
+				if (start < p_start)
+					start = p_end - 1;
+				else if (start >= p_end)
+					start = p_start;
+				if (start == end)
+					break;
+			}
+			if (chars)
+				printf("%.*s", chars, p);
+			if (start == end)
+				break;
+		}
+		if (c != '\n')
+			printf("\n");
+	}
+}
+
 #ifdef CONFIG_PPC64
 static void dump_slb(void)
 {
