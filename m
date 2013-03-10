Return-Path: <alex.grad@gmail.com>
Received: from mail-ea0-x22f.google.com (mail-ea0-x22f.google.com
 [IPv6:2a00:1450:4013:c01::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A5B122C02F0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2013 09:40:14 +1100 (EST)
Received: by mail-ea0-f175.google.com with SMTP id o10so883252eaj.6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Mar 2013 15:40:10 -0700 (PDT)
From: Alex Grad <alex.grad@gmail.com>
To: penberg@kernel.org
Subject: [PATCH]->[PATCH v2] kgdb: Removed kmalloc returned value cast
Date: Mon, 11 Mar 2013 00:39:48 +0200
Message-Id: <1362955188-3023-1-git-send-email-alex.grad@gmail.com>
Cc: sfr@canb.auug.org.au, mikey@neuling.org, daniel.baluta@gmail.com,
 linux-kernel@vger.kernel.org, tiejun.chen@windriver.com, paulus@samba.org,
 Alex Grad <alex.grad@gmail.com>, jason.wessel@windriver.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While at it, check kmalloc return value.

Signed-off-by: Alex Grad <alex.grad@gmail.com>
---
 arch/powerpc/kernel/kgdb.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index 5ca82cd..9e81dd8 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -159,7 +159,10 @@ static int kgdb_singlestep(struct pt_regs *regs)
 	if (user_mode(regs))
 		return 0;
 
-	backup_current_thread_info = (struct thread_info *)kmalloc(sizeof(struct thread_info), GFP_KERNEL);
+	backup_current_thread_info = kmalloc(sizeof(struct thread_info), GFP_KERNEL);
+	if (!backup_current_thread_info)
+		return -ENOMEM;
+
 	/*
 	 * On Book E and perhaps other processors, singlestep is handled on
 	 * the critical exception stack.  This causes current_thread_info()
-- 
1.7.10.4
