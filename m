Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1A43C2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2012 15:52:18 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id q645qEHo017559
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jul 2012 00:52:15 -0500
Message-ID: <1341381132.16808.0.camel@pasglop>
Subject: [PATCH] tty/hvc_opal: Fix debug function name
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 04 Jul 2012 15:52:12 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

udbg_init_debug_opal() should be udbg_init_debug_opal_raw() as
the caller in arch/powerpc/kernel/udbg.c expects

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/tty/hvc/hvc_opal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index ced26c8..0d2ea0c 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -401,7 +401,7 @@ out:
 }
 
 #ifdef CONFIG_PPC_EARLY_DEBUG_OPAL_RAW
-void __init udbg_init_debug_opal(void)
+void __init udbg_init_debug_opal_raw(void)
 {
 	u32 index = CONFIG_PPC_EARLY_DEBUG_OPAL_VTERMNO;
 	hvc_opal_privs[index] = &hvc_opal_boot_priv;
