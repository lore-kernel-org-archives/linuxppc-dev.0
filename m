Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 43EADDDE43
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 16:24:59 +1000 (EST)
Date: Wed, 9 May 2007 16:23:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 1/2] Declare {compat_}sys_utimensat
Message-Id: <20070509162357.65ab8868.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/compat.h   |    3 +++
 include/linux/syscalls.h |    2 ++
 2 files changed, 5 insertions(+), 0 deletions(-)

This is needed before Powerpc can wire up the syscall.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/linux/compat.h b/include/linux/compat.h
index ccd863d..70a157a 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -253,5 +253,8 @@ asmlinkage long compat_sys_epoll_pwait(int epfd,
 			const compat_sigset_t __user *sigmask,
 			compat_size_t sigsetsize);
 
+asmlinkage long compat_sys_utimensat(unsigned int dfd, char __user *filename,
+				struct compat_timespec __user *t, int flags);
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 1912c6c..3139f44 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -576,6 +576,8 @@ asmlinkage long sys_fstatat64(int dfd, char __user *filename,
 			       struct stat64 __user *statbuf, int flag);
 asmlinkage long sys_readlinkat(int dfd, const char __user *path, char __user *buf,
 			       int bufsiz);
+asmlinkage long sys_utimensat(int dfd, char __user *filename,
+				struct timespec __user *utimes, int flags);
 asmlinkage long compat_sys_futimesat(unsigned int dfd, char __user *filename,
 				     struct compat_timeval __user *t);
 asmlinkage long compat_sys_newfstatat(unsigned int dfd, char __user * filename,
-- 
1.5.1.3
