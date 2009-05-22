Return-Path: <jonsmirl@gmail.com>
Received: from mail-qy0-f128.google.com (mail-qy0-f128.google.com
	[209.85.221.128]) by ozlabs.org (Postfix) with ESMTP id 39E2CDE1B7
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 23:29:55 +1000 (EST)
Received: by qyk34 with SMTP id 34so3166595qyk.17
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 06:29:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090430223114.GA12571@oksana.dev.rtsoft.ru>
References: <20090430223114.GA12571@oksana.dev.rtsoft.ru>
Date: Fri, 22 May 2009 09:29:51 -0400
Message-ID: <9e4733910905220629p6592c8acj2f5a1e6df8c48099@mail.gmail.com>
Subject: Re: [PATCH] mpc52xx_psc_spi: Convert to cs_control callback
From: Jon Smirl <jonsmirl@gmail.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 30, 2009 at 6:31 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> mpc52xx_psc_spi driver is the last user of the legacy activate_cs
> and deactivate_cs callbacks, so convert the driver to the cs_control

This driver is missing a call to of_register_spi_devices(master, op->node);

Here's how I added it, but it could be done more cleanly.


diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
index 68c77a9..fe0658a 100644
--- a/drivers/spi/mpc52xx_psc_spi.c
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
 #include <linux/fsl_devices.h>
+#include <linux/of_spi.h>

 #include <asm/mpc52xx.h>
 #include <asm/mpc52xx_psc.h>
@@ -370,24 +371,24 @@ static irqreturn_t mpc52xx_psc_spi_isr(int irq,
void *dev_id)
 }

 /* bus_num is used only for the case dev->platform_data == NULL */
-static int __init mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
+static int __init mpc52xx_psc_spi_do_probe(struct of_device *op, u32 regaddr,
 				u32 size, unsigned int irq, s16 bus_num)
 {
-	struct fsl_spi_platform_data *pdata = dev->platform_data;
+	struct fsl_spi_platform_data *pdata = op->dev.platform_data;
 	struct mpc52xx_psc_spi *mps;
 	struct spi_master *master;
 	int ret;

-	master = spi_alloc_master(dev, sizeof *mps);
+	master = spi_alloc_master(&op->dev, sizeof *mps);
 	if (master == NULL)
 		return -ENOMEM;

-	dev_set_drvdata(dev, master);
+	dev_set_drvdata(&op->dev, master);
 	mps = spi_master_get_devdata(master);

 	mps->irq = irq;
 	if (pdata == NULL) {
-		dev_warn(dev, "probe called without platform data, no "
+		dev_warn(&op->dev, "probe called without platform data, no "
 				"(de)activate_cs function will be called\n");
 		mps->activate_cs = NULL;
 		mps->deactivate_cs = NULL;
@@ -407,7 +408,7 @@ static int __init mpc52xx_psc_spi_do_probe(struct
device *dev, u32 regaddr,

 	mps->psc = ioremap(regaddr, size);
 	if (!mps->psc) {
-		dev_err(dev, "could not ioremap I/O port range\n");
+		dev_err(&op->dev, "could not ioremap I/O port range\n");
 		ret = -EFAULT;
 		goto free_master;
 	}
@@ -439,6 +440,8 @@ static int __init mpc52xx_psc_spi_do_probe(struct
device *dev, u32 regaddr,
 	if (ret < 0)
 		goto unreg_master;

+	of_register_spi_devices(master, op->node);
+
 	return ret;

 unreg_master:
@@ -495,7 +498,7 @@ static int __init mpc52xx_psc_spi_of_probe(struct
of_device *op,
 		id = *psc_nump + 1;
 	}

-	return mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (u32)size64,
+	return mpc52xx_psc_spi_do_probe(op, (u32)regaddr64, (u32)size64,
 					irq_of_parse_and_map(op->node, 0), id);
 }


-- 
Jon Smirl
jonsmirl@gmail.com
