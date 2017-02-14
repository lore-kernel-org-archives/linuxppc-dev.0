Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMsFK5VM3zDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 16:59:33 +1100 (AEDT)
Date: Tue, 14 Feb 2017 16:59:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Anju T
 <anju@linux.vnet.ibm.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20170214165933.13ebd4f4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andrew,

After merging the akpm-current tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

arch/powerpc/lib/code-patching.c:61:16: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'is_conditional_branch'
 bool __kprobes is_conditional_branch(unsigned int instr)
                ^

Caused by commit

  916c821aaf13 ("kprobes: move kprobe declarations to asm-generic/kprobes.h")

interacting with commit

  51c9c0843993 ("powerpc/kprobes: Implement Optprobes")

from the powerpc tree.

I have applied this merge fix patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 14 Feb 2017 16:56:11 +1100
Subject: [PATCH] powerpc/kprobes: fixup for kprobes declarations moving

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/lib/code-patching.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 0899315e1434..0d3002b7e2b4 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -14,6 +14,7 @@
 #include <asm/page.h>
 #include <asm/code-patching.h>
 #include <linux/uaccess.h>
+#include <linux/kprobes.h>
 
 
 int patch_instruction(unsigned int *addr, unsigned int instr)
-- 
2.10.2

-- 
Cheers,
Stephen Rothwell
