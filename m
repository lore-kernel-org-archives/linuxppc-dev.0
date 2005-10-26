Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 0B111685CF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Oct 2005 17:35:52 +1000 (EST)
Message-ID: <1130311000.435f2d58835a8@webmail.mnet-online.de>
Date: Wed, 26 Oct 2005 09:16:40 +0200
From: hs@denx.de
To: vbordug@ru.mvista.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: ppc_sys fixes for 8xx and 82xx (whitespaces
	fixed)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

i tried your Patch on a MPC8270 based Board, and got some
compilerwarnings, which the following Patch will fix.

Thanks
Heiko Schocher

---

 arch/ppc/syslib/m8260_setup.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/syslib/m8260_setup.c b/arch/ppc/syslib/m8260_setup.c
--- a/arch/ppc/syslib/m8260_setup.c
+++ b/arch/ppc/syslib/m8260_setup.c
@@ -28,6 +28,7 @@
 #include <asm/machdep.h>
 #include <asm/bootinfo.h>
 #include <asm/time.h>
+#include <asm/ppc_sys.h>

 #include "cpm2_pic.h"

@@ -74,7 +75,7 @@ m8260_setup_arch(void)
 #endif

        identify_ppc_sys_by_name_and_id(BOARD_CHIP_NAME,
-                               in_be32(CPM_MAP_ADDR + CPM_IMMR_OFFSET));
+                       in_be32((void *)(CPM_MAP_ADDR + CPM_IMMR_OFFSET)));

        m82xx_board_setup();
 }
