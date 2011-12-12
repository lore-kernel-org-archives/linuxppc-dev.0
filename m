Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0BEB1B70C1
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Dec 2011 19:51:41 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/4] ppc32/kprobe: introduce copy_exc_stack
Date: Mon, 12 Dec 2011 16:50:51 +0800
Message-ID: <1323679853-31751-3-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1323679853-31751-1-git-send-email-tiejun.chen@windriver.com>
References: <1323679853-31751-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need a copy mechanism to migrate exception stack. But looks copy_page()
already implement this well so we can complete copy_exc_stack() based on
that directly.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/include/asm/page_32.h |    1 +
 arch/powerpc/kernel/misc_32.S      |   16 +++++++++++++++-
 arch/powerpc/kernel/ppc_ksyms.c    |    1 +
 3 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/page_32.h b/arch/powerpc/include/asm/page_32.h
index 68d73b2..2c1fd84 100644
--- a/arch/powerpc/include/asm/page_32.h
+++ b/arch/powerpc/include/asm/page_32.h
@@ -40,6 +40,7 @@ struct page;
 extern void clear_pages(void *page, int order);
 static inline void clear_page(void *page) { clear_pages(page, 0); }
 extern void copy_page(void *to, void *from);
+extern void copy_exc_stack(void *to, void *from);
 
 #include <asm-generic/getorder.h>
 
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 998a100..aa02545 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -527,7 +527,7 @@ _GLOBAL(clear_pages)
 	stw	r8,12(r3);	\
 	stwu	r9,16(r3)
 
-_GLOBAL(copy_page)
+ready_copy:
 	addi	r3,r3,-4
 	addi	r4,r4,-4
 
@@ -544,7 +544,21 @@ _GLOBAL(copy_page)
 	dcbt	r5,r4
 	li	r11,L1_CACHE_BYTES+4
 #endif /* MAX_COPY_PREFETCH */
+	blr
+
+_GLOBAL(copy_exc_stack)
+	mflr	r12
+	bl	ready_copy
+	mtlr	r12
+	li	r0,INT_FRAME_SIZE/L1_CACHE_BYTES - MAX_COPY_PREFETCH
+	b	go_copy
+
+_GLOBAL(copy_page)
+	mflr	r12
+	bl	ready_copy
+	mtlr	r12
 	li	r0,PAGE_SIZE/L1_CACHE_BYTES - MAX_COPY_PREFETCH
+go_copy:
 	crclr	4*cr0+eq
 2:
 	mtctr	r0
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index f5ae872..2223daf 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -88,6 +88,7 @@ EXPORT_SYMBOL(__clear_user);
 EXPORT_SYMBOL(__strncpy_from_user);
 EXPORT_SYMBOL(__strnlen_user);
 EXPORT_SYMBOL(copy_page);
+EXPORT_SYMBOL(copy_exc_stack);
 
 #if defined(CONFIG_PCI) && defined(CONFIG_PPC32)
 EXPORT_SYMBOL(isa_io_base);
-- 
1.5.6
