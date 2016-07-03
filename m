Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjQbD6TkJzDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 09:00:08 +1000 (AEST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>, Ian Munsie
 <imunsie@au1.ibm.com>, Michael Neuling <mikey@neuling.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] cxl: make base more explicitly non-modular
Date: Sun, 3 Jul 2016 16:31:53 -0400
Message-ID: <20160703203153.6155-1-paul.gortmaker@windriver.com>
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

The Kconfig/Makefile currently controlling compilation of this code is:

drivers/misc/cxl/Kconfig:config CXL_BASE
drivers/misc/cxl/Kconfig:       bool

drivers/misc/cxl/Makefile:obj-$(CONFIG_CXL_BASE)          += base.o

...meaning that it currently is not being built as a module by anyone.

Lets convert the one module_init into device_initcall so that
when reading the driver it more clear that it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We don't replace module.h with init.h since the file is doing
other modular stuff (module_get/put) even though it is built-in.

Cc: Ian Munsie <imunsie@au1.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/misc/cxl/base.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/base.c b/drivers/misc/cxl/base.c
index 9b90ec6c07cd..e6f49aca0035 100644
--- a/drivers/misc/cxl/base.c
+++ b/drivers/misc/cxl/base.c
@@ -114,5 +114,4 @@ static int __init cxl_base_init(void)
 	pr_devel("Found %d cxl device(s)\n", count);
 	return 0;
 }
-
-module_init(cxl_base_init);
+device_initcall(cxl_base_init);
-- 
2.8.4
