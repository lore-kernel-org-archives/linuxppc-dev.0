Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-red-R.bigfish.com (outbound-red.frontbridge.com
	[216.148.222.49])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 152C0679E7
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Aug 2006 06:49:10 +1000 (EST)
Message-ID: <44D655BF.3080803@am.sony.com>
Date: Sun, 06 Aug 2006 13:49:03 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: fix udbg warning
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix an implicit declaration warning in hash_utils_64.c
when udbg is enabled.

hash_utils_64.c: In function =91htab_bolt_mapping=92:
hash_utils_64.c:169: warning: implicit declaration of function =91udbg_pr=
intf=92


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---

Index: a/arch/powerpc/mm/hash_utils_64.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a.orig/arch/powerpc/mm/hash_utils_64.c
+++ a/arch/powerpc/mm/hash_utils_64.c
@@ -51,6 +51,7 @@
 #include <asm/cputable.h>
 #include <asm/abs_addr.h>
 #include <asm/sections.h>
+#include <asm/udbg.h>

 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
