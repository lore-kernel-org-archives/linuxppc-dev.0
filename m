Return-Path: <arnd@arndb.de>
Message-Id: <20061127182429.882511000@arndb.de>
References: <20061127181851.796747000@arndb.de>
Date: Mon, 27 Nov 2006 19:18:53 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: [POWERPC 2/9] spufs: always send sigtrap on breakpoint
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, Ulrich Weigand <ulrich.weigand@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, we only send a sigtrap if the current task is being ptraced.
This is somewhat inconsistant, and it breaks utrace support in fedora.
Removing the check should do the right thing in all cases.

Cc: Ulrich Weigand <ulrich.weigand@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

diff --git a/arch/powerpc/platforms/cell/spufs/run.c b/arch/powerpc/platforms/cell/spufs/run.c
index 1be4e33..1acc2ff 100644
--- a/arch/powerpc/platforms/cell/spufs/run.c
+++ b/arch/powerpc/platforms/cell/spufs/run.c
@@ -350,12 +350,10 @@ out2:
 	       (status >> SPU_STOP_STATUS_SHIFT != 0x2104)))))
 		ret = status;
 
-	if (unlikely(current->ptrace & PT_PTRACED)) {
-		if ((status & SPU_STATUS_STOPPED_BY_STOP)
-		    && (status >> SPU_STOP_STATUS_SHIFT) == 0x3fff) {
-			force_sig(SIGTRAP, current);
-			ret = -ERESTARTSYS;
-		}
+	if ((status & SPU_STATUS_STOPPED_BY_STOP)
+	    && (status >> SPU_STOP_STATUS_SHIFT) == 0x3fff) {
+		force_sig(SIGTRAP, current);
+		ret = -ERESTARTSYS;
 	}
 
 out:

--
