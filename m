Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id DA241DDE0F
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 13:47:50 +1000 (EST)
Date: Mon, 14 May 2007 13:47:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] Declare another couple of compat syscalls.
Message-Id: <20070514134747.1de2435d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Linus <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

compat_sys_signalfd and compat_sys_timerfd need declarations before
PowerPC can wire them up.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/compat.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 636502c..0e69d2c 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -261,5 +261,11 @@ asmlinkage long compat_sys_epoll_pwait(int epfd,
 asmlinkage long compat_sys_utimensat(unsigned int dfd, char __user *filename,
 				struct compat_timespec __user *t, int flags);
 
+asmlinkage long compat_sys_signalfd(int ufd,
+				const compat_sigset_t __user *sigmask,
+                                compat_size_t sigsetsize);
+asmlinkage long compat_sys_timerfd(int ufd, int clockid, int flags,
+				const struct compat_itimerspec __user *utmr);
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
-- 
1.5.1.4
