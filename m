Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4240F2C0384
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2013 18:20:34 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc/mpc5xxx: fix sparse warning for non static symbol
Date: Tue,  5 Feb 2013 08:20:18 +0100
Message-Id: <1360048818-3765-3-git-send-email-agust@denx.de>
In-Reply-To: <1360048818-3765-1-git-send-email-agust@denx.de>
References: <1360048818-3765-1-git-send-email-agust@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix warning:
symbol 'mpc5xxx_get_bus_frequency' was not declared. Should it be static?

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/sysdev/mpc5xxx_clocks.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/mpc5xxx_clocks.c b/arch/powerpc/sysdev/mpc5xxx_clocks.c
index 96f815a..5492dc5 100644
--- a/arch/powerpc/sysdev/mpc5xxx_clocks.c
+++ b/arch/powerpc/sysdev/mpc5xxx_clocks.c
@@ -9,9 +9,9 @@
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <linux/export.h>
+#include <asm/mpc5xxx.h>
 
-unsigned int
-mpc5xxx_get_bus_frequency(struct device_node *node)
+unsigned long mpc5xxx_get_bus_frequency(struct device_node *node)
 {
 	struct device_node *np;
 	const unsigned int *p_bus_freq = NULL;
-- 
1.7.5.4
