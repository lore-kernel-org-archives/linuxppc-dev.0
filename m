Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 426JfF2TbGzF35s
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2018 23:47:33 +1000 (AEST)
Message-Id: <113d4a559f6eec448b253bf5f0b4f2a8ffb187af.1536327756.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 1/3] powerpc/process: fix casting and missing header
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 muriloo@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  7 Sep 2018 13:47:29 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes the following warnings. The first ones are leftovers
from when __get_user() was replaced by probe_kernel_address().

The last one is from when show_user_instructions() was added.

arch/powerpc/kernel/process.c:1287:22: warning: incorrect type in argument 2 (different address spaces)
arch/powerpc/kernel/process.c:1287:22:    expected void const *src
arch/powerpc/kernel/process.c:1287:22:    got unsigned int [noderef] <asn:1>*<noident>
arch/powerpc/kernel/process.c:1319:21: warning: incorrect type in argument 2 (different address spaces)
arch/powerpc/kernel/process.c:1319:21:    expected void const *src
arch/powerpc/kernel/process.c:1319:21:    got unsigned int [noderef] <asn:1>*<noident>
arch/powerpc/kernel/process.c:1302:6: warning: symbol 'show_user_instructions' was not declared. Should it be static?

Fixes: 7b051f665c32d ("powerpc: Use probe_kernel_address in show_instructions")
Fixes: 88b0fe1757359 ("powerpc: Add show_user_instructions()")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v3: new in v3 to fix sparse warnings reported by snowpatch on the serie

 arch/powerpc/kernel/process.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 913c5725cdb2..e108e1ef2b85 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -65,6 +65,7 @@
 #include <asm/livepatch.h>
 #include <asm/cpu_has_feature.h>
 #include <asm/asm-prototypes.h>
+#include <asm/stacktrace.h>
 
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
@@ -1284,7 +1285,7 @@ static void show_instructions(struct pt_regs *regs)
 #endif
 
 		if (!__kernel_text_address(pc) ||
-		     probe_kernel_address((unsigned int __user *)pc, instr)) {
+		    probe_kernel_address((const void *)pc, instr)) {
 			pr_cont("XXXXXXXX ");
 		} else {
 			if (regs->nip == pc)
@@ -1316,7 +1317,7 @@ void show_user_instructions(struct pt_regs *regs)
 			pr_info("%s[%d]: code: ", current->comm, current->pid);
 		}
 
-		if (probe_kernel_address((unsigned int __user *)pc, instr)) {
+		if (probe_kernel_address((const void *)pc, instr)) {
 			pr_cont("XXXXXXXX ");
 		} else {
 			if (regs->nip == pc)
-- 
2.13.3
