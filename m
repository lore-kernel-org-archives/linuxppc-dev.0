Return-Path: <jirislaby@gmail.com>
Received: from server1.wserver.cz (server1.wserver.cz [82.113.45.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C4B7E1007D1
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Nov 2009 10:15:01 +1100 (EST)
From: Jiri Slaby <jslaby@suse.cz>
To: jirislaby@gmail.com
Subject: [PATCH v3 16/27] PPC: use helpers for rlimits
Date: Sat, 28 Nov 2009 00:05:56 +0100
Message-Id: <1259363167-9347-16-git-send-email-jslaby@suse.cz>
In-Reply-To: <1259363167-9347-1-git-send-email-jslaby@suse.cz>
References: <1259363167-9347-1-git-send-email-jslaby@suse.cz>
Cc: sfr@canb.auug.org.au, nhorman@tuxdriver.com,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux-kernel@vger.kernel.org, oleg@redhat.com,
	linuxppc-dev@ozlabs.org, mingo@redhat.com, tglx@linutronix.de,
	marcin.slusarz@gmail.com, hpa@zytor.com,
	Paul Mackerras <paulus@samba.org>, akpm@linux-foundation.org,
	James Morris <jmorris@namei.org>, torvalds@linux-foundation.org,
	mingo@elte.hu
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

I.e. either use newly added rlimit helpers or ACCESS_ONCE if not
applicable.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: James Morris <jmorris@namei.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
---
 arch/powerpc/mm/mmap_64.c                    |    4 ++--
 arch/powerpc/platforms/cell/spufs/coredump.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/mmap_64.c b/arch/powerpc/mm/mmap_64.c
index 0d957a4..8df1299 100644
--- a/arch/powerpc/mm/mmap_64.c
+++ b/arch/powerpc/mm/mmap_64.c
@@ -47,7 +47,7 @@ static inline int mmap_is_legacy(void)
 	if (current->personality & ADDR_COMPAT_LAYOUT)
 		return 1;
 
-	if (current->signal->rlim[RLIMIT_STACK].rlim_cur == RLIM_INFINITY)
+	if (rlim_get_cur(RLIMIT_STACK) == RLIM_INFINITY)
 		return 1;
 
 	return sysctl_legacy_va_layout;
@@ -77,7 +77,7 @@ static unsigned long mmap_rnd(void)
 
 static inline unsigned long mmap_base(void)
 {
-	unsigned long gap = current->signal->rlim[RLIMIT_STACK].rlim_cur;
+	unsigned long gap = rlim_get_cur(RLIMIT_STACK);
 
 	if (gap < MIN_GAP)
 		gap = MIN_GAP;
diff --git a/arch/powerpc/platforms/cell/spufs/coredump.c b/arch/powerpc/platforms/cell/spufs/coredump.c
index c4d4a19..4ef1c92 100644
--- a/arch/powerpc/platforms/cell/spufs/coredump.c
+++ b/arch/powerpc/platforms/cell/spufs/coredump.c
@@ -54,7 +54,7 @@ static ssize_t do_coredump_read(int num, struct spu_context *ctx, void *buffer,
  */
 static int spufs_dump_write(struct file *file, const void *addr, int nr, loff_t *foffset)
 {
-	unsigned long limit = current->signal->rlim[RLIMIT_CORE].rlim_cur;
+	unsigned long limit = rlim_get_cur(RLIMIT_CORE);
 	ssize_t written;
 
 	if (*foffset + nr > limit)
-- 
1.6.5.3
