Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc/hw_brk: Fix setting of length for exact mode
 breakpoints
Date: Mon, 24 Jun 2013 15:47:22 +1000
Message-Id: <1372052843-19109-1-git-send-email-mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The smallest match region for both the DABR and DAWR is 8 bytes, so the
kernel needs to filter matches when users want to look at regions smaller than
this.

Currently we set the length of PPC_BREAKPOINT_MODE_EXACT breakpoints to 8.
This is wrong as in exact mode we should only match on 1 address, hence the
length should be 1.

This ensures that the kernel will filter out any exact mode hardware breakpoint
matches on any addresses other than the requested one.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Reported-by: Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org
---
 arch/powerpc/kernel/ptrace.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 98c2fc1..64f7bd5 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1449,7 +1449,9 @@ static long ppc_set_hwdebug(struct task_struct *child,
 	 */
 	if (bp_info->addr_mode == PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE) {
 		len = bp_info->addr2 - bp_info->addr;
-	} else if (bp_info->addr_mode != PPC_BREAKPOINT_MODE_EXACT) {
+	} else if (bp_info->addr_mode == PPC_BREAKPOINT_MODE_EXACT)
+		len = 1;
+	else {
 		ptrace_put_breakpoints(child);
 		return -EINVAL;
 	}
-- 
1.7.10.4
