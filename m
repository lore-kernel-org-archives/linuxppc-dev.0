Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 10/20] powerpc/xmon: Factor out the oft-repeated setjmp logic
Date: Wed, 10 Oct 2012 01:20:37 +1100
Message-Id: <1349792447-15714-10-git-send-email-michael@ellerman.id.au>
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

We have over 15 routines that implement essentially the same logic
in terms of catching faults. Pull the logic out into two helper
routines.

The pattern becomes:

	if (start_bus_error_jump() == 0) {
		<do potentially faulting things>

		end_bus_error_jump();
	} else {
		printf("Faulting thing faulted!\n");
	}

Also move the globals next to the functions.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c |   33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 1f8d2f1..168c5e7 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -72,8 +72,6 @@ static unsigned long ncsum = 4096;
 static int termch;
 static char tmpstr[128];
 
-static long bus_error_jmp[JMP_BUF_LEN];
-static int catch_memory_errors;
 static long *xmon_fault_jmp[NR_CPUS];
 
 /* Breakpoint stuff */
@@ -636,6 +634,37 @@ static int xmon_ipi(struct pt_regs *regs)
 	return 0;
 }
 
+static long bus_error_jmp[JMP_BUF_LEN];
+static int catch_memory_errors;
+
+int start_bus_error_jump(void)
+{
+	int rc;
+
+	catch_memory_errors = 1;
+	sync();
+
+	rc = setjmp(bus_error_jmp);
+	if (rc)
+		catch_memory_errors = 0;
+
+	return rc;
+}
+
+void end_bus_error_jump(void)
+{
+	sync();
+
+	/* Wait a little while to see if we get a machine check */
+	__delay(200);
+
+	/*
+	 * We don't actually clear the jump buffer but setting
+	 * catch_memory_errors to zero means we'll no longer jump to it.
+	 */
+	catch_memory_errors = 0;
+}
+
 static int xmon_fault_handler(struct pt_regs *regs)
 {
 	struct bpt *bp;
-- 
1.7.9.5
