Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 6787BDE6DC
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 05:36:17 +1000 (EST)
Received: from pd2mr2so.prod.shaw.ca
	(pd2mr2so-qfe3.prod.shaw.ca [10.0.141.109]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0K0Z005747S49XD0@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 16 May 2008 13:36:04 -0600 (MDT)
Received: from pn2ml5so.prod.shaw.ca ([10.0.121.149])
	by pd2mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0K0Z008KO7S49J20@pd2mr2so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 16 May 2008 13:36:05 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0K0Z00F847S3G040@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 16 May 2008 13:36:03 -0600 (MDT)
Date: Fri, 16 May 2008 13:36:03 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/4] spi: Change modalias from a pointer to a character array
In-reply-to: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
To: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net
Message-id: <20080516193603.28030.51689.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
Cc: fabrizio.garetto@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Currently, 'modalias' in the spi_device structure is a 'const char *'.
The spi_new_device() function fills in the modalias value from a passed
in spi_board_info data block.  Since it is a pointer copy, the new
spi_device remains dependent on the spi_board_info structure after the
new spi_device is registered (no other fields in spi_device directly
depend on the spi_board_info structure; all of the other data is copied).

This causes a problem when dynamically propulating the list of attached
SPI devices.  For example, in arch/powerpc, the list of SPI devices can
be populated from data in the device tree.  With the current code, the
device tree adapter must kmalloc() a new spi_board_info structure for
each new SPI device it finds in the device tree, and there is no simple
mechanism in place for keeping track of these allocations.

This patch changes modalias from a 'const char *' to a fixed char array.
By copying the modalias string instead of referencing it, the dependency
on the spi_board_info structure is eliminated and an outside caller does
not need to maintain a separate spi_board_info allocation for each device.

If searched through the code to the best of my ability for any references
to modalias which may be affected by this change and haven't found anything.
It has been tested with the lite5200b platform in arch/powerpc.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/spi/spi.c       |    2 +-
 include/linux/spi/spi.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 1ad12af..bdf1b70 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -229,7 +229,7 @@ struct spi_device *spi_new_device(struct spi_master *master,
 	proxy->max_speed_hz = chip->max_speed_hz;
 	proxy->mode = chip->mode;
 	proxy->irq = chip->irq;
-	proxy->modalias = chip->modalias;
+	strncpy(proxy->modalias, chip->modalias, KOBJ_NAME_LEN);
 
 	snprintf(proxy->dev.bus_id, sizeof proxy->dev.bus_id,
 			"%s.%u", master->dev.bus_id,
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 387e428..38a080b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -82,7 +82,7 @@ struct spi_device {
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
-	const char		*modalias;
+	char			modalias[KOBJ_NAME_LEN];
 
 	/*
 	 * likely need more hooks for more protocol options affecting how
