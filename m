Return-Path: <rdunlap@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41TDFZ4bsRzF35s
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2018 03:34:58 +1000 (AEST)
To: PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] powerpc/platforms/85xx: fix t1042rdb_diu.c build errors &
 warning
Message-ID: <25463c4f-4901-b86f-2002-6c65c9ee9fd2@infradead.org>
Date: Sun, 15 Jul 2018 10:34:46 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors and warnings in t1042rdb_diu.c by adding header files
and MODULE_LICENSE().

../arch/powerpc/platforms/85xx/t1042rdb_diu.c:152:1: warning: data definition has no type or storage class
 early_initcall(t1042rdb_diu_init);
../arch/powerpc/platforms/85xx/t1042rdb_diu.c:152:1: error: type defaults to 'int' in declaration of 'early_initcall' [-Werror=implicit-int]
../arch/powerpc/platforms/85xx/t1042rdb_diu.c:152:1: warning: parameter names (without types) in function declaration

and
WARNING: modpost: missing MODULE_LICENSE() in arch/powerpc/platforms/85xx/t1042rdb_diu.o

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Scott Wood <oss@buserror.net>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
Found when using Michael's patch for ppc64_book3e_allmodconfig.

 arch/powerpc/platforms/85xx/t1042rdb_diu.c |    4 ++++
 1 file changed, 4 insertions(+)

--- lnx-418-rc4.orig/arch/powerpc/platforms/85xx/t1042rdb_diu.c
+++ lnx-418-rc4/arch/powerpc/platforms/85xx/t1042rdb_diu.c
@@ -9,8 +9,10 @@
  * option) any later version.
  */
 
+#include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 
@@ -150,3 +152,5 @@ static int __init t1042rdb_diu_init(void
 }
 
 early_initcall(t1042rdb_diu_init);
+
+MODULE_LICENSE("GPL");
