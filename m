Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x241.google.com (mail-wr0-x241.google.com
 [IPv6:2a00:1450:400c:c0c::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wNpq4HVwzF14Y
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 05:20:19 +1000 (AEST)
Received: by mail-wr0-x241.google.com with SMTP id w3-v6so27129732wrl.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 12:20:19 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/prom: Fix %u/%llx usage since prom_printf() change
Date: Tue, 29 May 2018 21:20:01 +0200
Message-Id: <20180529192001.30200-1-malat@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit eae5f709a4d7 ("powerpc: Add __printf verification to
prom_printf") __printf attribute was added to prom_printf(), which
means GCC started warning about type/format mismatches. As part of that
commit we changed some "%lx" formats to "%llx" where the type is
actually unsigned long long.

Unfortunately prom_printf() doesn't know how to print "%llx", it just
prints a literal "lx", eg:

  reserved memory map:
    lx - lx
    lx - lx

prom_printf() also doesn't know how to print "%u" (only "%lu"), it just
print a literal "u", eg:

  Max number of cores passed to firmware: u (NR_CPUS = 2048)

instead of:

  Max number of cores passed to firmware: 2048 (NR_CPUS = 2048)

This commit adds support for the missing formatters.

Fixes: eae5f709a4d7 ("powerpc: Add __printf verification to prom_printf")
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
I've reviewed all formatters added in eae5f709a4d7 and only %u and %llx were
actually missing (eg. llu or lld are not used)

 arch/powerpc/kernel/prom_init.c | 72 +++++++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 4d62f561f272..2c04516fe274 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -301,6 +301,9 @@ static void __init prom_print(const char *msg)
 }
 
 
+/* both prom_print_hex & prom_print_dec takes an unsigned long as input so that
+ * we do not need __udivdi3 or __umoddi3 on 32bits
+ */
 static void __init prom_print_hex(unsigned long val)
 {
 	int i, nibbles = sizeof(val)*2;
@@ -341,6 +344,7 @@ static void __init prom_printf(const char *format, ...)
 	va_list args;
 	unsigned long v;
 	long vs;
+	int n = 0;
 
 	va_start(args, format);
 	for (p = format; *p != 0; p = q) {
@@ -359,6 +363,10 @@ static void __init prom_printf(const char *format, ...)
 		++q;
 		if (*q == 0)
 			break;
+		while (*q == 'l') {
+			++q;
+			++n;
+		}
 		switch (*q) {
 		case 's':
 			++q;
@@ -367,39 +375,55 @@ static void __init prom_printf(const char *format, ...)
 			break;
 		case 'x':
 			++q;
-			v = va_arg(args, unsigned long);
+			switch (n) {
+			case 0:
+				v = va_arg(args, unsigned int);
+				break;
+			case 1:
+				v = va_arg(args, unsigned long);
+				break;
+			case 2:
+			default:
+				v = va_arg(args, unsigned long long);
+				break;
+			}
 			prom_print_hex(v);
 			break;
-		case 'd':
+		case 'u':
 			++q;
-			vs = va_arg(args, int);
-			if (vs < 0) {
-				prom_print("-");
-				vs = -vs;
+			switch (n) {
+			case 0:
+				v = va_arg(args, unsigned int);
+				break;
+			case 1:
+				v = va_arg(args, unsigned long);
+				break;
+			case 2:
+			default:
+				v = va_arg(args, unsigned long long);
+				break;
 			}
-			prom_print_dec(vs);
+			prom_print_dec(v);
 			break;
-		case 'l':
+		case 'd':
 			++q;
-			if (*q == 0)
+			switch (n) {
+			case 0:
+				vs = va_arg(args, int);
 				break;
-			else if (*q == 'x') {
-				++q;
-				v = va_arg(args, unsigned long);
-				prom_print_hex(v);
-			} else if (*q == 'u') { /* '%lu' */
-				++q;
-				v = va_arg(args, unsigned long);
-				prom_print_dec(v);
-			} else if (*q == 'd') { /* %ld */
-				++q;
+			case 1:
 				vs = va_arg(args, long);
-				if (vs < 0) {
-					prom_print("-");
-					vs = -vs;
-				}
-				prom_print_dec(vs);
+				break;
+			case 2:
+			default:
+				vs = va_arg(args, long long);
+				break;
+			}
+			if (vs < 0) {
+				prom_print("-");
+				vs = -vs;
 			}
+			prom_print_dec(vs);
 			break;
 		}
 	}
-- 
2.11.0
