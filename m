Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9015D1A078B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jan 2015 21:20:32 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mmarek@suse.cz, akpm@linux-foundation.org, jbaron@akamai.com,
 peterz@infradead.org, liuj97@gmail.com, mingo@kernel.org, mgorman@suse.de
Subject: [PATCH 2/2] powerpc: Include linux/jump_label.h to get
 HAVE_JUMP_LABEL define
Date: Tue,  6 Jan 2015 21:20:28 +1100
Message-Id: <1420539628-17875-2-git-send-email-anton@samba.org>
In-Reply-To: <1420539628-17875-1-git-send-email-anton@samba.org>
References: <1420539628-17875-1-git-send-email-anton@samba.org>
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
 arch/powerpc/platforms/pseries/hvCall.S | 2 +-
 arch/powerpc/platforms/pseries/lpar.c   | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

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
index 469751d..14ac1ad 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -27,6 +27,7 @@
 #include <linux/console.h>
 #include <linux/export.h>
 #include <linux/static_key.h>
+#include <linux/jump_label.h>
 #include <asm/processor.h>
 #include <asm/mmu.h>
 #include <asm/page.h>
-- 
2.1.0
