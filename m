Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3D12B2C0304
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2013 14:09:45 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>, <galak@kernel.crashing.org>
Subject: [v3][PATCH 5/6] kgdb/kgdbts: support ppc64
Date: Wed, 27 Feb 2013 11:09:27 +0800
Message-ID: <1361934568-31989-6-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1361934568-31989-1-git-send-email-tiejun.chen@windriver.com>
References: <1361934568-31989-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 jason.wessel@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can't look up the address of the entry point of the function simply
via that function symbol for all architectures.

For PPC64 ABI, actually there is a function descriptors structure.

A function descriptor is a three doubleword data structure that contains
the following values:
	* The first doubleword contains the address of the entry point of
		the function.
	* The second doubleword contains the TOC base address for
		the function.
	* The third doubleword contains the environment pointer for
		languages such as Pascal and PL/1.

So we should call a wapperred dereference_function_descriptor() to get
the address of the entry point of the function.

Note this is also safe for other architecture after refer to
"include/asm-generic/sections.h" since:

dereference_function_descriptor(p) always is (p) if without arched definition.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 drivers/misc/kgdbts.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
index 3aa9a96..4799e1f 100644
--- a/drivers/misc/kgdbts.c
+++ b/drivers/misc/kgdbts.c
@@ -103,6 +103,7 @@
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/module.h>
+#include <asm/sections.h>
 
 #define v1printk(a...) do { \
 	if (verbose) \
@@ -222,6 +223,7 @@ static unsigned long lookup_addr(char *arg)
 		addr = (unsigned long)do_fork;
 	else if (!strcmp(arg, "hw_break_val"))
 		addr = (unsigned long)&hw_break_val;
+	addr = (unsigned long )dereference_function_descriptor((void *)addr);
 	return addr;
 }
 
-- 
1.7.9.5
