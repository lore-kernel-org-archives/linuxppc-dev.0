Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 4D557679F9
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 20:45:42 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix spu_callbacks BUILD_BUG_ON
Date: Fri, 21 Apr 2006 12:45:27 +0200
References: <20060421080239.GC4717@suse.de>
	<20060421022555.2d460805.akpm@osdl.org>
	<200604211241.36596.arnd@arndb.de>
In-Reply-To: <200604211241.36596.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604211245.27744.arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
	linuxppc-dev@ozlabs.org, torvalds@osdl.org,
	Paul Mackerras <paulus@samba.org>, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Every time a new syscall gets added, a BUILD_BUG_ON in
arch/powerpc/platforms/cell/spu_callbacks.c gets triggered.
Since the addition of a new syscall is rather harmless,
the error should just be removed.

While we're here, add sys_tee to the list and add a comment
to systbl.S to remind people that there is another list
on powerpc.

Signed-of-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

--- linus-2.6.orig/arch/powerpc/platforms/cell/spu_callbacks.c
+++ linus-2.6/arch/powerpc/platforms/cell/spu_callbacks.c
@@ -317,17 +317,16 @@ void *spu_syscall_table[] = {
 	[__NR_ppoll]			sys_ni_syscall, /* sys_ppoll */
 	[__NR_unshare]			sys_unshare,
 	[__NR_splice]			sys_splice,
+	[__NR_tee]			sys_tee,
 };
 
 long spu_sys_callback(struct spu_syscall_block *s)
 {
 	long (*syscall)(u64 a1, u64 a2, u64 a3, u64 a4, u64 a5, u64 a6);
 
-	BUILD_BUG_ON(ARRAY_SIZE(spu_syscall_table) != __NR_syscalls);
-
 	syscall = spu_syscall_table[s->nr_ret];
 
-	if (s->nr_ret >= __NR_syscalls) {
+	if (s->nr_ret >= ARRAY_SIZE(spu_syscall_table)) {
 		pr_debug("%s: invalid syscall #%ld", __FUNCTION__, s->nr_ret);
 		return -ENOSYS;
 	}
Index: linus-2.6/arch/powerpc/kernel/systbl.S
===================================================================
--- linus-2.6.orig/arch/powerpc/kernel/systbl.S
+++ linus-2.6/arch/powerpc/kernel/systbl.S
@@ -324,3 +324,8 @@ COMPAT_SYS(ppoll)
 SYSCALL(unshare)
 SYSCALL(splice)
 SYSCALL(tee)
+
+/*
+ * please add new calls to arch/powerpc/platforms/cell/spu_callbacks.c
+ * as well when appropriate.
+ */
