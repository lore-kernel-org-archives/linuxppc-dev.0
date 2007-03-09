Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C788EDDEAB
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Mar 2007 15:21:59 +1100 (EST)
Date: Fri, 9 Mar 2007 15:22:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Wire up sys_sync_file_range
Message-Id: <20070309152201.027c2bf5.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This requires an architecture specific compat routine as u64s are passed
in odd/even (high/low) register pairs on ppc32.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/sys_ppc32.c |    9 +++++++++
 include/asm-powerpc/systbl.h    |    1 +
 include/asm-powerpc/unistd.h    |    3 ++-
 3 files changed, 12 insertions(+), 1 deletions(-)

David, the other two missing syscalls were wired up in the previous patch
set I sent today.  Thanks for your patch to push us along.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index 673e8d9..b282035 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -814,3 +814,12 @@ asmlinkage long compat_sys_request_key(const char __user *_type,
 	return sys_request_key(_type, _description, _callout_info, destringid);
 }
 
+asmlinkage long compat_sys_sync_file_range(int fd, u32 unused,
+		u32 offset_high, u32 offset_low,
+		u32 nbytes_high, u32 nbytes_low,
+		compat_uint_t flags)
+{
+	return sys_sync_file_range(fd, (loff_t)offset_high << 32 | offset_low,
+			(loff_t)nbytes_high << 32 | nbytes_low,
+			(unsigned int)flags);
+}
diff --git a/include/asm-powerpc/systbl.h b/include/asm-powerpc/systbl.h
index 8d853c5..3676a20 100644
--- a/include/asm-powerpc/systbl.h
+++ b/include/asm-powerpc/systbl.h
@@ -307,3 +307,4 @@ COMPAT_SYS_SPU(set_robust_list)
 COMPAT_SYS_SPU(move_pages)
 SYSCALL_SPU(getcpu)
 COMPAT_SYS(epoll_pwait)
+COMPAT_SYS_SPU(sync_file_range)
diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
index 2baedbe..17c2b96 100644
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -326,10 +326,11 @@
 #define __NR_move_pages		301
 #define __NR_getcpu		302
 #define __NR_epoll_pwait	303
+#define __NR_sync_file_range	304
 
 #ifdef __KERNEL__
 
-#define __NR_syscalls		304
+#define __NR_syscalls		305
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
-- 
1.5.0.3
