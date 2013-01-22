Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EF5502C0080
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 12:56:58 +1100 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc/mpic: make distribute_irqs obey
 MPIC_SINGLE_DEST_CPU
Date: Mon, 21 Jan 2013 19:56:42 -0600
Message-ID: <1358819804-28665-2-git-send-email-scottwood@freescale.com>
In-Reply-To: <1358819804-28665-1-git-send-email-scottwood@freescale.com>
References: <1358819804-28665-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previously we were setting an illegal configuration on mpc85xx
MPICs if CONFIG_IRQ_ALL_CPUS is enabled (which for some reason it is
in mpc85xx_smp_defconfig).

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/mpic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 3b2efd4..6694425 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -54,7 +54,7 @@ static DEFINE_RAW_SPINLOCK(mpic_lock);
 
 #ifdef CONFIG_PPC32	/* XXX for now */
 #ifdef CONFIG_IRQ_ALL_CPUS
-#define distribute_irqs	(1)
+#define distribute_irqs	(!(mpic->flags & MPIC_SINGLE_DEST_CPU))
 #else
 #define distribute_irqs	(0)
 #endif
-- 
1.7.9.5
