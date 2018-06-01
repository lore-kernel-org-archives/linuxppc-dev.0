Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y80R1jRwzF0dl
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 01:49:43 +1000 (AEST)
Message-Id: <b6f7afcf87f6a001d9653dea934ce34b97002073.1527868006.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1527868006.git.christophe.leroy@c-s.fr>
References: <cover.1527868006.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 07/14] powerpc: remove superflous inclusions of
 asm/fixmap.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  1 Jun 2018 15:49:39 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Files not using fixmap consts or functions don't need asm/fixmap.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/fixmap.h    | 2 --
 arch/powerpc/kernel/head_8xx.S       | 1 -
 arch/powerpc/mm/dump_hashpagetable.c | 1 -
 arch/powerpc/sysdev/cpm_common.c     | 1 -
 4 files changed, 5 deletions(-)

diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
index 6c40dfda5912..40efdf1d2d6e 100644
--- a/arch/powerpc/include/asm/fixmap.h
+++ b/arch/powerpc/include/asm/fixmap.h
@@ -15,9 +15,7 @@
 #define _ASM_FIXMAP_H
 
 #ifndef __ASSEMBLY__
-#include <linux/kernel.h>
 #include <asm/page.h>
-#include <asm/pgtable.h>
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
 #include <asm/kmap_types.h>
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 6cab07e76732..95f6bdc0718f 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -30,7 +30,6 @@
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
-#include <asm/fixmap.h>
 #include <asm/export.h>
 
 #if CONFIG_TASK_SIZE <= 0x80000000 && CONFIG_PAGE_OFFSET >= 0x80000000
diff --git a/arch/powerpc/mm/dump_hashpagetable.c b/arch/powerpc/mm/dump_hashpagetable.c
index 14cfb11b09d0..ddffb1513ddc 100644
--- a/arch/powerpc/mm/dump_hashpagetable.c
+++ b/arch/powerpc/mm/dump_hashpagetable.c
@@ -19,7 +19,6 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
-#include <asm/fixmap.h>
 #include <asm/pgtable.h>
 #include <linux/const.h>
 #include <asm/page.h>
diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
index b74508175b67..010975c3422f 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -28,7 +28,6 @@
 #include <asm/udbg.h>
 #include <asm/io.h>
 #include <asm/cpm.h>
-#include <asm/fixmap.h>
 #include <soc/fsl/qe/qe.h>
 
 #include <mm/mmu_decl.h>
-- 
2.13.3
