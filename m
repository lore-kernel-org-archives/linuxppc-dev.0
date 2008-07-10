Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1F52ADE1DE
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 07:24:58 +1000 (EST)
Date: Thu, 10 Jul 2008 16:23:38 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <for-27-patch1-0@bga.com>
Message-Id: <for-27-patch7@bga.com>
Subject: powerpc: add static and ifdef prom_strtoul and prom_memparse
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
Should we just remove them instead?

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 1ea8c8d..bf1f922 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -489,6 +489,7 @@ static int __init prom_setprop(phandle node, const char *nodename,
 	return call_prom("interpret", 1, 1, (u32)(unsigned long) cmd);
 }
 
+#if 0
 /* We can't use the standard versions because of RELOC headaches. */
 #define isxdigit(c)	(('0' <= (c) && (c) <= '9') \
 			 || ('a' <= (c) && (c) <= 'f') \
@@ -498,7 +499,7 @@ static int __init prom_setprop(phandle node, const char *nodename,
 #define islower(c)	('a' <= (c) && (c) <= 'z')
 #define toupper(c)	(islower(c) ? ((c) - 'a' + 'A') : (c))
 
-unsigned long prom_strtoul(const char *cp, const char **endp)
+static unsigned long prom_strtoul(const char *cp, const char **endp)
 {
 	unsigned long result = 0, base = 10, value;
 
@@ -523,7 +524,7 @@ unsigned long prom_strtoul(const char *cp, const char **endp)
 	return result;
 }
 
-unsigned long prom_memparse(const char *ptr, const char **retptr)
+static unsigned long prom_memparse(const char *ptr, const char **retptr)
 {
 	unsigned long ret = prom_strtoul(ptr, retptr);
 	int shift = 0;
@@ -549,6 +550,7 @@ unsigned long prom_memparse(const char *ptr, const char **retptr)
 
 	return ret;
 }
+#endif
 
 /*
  * Early parsing of the command line passed to the kernel, used for
