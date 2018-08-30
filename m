Return-Path: <Alexander.Levin@microsoft.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0119.outbound.protection.outlook.com [104.47.34.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421Vpp31NZzF36f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 04:08:15 +1000 (AEST)
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Randy Dunlap <rdunlap@infradead.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>, Kumar Gala
 <galak@kernel.crashing.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 095/113] powerpc/platforms/85xx: fix
 t1042rdb_diu.c build errors & warning
Date: Thu, 30 Aug 2018 18:08:10 +0000
Message-ID: <20180830180714.36167-29-alexander.levin@microsoft.com>
References: <20180830180714.36167-1-alexander.levin@microsoft.com>
In-Reply-To: <20180830180714.36167-1-alexander.levin@microsoft.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit f5daf77a55ef0e695cc90c440ed6503073ac5e07 ]

Fix build errors and warnings in t1042rdb_diu.c by adding header files
and MODULE_LICENSE().

../arch/powerpc/platforms/85xx/t1042rdb_diu.c:152:1: warning: data definiti=
on has no type or storage class
 early_initcall(t1042rdb_diu_init);
../arch/powerpc/platforms/85xx/t1042rdb_diu.c:152:1: error: type defaults t=
o 'int' in declaration of 'early_initcall' [-Werror=3Dimplicit-int]
../arch/powerpc/platforms/85xx/t1042rdb_diu.c:152:1: warning: parameter nam=
es (without types) in function declaration

and
WARNING: modpost: missing MODULE_LICENSE() in arch/powerpc/platforms/85xx/t=
1042rdb_diu.o

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Scott Wood <oss@buserror.net>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/platforms/85xx/t1042rdb_diu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/t1042rdb_diu.c b/arch/powerpc/plat=
forms/85xx/t1042rdb_diu.c
index 58fa3d319f1c..dac36ba82fea 100644
--- a/arch/powerpc/platforms/85xx/t1042rdb_diu.c
+++ b/arch/powerpc/platforms/85xx/t1042rdb_diu.c
@@ -9,8 +9,10 @@
  * option) any later version.
  */
=20
+#include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
=20
@@ -150,3 +152,5 @@ static int __init t1042rdb_diu_init(void)
 }
=20
 early_initcall(t1042rdb_diu_init);
+
+MODULE_LICENSE("GPL");
--=20
2.17.1
