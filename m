Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 09/20] powerpc/xmon: Fiddle xmon_depth_to_print logic in
 xmon_show_stack()
Date: Wed, 10 Oct 2012 01:20:36 +1100
Message-Id: <1349792447-15714-9-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1349792447-15714-1-git-send-email-michael@ellerman.id.au>
References: <1349792447-15714-1-git-send-email-michael@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently xmon_depth_to_print is static and global, but it's only
ever used in xmon_show_stack().

At least with a modern compiler it's inlined, so there's no point
in it being static, we could #define it but it's only used in one
place.

By reworking the logic we can drop count and just decrement the
max value as a loop counter. Also switch to a while loop so we
actually print no more than 64 frames as you'd expect based on the
variable name.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index d940234..1f8d2f1 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1281,21 +1281,19 @@ static void get_function_bounds(unsigned long pc, unsigned long *startp,
 	catch_memory_errors = 0;
 }
 
-static int xmon_depth_to_print = 64;
-
 #define LRSAVE_OFFSET		(STACK_FRAME_LR_SAVE * sizeof(unsigned long))
 #define MARKER_OFFSET		(STACK_FRAME_MARKER * sizeof(unsigned long))
 
 static void xmon_show_stack(unsigned long sp, unsigned long lr,
 			    unsigned long pc)
 {
+	int max_to_print = 64;
 	unsigned long ip;
 	unsigned long newsp;
 	unsigned long marker;
-	int count = 0;
 	struct pt_regs regs;
 
-	do {
+	while (max_to_print--) {
 		if (sp < PAGE_OFFSET) {
 			if (sp != 0)
 				printf("SP (%lx) is in userspace\n", sp);
@@ -1366,7 +1364,7 @@ static void xmon_show_stack(unsigned long sp, unsigned long lr,
 			break;
 
 		sp = newsp;
-	} while (count++ < xmon_depth_to_print);
+	}
 }
 
 static void backtrace(struct pt_regs *excp)
-- 
1.7.9.5
