Return-Path: <srs0=g6dx=3t=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2DbB38SNzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 14:29:10 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w2DbB21C0z8swW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 14:29:10 +1000 (AEST)
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w2Db921pWz9sN6
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2017 14:29:08 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id o123so28206200pga.1
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 21:29:08 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au,
	linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH] powerpc/syscalls/trace: Fix mmap in syscalls_trace
Date: Tue, 11 Apr 2017 14:28:37 +1000
Message-Id: <20170411042837.17292-1-bsingharora@gmail.com>
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

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
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
index de04c9f..10b7fe9d 100644
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
+SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
+		unsigned long, prot, unsigned long, flags,
+		unsigned long, fd, unsigned long, pgoff)
 {
 	return do_mmap2(addr, len, prot, flags, fd, pgoff, PAGE_SHIFT-12);
 }
 
-unsigned long sys_mmap(unsigned long addr, size_t len,
-		       unsigned long prot, unsigned long flags,
-		       unsigned long fd, off_t offset)
+SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
+		unsigned long, prot, unsigned long, flags,
+		unsigned long, fd, off_t, offset)
 {
 	return do_mmap2(addr, len, prot, flags, fd, offset, PAGE_SHIFT);
 }
-- 
2.9.3
