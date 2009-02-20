Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: Fix load/store float double alignment handler
Date: Fri, 20 Feb 2009 15:52:20 +1100
Message-ID: <29990.1235105540@neuling.org>
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

When we introduced VSX, we changed the way FPRs are stored in the
thread_struct.  Unfortunately we missed the load/store float double
alignment handler code when updating how we access FPRs in the
thread_struct. 

Below fixes this and merges the little/big endian case.  

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
benh: this needs to go into 27,28 and 29.  Sorry :-)

 arch/powerpc/kernel/align.c |   29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

Index: linux-bml/arch/powerpc/kernel/align.c
===================================================================
--- linux-bml.orig/arch/powerpc/kernel/align.c
+++ linux-bml/arch/powerpc/kernel/align.c
@@ -367,27 +367,24 @@ static int emulate_multiple(struct pt_re
 static int emulate_fp_pair(unsigned char __user *addr, unsigned int reg,
 			   unsigned int flags)
 {
-	char *ptr = (char *) &current->thread.TS_FPR(reg);
-	int i, ret;
+	char *ptr0 = (char *) &current->thread.TS_FPR(reg);
+	char *ptr1 = (char *) &current->thread.TS_FPR(reg+1);
+	int i, ret, sw = 0;
 
 	if (!(flags & F))
 		return 0;
 	if (reg & 1)
 		return 0;	/* invalid form: FRS/FRT must be even */
-	if (!(flags & SW)) {
-		/* not byte-swapped - easy */
-		if (!(flags & ST))
-			ret = __copy_from_user(ptr, addr, 16);
-		else
-			ret = __copy_to_user(addr, ptr, 16);
-	} else {
-		/* each FPR value is byte-swapped separately */
-		ret = 0;
-		for (i = 0; i < 16; ++i) {
-			if (!(flags & ST))
-				ret |= __get_user(ptr[i^7], addr + i);
-			else
-				ret |= __put_user(ptr[i^7], addr + i);
+	if (flags & SW)
+		sw = 7;
+	ret = 0;
+	for (i = 0; i < 8; ++i) {
+		if (!(flags & ST)) {
+			ret |= __get_user(ptr0[i^sw], addr + i);
+			ret |= __get_user(ptr1[i^sw], addr + i + 8);
+		} else {
+			ret |= __put_user(ptr0[i^sw], addr + i);
+			ret |= __put_user(ptr1[i^sw], addr + i + 8);
 		}
 	}
 	if (ret)
