Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5ACD2B6FFD
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2011 16:14:22 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id p3568a1H004464
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:08:36 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p356EL6U1798252
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:21 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p356ELke011133
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:21 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 15/15] powerpc: Improve prom_printf()
Date: Tue,  5 Apr 2011 16:14:11 +1000
Message-Id: <1301984051-18413-16-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
References: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds the ability to print decimal numbers and adds some more
format string variants

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/prom_init.c |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 941ff4d..29c67e9 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -335,6 +335,7 @@ static void __init prom_printf(const char *format, ...)
 	const char *p, *q, *s;
 	va_list args;
 	unsigned long v;
+	long vs;
 	struct prom_t *_prom = &RELOC(prom);
 
 	va_start(args, format);
@@ -368,12 +369,35 @@ static void __init prom_printf(const char *format, ...)
 			v = va_arg(args, unsigned long);
 			prom_print_hex(v);
 			break;
+		case 'd':
+			++q;
+			vs = va_arg(args, long);
+			if (vs < 0) {
+				prom_print("-");
+				vs = -vs;
+			}
+			prom_print_dec(vs);
+			break;
 		case 'l':
 			++q;
-			if (*q == 'u') { /* '%lu' */
+			if (*q == 0)
+				break;
+			else if (*q == 'x') {
+				++q;
+				v = va_arg(args, unsigned long);
+				prom_print_hex(v);
+			} else if (*q == 'u') { /* '%lu' */
 				++q;
 				v = va_arg(args, unsigned long);
 				prom_print_dec(v);
+			} else if (*q == 'd') { /* %ld */
+				++q;
+				vs = va_arg(args, long);
+				if (vs < 0) {
+					prom_print(RELOC("-"));
+					vs = -vs;
+				}
+				prom_print_dec(vs);
 			}
 			break;
 		}
-- 
1.7.1
