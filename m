Return-Path: <jirislaby@gmail.com>
Received: from smtp.mujha-vel.cz (smtp.mujha-vel.cz [81.30.225.246])
	by ozlabs.org (Postfix) with ESMTP id F1578B6EDF
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 03:07:18 +1100 (EST)
From: Jiri Slaby <jslaby@suse.cz>
To: jirislaby@gmail.com
Subject: [PATCH] PPC: use helpers for rlimits
Date: Wed,  6 Jan 2010 16:24:31 +0100
Message-Id: <1262791479-26594-3-git-send-email-jslaby@suse.cz>
In-Reply-To: <1262791479-26594-1-git-send-email-jslaby@suse.cz>
References: <1262791479-26594-1-git-send-email-jslaby@suse.cz>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make sure compiler won't do weird things with limits. E.g. fetching
them twice may return 2 different values after writable limits are
implemented.

I.e. either use rlimit helpers added in
3e10e716abf3c71bdb5d86b8f507f9e72236c9cd
or ACCESS_ONCE if not applicable.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
---
 arch/powerpc/mm/mmap_64.c                    |    4 ++--
 arch/powerpc/platforms/cell/spufs/coredump.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/mmap_64.c b/arch/powerpc/mm/mmap_64.c
index 0d957a4..5a783d8 100644
--- a/arch/powerpc/mm/mmap_64.c
+++ b/arch/powerpc/mm/mmap_64.c
@@ -47,7 +47,7 @@ static inline int mmap_is_legacy(void)
 	if (current->personality & ADDR_COMPAT_LAYOUT)
 		return 1;
 
-	if (current->signal->rlim[RLIMIT_STACK].rlim_cur == RLIM_INFINITY)
+	if (rlimit(RLIMIT_STACK) == RLIM_INFINITY)
 		return 1;
 
 	return sysctl_legacy_va_layout;
@@ -77,7 +77,7 @@ static unsigned long mmap_rnd(void)
 
 static inline unsigned long mmap_base(void)
 {
-	unsigned long gap = current->signal->rlim[RLIMIT_STACK].rlim_cur;
+	unsigned long gap = rlimit(RLIMIT_STACK);
 
 	if (gap < MIN_GAP)
 		gap = MIN_GAP;
diff --git a/arch/powerpc/platforms/cell/spufs/coredump.c b/arch/powerpc/platforms/cell/spufs/coredump.c
index c4d4a19..eea1202 100644
--- a/arch/powerpc/platforms/cell/spufs/coredump.c
+++ b/arch/powerpc/platforms/cell/spufs/coredump.c
@@ -54,7 +54,7 @@ static ssize_t do_coredump_read(int num, struct spu_context *ctx, void *buffer,
  */
 static int spufs_dump_write(struct file *file, const void *addr, int nr, loff_t *foffset)
 {
-	unsigned long limit = current->signal->rlim[RLIMIT_CORE].rlim_cur;
+	unsigned long limit = rlimit(RLIMIT_CORE);
 	ssize_t written;
 
 	if (*foffset + nr > limit)
-- 
1.6.5.7
