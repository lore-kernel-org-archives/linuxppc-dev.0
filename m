Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 15/20] powerpc/xmon: Deindent stop/restart_spus()
Date: Wed, 10 Oct 2012 01:20:42 +1100
Message-Id: <1349792447-15714-15-git-send-email-michael@ellerman.id.au>
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

Should be no logic change, use continue to avoid an indent.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c |   72 ++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index a8188f0..0fefe03 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2994,33 +2994,35 @@ static void stop_spus(void)
 		if (!spu_info[i].spu)
 			continue;
 
-		if (setjmp(bus_error_jmp) == 0) {
-			catch_memory_errors = 1;
-			sync();
+		if (setjmp(bus_error_jmp) != 0) {
+			catch_memory_errors = 0;
+			printf("*** Error stopping spu %.2d\n", i);
+			continue;
+		}
 
-			spu = spu_info[i].spu;
+		catch_memory_errors = 1;
+		sync();
 
-			spu_info[i].saved_spu_runcntl_RW =
-				in_be32(&spu->problem->spu_runcntl_RW);
+		spu = spu_info[i].spu;
 
-			tmp = spu_mfc_sr1_get(spu);
-			spu_info[i].saved_mfc_sr1_RW = tmp;
+		spu_info[i].saved_spu_runcntl_RW =
+			in_be32(&spu->problem->spu_runcntl_RW);
 
-			tmp &= ~MFC_STATE1_MASTER_RUN_CONTROL_MASK;
-			spu_mfc_sr1_set(spu, tmp);
+		tmp = spu_mfc_sr1_get(spu);
+		spu_info[i].saved_mfc_sr1_RW = tmp;
 
-			sync();
-			__delay(200);
+		tmp &= ~MFC_STATE1_MASTER_RUN_CONTROL_MASK;
+		spu_mfc_sr1_set(spu, tmp);
 
-			spu_info[i].stopped_ok = 1;
+		sync();
+		__delay(200);
+
+		spu_info[i].stopped_ok = 1;
+
+		printf("Stopped spu %.2d (was %s)\n", i,
+				spu_info[i].saved_spu_runcntl_RW ?
+				"running" : "stopped");
 
-			printf("Stopped spu %.2d (was %s)\n", i,
-					spu_info[i].saved_spu_runcntl_RW ?
-					"running" : "stopped");
-		} else {
-			catch_memory_errors = 0;
-			printf("*** Error stopping spu %.2d\n", i);
-		}
 		catch_memory_errors = 0;
 	}
 }
@@ -3040,23 +3042,25 @@ static void restart_spus(void)
 			continue;
 		}
 
-		if (setjmp(bus_error_jmp) == 0) {
-			catch_memory_errors = 1;
-			sync();
-
-			spu = spu_info[i].spu;
-			spu_mfc_sr1_set(spu, spu_info[i].saved_mfc_sr1_RW);
-			out_be32(&spu->problem->spu_runcntl_RW,
-					spu_info[i].saved_spu_runcntl_RW);
-
-			sync();
-			__delay(200);
-
-			printf("Restarted spu %.2d\n", i);
-		} else {
+		if (setjmp(bus_error_jmp) != 0) {
 			catch_memory_errors = 0;
 			printf("*** Error restarting spu %.2d\n", i);
+			continue;
 		}
+
+		catch_memory_errors = 1;
+		sync();
+
+		spu = spu_info[i].spu;
+		spu_mfc_sr1_set(spu, spu_info[i].saved_mfc_sr1_RW);
+		out_be32(&spu->problem->spu_runcntl_RW,
+				spu_info[i].saved_spu_runcntl_RW);
+
+		sync();
+		__delay(200);
+
+		printf("Restarted spu %.2d\n", i);
+
 		catch_memory_errors = 0;
 	}
 }
-- 
1.7.9.5
