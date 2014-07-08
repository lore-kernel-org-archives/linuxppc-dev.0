Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE8D61A0019
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jul 2014 16:00:13 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/cell: Fix compilation with CONFIG_COREDUMP=n
Date: Tue,  8 Jul 2014 16:00:09 +1000
Message-Id: <1404799209-14049-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 046d662f4818 "coredump: make core dump functionality optional"
made the coredump optional, but didn't update the spufs code that
depends on it. That leads to build errors such as:

  arch/powerpc/platforms/built-in.o: In function `.spufs_arch_write_note':
  coredump.c:(.text+0x22cd4): undefined reference to `.dump_emit'
  coredump.c:(.text+0x22cf4): undefined reference to `.dump_emit'
  coredump.c:(.text+0x22d0c): undefined reference to `.dump_align'
  coredump.c:(.text+0x22d48): undefined reference to `.dump_emit'
  coredump.c:(.text+0x22e7c): undefined reference to `.dump_skip'

Fix it by adding some ifdefs in the cell code.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/cell/spu_syscalls.c   | 2 ++
 arch/powerpc/platforms/cell/spufs/Makefile   | 3 ++-
 arch/powerpc/platforms/cell/spufs/syscalls.c | 6 ++++--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spu_syscalls.c b/arch/powerpc/platforms/cell/spu_syscalls.c
index 38e0a1a5cec3..5e6e0bad6db6 100644
--- a/arch/powerpc/platforms/cell/spu_syscalls.c
+++ b/arch/powerpc/platforms/cell/spu_syscalls.c
@@ -111,6 +111,7 @@ asmlinkage long sys_spu_run(int fd, __u32 __user *unpc, __u32 __user *ustatus)
 	return ret;
 }
 
+#ifdef CONFIG_COREDUMP
 int elf_coredump_extra_notes_size(void)
 {
 	struct spufs_calls *calls;
@@ -142,6 +143,7 @@ int elf_coredump_extra_notes_write(struct coredump_params *cprm)
 
 	return ret;
 }
+#endif
 
 void notify_spus_active(void)
 {
diff --git a/arch/powerpc/platforms/cell/spufs/Makefile b/arch/powerpc/platforms/cell/spufs/Makefile
index b9d5d678aa44..52a7d2596d30 100644
--- a/arch/powerpc/platforms/cell/spufs/Makefile
+++ b/arch/powerpc/platforms/cell/spufs/Makefile
@@ -1,8 +1,9 @@
 
 obj-$(CONFIG_SPU_FS) += spufs.o
-spufs-y += inode.o file.o context.o syscalls.o coredump.o
+spufs-y += inode.o file.o context.o syscalls.o
 spufs-y += sched.o backing_ops.o hw_ops.o run.o gang.o
 spufs-y += switch.o fault.o lscsa_alloc.o
+spufs-$(CONFIG_COREDUMP) += coredump.o
 
 # magic for the trace events
 CFLAGS_sched.o := -I$(src)
diff --git a/arch/powerpc/platforms/cell/spufs/syscalls.c b/arch/powerpc/platforms/cell/spufs/syscalls.c
index b045fdda4845..a87200a535fa 100644
--- a/arch/powerpc/platforms/cell/spufs/syscalls.c
+++ b/arch/powerpc/platforms/cell/spufs/syscalls.c
@@ -79,8 +79,10 @@ static long do_spu_create(const char __user *pathname, unsigned int flags,
 struct spufs_calls spufs_calls = {
 	.create_thread = do_spu_create,
 	.spu_run = do_spu_run,
-	.coredump_extra_notes_size = spufs_coredump_extra_notes_size,
-	.coredump_extra_notes_write = spufs_coredump_extra_notes_write,
 	.notify_spus_active = do_notify_spus_active,
 	.owner = THIS_MODULE,
+#ifdef CONFIG_COREDUMP
+	.coredump_extra_notes_size = spufs_coredump_extra_notes_size,
+	.coredump_extra_notes_write = spufs_coredump_extra_notes_write,
+#endif
 };
-- 
1.9.1
