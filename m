Return-Path: <ash@shisha.kicks-ass.net>
Received: from filtteri1.pp.htv.fi (filtteri1.pp.htv.fi [213.243.153.184])
	by ozlabs.org (Postfix) with ESMTP id D98B3B7144
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Nov 2010 06:40:06 +1100 (EST)
From: Alexander Shishkin <virtuoso@slind.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCHv6 6/7] wire up sys_time_change_notify() on powerpc
Date: Thu, 11 Nov 2010 21:30:01 +0200
Message-Id: <1289503802-22444-7-git-send-email-virtuoso@slind.org>
In-Reply-To: <1289503802-22444-1-git-send-email-virtuoso@slind.org>
References: <1289503802-22444-1-git-send-email-virtuoso@slind.org>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>, Greg KH <gregkh@suse.de>,
	Chris Friesen <chris.friesen@genband.com>,
	John Stultz <johnstul@us.ibm.com>, Andreas Schwab <schwab@linux-m68k.org>,
	Kay Sievers <kay.sievers@vrfy.org>,
	linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
	Alexander Shishkin <virtuoso@slind.org>, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
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
index aa0f1eb..a57cc82 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -348,3 +348,4 @@ COMPAT_SYS_SPU(sendmsg)
 COMPAT_SYS_SPU(recvmsg)
 COMPAT_SYS_SPU(recvmmsg)
 SYSCALL_SPU(accept4)
+SYSCALL(time_change_notify)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 6151937..bea2c9e 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -367,10 +367,11 @@
 #define __NR_recvmsg		342
 #define __NR_recvmmsg		343
 #define __NR_accept4		344
+#define __NR_time_change_notify 345
 
 #ifdef __KERNEL__
 
-#define __NR_syscalls		345
+#define __NR_syscalls		346
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
-- 
1.7.2.1.45.gb66c2
