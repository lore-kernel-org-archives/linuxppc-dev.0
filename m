Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by ozlabs.org (Postfix) with ESMTP id D452F2C0125
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 23:02:32 +1000 (EST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] macintosh: use %*ph to print small buffers
Date: Mon, 22 Apr 2013 16:02:19 +0300
Message-Id: <1366635739-11511-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/macintosh/smu.c     | 6 +-----
 drivers/macintosh/via-pmu.c | 5 +++--
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index 9c6b964..b3b2d36 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -120,11 +120,7 @@ static void smu_start_cmd(void)
 
 	DPRINTK("SMU: starting cmd %x, %d bytes data\n", cmd->cmd,
 		cmd->data_len);
-	DPRINTK("SMU: data buffer: %02x %02x %02x %02x %02x %02x %02x %02x\n",
-		((u8 *)cmd->data_buf)[0], ((u8 *)cmd->data_buf)[1],
-		((u8 *)cmd->data_buf)[2], ((u8 *)cmd->data_buf)[3],
-		((u8 *)cmd->data_buf)[4], ((u8 *)cmd->data_buf)[5],
-		((u8 *)cmd->data_buf)[6], ((u8 *)cmd->data_buf)[7]);
+	DPRINTK("SMU: data buffer: %8ph\n", cmd->data_buf);
 
 	/* Fill the SMU command buffer */
 	smu->cmd_buf->cmd = cmd->cmd;
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index c31fbab..283e1b5 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -750,8 +750,9 @@ done_battery_state_smart(struct adb_request* req)
 				voltage = (req->reply[8] << 8) | req->reply[9];
 				break;
 			default:
-				printk(KERN_WARNING "pmu.c : unrecognized battery info, len: %d, %02x %02x %02x %02x\n",
-					req->reply_len, req->reply[0], req->reply[1], req->reply[2], req->reply[3]);
+				pr_warn("pmu.c: unrecognized battery info, "
+					"len: %d, %4ph\n", req->reply_len,
+							   req->reply);
 				break;
 		}
 	}
-- 
1.8.2.rc0.22.gb3600c3
