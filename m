Return-Path: <vegard.nossum@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 0C89EDDF85
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 22:52:38 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so799697ugf.0
	for <linuxppc-dev@ozlabs.org>; Sat, 05 Jul 2008 05:52:36 -0700 (PDT)
Date: Sat, 5 Jul 2008 14:52:31 +0200
To: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: the printk problem
Message-ID: <20080705125230.GA20166@damson.getinternet.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.1.10.0807051332200.28765@fbirervta.pbzchgretzou.qr>
From: Vegard Nossum <vegard.nossum@gmail.com>
Cc: linux-ia64@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Peter Anvin <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jul 5, 2008 at 1:33 PM, Jan Engelhardt <jengelh@medozas.de> wrote:
>
> On Saturday 2008-07-05 00:01, Andrew Morton wrote:
>>
>>We don't know how much interest there would be in churning NIPQUAD from
>>the net guys.  Interestingly, there's also %C (wint_t) which is a
>>32-bit quantity.  So we could just go and say "%C prints an ipv4
>>address" and be done with it.  But there's no way of doing that for
>>ipv6 addresses so things would become asymmetrical there.
>
>        struct in6_addr src;
>        printk("Source address: %p{ipv6}\n", &src);
>
> How about %p{feature}?

Something like this?

(It's hard on the stack, yes, I know. We should fix kallsyms.)

Vegard


From: Vegard Nossum <vegard.nossum@gmail.com>
Date: Sat, 5 Jul 2008 14:01:00 +0200
Subject: [PATCH] printf: add %p{} extension

Signed-off-by: Vegard Nossum <vegard.nossum@gmail.com>
---
 lib/vsprintf.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 6021757..011cf3f 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -17,6 +17,7 @@
  */
 
 #include <stdarg.h>
+#include <linux/kallsyms.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/string.h>
@@ -366,6 +367,30 @@ static noinline char* put_dec(char *buf, unsigned long long num)
 #define SMALL	32		/* Must be 32 == 0x20 */
 #define SPECIAL	64		/* 0x */
 
+static char *custom_format(char *buf, char *end,
+	const char *fmt, unsigned int fmtlen, void *arg)
+{
+	if (!strncmp(fmt, "sym", fmtlen)) {
+		char name[KSYM_SYMBOL_LEN];
+		int len;
+		int i;
+
+		len = sprint_symbol(name, (unsigned long) arg);
+		if (len < 0)
+			return buf;
+
+		i = 0;
+		while (i < len) {
+			if (buf < end)
+				*buf = name[i];
+			++buf;
+			++i;
+		}
+	}
+
+	return buf;
+}
+
 static char *number(char *buf, char *end, unsigned long long num, int base, int size, int precision, int type)
 {
 	/* we are called with base 8, 10 or 16, only, thus don't need "G..."  */
@@ -648,6 +673,25 @@ int vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
 				continue;
 
 			case 'p':
+				if (fmt[1] == '{') {
+					const char *cfmt;
+
+					/* Skip the '%{' */
+					++fmt;
+					++fmt;
+
+					cfmt = fmt;
+
+					/* Skip everything up to the '}' */
+					while (*fmt && *fmt != '}')
+						++fmt;
+
+					str = custom_format(str, end,
+						cfmt, fmt - cfmt,
+						va_arg(args, void *));
+					continue;
+				}
+
 				flags |= SMALL;
 				if (field_width == -1) {
 					field_width = 2*sizeof(void *);
-- 
1.5.4.1
