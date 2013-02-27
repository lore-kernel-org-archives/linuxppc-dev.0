Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5F94B2C0ACE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2013 14:09:47 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>, <galak@kernel.crashing.org>
Subject: [v3][PATCH 6/6] powerpc/kgdb: remove copying the thread_info
Date: Wed, 27 Feb 2013 11:09:28 +0800
Message-ID: <1361934568-31989-7-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1361934568-31989-1-git-send-email-tiejun.chen@windriver.com>
References: <1361934568-31989-1-git-send-email-tiejun.chen@windriver.com>
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

Currently BookE and Book3E always copy the thread_info from
the kernel stack when we enter the debug exception, so we can
remove these action here to avoid copying again.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/kernel/kgdb.c |   28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index 1a57307..e954888 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -153,39 +153,11 @@ static int kgdb_handle_breakpoint(struct pt_regs *regs)
 
 static int kgdb_singlestep(struct pt_regs *regs)
 {
-	struct thread_info *thread_info, *exception_thread_info;
-	struct thread_info *backup_current_thread_info;
-
 	if (user_mode(regs))
 		return 0;
 
-	backup_current_thread_info = (struct thread_info *)kmalloc(sizeof(struct thread_info), GFP_KERNEL);
-	/*
-	 * On Book E and perhaps other processors, singlestep is handled on
-	 * the critical exception stack.  This causes current_thread_info()
-	 * to fail, since it it locates the thread_info by masking off
-	 * the low bits of the current stack pointer.  We work around
-	 * this issue by copying the thread_info from the kernel stack
-	 * before calling kgdb_handle_exception, and copying it back
-	 * afterwards.  On most processors the copy is avoided since
-	 * exception_thread_info == thread_info.
-	 */
-	thread_info = (struct thread_info *)(regs->gpr[1] & ~(THREAD_SIZE-1));
-	exception_thread_info = current_thread_info();
-
-	if (thread_info != exception_thread_info) {
-		/* Save the original current_thread_info. */
-		memcpy(backup_current_thread_info, exception_thread_info, sizeof *thread_info);
-		memcpy(exception_thread_info, thread_info, sizeof *thread_info);
-	}
-
 	kgdb_handle_exception(0, SIGTRAP, 0, regs);
 
-	if (thread_info != exception_thread_info)
-		/* Restore current_thread_info lastly. */
-		memcpy(exception_thread_info, backup_current_thread_info, sizeof *thread_info);
-
-	kfree(backup_current_thread_info);
 	return 1;
 }
 
-- 
1.7.9.5
