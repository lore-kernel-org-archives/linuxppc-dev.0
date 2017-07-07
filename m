Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x3vYf6fWgzDr5V
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jul 2017 22:48:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: torvalds@linux-fondation.org
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/fcntl: Fix F_GET/SETLK etc. for compat processes
Date: Fri,  7 Jul 2017 22:48:51 +1000
Message-Id: <1499431731-27058-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 8c6657cb50cb ("Switch flock copyin/copyout primitives to
copy_{from,to}_user()") added copy_flock_fields(from, to), but then in all cases
called it with arguments of (to, from). eg:

  static int get_compat_flock(struct flock *kfl, struct compat_flock __user *ufl)
  {
  	struct compat_flock fl;

  	if (copy_from_user(&fl, ufl, sizeof(struct compat_flock)))
  		return -EFAULT;
  	copy_flock_fields(*kfl, fl);
  	return 0;
  }

We are reading the compat_flock ufl from userspace, into flock kfl. First we
copy all of ufl into fl on the stack, and then we want to assign each field of
fl to kfl. So we are copying from fl and to kfl. But as written the
copy_flock_fields() macro takes the arguments in the other order.

copy_to/from_user() take "to" as the first argument, so change the order of
arguments in the copy_flock_fields() macro, rather than changing the callers.

Fixes: 8c6657cb50cb ("Switch flock copyin/copyout primitives to copy_{from,to}_user()")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 fs/fcntl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index b6bd89628025..f40e3a9c10a5 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -520,7 +520,7 @@ SYSCALL_DEFINE3(fcntl64, unsigned int, fd, unsigned int, cmd,
 
 #ifdef CONFIG_COMPAT
 /* careful - don't use anywhere else */
-#define copy_flock_fields(from, to)		\
+#define copy_flock_fields(to, from)		\
 	(to).l_type = (from).l_type;		\
 	(to).l_whence = (from).l_whence;	\
 	(to).l_start = (from).l_start;		\
-- 
2.7.4
