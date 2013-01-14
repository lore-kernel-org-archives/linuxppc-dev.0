Return-Path: <dinggnu@gmail.com>
Received: from mail-qc0-f182.google.com (mail-qc0-f182.google.com
 [209.85.216.182])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B40192C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 04:26:44 +1100 (EST)
Received: by mail-qc0-f182.google.com with SMTP id k19so2615758qcs.41
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 09:26:41 -0800 (PST)
From: Cong Ding <dinggnu@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Tiejun Chen <tiejun.chen@windriver.com>,
 Michael Neuling <mikey@neuling.org>,
 Jason Wessel <jason.wessel@windriver.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: kernel/kgdb.c: fix memory leakage
Date: Mon, 14 Jan 2013 17:26:32 +0000
Message-Id: <1358184395-31418-1-git-send-email-dinggnu@gmail.com>
Cc: Cong Ding <dinggnu@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

the variable backup_current_thread_info isn't freed before existing the
function.

Signed-off-by: Cong Ding <dinggnu@gmail.com>
---
 arch/powerpc/kernel/kgdb.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index 8747447..5ca82cd 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -154,12 +154,12 @@ static int kgdb_handle_breakpoint(struct pt_regs *regs)
 static int kgdb_singlestep(struct pt_regs *regs)
 {
 	struct thread_info *thread_info, *exception_thread_info;
-	struct thread_info *backup_current_thread_info = \
-		(struct thread_info *)kmalloc(sizeof(struct thread_info), GFP_KERNEL);
+	struct thread_info *backup_current_thread_info;
 
 	if (user_mode(regs))
 		return 0;
 
+	backup_current_thread_info = (struct thread_info *)kmalloc(sizeof(struct thread_info), GFP_KERNEL);
 	/*
 	 * On Book E and perhaps other processors, singlestep is handled on
 	 * the critical exception stack.  This causes current_thread_info()
@@ -185,6 +185,7 @@ static int kgdb_singlestep(struct pt_regs *regs)
 		/* Restore current_thread_info lastly. */
 		memcpy(exception_thread_info, backup_current_thread_info, sizeof *thread_info);
 
+	kfree(backup_current_thread_info);
 	return 1;
 }
 
-- 
1.7.9.5
