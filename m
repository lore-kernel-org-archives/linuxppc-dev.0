Return-Path: <srs0=ztpm=3u=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2vLk1D0JzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 16:35:42 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w2vLk0WrKz8sZm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 16:35:42 +1000 (AEST)
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w2vLj4HdTz9sNJ
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2017 16:35:41 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id a188so3191128pfa.2
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2017 23:35:41 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/syscalls/trace: Fix mmap in syscalls_trace
Date: Wed, 12 Apr 2017 16:35:19 +1000
Message-Id: <20170412063519.18560-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch uses SYSCALL_DEFINE6 for sys_mmap and sys_mmap2
so that the meta-data associated with these syscalls is
visible to the syscall tracer. In the absence of this
generic syscalls (defined outside arch) like munmap,etc.
are visible in available_events, syscall_enter_mmap and
syscall_exit_mmap is not.

A side-effect of this change is that the return type has
changed from unsigned long to long.

Prior to these changes, we had, under /sys/kernel/tracing

cat available_events  | grep syscalls | grep map
syscalls:sys_exit_remap_file_pages
syscalls:sys_enter_remap_file_pages
syscalls:sys_exit_munmap
syscalls:sys_enter_munmap
syscalls:sys_exit_mremap
syscalls:sys_enter_mremap

After these changes we have mmap in available_events.

cat available_events  | grep syscalls | grep map
syscalls:sys_exit_mmap
syscalls:sys_enter_mmap
syscalls:sys_exit_remap_file_pages
syscalls:sys_enter_remap_file_pages
syscalls:sys_exit_munmap
syscalls:sys_enter_munmap
syscalls:sys_exit_mremap
syscalls:sys_enter_mremap

Sample trace:
     cat-3399  [001] ....   196.542410: sys_mmap(addr: 7fff922a0000, len: 20000, prot: 3, flags: 812, fd: 3, offset: 1b0000)
     cat-3399  [001] ....   196.542443: sys_mmap -> 0x7fff922a0000
     cat-3399  [001] ....   196.542668: sys_munmap(addr: 7fff922c0000, len: 6d2c)
     cat-3399  [001] ....   196.542677: sys_munmap -> 0x0

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---

 Changelog:
   Removed RFC
   Fixed len from unsigned long to size_t
   Added some examples of use of mmap trace

 arch/powerpc/include/asm/syscalls.h |  4 ++--
 arch/powerpc/kernel/syscalls.c      | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/syscalls.h b/arch/powerpc/include/asm/syscalls.h
index 23be8f1..16fab68 100644
--- a/arch/powerpc/include/asm/syscalls.h
+++ b/arch/powerpc/include/asm/syscalls.h
@@ -8,10 +8,10 @@
 
 struct rtas_args;
 
-asmlinkage unsigned long sys_mmap(unsigned long addr, size_t len,
+asmlinkage long sys_mmap(unsigned long addr, size_t len,
 		unsigned long prot, unsigned long flags,
 		unsigned long fd, off_t offset);
-asmlinkage unsigned long sys_mmap2(unsigned long addr, size_t len,
+asmlinkage long sys_mmap2(unsigned long addr, size_t len,
 		unsigned long prot, unsigned long flags,
 		unsigned long fd, unsigned long pgoff);
 asmlinkage long ppc64_personality(unsigned long personality);
diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
index de04c9f..a877bf8 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -42,11 +42,11 @@
 #include <asm/unistd.h>
 #include <asm/asm-prototypes.h>
 
-static inline unsigned long do_mmap2(unsigned long addr, size_t len,
+static inline long do_mmap2(unsigned long addr, size_t len,
 			unsigned long prot, unsigned long flags,
 			unsigned long fd, unsigned long off, int shift)
 {
-	unsigned long ret = -EINVAL;
+	long ret = -EINVAL;
 
 	if (!arch_validate_prot(prot))
 		goto out;
@@ -62,16 +62,16 @@ static inline unsigned long do_mmap2(unsigned long addr, size_t len,
 	return ret;
 }
 
-unsigned long sys_mmap2(unsigned long addr, size_t len,
-			unsigned long prot, unsigned long flags,
-			unsigned long fd, unsigned long pgoff)
+SYSCALL_DEFINE6(mmap2, unsigned long, addr, size_t, len,
+		unsigned long, prot, unsigned long, flags,
+		unsigned long, fd, unsigned long, pgoff)
 {
 	return do_mmap2(addr, len, prot, flags, fd, pgoff, PAGE_SHIFT-12);
 }
 
-unsigned long sys_mmap(unsigned long addr, size_t len,
-		       unsigned long prot, unsigned long flags,
-		       unsigned long fd, off_t offset)
+SYSCALL_DEFINE6(mmap, unsigned long, addr, size_t, len,
+		unsigned long, prot, unsigned long, flags,
+		unsigned long, fd, off_t, offset)
 {
 	return do_mmap2(addr, len, prot, flags, fd, offset, PAGE_SHIFT);
 }
-- 
2.9.3
