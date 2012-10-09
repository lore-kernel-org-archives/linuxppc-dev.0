Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 08/20] powerpc/xmon: Use STACK_FRAME_OVERHEAD in
 xmon_show_stack()
Date: Wed, 10 Oct 2012 01:20:35 +1100
Message-Id: <1349792447-15714-8-git-send-email-michael@ellerman.id.au>
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

We use STACK_FRAME_OVERHEAD in the exception vectors to establish
the exception frame, so it should be good enough to use here.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index abf6be4..d940234 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1286,12 +1286,6 @@ static int xmon_depth_to_print = 64;
 #define LRSAVE_OFFSET		(STACK_FRAME_LR_SAVE * sizeof(unsigned long))
 #define MARKER_OFFSET		(STACK_FRAME_MARKER * sizeof(unsigned long))
 
-#ifdef __powerpc64__
-#define REGS_OFFSET		0x70
-#else
-#define REGS_OFFSET		16
-#endif
-
 static void xmon_show_stack(unsigned long sp, unsigned long lr,
 			    unsigned long pc)
 {
@@ -1355,10 +1349,10 @@ static void xmon_show_stack(unsigned long sp, unsigned long lr,
 		   an exception frame. */
 		if (mread(sp + MARKER_OFFSET, &marker, sizeof(unsigned long))
 		    && marker == STACK_FRAME_REGS_MARKER) {
-			if (mread(sp + REGS_OFFSET, &regs, sizeof(regs))
+			if (mread(sp + STACK_FRAME_OVERHEAD, &regs, sizeof(regs))
 			    != sizeof(regs)) {
 				printf("Couldn't read registers at %lx\n",
-				       sp + REGS_OFFSET);
+				       sp + STACK_FRAME_OVERHEAD);
 				break;
 			}
 			printf("--- Exception: %lx %s at ", regs.trap,
-- 
1.7.9.5
