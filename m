Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: remove unused variable in emulate_fp_pair
Date: Tue, 08 Jul 2008 18:53:03 +1000
Message-ID: <23807.1215507183@neuling.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

regs is not used in emulate_fp_pair so remove it.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
Benh: please add to your 2.6.27 tree

 arch/powerpc/kernel/align.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/align.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/align.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/align.c
@@ -363,8 +363,8 @@ static int emulate_multiple(struct pt_re
  * Only POWER6 has these instructions, and it does true little-endian,
  * so we don't need the address swizzling.
  */
-static int emulate_fp_pair(struct pt_regs *regs, unsigned char __user *addr,
-			   unsigned int reg, unsigned int flags)
+static int emulate_fp_pair(unsigned char __user *addr, unsigned int reg,
+			   unsigned int flags)
 {
 	char *ptr = (char *) &current->thread.TS_FPR(reg);
 	int i, ret;
@@ -759,7 +759,7 @@ int fix_alignment(struct pt_regs *regs)
 
 	/* Special case for 16-byte FP loads and stores */
 	if (nb == 16)
-		return emulate_fp_pair(regs, addr, reg, flags);
+		return emulate_fp_pair(addr, reg, flags);
 
 	/* If we are loading, get the data from user space, else
 	 * get it from register values
