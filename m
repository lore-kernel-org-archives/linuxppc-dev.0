Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 03 Nov 2006 18:28:54 +1100
Subject: [PATCH 2/3] Show state of spus as they're stopped in Cell xmon helper
In-Reply-To: <1162538933.650101.682761686374.qpush@cradle>
Message-Id: <20061103072854.7239067CA6@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

After stopping spus in xmon I often find myself trawling through the
field dumps to find out which spus were running. The spu stopping
code actually knows what's running, so let's print it out to save
the user some futzing.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
 arch/powerpc/xmon/xmon.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: cell/arch/powerpc/xmon/xmon.c
===================================================================
--- cell.orig/arch/powerpc/xmon/xmon.c
+++ cell/arch/powerpc/xmon/xmon.c
@@ -2700,7 +2700,10 @@ static void stop_spus(void)
 			__delay(200);
 
 			spu_info[i].stopped_ok = 1;
-			printf("Stopped spu %.2d\n", i);
+
+			printf("Stopped spu %.2d (was %s)\n", i,
+					spu_info[i].saved_spu_runcntl_RW ?
+					"running" : "stopped");
 		} else {
 			catch_memory_errors = 0;
 			printf("*** Error stopping spu %.2d\n", i);
