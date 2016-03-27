Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qYCK00hvzzDqD5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 10:04:03 +1100 (AEDT)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, Andrzej Hajda
 <a.hajda@samsung.com>,
 Anton Blanchard <anton@samba.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/3] powerpc: make kernel/nvram_64.c explicitly non-modular
Date: Sun, 27 Mar 2016 18:08:16 -0400
Message-ID: <1459116497-19991-3-git-send-email-paul.gortmaker@windriver.com>
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

The Makefile/Kconfig currently controlling compilation of this code is:

obj-$(CONFIG_PPC64)             += setup_64.o sys_ppc32.o \
                                   signal_64.o ptrace32.o \
                                   paca.o nvram_64.o firmware.o

arch/powerpc/platforms/Kconfig.cputype:config PPC64
arch/powerpc/platforms/Kconfig.cputype: bool "64-bit kernel"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We don't replace module.h with init.h since the file already has that.

We delete the MODULE_LICENSE tag since that information is already
contained at the top of the file in the comments.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/kernel/nvram_64.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 0cab9e8c3794..856f9a7944cd 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -15,8 +15,6 @@
  *       parsing code.
  */
 
-#include <linux/module.h>
-
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
@@ -1231,12 +1229,4 @@ static int __init nvram_init(void)
   	
   	return rc;
 }
-
-static void __exit nvram_cleanup(void)
-{
-        misc_deregister( &nvram_dev );
-}
-
-module_init(nvram_init);
-module_exit(nvram_cleanup);
-MODULE_LICENSE("GPL");
+device_initcall(nvram_init);
-- 
2.6.1
