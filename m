Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 11/20] powerpc/xmon: Move handle_fault() next to related
 routines
Date: Wed, 10 Oct 2012 01:20:38 +1100
Message-Id: <1349792447-15714-11-git-send-email-michael@ellerman.id.au>
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

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c |   48 +++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 168c5e7..65c3d22 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -665,6 +665,30 @@ void end_bus_error_jump(void)
 	catch_memory_errors = 0;
 }
 
+static int fault_type;
+static int fault_except;
+static char *fault_chars[] = { "--", "**", "##" };
+
+static int handle_fault(struct pt_regs *regs)
+{
+	fault_except = TRAP(regs);
+	switch (TRAP(regs)) {
+	case 0x200:
+		fault_type = 0;
+		break;
+	case 0x300:
+	case 0x380:
+		fault_type = 1;
+		break;
+	default:
+		fault_type = 2;
+	}
+
+	longjmp(bus_error_jmp, 1);
+
+	return 0;
+}
+
 static int xmon_fault_handler(struct pt_regs *regs)
 {
 	struct bpt *bp;
@@ -1755,30 +1779,6 @@ mwrite(unsigned long adrs, void *buf, int size)
 	return n;
 }
 
-static int fault_type;
-static int fault_except;
-static char *fault_chars[] = { "--", "**", "##" };
-
-static int handle_fault(struct pt_regs *regs)
-{
-	fault_except = TRAP(regs);
-	switch (TRAP(regs)) {
-	case 0x200:
-		fault_type = 0;
-		break;
-	case 0x300:
-	case 0x380:
-		fault_type = 1;
-		break;
-	default:
-		fault_type = 2;
-	}
-
-	longjmp(bus_error_jmp, 1);
-
-	return 0;
-}
-
 #define SWAP(a, b, t)	((t) = (a), (a) = (b), (b) = (t))
 
 static void
-- 
1.7.9.5
