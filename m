Return-Path: <SRS0+455da65edc9e485b1fd8+617+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D7DC367A70
	for <linuxppc-dev@ozlabs.org>; Mon,  2 May 2005 17:59:53 +1000 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: akpm@osdl.org, linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Mon, 02 May 2005 08:57:30 +0100
Message-Id: <1115020651.3287.0.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [PATCH] ppc32: platform-specific functions missing from kallsyms.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PPC32 kernel puts platform-specific functions into separate sections
so that unneeded parts of it can be freed when we've booted and actually
worked out what we're running on today. 

This makes kallsyms ignore those functions, because they're not between
_[se]text or _[se]inittext. Rather than teaching kallsyms about the
various pmac/chrp/etc sections, this patch adds '_[se]extratext' markers
for kallsyms.

Signed-off-by: David Woodhouse <dwmw2@infradead.org> 

--- linux-2.6.11/arch/ppc/kernel/vmlinux.lds~	2005-05-01 10:43:10.000000000 +0100
+++ linux-2.6.11/arch/ppc/kernel/vmlinux.lds	2005-05-02 08:06:52.000000000 +0100
@@ -147,6 +147,7 @@ SECTIONS
   __init_end = .;
 
   . = ALIGN(4096);
+  _sextratext = .;
   __pmac_begin = .;
   .pmac.text : { *(.pmac.text) }
   .pmac.data : { *(.pmac.data) }
@@ -173,6 +174,7 @@ SECTIONS
   .openfirmware.data : { *(.openfirmware.data) }
   . = ALIGN(4096);
   __openfirmware_end = .;
+  _eextratext = .;
 
   __bss_start = .;
   .bss :
--- linux-2.6.11/include/asm-generic/sections.h~	2005-03-02 07:37:31.000000000 +0000
+++ linux-2.6.11/include/asm-generic/sections.h	2005-05-02 08:43:04.000000000 +0100
@@ -8,6 +8,8 @@ extern char _data[], _sdata[], _edata[];
 extern char __bss_start[], __bss_stop[];
 extern char __init_begin[], __init_end[];
 extern char _sinittext[], _einittext[];
+extern char _sextratext[] __attribute__((weak));
+extern char _eextratext[] __attribute__((weak));
 extern char _end[];
 
 #endif /* _ASM_GENERIC_SECTIONS_H_ */
--- linux-2.6.11/scripts/kallsyms.c~	2005-03-02 07:38:33.000000000 +0000
+++ linux-2.6.11/scripts/kallsyms.c	2005-05-02 08:09:11.000000000 +0100
@@ -67,7 +67,7 @@ struct sym_entry {
 
 static struct sym_entry *table;
 static int size, cnt;
-static unsigned long long _stext, _etext, _sinittext, _einittext;
+static unsigned long long _stext, _etext, _sinittext, _einittext, _sextratext, _eextratext;
 static int all_symbols = 0;
 
 struct token {
@@ -132,6 +132,10 @@ read_symbol(FILE *in, struct sym_entry *
 		_sinittext = s->addr;
 	else if (strcmp(str, "_einittext") == 0)
 		_einittext = s->addr;
+	else if (strcmp(str, "_sextratext") == 0)
+		_sextratext = s->addr;
+	else if (strcmp(str, "_eextratext") == 0)
+		_eextratext = s->addr;
 	else if (toupper(s->type) == 'A')
 	{
 		/* Keep these useful absolute symbols */
@@ -182,16 +186,18 @@ symbol_valid(struct sym_entry *s)
 	 * and inittext sections are discarded */
 	if (!all_symbols) {
 		if ((s->addr < _stext || s->addr > _etext)
-		    && (s->addr < _sinittext || s->addr > _einittext))
+		    && (s->addr < _sinittext || s->addr > _einittext) 
+		    && (s->addr < _sextratext || s->addr > _eextratext))
 			return 0;
 		/* Corner case.  Discard any symbols with the same value as
-		 * _etext or _einittext, they can move between pass 1 and 2
-		 * when the kallsyms data is added.  If these symbols move then
-		 * they may get dropped in pass 2, which breaks the kallsyms
-		 * rules.
+		 * _etext _einittext or _eextratext; they can move between pass 
+		 * 1 and 2 when the kallsyms data is added.  If these symbols 
+		 * move then they may get dropped in pass 2, which breaks the
+		 * kallsyms rules.
 		 */
 		if ((s->addr == _etext && strcmp(s->sym + 1, "_etext")) ||
-		    (s->addr == _einittext && strcmp(s->sym + 1, "_einittext")))
+		    (s->addr == _einittext && strcmp(s->sym + 1, "_einittext")) ||
+		    (s->addr == _eextratext && strcmp(s->sym + 1, "_eextratext")))
 			return 0;
 	}
 
--- linux-2.6.11/kernel/kallsyms.c~	2005-05-01 10:37:45.000000000 +0100
+++ linux-2.6.11/kernel/kallsyms.c	2005-05-02 08:42:59.000000000 +0100
@@ -46,6 +46,14 @@ static inline int is_kernel_inittext(uns
 	return 0;
 }
 
+static inline int is_kernel_extratext(unsigned long addr)
+{
+	if (addr >= (unsigned long)_sextratext
+	    && addr <= (unsigned long)_eextratext)
+		return 1;
+	return 0;
+}
+
 static inline int is_kernel_text(unsigned long addr)
 {
 	if (addr >= (unsigned long)_stext && addr <= (unsigned long)_etext)
@@ -169,7 +177,7 @@ const char *kallsyms_lookup(unsigned lon
 	namebuf[0] = 0;
 
 	if ((all_var && is_kernel(addr)) ||
-	    (!all_var && (is_kernel_text(addr) || is_kernel_inittext(addr)))) {
+	    (!all_var && (is_kernel_text(addr) || is_kernel_inittext(addr) || is_kernel_extratext(addr)))) {
 		unsigned long symbol_end=0;
 
 		/* do a binary search on the sorted kallsyms_addresses array */


-- 
dwmw2
