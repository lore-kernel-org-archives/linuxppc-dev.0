Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: paulus@samba.org, benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: fix uninitialised variable in VSX alignment code
Date: Thu, 28 Aug 2008 14:57:39 +1000
Message-ID: <5821.1219899459@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This fixes an uninitialised variable in the VSX alignment code.  It can
cause warnings from GCC (noticed with GCC 4.1.1).

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
paulus: for your 2.6.27 tree.

Kudos to paulus for finding this.

 arch/powerpc/kernel/align.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/align.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/align.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/align.c
@@ -647,7 +647,7 @@ static int emulate_vsx(unsigned char __u
 		       unsigned int flags, unsigned int length)
 {
 	char *ptr = (char *) &current->thread.TS_FPR(reg);
-	int ret;
+	int ret = 0;
 
 	flush_vsx_to_thread(current);
