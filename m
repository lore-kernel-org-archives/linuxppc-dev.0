Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) by ozlabs.org (Postfix) with ESMTP id 6F830105721
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 05:24:20 +1100 (EST)
Received: by mail-pv0-f170.google.com with SMTP id 11so131850pvg.15
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 10:24:20 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 27/27] of: remove obsolete members from of_platform_driver
To: monstr@monstr.eu, gregkh@suse.de, benh@kernel.crashing.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	sfr@canb.auug.org.au, jgarzik@pobox.com, ben-linux@fluff.org,
	dwmw2@infradead.org, jeremy.kerr@canonical.com,
	James.Bottomley@suse.de, broonie@opensource.wolfsonmicro.com,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	linux-ide@vger.kernel.org, netdev@vger.kernel.org,
	linux-i2c@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linux-scsi@vger.kernel.org, alsa-devel@alsa-project.org
Date: Thu, 11 Mar 2010 11:24:17 -0700
Message-ID: <20100311182416.13103.38891.stgit@angua>
In-Reply-To: <20100311181604.13103.30088.stgit@angua>
References: <20100311181604.13103.30088.stgit@angua>
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

.name, .match_table and .owner already exist in struct device_driver.
Remove the duplication from struct of_platform_driver.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/of/platform.c       |    7 -------
 include/linux/of_platform.h |    4 ----
 2 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 9fd7f7d..ba402c6 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -385,13 +385,6 @@ int of_bus_type_init(struct bus_type *bus, const char *name)
 
 int of_register_driver(struct of_platform_driver *drv, struct bus_type *bus)
 {
-	/* initialize common driver fields */
-	if (!drv->driver.name)
-		drv->driver.name = drv->name;
-	if (!drv->driver.owner)
-		drv->driver.owner = drv->owner;
-	if (!drv->driver.of_match_table)
-		drv->driver.of_match_table = drv->match_table;
 	drv->driver.bus = bus;
 
 	/* register with core */
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index ac3ae07..1643d37 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -31,10 +31,6 @@ extern struct bus_type of_platform_bus_type;
  */
 struct of_platform_driver
 {
-	const char		*name;
-	const struct of_device_id	*match_table;
-	struct module		*owner;
-
 	int	(*probe)(struct of_device* dev,
 			 const struct of_device_id *match);
 	int	(*remove)(struct of_device* dev);
