Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id F399E67E6F
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Oct 2006 04:35:20 +1000 (EST)
Message-ID: <45255064.3080602@am.sony.com>
Date: Thu, 05 Oct 2006 11:35:16 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: minor fix for bootargs property
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Avoid the use of an uninitialized stack variable when the powerpc device tree
bootargs property is either missing or incorrectly defined.  This also makes
CONFIG_CMDLINE work properly under these conditions.  This change adds a test
for the existence of the bootargs property.

early_init_dt_scan_chosen() tests for a zero length bootargs property in its
CONFIG_CMDLINE processing, but the current implementation of
of_get_flat_dt_prop() doesn't assign a value to the length when no property is
found.  Since an automatic variable is used, a stale value from the stack will
be used in the test.


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---

Index: cell--common--5/arch/powerpc/kernel/prom.c
===================================================================
--- cell--common--5.orig/arch/powerpc/kernel/prom.c
+++ cell--common--5/arch/powerpc/kernel/prom.c
@@ -724,7 +724,7 @@
 		strlcpy(cmd_line, p, min((int)l, COMMAND_LINE_SIZE));
 
 #ifdef CONFIG_CMDLINE
-	if (l == 0 || (l == 1 && (*p) == 0))
+	if (p == NULL || l == 0 || (l == 1 && (*p) == 0))
 		strlcpy(cmd_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
 #endif /* CONFIG_CMDLINE */
 
