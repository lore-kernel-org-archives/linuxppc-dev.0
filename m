Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 1/3] of: include linux/proc_fs.h
Message-Id: <1261532718.575422.369701385795.1.gpush@pororo>
In-Reply-To: <1261532718.575048.365032094903.0.gpush@pororo>
To: Grant Likely <grant.likely@secretlab.ca>,
	devicetree-discuss@lists.ozlabs.org
From: Jeremy Kerr <jeremy.kerr@canonical.com>
Date: Wed, 23 Dec 2009 09:45:18 +0800
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We use a few procfs-specific functions (eg, proc_device_tree_*) which
aren't covered by the current includes. This causes the following build
error on arm:

drivers/of/base.c: In function 'prom_add_property':
drivers/of/base.c:861: error: implicit declaration of function 'proc_device_tree_add_prop'
drivers/of/base.c: In function 'prom_remove_property':
drivers/of/base.c:902: error: implicit declaration of function 'proc_device_tree_remove_prop'
drivers/of/base.c: In function 'prom_update_property':
drivers/of/base.c:946: error: implicit declaration of function 'proc_device_tree_update_prop'

Add proc_fs.h for these prototypes.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 drivers/of/base.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 974f64e..2dcb7a3 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/spinlock.h>
+#include <linux/proc_fs.h>
 
 struct device_node *allnodes;
 
