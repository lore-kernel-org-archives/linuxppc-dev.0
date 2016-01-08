Return-Path: <computersforpeace@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 545831A01E3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jan 2016 05:30:23 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id 65so1005775pff.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Jan 2016 10:30:23 -0800 (PST)
From: Brian Norris <computersforpeace@gmail.com>
To: Ian Munsie <imunsie@au1.ibm.com>,
	Michael Neuling <mikey@neuling.org>
Cc: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 Brian Norris <computersforpeace@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Joe Perches <joe@perches.com>, Michal Marek <mmarek@suse.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Anton Blanchard <anton@au1.ibm.com>
Subject: [PATCH v2 1/2] cxl: fix build for GCC 4.6.x
Date: Fri,  8 Jan 2016 10:30:09 -0800
Message-Id: <1452277810-98195-1-git-send-email-computersforpeace@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

GCC 4.6.3 does not support -Wno-unused-const-variable. Instead, use the
kbuild infrastructure that checks if this options exists.

Fixes: 2cd55c68c0a4 ("cxl: Fix build failure due to -Wunused-variable behaviour change")
Suggested-by: Michal Marek <mmarek@suse.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
v2: don't remove -Werror

 drivers/misc/cxl/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/Makefile b/drivers/misc/cxl/Makefile
index 6982f603fadc..ab6f392d3504 100644
--- a/drivers/misc/cxl/Makefile
+++ b/drivers/misc/cxl/Makefile
@@ -1,4 +1,4 @@
-ccflags-y := -Werror -Wno-unused-const-variable
+ccflags-y := -Werror $(call cc-disable-warning, unused-const-variable)
 
 cxl-y				+= main.o file.o irq.o fault.o native.o
 cxl-y				+= context.o sysfs.o debugfs.o pci.o trace.o
-- 
2.6.0.rc2.230.g3dd15c0
