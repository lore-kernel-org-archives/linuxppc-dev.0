Return-Path: <galak@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 00A6A680A4
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Aug 2005 05:15:39 +1000 (EST)
Date: Fri, 26 Aug 2005 14:15:34 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0508261415080.29975@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc32: add CONFIG_HZ
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

While ppc32 has the CONFIG_HZ Kconfig option, it wasnt actually being
used. Connect it up and set all platforms to 250Hz.  This pretty much
mimics the ppc64 patch from Anton Blanchard.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit a7d81273171d49ac130f303eb63903298b4aeefb
tree a36b7872c98068519b9d85aa16e5f3f0b1668183
parent d90fa018552f3c3515ec46beadc0f0ff64c54547
author Kumar K. Gala <kumar.gala@freescale.com> Fri, 26 Aug 2005 14:14:40 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Fri, 26 Aug 2005 14:14:40 -0500

 include/asm-ppc/param.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/include/asm-ppc/param.h b/include/asm-ppc/param.h
--- a/include/asm-ppc/param.h
+++ b/include/asm-ppc/param.h
@@ -1,8 +1,10 @@
 #ifndef _ASM_PPC_PARAM_H
 #define _ASM_PPC_PARAM_H
 
+#include <linux/config.h>
+
 #ifdef __KERNEL__
-#define HZ		1000		/* internal timer frequency */
+#define HZ		CONFIG_HZ	/* internal timer frequency */
 #define USER_HZ		100		/* for user interfaces in "ticks" */
 #define CLOCKS_PER_SEC	(USER_HZ)	/* frequency at which times() counts */
 #endif /* __KERNEL__ */
