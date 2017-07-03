Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1S2j6jyqzDr5y
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 23:02:05 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v6 07/10] powerpc/vmlinux.lds: Align __init_begin to 16M
Date: Mon,  3 Jul 2017 23:01:51 +1000
Message-Id: <1499086914-25695-7-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1499086914-25695-1-git-send-email-mpe@ellerman.id.au>
References: <1499086914-25695-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Balbir Singh <bsingharora@gmail.com>

For CONFIG_STRICT_KERNEL_RWX align __init_begin to 16M. We use 16M
since its the larger of 2M on radix and 16M on hash for our linear
mapping. The plan is to have .text, .rodata and everything upto
__init_begin marked as RX. Note we still have executable read only
data. We could further align rodata to another 16M boundary. I've used
keeping text plus rodata as read-only-executable as a trade-off to
doing read-only-executable for text and read-only for rodata.

We don't use multi PT_LOAD in PHDRS because we are not sure if all
bootloaders support them. This patch keeps PHDRS in vmlinux.lds.S as
the same they are with just one PT_LOAD for all of the kernel marked
as RWX (7).

mpe: What this means is the added alignment bloats the resulting
binary on disk, a powernv kernel goes from 17M to 22M.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/vmlinux.lds.S | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index ace6b6579961..b1a250560198 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -8,6 +8,12 @@
 #include <asm/cache.h>
 #include <asm/thread_info.h>
 
+#ifdef CONFIG_STRICT_KERNEL_RWX
+#define STRICT_ALIGN_SIZE	(1 << 24)
+#else
+#define STRICT_ALIGN_SIZE	PAGE_SIZE
+#endif
+
 ENTRY(_stext)
 
 PHDRS {
@@ -123,7 +129,7 @@ SECTIONS
 	PROVIDE32 (etext = .);
 
 	/* Read-only data */
-	RODATA
+	RO_DATA(PAGE_SIZE)
 
 	EXCEPTION_TABLE(0)
 
@@ -140,7 +146,7 @@ SECTIONS
 /*
  * Init sections discarded at runtime
  */
-	. = ALIGN(PAGE_SIZE);
+	. = ALIGN(STRICT_ALIGN_SIZE);
 	__init_begin = .;
 	INIT_TEXT_SECTION(PAGE_SIZE) :kernel
 
-- 
2.7.4
