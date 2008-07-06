Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AF80DDDE03
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jul 2008 15:37:33 +1000 (EST)
Date: Sat, 5 Jul 2008 22:37:13 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: the printk problem
In-Reply-To: <20080706052741.GA18928@elte.hu>
Message-ID: <alpine.LFD.1.10.0807052232530.3016@woody.linux-foundation.org>
References: <20080625131101.GA6205@digi.com> <20080704104634.GA31634@digi.com>
	<20080704111540.ddffd241.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0807041147450.2815@woody.linux-foundation.org>
	<alpine.LFD.1.10.0807041250220.2815@woody.linux-foundation.org>
	<1215212420.8970.8.camel@pasglop>
	<alpine.LFD.1.10.0807041622270.2815@woody.linux-foundation.org>
	<alpine.LFD.1.10.0807051523180.2847@woody.linux-foundation.org>
	<20080706052741.GA18928@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-ia64@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Peter Anvin <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>, parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Sun, 6 Jul 2008, Ingo Molnar wrote:
> 
> applied (with the commit message below) to tip/x86/debug for v2.6.27 
> merging, thanks Linus. Can i add your SOB too?

Sure, add my S-O-B. But I hope/assuem that you also added my earlier patch 
that added the support for '%pS' too? I'm not entirely sure that should go 
in an x86-specific branch, since it has nothing x86-specific in it.

Also, I've cleaned up the lib/vsnprintf.c patch to fix up some minor 
details. For example, it should not default to a field width of 
"2*sizeof(unsigned long)" - it should do that only if it ends up printing 
the pointer as a hex number.

So this is my current version.. (the "precision" thing was moved into the 
'pointer()' function, and to after the special case handling).

		Linus
---
 lib/vsprintf.c |  118 ++++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 85 insertions(+), 33 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 6021757..f60c7c0 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -22,6 +22,8 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/kernel.h>
+#include <linux/kallsyms.h>
+#include <linux/uaccess.h>
 
 #include <asm/page.h>		/* for PAGE_SIZE */
 #include <asm/div64.h>
@@ -482,6 +484,82 @@ static char *number(char *buf, char *end, unsigned long long num, int base, int
 	return buf;
 }
 
+static char *string(char *buf, char *end, char *s, int field_width, int precision, int flags)
+{
+	int len, i;
+
+	if ((unsigned long)s < PAGE_SIZE)
+		s = "<NULL>";
+
+	len = strnlen(s, precision);
+
+	if (!(flags & LEFT)) {
+		while (len < field_width--) {
+			if (buf < end)
+				*buf = ' ';
+			++buf;
+		}
+	}
+	for (i = 0; i < len; ++i) {
+		if (buf < end)
+			*buf = *s;
+		++buf; ++s;
+	}
+	while (len < field_width--) {
+		if (buf < end)
+			*buf = ' ';
+		++buf;
+	}
+	return buf;
+}
+
+static inline void *dereference_function_descriptor(void *ptr)
+{
+#if defined(CONFIG_IA64) || defined(CONFIG_PPC64)
+	void *p;
+	if (!probe_kernel_address(ptr, p))
+		ptr = p;
+#endif
+	return ptr;
+}
+
+
+/*
+ * Show a '%p' thing.  A kernel extension is that the '%p' is followed
+ * by an extra set of alphanumeric characters that are extended format
+ * specifiers.  Right now we just handle 'F' (for symbolic Function
+ * pointers) and 'S' (for Symbolic data pointers), but this can easily
+ * be extended in the future (network address types etc).
+ *
+ * The difference between 'S' and 'F' is that on ia64 and ppc64 function
+ * pointers are really function descriptors, which contain a pointer the
+ * real address. 
+ */
+static char *pointer(const char *fmt, char *buf, char *end, void *ptr, int base, int size, int precision, int type)
+{
+	switch (*fmt) {
+	case 'F':
+		ptr = dereference_function_descriptor(ptr);
+		/* Fallthrough */
+	case 'S': {	/* Other (direct) pointer */
+#if CONFIG_KALLSYMS
+		char sym[KSYM_SYMBOL_LEN];
+		sprint_symbol(sym, (unsigned long) ptr);
+		return string(buf, end, sym, size, precision, type);
+#else
+		type |= SPECIAL;
+		break;
+#endif
+	}
+	}
+	type |= SMALL;
+	if (precision == -1) {
+		precision = 2*sizeof(void *);
+		type |= ZEROPAD;
+	}
+	return number(buf, end, (unsigned long long) ptr, base, size, precision, type);
+}
+
 /**
  * vsnprintf - Format a string and place it in a buffer
  * @buf: The buffer to place the result into
@@ -502,11 +580,9 @@ static char *number(char *buf, char *end, unsigned long long num, int base, int
  */
 int vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
 {
-	int len;
 	unsigned long long num;
-	int i, base;
+	int base;
 	char *str, *end, c;
-	const char *s;
 
 	int flags;		/* flags to number() */
 
@@ -622,40 +698,16 @@ int vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
 				continue;
 
 			case 's':
-				s = va_arg(args, char *);
-				if ((unsigned long)s < PAGE_SIZE)
-					s = "<NULL>";
-
-				len = strnlen(s, precision);
-
-				if (!(flags & LEFT)) {
-					while (len < field_width--) {
-						if (str < end)
-							*str = ' ';
-						++str;
-					}
-				}
-				for (i = 0; i < len; ++i) {
-					if (str < end)
-						*str = *s;
-					++str; ++s;
-				}
-				while (len < field_width--) {
-					if (str < end)
-						*str = ' ';
-					++str;
-				}
+				str = string(str, end, va_arg(args, char *), field_width, precision, flags);
 				continue;
 
 			case 'p':
-				flags |= SMALL;
-				if (field_width == -1) {
-					field_width = 2*sizeof(void *);
-					flags |= ZEROPAD;
-				}
-				str = number(str, end,
-						(unsigned long) va_arg(args, void *),
+				str = pointer(fmt+1, str, end,
+						va_arg(args, void *),
 						16, field_width, precision, flags);
+				/* Skip all alphanumeric pointer suffixes */
+				while (isalnum(fmt[1]))
+					fmt++;
 				continue;
 
 
