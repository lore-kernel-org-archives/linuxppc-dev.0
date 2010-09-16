Return-Path: <ash@shisha.kicks-ass.net>
Received: from filtteri6.pp.htv.fi (filtteri6.pp.htv.fi [213.243.153.189])
	by ozlabs.org (Postfix) with ESMTP id DBCEAB70CB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Sep 2010 08:26:34 +1000 (EST)
From: Alexander Shishkin <virtuoso@slind.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] wire up sys_time_change_notify() on powerpc
Date: Fri, 17 Sep 2010 01:10:46 +0300
Message-Id: <1284675049-23479-5-git-send-email-virtuoso@slind.org>
In-Reply-To: <1284675049-23479-1-git-send-email-virtuoso@slind.org>
References: <1284675049-23479-1-git-send-email-virtuoso@slind.org>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>, Greg KH <gregkh@suse.de>,
	Chris Friesen <chris.friesen@genband.com>,
	John Stultz <johnstul@us.ibm.com>, Andreas Schwab <schwab@linux-m68k.org>,
	Kay Sievers <kay.sievers@vrfy.org>, linuxppc-dev@lists.ozlabs.org,
	Alexander Shishkin <virtuoso@slind.org>, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Andreas Schwab <schwab@linux-m68k.org>
CC: Alexander Shishkin <virtuoso@slind.org>
CC: Christoph Hellwig <hch@lst.de>
CC: Jesper Nilsson <jesper.nilsson@axis.com>
CC: linuxppc-dev@lists.ozlabs.org
CC: linux-kernel@vger.kernel.org
---
 arch/powerpc/include/asm/systbl.h |    1 +
 arch/powerpc/include/asm/unistd.h |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 3d21266..124b610 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -329,3 +329,4 @@ COMPAT_SYS(rt_tgsigqueueinfo)
 SYSCALL(fanotify_init)
 COMPAT_SYS(fanotify_mark)
 SYSCALL_SPU(prlimit64)
+SYSCALL(time_change_notify)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 597e6f9..6ab64da 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -348,10 +348,11 @@
 #define __NR_fanotify_init	323
 #define __NR_fanotify_mark	324
 #define __NR_prlimit64		325
+#define __NR_time_change_notify	326
 
 #ifdef __KERNEL__
 
-#define __NR_syscalls		326
+#define __NR_syscalls		327
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
-- 
1.7.2.1.45.gb66c2
