Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4239CDDDE3
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 15:03:32 +1100 (EST)
Date: Mon, 20 Oct 2008 23:03:18 -0500 (CDT)
Message-Id: <200810210403.m9L43I6t054774@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
Subject: powerpc: delete prom_strtoul and prom_memparse
Sender: Milton Miller <miltonm@realtime.net>
To: Ben Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These functions should have been static, and inspection shows they
are no longer used.   (We used to parse mem= but we now defer that
to early_param).

Signed-off-by: Milton Miller <miltonm@bga.com>
---
This version removes them

Index: next.git/arch/powerpc/kernel/prom_init.c
===================================================================
--- next.git.orig/arch/powerpc/kernel/prom_init.c	2008-10-20 17:51:15.000000000 -0500
+++ next.git/arch/powerpc/kernel/prom_init.c	2008-10-20 22:40:16.000000000 -0500
@@ -487,67 +487,6 @@ static int __init prom_setprop(phandle n
 	return call_prom("interpret", 1, 1, (u32)(unsigned long) cmd);
 }
 
-/* We can't use the standard versions because of RELOC headaches. */
-#define isxdigit(c)	(('0' <= (c) && (c) <= '9') \
-			 || ('a' <= (c) && (c) <= 'f') \
-			 || ('A' <= (c) && (c) <= 'F'))
-
-#define isdigit(c)	('0' <= (c) && (c) <= '9')
-#define islower(c)	('a' <= (c) && (c) <= 'z')
-#define toupper(c)	(islower(c) ? ((c) - 'a' + 'A') : (c))
-
-unsigned long prom_strtoul(const char *cp, const char **endp)
-{
-	unsigned long result = 0, base = 10, value;
-
-	if (*cp == '0') {
-		base = 8;
-		cp++;
-		if (toupper(*cp) == 'X') {
-			cp++;
-			base = 16;
-		}
-	}
-
-	while (isxdigit(*cp) &&
-	       (value = isdigit(*cp) ? *cp - '0' : toupper(*cp) - 'A' + 10) < base) {
-		result = result * base + value;
-		cp++;
-	}
-
-	if (endp)
-		*endp = cp;
-
-	return result;
-}
-
-unsigned long prom_memparse(const char *ptr, const char **retptr)
-{
-	unsigned long ret = prom_strtoul(ptr, retptr);
-	int shift = 0;
-
-	/*
-	 * We can't use a switch here because GCC *may* generate a
-	 * jump table which won't work, because we're not running at
-	 * the address we're linked at.
-	 */
-	if ('G' == **retptr || 'g' == **retptr)
-		shift = 30;
-
-	if ('M' == **retptr || 'm' == **retptr)
-		shift = 20;
-
-	if ('K' == **retptr || 'k' == **retptr)
-		shift = 10;
-
-	if (shift) {
-		ret <<= shift;
-		(*retptr)++;
-	}
-
-	return ret;
-}
-
 /*
  * Early parsing of the command line passed to the kernel, used for
  * "mem=x" and the options that affect the iommu
