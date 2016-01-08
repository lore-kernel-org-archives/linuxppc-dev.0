Return-Path: <computersforpeace@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 55BB21A031E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jan 2016 05:30:23 +1100 (AEDT)
Received: by mail-pa0-x241.google.com with SMTP id pv5so22849799pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Jan 2016 10:30:23 -0800 (PST)
From: Brian Norris <computersforpeace@gmail.com>
To: Ian Munsie <imunsie@au1.ibm.com>,
	Michael Neuling <mikey@neuling.org>
Cc: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 Brian Norris <computersforpeace@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Joe Perches <joe@perches.com>, Michal Marek <mmarek@suse.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Anton Blanchard <anton@au1.ibm.com>
Subject: [PATCH v2 2/2] cxl: use -Werror only with CONFIG_PPC_WERROR
Date: Fri,  8 Jan 2016 10:30:10 -0800
Message-Id: <1452277810-98195-2-git-send-email-computersforpeace@gmail.com>
In-Reply-To: <1452277810-98195-1-git-send-email-computersforpeace@gmail.com>
References: <1452277810-98195-1-git-send-email-computersforpeace@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some developers really like to have -Werror enabled for their code, as
it helps to ensure warning free code. Others don't want -Werror, as it
(for example) can cause problems when newer (or older) compilers have
different sets of warnings, or new warnings can appear just when turning
up the warning level (e.g., make W=1 or W=2). Thus, it seems prudent to
have the use of -Werror be configurable.

It so happens that cxl is only built on PowerPC, and PowerPC already
has a nice set of Kconfig options for this, under CONFIG_PPC_WERROR. So
let's use that, and the world is a happy place again! (Note that
PPC_WERROR defaults to =y, so the common case compile should still be
enforcing -Werror.)

Fixes: d3d73f4b38a8 ("cxl: Compile with -Werror")
Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
v2: new in v2

 drivers/misc/cxl/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/Makefile b/drivers/misc/cxl/Makefile
index ab6f392d3504..be2ac5ce349f 100644
--- a/drivers/misc/cxl/Makefile
+++ b/drivers/misc/cxl/Makefile
@@ -1,4 +1,5 @@
-ccflags-y := -Werror $(call cc-disable-warning, unused-const-variable)
+ccflags-y			:= $(call cc-disable-warning, unused-const-variable)
+ccflags-$(CONFIG_PPC_WERROR)	+= -Werror
 
 cxl-y				+= main.o file.o irq.o fault.o native.o
 cxl-y				+= context.o sysfs.o debugfs.o pci.o trace.o
-- 
2.6.0.rc2.230.g3dd15c0
