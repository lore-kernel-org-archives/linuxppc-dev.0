Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 16/20] powerpc/xmon: Use start_bus_error_jump() in spu routines
Date: Wed, 10 Oct 2012 01:20:43 +1100
Message-Id: <1349792447-15714-16-git-send-email-michael@ellerman.id.au>
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

Moves the printfs & setting of stopped_ok out of the protected area.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c |   22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 0fefe03..abc89a4 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2994,15 +2994,11 @@ static void stop_spus(void)
 		if (!spu_info[i].spu)
 			continue;
 
-		if (setjmp(bus_error_jmp) != 0) {
-			catch_memory_errors = 0;
+		if (start_bus_error_jump() != 0) {
 			printf("*** Error stopping spu %.2d\n", i);
 			continue;
 		}
 
-		catch_memory_errors = 1;
-		sync();
-
 		spu = spu_info[i].spu;
 
 		spu_info[i].saved_spu_runcntl_RW =
@@ -3014,16 +3010,13 @@ static void stop_spus(void)
 		tmp &= ~MFC_STATE1_MASTER_RUN_CONTROL_MASK;
 		spu_mfc_sr1_set(spu, tmp);
 
-		sync();
-		__delay(200);
+		end_bus_error_jump();
 
 		spu_info[i].stopped_ok = 1;
 
 		printf("Stopped spu %.2d (was %s)\n", i,
 				spu_info[i].saved_spu_runcntl_RW ?
 				"running" : "stopped");
-
-		catch_memory_errors = 0;
 	}
 }
 
@@ -3042,26 +3035,19 @@ static void restart_spus(void)
 			continue;
 		}
 
-		if (setjmp(bus_error_jmp) != 0) {
-			catch_memory_errors = 0;
+		if (start_bus_error_jump() != 0) {
 			printf("*** Error restarting spu %.2d\n", i);
 			continue;
 		}
 
-		catch_memory_errors = 1;
-		sync();
-
 		spu = spu_info[i].spu;
 		spu_mfc_sr1_set(spu, spu_info[i].saved_mfc_sr1_RW);
 		out_be32(&spu->problem->spu_runcntl_RW,
 				spu_info[i].saved_spu_runcntl_RW);
 
-		sync();
-		__delay(200);
+		end_bus_error_jump();
 
 		printf("Restarted spu %.2d\n", i);
-
-		catch_memory_errors = 0;
 	}
 }
 
-- 
1.7.9.5
