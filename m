Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <dbbd10ea7560c312f6c9402f63dd030c1bf6e8ab.1208505275.git.michael@ellerman.id.au>
In-Reply-To: <fbb91d0892c720d6f28501e1830028c78eb6664f.1208505275.git.michael@ellerman.id.au>
References: <fbb91d0892c720d6f28501e1830028c78eb6664f.1208505275.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 10/11] Convert from DEBUG() to pr_debug() in
	platforms/pseries/scanlog.c
Date: Fri, 18 Apr 2008 17:54:44 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

While we're at it, remove the hand-rolled runtime debugging support
in there. This file has been largely unchanged for eons, if we need to
debug it in future we can recompile.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/scanlog.c |   23 ++++++++---------------
 1 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/scanlog.c b/arch/powerpc/platforms/pseries/scanlog.c
index e5b0ea8..bec3803 100644
--- a/arch/powerpc/platforms/pseries/scanlog.c
+++ b/arch/powerpc/platforms/pseries/scanlog.c
@@ -38,9 +38,7 @@
 #define SCANLOG_HWERROR -1
 #define SCANLOG_CONTINUE 1
 
-#define DEBUG(A...) do { if (scanlog_debug) printk(KERN_ERR "scanlog: " A); } while (0)
 
-static int scanlog_debug;
 static unsigned int ibm_scan_log_dump;			/* RTAS token */
 static struct proc_dir_entry *proc_ppc64_scan_log_dump;	/* The proc file */
 
@@ -86,14 +84,14 @@ static ssize_t scanlog_read(struct file *file, char __user *buf,
 		memcpy(data, rtas_data_buf, RTAS_DATA_BUF_SIZE);
 		spin_unlock(&rtas_data_buf_lock);
 
-		DEBUG("status=%d, data[0]=%x, data[1]=%x, data[2]=%x\n",
-		      status, data[0], data[1], data[2]);
+		pr_debug("scanlog: status=%d, data[0]=%x, data[1]=%x, " \
+			 "data[2]=%x\n", status, data[0], data[1], data[2]);
 		switch (status) {
 		    case SCANLOG_COMPLETE:
-			DEBUG("hit eof\n");
+			pr_debug("scanlog: hit eof\n");
 			return 0;
 		    case SCANLOG_HWERROR:
-			DEBUG("hardware error reading scan log data\n");
+			pr_debug("scanlog: hardware error reading data\n");
 			return -EIO;
 		    case SCANLOG_CONTINUE:
 			/* We may or may not have data yet */
@@ -110,7 +108,8 @@ static ssize_t scanlog_read(struct file *file, char __user *buf,
 			/* Assume extended busy */
 			wait_time = rtas_busy_delay_time(status);
 			if (!wait_time) {
-				printk(KERN_ERR "scanlog: unknown error from rtas: %d\n", status);
+				printk(KERN_ERR "scanlog: unknown error " \
+				       "from rtas: %d\n", status);
 				return -EIO;
 			}
 		}
@@ -134,15 +133,9 @@ static ssize_t scanlog_write(struct file * file, const char __user * buf,
 
 	if (buf) {
 		if (strncmp(stkbuf, "reset", 5) == 0) {
-			DEBUG("reset scanlog\n");
+			pr_debug("scanlog: reset scanlog\n");
 			status = rtas_call(ibm_scan_log_dump, 2, 1, NULL, 0, 0);
-			DEBUG("rtas returns %d\n", status);
-		} else if (strncmp(stkbuf, "debugon", 7) == 0) {
-			printk(KERN_ERR "scanlog: debug on\n");
-			scanlog_debug = 1;
-		} else if (strncmp(stkbuf, "debugoff", 8) == 0) {
-			printk(KERN_ERR "scanlog: debug off\n");
-			scanlog_debug = 0;
+			pr_debug("scanlog: rtas returns %d\n", status);
 		}
 	}
 	return count;
-- 
1.5.5
