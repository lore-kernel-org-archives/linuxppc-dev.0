Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 40BQlm0tFMzF2Hc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 11:36:03 +1100 (AEDT)
Date: Thu, 29 Mar 2018 11:36:04 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Jiri Kosina <trivial@kernel.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] macintosh/adb: Use C99 initializers for struct adb_driver
 instances
Message-ID: <alpine.LNX.2.21.1803291117110.30@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No change to object files.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---
 drivers/macintosh/adb-iop.c    | 14 +++++++-------
 drivers/macintosh/macio-adb.c  | 15 +++++++--------
 drivers/macintosh/via-macii.c  | 14 +++++++-------
 drivers/macintosh/via-pmu.c    | 14 +++++++-------
 drivers/macintosh/via-pmu68k.c | 14 +++++++-------
 5 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/drivers/macintosh/adb-iop.c b/drivers/macintosh/adb-iop.c
index 15db69d8ba69..ca623e6446e4 100644
--- a/drivers/macintosh/adb-iop.c
+++ b/drivers/macintosh/adb-iop.c
@@ -53,13 +53,13 @@ static void adb_iop_poll(void);
 static int adb_iop_reset_bus(void);
 
 struct adb_driver adb_iop_driver = {
-	"ISM IOP",
-	adb_iop_probe,
-	adb_iop_init,
-	adb_iop_send_request,
-	adb_iop_autopoll,
-	adb_iop_poll,
-	adb_iop_reset_bus
+	.name         = "ISM IOP",
+	.probe        = adb_iop_probe,
+	.init         = adb_iop_init,
+	.send_request = adb_iop_send_request,
+	.autopoll     = adb_iop_autopoll,
+	.poll         = adb_iop_poll,
+	.reset_bus    = adb_iop_reset_bus
 };
 
 static void adb_iop_end_req(struct adb_request *req, int state)
diff --git a/drivers/macintosh/macio-adb.c b/drivers/macintosh/macio-adb.c
index 9a6223add30e..eb3adfb7f88d 100644
--- a/drivers/macintosh/macio-adb.c
+++ b/drivers/macintosh/macio-adb.c
@@ -70,14 +70,13 @@ static void macio_adb_poll(void);
 static int macio_adb_reset_bus(void);
 
 struct adb_driver macio_adb_driver = {
-	"MACIO",
-	macio_probe,
-	macio_init,
-	macio_send_request,
-	/*macio_write,*/
-	macio_adb_autopoll,
-	macio_adb_poll,
-	macio_adb_reset_bus
+	.name         = "MACIO",
+	.probe        = macio_probe,
+	.init         = macio_init,
+	.send_request = macio_send_request,
+	.autopoll     = macio_adb_autopoll,
+	.poll         = macio_adb_poll,
+	.reset_bus    = macio_adb_reset_bus,
 };
 
 int macio_probe(void)
diff --git a/drivers/macintosh/via-macii.c b/drivers/macintosh/via-macii.c
index 4ba06a1695ea..cf6f7d52d6be 100644
--- a/drivers/macintosh/via-macii.c
+++ b/drivers/macintosh/via-macii.c
@@ -91,13 +91,13 @@ static void macii_poll(void);
 static int macii_reset_bus(void);
 
 struct adb_driver via_macii_driver = {
-	"Mac II",
-	macii_probe,
-	macii_init,
-	macii_send_request,
-	macii_autopoll,
-	macii_poll,
-	macii_reset_bus
+	.name         = "Mac II",
+	.probe        = macii_probe,
+	.init         = macii_init,
+	.send_request = macii_send_request,
+	.autopoll     = macii_autopoll,
+	.poll         = macii_poll,
+	.reset_bus    = macii_reset_bus,
 };
 
 static enum macii_state {
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index c4c2b3b85ebc..8da474899d79 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -199,13 +199,13 @@ static const struct file_operations pmu_options_proc_fops;
 
 #ifdef CONFIG_ADB
 struct adb_driver via_pmu_driver = {
-	"PMU",
-	pmu_probe,
-	pmu_init,
-	pmu_send_request,
-	pmu_adb_autopoll,
-	pmu_poll_adb,
-	pmu_adb_reset_bus
+	.name         = "PMU",
+	.probe        = pmu_probe,
+	.init         = pmu_init,
+	.send_request = pmu_send_request,
+	.autopoll     = pmu_adb_autopoll,
+	.poll         = pmu_poll_adb,
+	.reset_bus    = pmu_adb_reset_bus,
 };
 #endif /* CONFIG_ADB */
 
diff --git a/drivers/macintosh/via-pmu68k.c b/drivers/macintosh/via-pmu68k.c
index 7d9c4baf8c11..d545ed45e482 100644
--- a/drivers/macintosh/via-pmu68k.c
+++ b/drivers/macintosh/via-pmu68k.c
@@ -120,13 +120,13 @@ static void pmu_enable_backlight(int on);
 static void pmu_set_brightness(int level);
 
 struct adb_driver via_pmu_driver = {
-	"68K PMU",
-	pmu_probe,
-	pmu_init,
-	pmu_send_request,
-	pmu_autopoll,
-	pmu_poll,
-	pmu_reset_bus
+	.name         = "68K PMU",
+	.probe        = pmu_probe,
+	.init         = pmu_init,
+	.send_request = pmu_send_request,
+	.autopoll     = pmu_autopoll,
+	.poll         = pmu_poll,
+	.reset_bus    = pmu_reset_bus,
 };
 
 /*
