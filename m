Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 14/20] powerpc/xmon: Convert read/write_spr() to use
 start_bus_error_jump()
Date: Wed, 10 Oct 2012 01:20:41 +1100
Message-Id: <1349792447-15714-14-git-send-email-michael@ellerman.id.au>
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

read_spr() and write_spr() were both forgetting to clear catch_memory_errors,
that's fixed now that they use start/end_bus_error_jump().

Also drop the setting of n in both routines, it's never used.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c |   22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index ddae5cf..a8188f0 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1599,16 +1599,9 @@ read_spr(int n)
 	store_inst(instrs);
 	store_inst(instrs+1);
 
-	if (setjmp(bus_error_jmp) == 0) {
-		catch_memory_errors = 1;
-		sync();
-
+	if (start_bus_error_jump() == 0) {
 		ret = code();
-
-		sync();
-		/* wait a little while to see if we get a machine check */
-		__delay(200);
-		n = size;
+		end_bus_error_jump();
 	}
 
 	return ret;
@@ -1635,16 +1628,9 @@ write_spr(int n, unsigned long val)
 	store_inst(instrs);
 	store_inst(instrs+1);
 
-	if (setjmp(bus_error_jmp) == 0) {
-		catch_memory_errors = 1;
-		sync();
-
+	if (start_bus_error_jump() == 0) {
 		code(val);
-
-		sync();
-		/* wait a little while to see if we get a machine check */
-		__delay(200);
-		n = size;
+		end_bus_error_jump();
 	}
 }
 
-- 
1.7.9.5
