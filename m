Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42B0dR22rdzF3Sb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 23:59:38 +1000 (AEST)
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 124/197] powerpc/platforms/85xx: fix t1042rdb_diu.c build
 errors & warning
Date: Thu, 13 Sep 2018 15:31:13 +0200
Message-Id: <20180913131846.505123144@linuxfoundation.org>
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit f5daf77a55ef0e695cc90c440ed6503073ac5e07 ]

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
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/85xx/t1042rdb_diu.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/powerpc/platforms/85xx/t1042rdb_diu.c
+++ b/arch/powerpc/platforms/85xx/t1042rdb_diu.c
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
