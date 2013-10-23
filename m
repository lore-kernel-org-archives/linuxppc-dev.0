Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 775342C03A9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 20:31:42 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <scottwood@freescale.com>
Subject: [v6][PATCH 4/5] powerpc/kgdb: use DEFINE_PER_CPU to allocate kgdb's
 thread_info
Date: Wed, 23 Oct 2013 17:31:24 +0800
Message-ID: <1382520685-11609-5-git-send-email-tiejun.chen@windriver.com>
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

Use DEFINE_PER_CPU to allocate thread_info statically instead of kmalloc().
This can avoid introducing more memory check codes.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/kernel/kgdb.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index c1eef24..447c14b 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -151,15 +151,15 @@ static int kgdb_handle_breakpoint(struct pt_regs *regs)
 	return 1;
 }
 
+static DEFINE_PER_CPU(struct thread_info, kgdb_thread_info);
 static int kgdb_singlestep(struct pt_regs *regs)
 {
 	struct thread_info *thread_info, *exception_thread_info;
-	struct thread_info *backup_current_thread_info;
+	struct thread_info *backup_current_thread_info = &__get_cpu_var(kgdb_thread_info);
 
 	if (user_mode(regs))
 		return 0;
 
-	backup_current_thread_info = kmalloc(sizeof(struct thread_info), GFP_KERNEL);
 	/*
 	 * On Book E and perhaps other processors, singlestep is handled on
 	 * the critical exception stack.  This causes current_thread_info()
@@ -185,7 +185,6 @@ static int kgdb_singlestep(struct pt_regs *regs)
 		/* Restore current_thread_info lastly. */
 		memcpy(exception_thread_info, backup_current_thread_info, sizeof *thread_info);
 
-	kfree(backup_current_thread_info);
 	return 1;
 }
 
-- 
1.7.9.5
