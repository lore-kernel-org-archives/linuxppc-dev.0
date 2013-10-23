Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D67012C0441
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 20:31:44 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <scottwood@freescale.com>
Subject: [v6][PATCH 5/5] powerpc/book3e/kgdb: Fix a single stgep case of lazy
 IRQ
Date: Wed, 23 Oct 2013 17:31:25 +0800
Message-ID: <1382520685-11609-6-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1382520685-11609-1-git-send-email-tiejun.chen@windriver.com>
References: <1382520685-11609-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In lazy EE magic, we may have a lazy interrupt occured while
entering kgdb, but we really don't want to replay that interrupt
for kgdb, so we have to clear the PACA_IRQ_HARD_DIS force to
make sure we can exit directly from this debug exception.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/kernel/kgdb.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index 447c14b..9872f58 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -185,6 +185,14 @@ static int kgdb_singlestep(struct pt_regs *regs)
 		/* Restore current_thread_info lastly. */
 		memcpy(exception_thread_info, backup_current_thread_info, sizeof *thread_info);
 
+#ifdef CONFIG_PPC64
+	/*
+	 * Clear the PACA_IRQ_HARD_DIS from the pending mask
+	 * since we are about to exit this directly from debug
+	 * exception without any replay interrupt in lazy EE case.
+	 */
+	local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
+#endif
 	return 1;
 }
 
-- 
1.7.9.5
