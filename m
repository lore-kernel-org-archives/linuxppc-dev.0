Return-Path: <a.heider@gmail.com>
From: Andre Heider <a.heider@gmail.com>
To: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 13/15] ps3disk: Use region flags
Date: Mon,  1 Aug 2011 22:03:04 +0200
Message-Id: <1312228986-32307-14-git-send-email-a.heider@gmail.com>
In-Reply-To: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
Cc: cbe-oss-dev@lists.ozlabs.org, Hector Martin <hector@marcansoft.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Provide a set of default region flags and make them overwritable via
a module parameter array.
Set PS3_STORAGE_FLAG_SKIP_ACL for region 0, so it can be accessed
from the GameOS lpar.

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 drivers/block/ps3disk.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index 30dae10..483806e 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -39,6 +39,19 @@
 #define PS3DISK_NAME		"ps3d%c%c"
 
 
+static unsigned int region_flags[] = {
+	PS3_STORAGE_FLAG_SKIP_ACL,		/* raw disk */
+	PS3_STORAGE_FLAG_DEFAULT,		/* core os */
+	PS3_STORAGE_FLAG_DEFAULT,		/* gameos pup */
+	PS3_STORAGE_FLAG_DEFAULT,		/* n/a */
+	PS3_STORAGE_FLAG_DEFAULT,		/* n/a */
+	PS3_STORAGE_FLAG_DEFAULT,		/* n/a */
+	PS3_STORAGE_FLAG_DEFAULT,		/* n/a */
+	PS3_STORAGE_FLAG_DEFAULT,		/* n/a */
+};
+module_param_array(region_flags, uint, NULL, S_IRUGO);
+MODULE_PARM_DESC(region_flags, "Region flags");
+
 struct ps3disk_private {
 	spinlock_t lock;		/* Request queue spinlock */
 	struct request_queue *queue;
@@ -453,6 +466,9 @@ static int __devinit ps3disk_probe(struct ps3_system_bus_device *_dev)
 		goto fail_free_priv;
 	}
 
+	for (region_idx = 0; region_idx < dev->num_regions; region_idx++)
+		dev->regions[region_idx].flags = region_flags[region_idx];
+
 	error = ps3stor_setup(dev, ps3disk_interrupt);
 	if (error)
 		goto fail_free_bounce;
-- 
1.7.5.4
