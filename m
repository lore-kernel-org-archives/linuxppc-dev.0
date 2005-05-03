Return-Path: <SRS0+3a3b73cd5a4912475f9e+618+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 06E58679F3
	for <linuxppc-dev@ozlabs.org>; Tue,  3 May 2005 18:00:10 +1000 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050502183733.52db7703.akpm@osdl.org>
References: <1115020651.3287.0.camel@localhost.localdomain>
	<20050502183733.52db7703.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 03 May 2005 08:59:45 +0100
Message-Id: <1115107188.8508.20.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc32: platform-specific functions missing from
	kallsyms.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-05-02 at 18:37 -0700, Andrew Morton wrote:
> 2.6.11?  Wow.

Actually 2.6.11-1.1283_FC4; the Fedora kernel. It's at least 2.6.12-rc3,
and Dave had been tracking Linus' tree fairly actively -- but I suspect
he may have fallen behind in the absence of nightly git snapshots. Must
fix that now we have tags.

Here it is updated to the current git tree and compile-tested.

Index: arch/ppc/kernel/vmlinux.lds.S
===================================================================
--- 226896c455d8a4996527c4a0ec5699956c657ec3/arch/ppc/kernel/vmlinux.lds.S  (mode:100644 sha1:0c0e714b84de74febf1f4dcb59eb1a859902deac)
+++ uncommitted/arch/ppc/kernel/vmlinux.lds.S  (mode:100644)
@@ -145,6 +145,7 @@
   __init_end = .;
 
   . = ALIGN(4096);
+  _sextratext = .;
   __pmac_begin = .;
   .pmac.text : { *(.pmac.text) }
   .pmac.data : { *(.pmac.data) }
@@ -171,6 +172,7 @@
   .openfirmware.data : { *(.openfirmware.data) }
   . = ALIGN(4096);
   __openfirmware_end = .;
+  _eextratext = .;
 
   __bss_start = .;
   .bss       :
Index: include/asm-generic/sections.h
===================================================================
--- 226896c455d8a4996527c4a0ec5699956c657ec3/include/asm-generic/sections.h  (mode:100644 sha1:976ac29598b78d0b2c0c90516480e93434d8f506)
+++ uncommitted/include/asm-generic/sections.h  (mode:100644)
@@ -8,6 +8,8 @@
 extern char __bss_start[], __bss_stop[];
 extern char __init_begin[], __init_end[];
 extern char _sinittext[], _einittext[];
+extern char _sextratext[] __attribute__((weak));
+extern char _eextratext[] __attribute__((weak));
 extern char _end[];
 
 #endif /* _ASM_GENERIC_SECTIONS_H_ */
Index: kernel/kallsyms.c
===================================================================
--- 226896c455d8a4996527c4a0ec5699956c657ec3/kernel/kallsyms.c  (mode:100644 sha1:1627f8d6e0cdd5f918c30666f4434407df25c293)
+++ uncommitted/kernel/kallsyms.c  (mode:100644)
@@ -46,6 +46,14 @@
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
@@ -169,7 +177,7 @@
 	namebuf[0] = 0;
 
 	if ((all_var && is_kernel(addr)) ||
-	    (!all_var && (is_kernel_text(addr) || is_kernel_inittext(addr)))) {
+	    (!all_var && (is_kernel_text(addr) || is_kernel_inittext(addr) || is_kernel_extratext(addr)))) {
 		unsigned long symbol_end=0;
 
 		/* do a binary search on the sorted kallsyms_addresses array */
Index: scripts/kallsyms.c
===================================================================
--- 226896c455d8a4996527c4a0ec5699956c657ec3/scripts/kallsyms.c  (mode:100644 sha1:fe11df83d1fc91b3e6de8a7bdc4a06e25f3d0e2f)
+++ uncommitted/scripts/kallsyms.c  (mode:100644)
@@ -67,7 +67,7 @@
 
 static struct sym_entry *table;
 static int size, cnt;
-static unsigned long long _stext, _etext, _sinittext, _einittext;
+static unsigned long long _stext, _etext, _sinittext, _einittext, _sextratext, _eextratext;
 static int all_symbols = 0;
 static char symbol_prefix_char = '\0';
 
@@ -139,6 +139,10 @@
 		_sinittext = s->addr;
 	else if (strcmp(sym, "_einittext") == 0)
 		_einittext = s->addr;
+	else if (strcmp(sym, "_sextratext") == 0)
+		_sextratext = s->addr;
+	else if (strcmp(sym, "_eextratext") == 0)
+		_eextratext = s->addr;
 	else if (toupper(s->type) == 'A')
 	{
 		/* Keep these useful absolute symbols */
@@ -194,16 +198,18 @@
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
+		 * 1 and 2 when the kallsyms data are added.  If these symbols
+		 * move then they may get dropped in pass 2, which breaks the
+		 * kallsyms rules.
 		 */
 		if ((s->addr == _etext && strcmp(s->sym + offset, "_etext")) ||
-		    (s->addr == _einittext && strcmp(s->sym + offset, "_einittext")))
+		    (s->addr == _einittext && strcmp(s->sym + offset, "_einittext")) ||
+		    (s->addr == _eextratext && strcmp(s->sym + offset, "_eextratext")))
 			return 0;
 	}
 


-- 
dwmw2
