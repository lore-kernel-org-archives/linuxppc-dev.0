Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D41702C0317
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2013 22:02:57 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>, <galak@kernel.crashing.org>
Subject: [v4][PATCH 3/7] book3e/kgdb: update thread's dbcr0
Date: Mon, 11 Mar 2013 19:02:42 +0800
Message-ID: <1362999766-20897-4-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1362999766-20897-1-git-send-email-tiejun.chen@windriver.com>
References: <1362999766-20897-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 jason.wessel@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

gdb always need to generate a single step properly to invoke
a kgdb state. But with lazy interrupt, book3e can't always
trigger a debug exception with a single step since the current
is blocked for handling those pending exception, then we miss
that expected dbcr configuration at last to generate a debug
exception.

So here we also update thread's dbcr0 to make sure the current
can go back with that missed dbcr0 configuration.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/kernel/kgdb.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index 5ca82cd..1a57307 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -410,7 +410,7 @@ int kgdb_arch_handle_exception(int vector, int signo, int err_code,
 			       struct pt_regs *linux_regs)
 {
 	char *ptr = &remcom_in_buffer[1];
-	unsigned long addr;
+	unsigned long addr, dbcr0;
 
 	switch (remcom_in_buffer[0]) {
 		/*
@@ -427,8 +427,15 @@ int kgdb_arch_handle_exception(int vector, int signo, int err_code,
 		/* set the trace bit if we're stepping */
 		if (remcom_in_buffer[0] == 's') {
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
-			mtspr(SPRN_DBCR0,
-			      mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
+			dbcr0 = mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM;
+			mtspr(SPRN_DBCR0, dbcr0);
+#ifdef CONFIG_PPC_BOOK3E_64
+			/* With lazy interrut we have to update thread dbcr0 here
+			 * to make sure we can set debug properly at last to invoke
+			 * kgdb again to work well.
+			 */
+			current->thread.dbcr0 = dbcr0;
+#endif
 			linux_regs->msr |= MSR_DE;
 #else
 			linux_regs->msr |= MSR_SE;
-- 
1.7.9.5
