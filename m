Return-Path: <rmk+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE9481A043C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 05:41:51 +1000 (AEST)
In-Reply-To: <20150922161710.GA21084@n2100.arm.linux.org.uk>
References: <20150922161710.GA21084@n2100.arm.linux.org.uk>
From: Russell King <rmk+kernel@arm.linux.org.uk>
To: Florian Fainelli <f.fainelli@gmail.com>, David Miller <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Grant Likely <grant.likely@linaro.org>,
 Iyappan Subramanian <isubramanian@apm.com>, Keyur Chudgar <kchudgar@apm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Li Yang <leoli@freescale.com>, Michal Simek <michal.simek@xilinx.com>,
 netdev@vger.kernel.org, Robert Richter <rric@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 "Soren Brinkmann" <soren.brinkmann@xilinx.com>,
 Sunil Goutham <sgoutham@cavium.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3 9/9] net: fix net_device refcounting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ZfCJl-0004S9-Qq@rmk-PC.arm.linux.org.uk>
Sender: Russell King <rmk@arm.linux.org.uk>
Date: Thu, 24 Sep 2015 20:36:33 +0100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

of_find_net_device_by_node() uses class_find_device() internally to
lookup the corresponding network device.  class_find_device() returns
a reference to the embedded struct device, with its refcount
incremented.

Add a comment to the definition in net/core/net-sysfs.c indicating the
need to drop this refcount, and fix the DSA code to drop this refcount
when the OF-generated platform data is cleaned up and freed.  Also
arrange for the ref to be dropped when handling errors.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 net/core/net-sysfs.c | 9 +++++++++
 net/dsa/dsa.c        | 5 ++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index b279077c3089..805a95a48107 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1481,6 +1481,15 @@ static int of_dev_node_match(struct device *dev, const void *data)
 	return ret == 0 ? dev->of_node == data : ret;
 }
 
+/*
+ * of_find_net_device_by_node - lookup the net device for the device node
+ * @np: OF device node
+ *
+ * Looks up the net_device structure corresponding with the device node.
+ * If successful, returns a pointer to the net_device with the embedded
+ * struct device refcount incremented by one, or NULL on failure. The
+ * refcount must be dropped when done with the net_device.
+ */
 struct net_device *of_find_net_device_by_node(struct device_node *np)
 {
 	struct device *dev;
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index bf4ba15fb780..c59fa5d9c22c 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -679,7 +679,7 @@ static int dsa_of_probe(struct device *dev)
 	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
 	if (!pd) {
 		ret = -ENOMEM;
-		goto out_put_mdio;
+		goto out_put_ethernet;
 	}
 
 	dev->platform_data = pd;
@@ -773,6 +773,8 @@ static int dsa_of_probe(struct device *dev)
 out_free:
 	kfree(pd);
 	dev->platform_data = NULL;
+out_put_ethernet:
+	put_device(&ethernet_dev->dev);
 out_put_mdio:
 	put_device(&mdio_bus->dev);
 	return ret;
@@ -786,6 +788,7 @@ static void dsa_of_remove(struct device *dev)
 		return;
 
 	dsa_of_free_platform_data(pd);
+	put_device(&pd->of_netdev->dev);
 	kfree(pd);
 }
 #else
-- 
2.1.0
