Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: fix VSX alignment handler for regs 32-63
Date: Fri, 13 Feb 2009 16:08:58 +1100
Message-ID: <1803.1234501738@neuling.org>
Sender: mikey@neuling.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix the VSX alignment handler for VSX registers > 32.  32-63 are stored
in the VMX part of the thread_struct not the FPR part.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/align.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/align.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/align.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/align.c
@@ -646,11 +646,16 @@ static int emulate_vsx(unsigned char __u
 		       unsigned int areg, struct pt_regs *regs,
 		       unsigned int flags, unsigned int length)
 {
-	char *ptr = (char *) &current->thread.TS_FPR(reg);
+	char *ptr;
 	int ret = 0;
 
 	flush_vsx_to_thread(current);
 
+	if (reg < 32)
+		ptr = (char *) &current->thread.TS_FPR(reg);
+	else
+		ptr = (char *) &current->thread.vr[reg - 32];
+
 	if (flags & ST)
 		ret = __copy_to_user(addr, ptr, length);
         else {
