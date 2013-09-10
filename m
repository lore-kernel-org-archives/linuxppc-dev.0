Return-Path: <murzin.v@gmail.com>
Received: from mail-lb0-x230.google.com (mail-lb0-x230.google.com
 [IPv6:2a00:1450:4010:c04::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2947F2C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 02:42:51 +1000 (EST)
Received: by mail-lb0-f176.google.com with SMTP id y6so6489005lbh.35
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Sep 2013 09:42:47 -0700 (PDT)
From: Vladimir Murzin <murzin.v@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc: fix section mismatch warning for prom_rtas_call
Date: Tue, 10 Sep 2013 18:42:07 +0200
Message-Id: <1378831327-2263-1-git-send-email-murzin.v@gmail.com>
Cc: Vladimir Murzin <murzin.v@gmail.com>, paulus@samba.org, anton@samba.org,
 nfont@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While cross-building for PPC64 I've got

WARNING: vmlinux.o(.text.unlikely+0x1ba): Section mismatch in
reference from the function .prom_rtas_call() to the variable
.init.data:dt_string_start The function .prom_rtas_call() references
the variable __initdata dt_string_start.  This is often because
.prom_rtas_call lacks a __initdata annotation or the annotation of
dt_string_start is wrong.

WARNING: vmlinux.o(.meminit.text+0xeb0): Section mismatch in reference
from the function .free_area_init_core.isra.47() to the function
.init.text:.set_pageblock_order() The function __meminit
.free_area_init_core.isra.47() references a function __init
.set_pageblock_order().  If .set_pageblock_order is only used by
.free_area_init_core.isra.47 then annotate .set_pageblock_order with a
matching annotation.

Fix it by proper annotation of prom_rtas_call.

Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
---
 arch/powerpc/kernel/prom_init.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 7b6391b..12e656f 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1297,7 +1297,8 @@ static void __init prom_query_opal(void)
 		prom_opal_align = 0x10000;
 }
 
-static int prom_rtas_call(int token, int nargs, int nret, int *outputs, ...)
+static int __init prom_rtas_call(int token, int nargs, int nret,
+				 int *outputs, ...)
 {
 	struct rtas_args rtas_args;
 	va_list list;
-- 
1.7.10.4
