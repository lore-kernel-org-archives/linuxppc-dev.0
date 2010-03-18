Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by ozlabs.org (Postfix) with ESMTP id 6C091B7E5F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Mar 2010 02:22:22 +1100 (EST)
Received: by pvg12 with SMTP id 12so1087418pvg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Mar 2010 08:22:21 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [V2 PATCH 02/10] i2c/of: Allow device node to be passed via
	i2c_board_info
To: davem@davemloft.net, benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
	michal.simek@petalogix.com, linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au
Date: Thu, 18 Mar 2010 09:22:16 -0600
Message-ID: <20100318152216.21082.63.stgit@angua>
In-Reply-To: <20100318144836.21082.93040.stgit@angua>
References: <20100318144836.21082.93040.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The struct device_node *of_node pointer is moving out of dev->archdata
and into the struct device proper.  of_i2c.c needs to set the of_node
pointer before the device is registered.  Since the i2c subsystem
doesn't allow 2 stage allocation and registration of i2c devices, the
of_node pointer needs to be passed via the i2c_board_info structure
so that it is set prior to registration.

This patch adds of_node to struct i2c_board_info (conditional on
CONFIG_OF), sets of_node in i2c_new_device(), and modifies of_i2c.c
to use the new parameter.  The calling of dev_archdata_set_node()
from of_i2c will be removed in a subsequent patch when of_node is
removed from archdata and all users are converted over.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/i2c/i2c-core.c |    3 +++
 drivers/of/of_i2c.c    |    1 +
 include/linux/i2c.h    |    4 ++++
 3 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 3202a86..4099b2b 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -387,6 +387,9 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 	client->dev.parent = &client->adapter->dev;
 	client->dev.bus = &i2c_bus_type;
 	client->dev.type = &i2c_client_type;
+#ifdef CONFIG_OF
+	client->dev.of_node = info->of_node;
+#endif
 
 	dev_set_name(&client->dev, "%d-%04x", i2c_adapter_id(adap),
 		     client->addr);
diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index a3a708e..e690a2a 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -43,6 +43,7 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
 		info.addr = be32_to_cpup(addr);
 
 		dev_archdata_set_node(&dev_ad, node);
+		info.of_node = node;
 		info.archdata = &dev_ad;
 
 		request_module("%s", info.type);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 0a5da63..4f37ff1 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -34,6 +34,7 @@
 #include <linux/device.h>	/* for struct device */
 #include <linux/sched.h>	/* for completion */
 #include <linux/mutex.h>
+#include <linux/of.h>		/* for struct device_node */
 
 extern struct bus_type i2c_bus_type;
 
@@ -251,6 +252,9 @@ struct i2c_board_info {
 	unsigned short	addr;
 	void		*platform_data;
 	struct dev_archdata	*archdata;
+#ifdef CONFIG_OF
+	struct device_node *of_node;
+#endif
 	int		irq;
 };
 
