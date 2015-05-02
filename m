Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 307B71A001E
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 May 2015 05:35:21 +1000 (AEST)
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3.19 118/177] powerpc,
 jump_label: Include linux/jump_label.h to get HAVE_JUMP_LABEL define
Date: Sat,  2 May 2015 21:02:20 +0200
Message-Id: <20150502190125.524876055@linuxfoundation.org>
In-Reply-To: <20150502190119.666291882@linuxfoundation.org>
References: <20150502190119.666291882@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 heiko.carstens@de.ibm.com, paulus@samba.org, stable@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, linux@arm.linux.org.uk,
 Linus Torvalds <torvalds@linux-foundation.org>, mgorman@suse.de,
 catalin.marinas@arm.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 liuj97@gmail.com, will.deacon@arm.com, rostedt@goodmis.org, jbaron@akamai.com,
 Anton Blanchard <anton@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 mmarek@suse.cz, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 ralf@linux-mips.org, schwidefsky@de.ibm.com,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

3.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anton Blanchard <anton@samba.org>

commit 58995a9a5b292458f94a2356b8c878230fa56fe0 upstream.

Commit 1bc9e47aa8e4 ("powerpc/jump_label: Use HAVE_JUMP_LABEL")
converted uses of CONFIG_JUMP_LABEL to HAVE_JUMP_LABEL in
some assembly files.

HAVE_JUMP_LABEL is defined in linux/jump_label.h, so we need to
include this or we always get the non jump label fallback code.

Signed-off-by: Anton Blanchard <anton@samba.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: benh@kernel.crashing.org
Cc: catalin.marinas@arm.com
Cc: davem@davemloft.net
Cc: heiko.carstens@de.ibm.com
Cc: jbaron@akamai.com
Cc: linux@arm.linux.org.uk
Cc: linuxppc-dev@lists.ozlabs.org
Cc: liuj97@gmail.com
Cc: mgorman@suse.de
Cc: mmarek@suse.cz
Cc: paulus@samba.org
Cc: ralf@linux-mips.org
Cc: rostedt@goodmis.org
Cc: schwidefsky@de.ibm.com
Cc: will.deacon@arm.com
Fixes: 1bc9e47aa8e4 ("powerpc/jump_label: Use HAVE_JUMP_LABEL")
Link: http://lkml.kernel.org/r/1428551492-21977-3-git-send-email-anton@samba.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/opal-wrappers.S |    2 +-
 arch/powerpc/platforms/pseries/hvCall.S        |    2 +-
 arch/powerpc/platforms/pseries/lpar.c          |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

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
