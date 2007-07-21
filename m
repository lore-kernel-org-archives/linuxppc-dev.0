Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A8669DDE04
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 00:24:48 +1000 (EST)
Date: Sun, 22 Jul 2007 00:25:00 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] hvcs: make some things static and const
Message-Id: <20070722002500.d27ab5ad.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/char/hvcs.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Built for PowerPC allmodconfig and ppc64_defconfig.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/char/hvcs.c b/drivers/char/hvcs.c
index 17f96e0..69d8866 100644
--- a/drivers/char/hvcs.c
+++ b/drivers/char/hvcs.c
@@ -210,9 +210,9 @@ static struct ktermios hvcs_tty_termios = {
 static int hvcs_parm_num_devs = -1;
 module_param(hvcs_parm_num_devs, int, 0);
 
-char hvcs_driver_name[] = "hvcs";
-char hvcs_device_node[] = "hvcs";
-char hvcs_driver_string[]
+static const char hvcs_driver_name[] = "hvcs";
+static const char hvcs_device_node[] = "hvcs";
+static const char hvcs_driver_string[]
 	= "IBM hvcs (Hypervisor Virtual Console Server) Driver";
 
 /* Status of partner info rescan triggered via sysfs. */
@@ -1092,7 +1092,7 @@ static int hvcs_enable_device(struct hvcs_struct *hvcsd, uint32_t unit_address,
  * NOTICE: Do NOT hold either the hvcs_struct.lock or hvcs_structs_lock when
  * calling this function or you will get deadlock.
  */
-struct hvcs_struct *hvcs_get_by_index(int index)
+static struct hvcs_struct *hvcs_get_by_index(int index)
 {
 	struct hvcs_struct *hvcsd = NULL;
 	unsigned long flags;
-- 
1.5.2.3
