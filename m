Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0137.outbound.protection.outlook.com [157.56.110.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C972F1A0171
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 14:48:54 +1100 (AEDT)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Tiejun Chen <tiejun.chen@intel.com>, Michael Ellerman
 <mpe@ellerman.id.au>, <kexec@lists.infradead.org>, Scott Wood
 <scottwood@freescale.com>
Subject: [PATCH v2 12/18] powerpc/book3e/kdump: Enable
 crash_kexec_wait_realmode
Date: Tue, 6 Oct 2015 22:48:16 -0500
Message-ID: <1444189702-17241-13-git-send-email-scottwood@freescale.com>
In-Reply-To: <1444189702-17241-1-git-send-email-scottwood@freescale.com>
References: <1444189702-17241-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While book3e doesn't have "real mode", we still want to wait for
all the non-crash cpus to complete their shutdown.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/crash.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index 51dbace..2bb252c 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -221,8 +221,8 @@ void crash_kexec_secondary(struct pt_regs *regs)
 #endif	/* CONFIG_SMP */
 
 /* wait for all the CPUs to hit real mode but timeout if they don't come in */
-#if defined(CONFIG_SMP) && defined(CONFIG_PPC_STD_MMU_64)
-static void crash_kexec_wait_realmode(int cpu)
+#if defined(CONFIG_SMP) && defined(CONFIG_PPC64)
+static void __maybe_unused crash_kexec_wait_realmode(int cpu)
 {
 	unsigned int msecs;
 	int i;
@@ -244,7 +244,7 @@ static void crash_kexec_wait_realmode(int cpu)
 }
 #else
 static inline void crash_kexec_wait_realmode(int cpu) {}
-#endif	/* CONFIG_SMP && CONFIG_PPC_STD_MMU_64 */
+#endif	/* CONFIG_SMP && CONFIG_PPC64 */
 
 /*
  * Register a function to be called on shutdown.  Only use this if you
-- 
2.1.4
