Return-Path: <B21284@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe004.messaging.microsoft.com [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2629EB6FE3
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2012 12:20:01 +1000 (EST)
From: Mingkai Hu <Mingkai.hu@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/4] powerpc/mpic_msgr: fix compile error when SMP disabled
Date: Mon, 16 Apr 2012 10:05:05 +0800
Message-ID: <1334541908-19331-1-git-send-email-Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mingkai Hu <Mingkai.hu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In file included from arch/powerpc/sysdev/mpic_msgr.c:20:0:
~/arch/powerpc/include/asm/mpic_msgr.h: In function 'mpic_msgr_set_destination':
~/arch/powerpc/include/asm/mpic_msgr.h:117:2:
error: implicit declaration of function 'get_hard_smp_processor_id'
make[1]: *** [arch/powerpc/sysdev/mpic_msgr.o] Error 1

Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
---
 arch/powerpc/include/asm/mpic_msgr.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/mpic_msgr.h b/arch/powerpc/include/asm/mpic_msgr.h
index 3ec37dc..326d33c 100644
--- a/arch/powerpc/include/asm/mpic_msgr.h
+++ b/arch/powerpc/include/asm/mpic_msgr.h
@@ -13,6 +13,7 @@
 
 #include <linux/types.h>
 #include <linux/spinlock.h>
+#include <asm/smp.h>
 
 struct mpic_msgr {
 	u32 __iomem *base;
-- 
1.7.5.1
