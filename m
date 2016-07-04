Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjdSN69HczDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 17:09:56 +1000 (AEST)
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rjdSN2QfZz9s5J
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Jul 2016 17:09:56 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id 66so15681940pfy.1
 for <linuxppc-dev@ozlabs.org>; Mon, 04 Jul 2016 00:09:56 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: Daniel Axtens <dja@axtens.net>
Subject: [PATCH 2/6] powerpc/kernel: Drop annotation for generic,
 unannotated function
Date: Mon,  4 Jul 2016 17:09:38 +1000
Message-Id: <1467616182-30886-2-git-send-email-dja@axtens.net>
In-Reply-To: <1467616182-30886-1-git-send-email-dja@axtens.net>
References: <1467616182-30886-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sadly, access_process_vm takes an unsigned long, rather than a void
__user *. Worse, it's a generic kernel function: changing it would be
a massive, kernel-wide effort.

So, __force the annotation away.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/kernel/ptrace32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace32.c b/arch/powerpc/kernel/ptrace32.c
index f52b7db327c8..c2eb319a9239 100644
--- a/arch/powerpc/kernel/ptrace32.c
+++ b/arch/powerpc/kernel/ptrace32.c
@@ -73,7 +73,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 		if (get_user(addrOthers, (u32 __user * __user *)addr) != 0)
 			break;
 
-		copied = access_process_vm(child, (u64)addrOthers, &tmp,
+		copied = access_process_vm(child, (u64 __force)addrOthers, &tmp,
 				sizeof(tmp), 0);
 		if (copied != sizeof(tmp))
 			break;
@@ -178,7 +178,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 		if (get_user(addrOthers, (u32 __user * __user *)addr) != 0)
 			break;
 		ret = 0;
-		if (access_process_vm(child, (u64)addrOthers, &tmp,
+		if (access_process_vm(child, (u64 __force)addrOthers, &tmp,
 					sizeof(tmp), 1) == sizeof(tmp))
 			break;
 		ret = -EIO;
-- 
2.1.4
