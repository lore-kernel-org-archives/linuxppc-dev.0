Return-Path: <f.fainelli@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B9D1EB6F7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 22:20:27 +1000 (EST)
Received: by wwg9 with SMTP id 9so37782wwg.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 05:20:22 -0700 (PDT)
Sender: Florian Fainelli <f.fainelli@gmail.com>
From: Florian Fainelli <florian@openwrt.org>
To: Ian Munsie <imunsie@au.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] perf: fix build for PowerPC with uclibc toolchains
Date: Tue, 23 Aug 2011 14:20:08 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201108231420.08879.florian@openwrt.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

libio.h is not provided by uClibc, in order to be able to test the
definition of __UCLIBC__ we need to include stdlib.h, which also
includes stddef.h, providing the definition of 'NULL'.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
FYI, I submitted the exact same patch for ARM:
https://patchwork.kernel.org/patch/1049152/

diff --git a/tools/perf/arch/powerpc/util/dwarf-regs.c b/tools/perf/arch/powerpc/util/dwarf-regs.c
index 48ae0c5..7cdd61d 100644
--- a/tools/perf/arch/powerpc/util/dwarf-regs.c
+++ b/tools/perf/arch/powerpc/util/dwarf-regs.c
@@ -9,7 +9,10 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#include <stdlib.h>
+#ifndef __UCLIBC__
 #include <libio.h>
+#endif
 #include <dwarf-regs.h>
 
 
-- 
1.7.4.1
