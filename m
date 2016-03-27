Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qYCDQ1pDDzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 10:00:06 +1100 (AEDT)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>, Arnd Bergmann
 <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul
 Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/3] powerpc: make cell/spu_base.c explicitly non-modular
Date: Sun, 27 Mar 2016 18:08:15 -0400
Message-ID: <1459116497-19991-2-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1459116497-19991-1-git-send-email-paul.gortmaker@windriver.com>
References: <1459116497-19991-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Kconfig currently controlling compilation of this code is:

arch/powerpc/platforms/cell/Kconfig:config SPU_BASE
arch/powerpc/platforms/cell/Kconfig:    bool

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/platforms/cell/spu_base.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
index f7af74f83693..3ede04ffdeea 100644
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -24,7 +24,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/list.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
@@ -805,7 +805,4 @@ static int __init init_spu_base(void)
  out:
 	return ret;
 }
-module_init(init_spu_base);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Arnd Bergmann <arndb@de.ibm.com>");
+device_initcall(init_spu_base);
-- 
2.6.1
