Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: Add alignment handler for new lfiwzx instruction
Date: Fri, 20 Feb 2009 15:51:37 +1100
Message-ID: <29888.1235105497@neuling.org>
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

lfiwzx is a new floating point load instruction in 2.06 that needs an
alignment handler for Linux.  

Turns out to be the worlds easiest handler to add.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
Benh: this is for 2.6.30, but would be nice to be back in 2.6.27/28/29
too.

 arch/powerpc/kernel/align.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/align.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/align.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/align.c
@@ -187,7 +187,7 @@ static struct aligninfo aligninfo[128] =
 	{ 4, ST+F+S+U },	/* 11 1 1010: stfsux */
 	{ 8, ST+F+U },		/* 11 1 1011: stfdux */
 	INVALID,		/* 11 1 1100 */
-	INVALID,		/* 11 1 1101 */
+	{ 4, LD+F },		/* 11 1 1101: lfiwzx */
 	INVALID,		/* 11 1 1110 */
 	INVALID,		/* 11 1 1111 */
 };
