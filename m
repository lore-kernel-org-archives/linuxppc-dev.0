Return-Path: <ntl@pobox.com>
Received: from gretel.pobox.com (gretel.pobox.com [208.58.1.197])
	by ozlabs.org (Postfix) with ESMTP id 55F57DDDFB
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 13:27:28 +1100 (EST)
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by gretel.pobox.com (Postfix) with ESMTP id 363B0564439A
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 21:02:00 -0500 (EST)
Date: Mon, 5 Feb 2007 20:01:15 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] maple: use mmio nvram
Message-ID: <20070206020115.GG6174@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some systems supported by the maple platform (e.g. JS2x blades running
SLOF) are able to use the mmio_nvram backend for reading and writing
nvram.  This is an improvement over the current situation -- no nvram
access from userspace at all.

Select MMIO_NVRAM for the maple platform.

Initialize the mmio_nvram backend from maple setup code.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---

Please apply this patch instead of the "rename pSeries nvram
functions" and "move pSeries nvram code to neutral location" patches
from January 24.

 arch/powerpc/Kconfig                 |    1 +
 arch/powerpc/platforms/maple/setup.c |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 0855d55..113685e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -484,6 +484,7 @@ config PPC_MAPLE
 	select PPC_970_NAP
 	select PPC_NATIVE
 	select PPC_RTAS
+	select MMIO_NVRAM
 	default n
 	help
           This option enables support for the Maple 970FX Evaluation Board.
diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index 50855d4..82d3f9e 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -62,6 +62,7 @@
 #include <asm/mpic.h>
 #include <asm/rtas.h>
 #include <asm/udbg.h>
+#include <asm/nvram.h>
 
 #include "maple.h"
 
@@ -195,6 +196,8 @@ void __init maple_setup_arch(void)
 	maple_use_rtas_reboot_and_halt_if_present();
 
 	printk(KERN_DEBUG "Using native/NAP idle loop\n");
+
+	mmio_nvram_init();
 }
 
 /* 
-- 
1.4.4.3
