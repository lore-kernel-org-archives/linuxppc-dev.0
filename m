Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 28A3D2C008F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2012 11:35:58 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/mpic_msgr: add missing includes
Date: Wed, 22 Aug 2012 20:35:47 -0500
Message-ID: <1345685747-22451-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Meador Inge <meador_inge@mentor.com>, linuxppc-dev@lists.ozlabs.org,
 Jia Hongtao <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add several #includes that mpic_msgr relies on being pulled implicitly,
which only happens on certain configs.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Meador Inge <meador_inge@mentor.com>
Cc: Jia Hongtao <B38951@freescale.com>
---
 arch/powerpc/include/asm/mpic_msgr.h |    1 +
 arch/powerpc/sysdev/mpic_msgr.c      |    3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/mpic_msgr.h b/arch/powerpc/include/asm/mpic_msgr.h
index 326d33c..d4f471f 100644
--- a/arch/powerpc/include/asm/mpic_msgr.h
+++ b/arch/powerpc/include/asm/mpic_msgr.h
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/spinlock.h>
 #include <asm/smp.h>
+#include <asm/io.h>
 
 struct mpic_msgr {
 	u32 __iomem *base;
diff --git a/arch/powerpc/sysdev/mpic_msgr.c b/arch/powerpc/sysdev/mpic_msgr.c
index 483d8fa..e961f8c 100644
--- a/arch/powerpc/sysdev/mpic_msgr.c
+++ b/arch/powerpc/sysdev/mpic_msgr.c
@@ -14,6 +14,9 @@
 #include <linux/list.h>
 #include <linux/of_platform.h>
 #include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/slab.h>
 #include <asm/prom.h>
 #include <asm/hw_irq.h>
 #include <asm/ppc-pci.h>
-- 
1.7.9.5
