Return-Path: <kosmo@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 91C01DDF55
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 21:30:10 +1100 (EST)
From: Piotr Ziecik <kosmo@semihalf.com>
To: LinuxPPC Mailing List <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Enable CPU_FTR_NEED_COHERENT for MPC52xx
Date: Mon, 16 Mar 2009 11:05:25 +0100
Message-Id: <1237197925-71727-1-git-send-email-kosmo@semihalf.com>
In-Reply-To: <20090311222615.63410@gmx.net>
References: <20090311222615.63410@gmx.net>
Cc: Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

BestComm, a DMA engine in MPC52xx SoC, requires snooping when
CPU caches are enabled to work properly.

Adding CPU_FTR_NEED_COHERENT fixes NFS problems on MPC52xx machines
introduced by 'powerpc/mm: Fix handling of _PAGE_COHERENT in BAT setup code'.

Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
---

This patch was succesfully tested on our MPC5200-based.
Ben, Gerhard could you ack this patch, as it implements your suggestion.

 arch/powerpc/include/asm/cputable.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index b18358f..22dc2d8 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -241,9 +241,11 @@ extern const char *powerpc_base_platform;
 /* We need to mark all pages as being coherent if we're SMP or we have a
  * 74[45]x and an MPC107 host bridge. Also 83xx and PowerQUICC II
  * require it for PCI "streaming/prefetch" to work properly.
+ * This is also required by 52xx family.
  */
 #if defined(CONFIG_SMP) || defined(CONFIG_MPC10X_BRIDGE) \
-	|| defined(CONFIG_PPC_83xx) || defined(CONFIG_8260)
+	|| defined(CONFIG_PPC_83xx) || defined(CONFIG_8260) \
+	|| defined(CONFIG_PPC_MPC52xx)
 #define CPU_FTR_COMMON                  CPU_FTR_NEED_COHERENT
 #else
 #define CPU_FTR_COMMON                  0
-- 
1.6.0.6
