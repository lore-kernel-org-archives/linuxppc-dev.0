Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vYjQw1hbWzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 17:41:59 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel] powerpc/powernv: Fix clobbered MSR
Date: Thu,  2 Mar 2017 17:41:24 +1100
Message-Id: <20170302064124.26342-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If CONFIG_DEBUG_INFO_SPLIT is not set but CONFIG_DEBUG_INFO is,
the kernel makefile just adds "-g" and the scripts/gcc-goto.sh test for
the "asm goto ("" :::: entry)" support succedes and adds
-DCC_HAVE_ASM_GOTO to KBUILD_CFLAGS/KBUILD_AFLAGS. This effectively
makes OPAL_BRANCH() a noop (or something similar).

With CONFIG_DEBUG_INFO_SPLIT=y, the makefile adds "-gsplit-dwarf" which
somehow makes the scripts/gcc-goto.sh test fail and not have
CC_HAVE_ASM_GOTO defined so the alternative OPAL_BRANCH() is used
and this particular chunk clobbers r12 where the parenting code -
OPAL_CALL() - stores MSR; as the result, the kernel oops'es right after
early_setup() because of broken MSR.

This replaces r12 with r11 which is overwritten right after
OPAL_BRANCH(opal_tracepoint_entry) anyway.

I used gcc 5.4.1 20161205 built from sha1 ffadbf3ae29.

Fixes: ab9bad0ead9a ("powerpc/powernv: Remove separate entry for OPAL real mode calls")
Suggested-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/opal-wrappers.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 6693f75e93d1..da8a0f7a035c 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -39,8 +39,8 @@ opal_tracepoint_refcount:
 BEGIN_FTR_SECTION;						\
 	b	1f;						\
 END_FTR_SECTION(0, 1);						\
-	ld	r12,opal_tracepoint_refcount@toc(r2);		\
-	cmpdi	r12,0;						\
+	ld	r11,opal_tracepoint_refcount@toc(r2);		\
+	cmpdi	r11,0;						\
 	bne-	LABEL;						\
 1:
 
-- 
2.11.0
