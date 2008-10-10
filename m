Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A0AF8DE0AE
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 22:56:39 +1100 (EST)
Date: Fri, 10 Oct 2008 06:56:33 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org, Ben Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Message-id: <patch-xics-6@bga.com>
In-Reply-To: <patch-xics-0@bga.com>
Subject: [PATCH 6/16] xics: trim includes
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Trim unneeded includes from xics.c.  We don't use signals or gfp
flags, we use only OF functions and don't need prom, and the 8259
is now handled by our caller.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
asm/smp.h gives us cpu mask accessors for !CONFIG_SMP, used in the next patch

Index: work.git/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- work.git.orig/arch/powerpc/platforms/pseries/xics.c	2008-08-07 03:41:08.000000000 -0500
+++ work.git/arch/powerpc/platforms/pseries/xics.c	2008-08-07 03:43:12.000000000 -0500
@@ -15,21 +15,18 @@
 #include <linux/irq.h>
 #include <linux/smp.h>
 #include <linux/interrupt.h>
-#include <linux/signal.h>
 #include <linux/init.h>
-#include <linux/gfp.h>
 #include <linux/radix-tree.h>
 #include <linux/cpu.h>
+#include <linux/of.h>
 
 #include <asm/firmware.h>
-#include <asm/prom.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/smp.h>
 #include <asm/rtas.h>
 #include <asm/hvcall.h>
 #include <asm/machdep.h>
-#include <asm/i8259.h>
 
 #include "xics.h"
 #include "plpar_wrappers.h"
