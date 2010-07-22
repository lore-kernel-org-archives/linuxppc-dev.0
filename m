Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) by ozlabs.org (Postfix) with ESMTP id 8BF6C101663
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 08:30:27 +1000 (EST)
Received: by pvg16 with SMTP id 16so3564918pvg.15
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 15:30:26 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [PATCH 4/4] microblaze: remove references to of_device and
	to_of_device
To: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	benh@kernel.crashing.org, sparclinux@vger.kernel.org, davem@davemloft.net
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 22 Jul 2010 16:30:21 -0600
Message-ID: <20100722223021.21557.65702.stgit@angua>
In-Reply-To: <20100722222600.21557.34167.stgit@angua>
References: <20100722222600.21557.34167.stgit@angua>
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

of_device is just a #define alias to platform_device.  This patch
replaces all references to it with platform_device.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/microblaze/kernel/of_platform.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/microblaze/kernel/of_platform.c b/arch/microblaze/kernel/of_platform.c
index 80c9c49..c664b27 100644
--- a/arch/microblaze/kernel/of_platform.c
+++ b/arch/microblaze/kernel/of_platform.c
@@ -50,16 +50,16 @@ const struct of_device_id of_default_bus_ids[] = {
 
 static int of_dev_node_match(struct device *dev, void *data)
 {
-	return to_of_device(dev)->dev.of_node == data;
+	return to_platform_device(dev)->dev.of_node == data;
 }
 
-struct of_device *of_find_device_by_node(struct device_node *np)
+struct platform_device *of_find_device_by_node(struct device_node *np)
 {
 	struct device *dev;
 
 	dev = bus_find_device(&platform_bus_type, NULL, np, of_dev_node_match);
 	if (dev)
-		return to_of_device(dev);
+		return to_platform_device(dev);
 	return NULL;
 }
 EXPORT_SYMBOL(of_find_device_by_node);
