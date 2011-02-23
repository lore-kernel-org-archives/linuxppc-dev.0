Return-Path: <grant.likely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [RFC PATCH 02/15] dt: add a match table pointer to struct device
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	devicetree-discuss@lists.ozlabs.org, sfr@canb.auug.org.au,
	linux-kernel@vger.kernel.org, davem@davemloft.net
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 22 Feb 2011 21:33:45 -0700
Message-ID: <20110223043345.20795.2936.stgit@localhost6.localdomain6>
In-Reply-To: <20110223043015.20795.37090.stgit@localhost6.localdomain6>
References: <20110223043015.20795.37090.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a new .of_match field to struct device which points at the
matching device driver .of_match_table entry when a device is probed
via the device tree

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 include/linux/device.h    |    1 +
 include/linux/of_device.h |    5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index ca5d252..8d8e267 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -441,6 +441,7 @@ struct device {
 	struct dev_archdata	archdata;
 
 	struct device_node	*of_node; /* associated device tree node */
+	const struct of_device_id *of_match; /* matching of_device_id from driver */
 
 	dev_t			devt;	/* dev_t, creates the sysfs "dev" */
 
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 975d347..8bfe6c1 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -18,10 +18,11 @@ extern void of_device_make_bus_id(struct device *dev);
  * @drv: the device_driver structure to test
  * @dev: the device structure to match against
  */
-static inline int of_driver_match_device(const struct device *dev,
+static inline int of_driver_match_device(struct device *dev,
 					 const struct device_driver *drv)
 {
-	return of_match_device(drv->of_match_table, dev) != NULL;
+	dev->of_match = of_match_device(drv->of_match_table, dev);
+	return dev->of_match != NULL;
 }
 
 extern struct platform_device *of_dev_get(struct platform_device *dev);
