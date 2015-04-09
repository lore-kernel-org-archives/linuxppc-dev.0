Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA18D1A0C77
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 13:51:38 +1000 (AEST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mmarek@suse.cz, akpm@linux-foundation.org, jbaron@akamai.com,
 peterz@infradead.org, liuj97@gmail.com, mingo@kernel.org, mgorman@suse.de,
 linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com,
 ralf@linux-mips.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
 davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
 rostedt@goodmis.org
Subject: [PATCH 3/3] powerpc: Include linux/jump_label.h to get
 HAVE_JUMP_LABEL define
Date: Thu,  9 Apr 2015 13:51:32 +1000
Message-Id: <1428551492-21977-3-git-send-email-anton@samba.org>
In-Reply-To: <1428551492-21977-1-git-send-email-anton@samba.org>
References: <1428551492-21977-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 1bc9e47aa8e4 ("powerpc/jump_label: Use HAVE_JUMP_LABEL")
converted uses of CONFIG_JUMP_LABEL to HAVE_JUMP_LABEL in
some assembly files.

HAVE_JUMP_LABEL is defined in linux/jump_label.h, so we need to
include this or we always get the non jump label fallback code.

Fixes: 1bc9e47aa8e4 ("powerpc/jump_label: Use HAVE_JUMP_LABEL")
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/platforms/powernv/opal-wrappers.S | 2 +-
 arch/powerpc/platforms/pseries/hvCall.S        | 2 +-
 arch/powerpc/platforms/pseries/lpar.c          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index b23fe7c..4c4fe6f 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -9,11 +9,11 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#include <linux/jump_label.h>
 #include <asm/ppc_asm.h>
 #include <asm/hvcall.h>
 #include <asm/asm-offsets.h>
 #include <asm/opal.h>
-#include <asm/jump_label.h>
 
 	.section	".text"
 
diff --git a/arch/powerpc/platforms/pseries/hvCall.S b/arch/powerpc/platforms/pseries/hvCall.S
index ccd53f9..74b5b8e 100644
--- a/arch/powerpc/platforms/pseries/hvCall.S
+++ b/arch/powerpc/platforms/pseries/hvCall.S
@@ -7,12 +7,12 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
+#include <linux/jump_label.h>
 #include <asm/hvcall.h>
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
-#include <asm/jump_label.h>
 
 	.section	".text"
 	
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index b5682fd..b7a67e3 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -26,7 +26,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/console.h>
 #include <linux/export.h>
-#include <linux/static_key.h>
+#include <linux/jump_label.h>
 #include <asm/processor.h>
 #include <asm/mmu.h>
 #include <asm/page.h>
-- 
2.1.0
