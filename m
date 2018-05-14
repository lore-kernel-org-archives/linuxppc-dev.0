Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40l1912Q7yzF152
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 23:03:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: kernel-hardening@lists.openwall.com, thgarnie@google.com,
 keescook@chromium.org
Subject: [PATCH 1/2] powerpc: Rename thread_struct.fs to addr_limit
Date: Mon, 14 May 2018 23:03:15 +1000
Message-Id: <20180514130316.23855-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It's called 'fs' for historical reasons, it's named after the x86 'FS'
register. But we don't have to use that name for the member of
thread_struct, and in fact arch/x86 doesn't even call it 'fs' anymore.

So rename it to 'addr_limit', which better reflects what it's used
for, and is also the name used on other arches.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/processor.h | 6 +++---
 arch/powerpc/include/asm/uaccess.h   | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index b4778cfaad5b..07167c2d1825 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -264,7 +264,7 @@ struct thread_struct {
 	unsigned long	ksp_vsid;
 #endif
 	struct pt_regs	*regs;		/* Pointer to saved register state */
-	mm_segment_t	fs;		/* for get_fs() validation */
+	mm_segment_t	addr_limit;	/* for get_fs() validation */
 #ifdef CONFIG_BOOKE
 	/* BookE base exception scratch space; align on cacheline */
 	unsigned long	normsave[8] ____cacheline_aligned;
@@ -398,7 +398,7 @@ struct thread_struct {
 #define INIT_THREAD { \
 	.ksp = INIT_SP, \
 	.ksp_limit = INIT_SP_LIMIT, \
-	.fs = KERNEL_DS, \
+	.addr_limit = KERNEL_DS, \
 	.pgdir = swapper_pg_dir, \
 	.fpexc_mode = MSR_FE0 | MSR_FE1, \
 	SPEFSCR_INIT \
@@ -407,7 +407,7 @@ struct thread_struct {
 #define INIT_THREAD  { \
 	.ksp = INIT_SP, \
 	.regs = (struct pt_regs *)INIT_SP - 1, /* XXX bogus, I think */ \
-	.fs = KERNEL_DS, \
+	.addr_limit = KERNEL_DS, \
 	.fpexc_mode = 0, \
 	.ppr = INIT_PPR, \
 	.fscr = FSCR_TAR | FSCR_EBB \
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index a62ee663b2c8..a91cea15187b 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -30,8 +30,8 @@
 #endif
 
 #define get_ds()	(KERNEL_DS)
-#define get_fs()	(current->thread.fs)
-#define set_fs(val)	(current->thread.fs = (val))
+#define get_fs()	(current->thread.addr_limit)
+#define set_fs(val)	(current->thread.addr_limit = (val))
 
 #define segment_eq(a, b)	((a).seg == (b).seg)
 
-- 
2.14.1
