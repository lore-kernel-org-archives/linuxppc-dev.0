Return-Path: <alex.grad@gmail.com>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A7D2D2C0306
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2013 00:06:42 +1100 (EST)
Received: by mail-wg0-f45.google.com with SMTP id dq12so4183758wgb.24
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Mar 2013 06:06:38 -0700 (PDT)
From: Alex Grad <alex.grad@gmail.com>
To: benh@kernel.crashing.org
Subject: [PATCH] kgdb: Removed kmalloc returned value cast
Date: Sun, 10 Mar 2013 15:06:19 +0200
Message-Id: <1362920779-25925-1-git-send-email-alex.grad@gmail.com>
Cc: mikey@neuling.org, fr@canb.auug.org.au, linux-kernel@vger.kernel.org,
 tiejun.chen@windriver.com, paulus@samba.org, Alex Grad <alex.grad@gmail.com>,
 jason.wessel@windriver.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Alex Grad <alex.grad@gmail.com>
---
 arch/powerpc/kernel/kgdb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index 5ca82cd..c1eef24 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -159,7 +159,7 @@ static int kgdb_singlestep(struct pt_regs *regs)
 	if (user_mode(regs))
 		return 0;
 
-	backup_current_thread_info = (struct thread_info *)kmalloc(sizeof(struct thread_info), GFP_KERNEL);
+	backup_current_thread_info = kmalloc(sizeof(struct thread_info), GFP_KERNEL);
 	/*
 	 * On Book E and perhaps other processors, singlestep is handled on
 	 * the critical exception stack.  This causes current_thread_info()
-- 
1.7.10.4
