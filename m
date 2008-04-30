Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E2E24DDF41
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 08:27:43 +1000 (EST)
Message-ID: <4818F1C5.2010800@am.sony.com>
Date: Wed, 30 Apr 2008 15:25:09 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 2/5] PS3: Add time include to lpm
References: <20080430215644.655638516@am.sony.com>
In-Reply-To: <20080430215644.655638516@am.sony.com>
Content-Type: text/plain; charset="UTF-8"
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

Add an include <asm/time.h> statement for get_tb().

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
drivers/ps3/ps3-lpm.c:192: error: implicit declaration of function 'get_tb'

I could not recreate this error.  asm/time.h seems to be included
from linux/module.h:

In file included from include2/asm/cputime.h:27,
                 from /home/geoff/projects/cell/linux-2.6/include/linux/sched.h:67,
                 from include2/asm/elf.h:6,
                 from /home/geoff/projects/cell/linux-2.6/include/linux/elf.h:8,
                 from /home/geoff/projects/cell/linux-2.6/include/linux/module.h:15,
                 from /home/geoff/projects/cell/linux-2.6/drivers/ps3/ps3-lpm.c:24:
include2/asm/time.h:134

 drivers/ps3/ps3-lpm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/ps3/ps3-lpm.c
+++ b/drivers/ps3/ps3-lpm.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/uaccess.h>
+#include <asm/time.h>
 #include <asm/ps3.h>
 #include <asm/lv1call.h>
 #include <asm/cell-pmu.h>

-- 
