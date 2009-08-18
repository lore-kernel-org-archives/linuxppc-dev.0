Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 62E35B7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 07:46:24 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 97E13DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 07:46:23 +1000 (EST)
Date: Wed, 19 Aug 2009 01:46:22 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/2] mtd: m25p80: Rework probing/JEDEC code
Message-ID: <20090818214622.GA22651@oksana.dev.rtsoft.ru>
References: <20090818214449.GA12848@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090818214449.GA12848@oksana.dev.rtsoft.ru>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previosly the driver always tried JEDEC probing, assuming that non-JEDEC
chips will return '0'. But truly non-JEDEC chips (like CAT25) won't do
that, their behaviour on RDID command is undefined, so the driver should
not call jedec_probe() for these chips.

Also, be less strict on error conditions, don't fail to probe if JEDEC
found a chip that is different from what platform code told, instead
just print some warnings and use an information obtained via JEDEC. In
that case we should not trust partitions any longer, but they might be
still useful (i.e. they could protect some parts of the chip).

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mtd/devices/m25p80.c |   69 ++++++++++++++++++++++++-----------------
 1 files changed, 40 insertions(+), 29 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 0d74b38..b75e319 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -581,6 +581,14 @@ static const struct spi_device_id *__devinit jedec_probe(struct spi_device *spi)
 	jedec = jedec << 8;
 	jedec |= id[2];
 
+	/*
+	 * Some chips (like Numonyx M25P80) have JEDEC and non-JEDEC variants,
+	 * which depend on technology process. Officially RDID command doesn't
+	 * exist for non-JEDEC chips, but for compatibility they return ID 0.
+	 */
+	if (jedec == 0)
+		return NULL;
+
 	ext_jedec = id[3] << 8 | id[4];
 
 	for (tmp = 0; tmp < ARRAY_SIZE(m25p_ids) - 1; tmp++) {
@@ -602,7 +610,7 @@ static const struct spi_device_id *__devinit jedec_probe(struct spi_device *spi)
  */
 static int __devinit m25p_probe(struct spi_device *spi)
 {
-	const struct spi_device_id	*id;
+	const struct spi_device_id	*id = spi_get_device_id(spi);
 	struct flash_platform_data	*data;
 	struct m25p			*flash;
 	struct flash_info		*info;
@@ -615,41 +623,44 @@ static int __devinit m25p_probe(struct spi_device *spi)
 	 */
 	data = spi->dev.platform_data;
 	if (data && data->type) {
+		const struct spi_device_id *plat_id;
+
 		for (i = 0; i < ARRAY_SIZE(m25p_ids) - 1; i++) {
-			id = &m25p_ids[i];
-			info = (void *)m25p_ids[i].driver_data;
-			if (strcmp(data->type, id->name))
+			plat_id = &m25p_ids[i];
+			if (strcmp(data->type, plat_id->name))
 				continue;
 			break;
 		}
 
-		/* unrecognized chip? */
-		if (i == ARRAY_SIZE(m25p_ids) - 1) {
-			DEBUG(MTD_DEBUG_LEVEL0, "%s: unrecognized id %s\n",
-					dev_name(&spi->dev), data->type);
-			info = NULL;
-
-		/* recognized; is that chip really what's there? */
-		} else if (info->jedec_id) {
-			id = jedec_probe(spi);
-
-			if (id != &m25p_ids[i]) {
-				dev_warn(&spi->dev, "found %s, expected %s\n",
-						id ? id->name : "UNKNOWN",
-						m25p_ids[i].name);
-				info = NULL;
-			}
-		}
-	} else {
-		id = jedec_probe(spi);
-		if (!id)
-			id = spi_get_device_id(spi);
-
-		info = (void *)id->driver_data;
+		if (plat_id)
+			id = plat_id;
+		else
+			dev_warn(&spi->dev, "unrecognized id %s\n", data->type);
 	}
 
-	if (!info)
-		return -ENODEV;
+	info = (void *)id->driver_data;
+
+	if (info->jedec_id) {
+		const struct spi_device_id *jid;
+
+		jid = jedec_probe(spi);
+		if (!jid) {
+			dev_info(&spi->dev, "non-JEDEC variant of %s\n",
+				 id->name);
+		} else if (jid != id) {
+			/*
+			 * JEDEC knows better, so overwrite platform ID. We
+			 * can't trust partitions any longer, but we'll let
+			 * mtd apply them anyway, since some partitions may be
+			 * marked read-only, and we don't want to lose that
+			 * information, even if it's not 100% accurate.
+			 */
+			dev_warn(&spi->dev, "found %s, expected %s\n",
+				 jid->name, id->name);
+			id = jid;
+			info = (void *)jid->driver_data;
+		}
+	}
 
 	flash = kzalloc(sizeof *flash, GFP_KERNEL);
 	if (!flash)
-- 
1.6.3.3
