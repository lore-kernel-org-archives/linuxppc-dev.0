Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4614C1A00B5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 03:26:35 +1000 (AEST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6226D14016A
 for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2015 03:26:34 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Fri, 29 May 2015 03:26:32 +1000
Message-ID: <55674F90.8040903@linux.vnet.ibm.com>
Date: Thu, 28 May 2015 22:55:36 +0530
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@ozlabs.org
CC: Joel Stanley <joel@jms.id.au>, Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH V2] drivers/mtd: add powernv flash MTD abstraction driver
References: <1432818408-11558-1-git-send-email-cyrilbur@gmail.com>
In-Reply-To: <1432818408-11558-1-git-send-email-cyrilbur@gmail.com>
Content-Type: multipart/alternative;
 boundary="------------060405070508030502060505"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060405070508030502060505
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/28/2015 06:36 PM, Cyril Bur wrote:
> Powerpc powernv platforms allow access to certain system flash devices
> through a firmwarwe interface. This change adds an mtd driver for these
> flash devices.
>
> Minor updates from Jeremy Kerr and Joel Stanley.
>
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> ---
> V2: Address Brian Norris' review
>      Fix typos
>      Change from NAND flash type to NOR flash type
>      Correctness tweaks
> ---
>   drivers/mtd/devices/Kconfig         |   8 +
>   drivers/mtd/devices/Makefile        |   1 +
>   drivers/mtd/devices/powernv_flash.c | 286 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 295 insertions(+)
>   create mode 100644 drivers/mtd/devices/powernv_flash.c
>
> diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
> index c49d0b1..a8cc237 100644
> --- a/drivers/mtd/devices/Kconfig
> +++ b/drivers/mtd/devices/Kconfig
> @@ -195,6 +195,14 @@ config MTD_BLOCK2MTD
>   	  Testing MTD users (eg JFFS2) on large media and media that might
>   	  be removed during a write (using the floppy drive).
>   
> +config MTD_POWERNV_FLASH
> +	tristate "powernv flash MTD driver"
> +	depends on PPC_POWERNV
> +	help
> +	  This provides an MTD device to access NVRAM on powernv OPAL

NVRAM ? or to access FLASH device ?

> +	  platforms from Linux. This device abstracts away the
> +	  firmware interface for NVRAM access.
> +
>   comment "Disk-On-Chip Device Drivers"
>   
>   config MTD_DOCG3
> diff --git a/drivers/mtd/devices/Makefile b/drivers/mtd/devices/Makefile
> index f0b0e61..7912d3a 100644
> --- a/drivers/mtd/devices/Makefile
> +++ b/drivers/mtd/devices/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_MTD_SPEAR_SMI)	+= spear_smi.o
>   obj-$(CONFIG_MTD_SST25L)	+= sst25l.o
>   obj-$(CONFIG_MTD_BCM47XXSFLASH)	+= bcm47xxsflash.o
>   obj-$(CONFIG_MTD_ST_SPI_FSM)    += st_spi_fsm.o
> +obj-$(CONFIG_MTD_POWERNV_FLASH)	+= powernv_flash.o
>   
>   
>   CFLAGS_docg3.o			+= -I$(src)
> diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
> new file mode 100644
> index 0000000..f619e4a
> --- /dev/null
> +++ b/drivers/mtd/devices/powernv_flash.c
> @@ -0,0 +1,286 @@
> +/*
> + * OPAL PNOR flash MTD abstraction
> + *
> + * IBM 2015
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/errno.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/string.h>
> +#include <linux/slab.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +
> +#include <linux/debugfs.h>
> +#include <linux/seq_file.h>
> +
> +#include <asm/opal.h>
> +
> +
> +/*
> + * This driver creates the a Linux MTD abstraction for platform PNOR flash
> + * backed by OPAL calls
> + */
> +
> +struct powernv_flash {
> +	struct mtd_info	mtd;
> +	uint64_t	id;

'id' should be u32

> +};
> +
> +enum flash_op {
> +	FLASH_OP_READ,
> +	FLASH_OP_WRITE,
> +	FLASH_OP_ERASE,
> +};
> +
> +static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
> +		loff_t offset, size_t len, size_t *retlen, u_char *buf)
> +{
> +	struct powernv_flash *info = (struct powernv_flash *)mtd->priv;
> +	struct device *dev = &mtd->dev;
> +	int token;
> +	struct opal_msg msg;
> +	int rc;
> +
> +	dev_dbg(dev, "%s(op=%d, offset=0x%llx, len=%zu)\n",
> +			__func__, op, offset, len);
> +
> +	token = opal_async_get_token_interruptible();
> +	if (token < 0) {
> +		dev_err(dev, "Failed to get an async token\n");
> +		return -ENOMEM;

ENOMEM is not correct code here.. 'token' itself has the right one in 
case of
failure. To be more precise,
if (token < 0) {
     if (token != -ERESTARTSYS)
         dev_err(dev, "Failed to get an async token\n");

     return token;
}

> +	}
> +
> +	switch (op) {
> +	case FLASH_OP_READ:
> +		rc = opal_flash_read(info->id, offset, __pa(buf), len, token);
> +		break;
> +	case FLASH_OP_WRITE:
> +		rc = opal_flash_write(info->id, offset, __pa(buf), len, token);
> +		break;
> +	case FLASH_OP_ERASE:
> +		rc = opal_flash_erase(info->id, offset, len, token);
> +		break;
> +	default:
> +		BUG_ON(1);
> +	}
> +
> +	if (rc != OPAL_ASYNC_COMPLETION) {
> +		dev_err(dev, "opal_flash_async_op(op=%d) failed (rc %d)\n",
> +				op, rc);

release the token, opal_async_release_token();

> +		return -EIO;
> +	}
> +
> +	rc = opal_async_wait_response(token, &msg);
> +	opal_async_release_token(token);
> +	if (rc) {
> +		dev_err(dev, "opal async wait failed (rc %d)\n", rc);
> +		return -EIO;
> +	}
> +
> +	rc = be64_to_cpu(msg.params[1]);
> +	if (rc == OPAL_SUCCESS) {
> +		rc = 0;
> +		if (retlen)
> +			*retlen = len;
> +	} else {
> +		rc = -EIO;
> +	}
> +

return rc;

> +	return 0;
> +}
> +
> +/**
> + * @mtd: the device
> + * @from: the offset to read from
> + * @len: the number of bytes to read
> + * @retlen: the number of bytes actually read
> + * @buf: the filled in buffer
> + *
> + * Returns 0 if read successful, or -ERRNO if an error occurred
> + */
> +static int powernv_flash_read(struct mtd_info *mtd, loff_t from, size_t len,
> +	     size_t *retlen, u_char *buf)
> +{
> +	return powernv_flash_async_op(mtd, FLASH_OP_READ, from,
> +			len, retlen, buf);
> +}
> +
> +/**
> + * @mtd: the device
> + * @to: the offset to write to
> + * @len: the number of bytes to write
> + * @retlen: the number of bytes actually written
> + * @buf: the buffer to get bytes from
> + *
> + * Returns 0 if write successful, -ERRNO if error occurred
> + */
> +static int powernv_flash_write(struct mtd_info *mtd, loff_t to, size_t len,
> +		     size_t *retlen, const u_char *buf)
> +{
> +	return powernv_flash_async_op(mtd, FLASH_OP_WRITE, to,
> +			len, retlen, (u_char *)buf);

Why typecast ? 'buf' should be 'const' for write operation.

> +}
> +
> +/**
> + * @mtd: the device
> + * @erase: the erase info
> + * Returns 0 if erase successful or -ERRNO if an error occurred
> + */
> +static int powernv_flash_erase(struct mtd_info *mtd, struct erase_info *erase)
> +{
> +	int rc;
> +
> +	erase->state = MTD_ERASING;
> +
> +	/* todo: register our own notifier to do a true async implementation */
> +	rc =  powernv_flash_async_op(mtd, FLASH_OP_ERASE, erase->addr,
> +			erase->len, NULL, NULL);
> +
> +	if (rc) {
> +		erase->fail_addr = erase->addr;
> +		erase->state = MTD_ERASE_FAILED;
> +	} else {
> +		erase->state = MTD_ERASE_DONE;
> +	}
> +	mtd_erase_callback(erase);

return rc;

> +	return 0;
> +}
> +
> +/**
> + * powernv_flash_set_driver_info - Fill the mtd_info structure and docg3
> + * structure @pdev: The platform device
> + * @mtd: The structure to fill
> + */
> +static int __init powernv_flash_set_driver_info(struct device *dev,
> +		struct mtd_info *mtd)

Why __init tag ? Called from the probe so should not be .. ?

> +{
> +	u64 size;
> +	u32 erase_size;
> +	int rc;
> +
> +	rc = of_property_read_u32(dev->of_node, "ibm,flash-block-size",
> +			&erase_size);
> +	if (rc) {
> +		dev_err(dev, "couldn't get resource block size information\n");
> +		return rc;
> +	}
> +
> +	rc = of_property_read_u64(dev->of_node, "reg", &size);
> +	if (rc) {
> +		dev_err(dev, "couldn't get resource size information\n");
> +		return rc;
> +	}
> +
> +	/*
> +	 * Going to have to check what details I need to set and how to
> +	 * get them
> +	 */
> +	mtd->name = of_get_property(dev->of_node, "name", NULL);
> +	/*
> +	 * Using MTD_ABSENT as this is really just a passthrough to a firmware

But you are using MTD_NORFLASH :)

> +	 * interface
> +	 */
> +	mtd->type = MTD_NORFLASH;
> +	mtd->flags = MTD_WRITEABLE;
> +	mtd->size = size;
> +	mtd->erasesize = erase_size;
> +	mtd->writebufsize = mtd->writesize = 1;
> +	mtd->owner = THIS_MODULE;
> +	mtd->_erase = powernv_flash_erase;
> +	mtd->_read = powernv_flash_read;
> +	mtd->_write = powernv_flash_write;
> +	mtd->dev.parent = dev;
> +	return 0;
> +}
> +
> +/**
> + * powernv_flash_probe
> + * @pdev: platform device
> + *
> + * Returns 0 on success, -ENOMEM, -ENXIO on error
> + */
> +static int powernv_flash_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct powernv_flash *data;
> +	int ret;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	data->mtd.priv = data;
> +
> +	ret = of_property_read_u32(dev->of_node, "ibm,opal-id", &(data->id));
> +	if (ret) {
> +		dev_err(dev, "no device property 'ibm,opal-id'\n");
> +		goto out;
> +	}
> +
> +	ret = powernv_flash_set_driver_info(dev, &data->mtd);
> +	if (ret)
> +		goto out;
> +
> +	/*
> +	 * Skiboot does expose the partitioning information via OF and the
> +	 * ofpart parser could partition it all nicely.
> +	 *
> +	 * The current flash that skiboot exposes is one contiguous flash chip
> +	 * with an ffs partition at the start, it should prove easier for users
> +	 * to deal with partitions or not as they see fit
> +	 */
> +	ret = mtd_device_register(&data->mtd, NULL, 0);
> +
> +out:
> +	return ret;
> +}
> +
> +/**
> + * op_release - Release the driver
> + * @pdev: the platform device
> + *
> + * Returns 0
> + */
> +static int powernv_flash_release(struct platform_device *pdev)
> +{
> +	/* All resources should be freed automatically */

Other resources are ok, but mtd device should be explicitly deleted ..

Neelesh.

> +	return 0;
> +}
> +
> +static const struct of_device_id powernv_flash_match[] = {
> +	{ .compatible = "ibm,opal-flash" },
> +	{}
> +};
> +
> +static struct platform_driver powernv_flash_driver = {
> +	.driver		= {
> +		.name		= "powernv_flash",
> +		.of_match_table	= powernv_flash_match,
> +	},
> +	.remove		= powernv_flash_release,
> +	.probe		= powernv_flash_probe,
> +};
> +
> +module_platform_driver(powernv_flash_driver);
> +
> +MODULE_DEVICE_TABLE(of, powernv_flash_match);
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Cyril Bur <cyril.bur@au1.ibm.com>");
> +MODULE_DESCRIPTION("MTD abstraction for OPAL flash");


--------------060405070508030502060505
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    <br>
    <div class="moz-cite-prefix">On 05/28/2015 06:36 PM, Cyril Bur
      wrote:<br>
    </div>
    <blockquote
      cite="mid:1432818408-11558-1-git-send-email-cyrilbur@gmail.com"
      type="cite">
      <pre wrap="">Powerpc powernv platforms allow access to certain system flash devices
through a firmwarwe interface. This change adds an mtd driver for these
flash devices.

Minor updates from Jeremy Kerr and Joel Stanley.

Signed-off-by: Cyril Bur <a class="moz-txt-link-rfc2396E" href="mailto:cyrilbur@gmail.com">&lt;cyrilbur@gmail.com&gt;</a>
Signed-off-by: Joel Stanley <a class="moz-txt-link-rfc2396E" href="mailto:joel@jms.id.au">&lt;joel@jms.id.au&gt;</a>
Signed-off-by: Jeremy Kerr <a class="moz-txt-link-rfc2396E" href="mailto:jk@ozlabs.org">&lt;jk@ozlabs.org&gt;</a>
---
V2: Address Brian Norris' review
    Fix typos
    Change from NAND flash type to NOR flash type
    Correctness tweaks
---
 drivers/mtd/devices/Kconfig         |   8 +
 drivers/mtd/devices/Makefile        |   1 +
 drivers/mtd/devices/powernv_flash.c | 286 ++++++++++++++++++++++++++++++++++++
 3 files changed, 295 insertions(+)
 create mode 100644 drivers/mtd/devices/powernv_flash.c

diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
index c49d0b1..a8cc237 100644
--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -195,6 +195,14 @@ config MTD_BLOCK2MTD
 	  Testing MTD users (eg JFFS2) on large media and media that might
 	  be removed during a write (using the floppy drive).
 
+config MTD_POWERNV_FLASH
+	tristate "powernv flash MTD driver"
+	depends on PPC_POWERNV
+	help
+	  This provides an MTD device to access NVRAM on powernv OPAL</pre>
    </blockquote>
    <br>
    <small>NVRAM ? or to access FLASH device ?</small><br>
    <br>
    <blockquote
      cite="mid:1432818408-11558-1-git-send-email-cyrilbur@gmail.com"
      type="cite">
      <pre wrap="">
+	  platforms from Linux. This device abstracts away the
+	  firmware interface for NVRAM access.
+
 comment "Disk-On-Chip Device Drivers"
 
 config MTD_DOCG3
diff --git a/drivers/mtd/devices/Makefile b/drivers/mtd/devices/Makefile
index f0b0e61..7912d3a 100644
--- a/drivers/mtd/devices/Makefile
+++ b/drivers/mtd/devices/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_MTD_SPEAR_SMI)	+= spear_smi.o
 obj-$(CONFIG_MTD_SST25L)	+= sst25l.o
 obj-$(CONFIG_MTD_BCM47XXSFLASH)	+= bcm47xxsflash.o
 obj-$(CONFIG_MTD_ST_SPI_FSM)    += st_spi_fsm.o
+obj-$(CONFIG_MTD_POWERNV_FLASH)	+= powernv_flash.o
 
 
 CFLAGS_docg3.o			+= -I$(src)
diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
new file mode 100644
index 0000000..f619e4a
--- /dev/null
+++ b/drivers/mtd/devices/powernv_flash.c
@@ -0,0 +1,286 @@
+/*
+ * OPAL PNOR flash MTD abstraction
+ *
+ * IBM 2015
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include &lt;linux/kernel.h&gt;
+#include &lt;linux/module.h&gt;
+#include &lt;linux/errno.h&gt;
+#include &lt;linux/of.h&gt;
+#include &lt;linux/of_address.h&gt;
+#include &lt;linux/platform_device.h&gt;
+#include &lt;linux/string.h&gt;
+#include &lt;linux/slab.h&gt;
+#include &lt;linux/mtd/mtd.h&gt;
+#include &lt;linux/mtd/partitions.h&gt;
+
+#include &lt;linux/debugfs.h&gt;
+#include &lt;linux/seq_file.h&gt;
+
+#include &lt;asm/opal.h&gt;
+
+
+/*
+ * This driver creates the a Linux MTD abstraction for platform PNOR flash
+ * backed by OPAL calls
+ */
+
+struct powernv_flash {
+	struct mtd_info	mtd;
+	uint64_t	id;</pre>
    </blockquote>
    <br>
    <small>'id' should be u32</small><br>
    <br>
    <blockquote
      cite="mid:1432818408-11558-1-git-send-email-cyrilbur@gmail.com"
      type="cite">
      <pre wrap="">
+};
+
+enum flash_op {
+	FLASH_OP_READ,
+	FLASH_OP_WRITE,
+	FLASH_OP_ERASE,
+};
+
+static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
+		loff_t offset, size_t len, size_t *retlen, u_char *buf)
+{
+	struct powernv_flash *info = (struct powernv_flash *)mtd-&gt;priv;
+	struct device *dev = &amp;mtd-&gt;dev;
+	int token;
+	struct opal_msg msg;
+	int rc;
+
+	dev_dbg(dev, "%s(op=%d, offset=0x%llx, len=%zu)\n",
+			__func__, op, offset, len);
+
+	token = opal_async_get_token_interruptible();
+	if (token &lt; 0) {
+		dev_err(dev, "Failed to get an async token\n");
+		return -ENOMEM;</pre>
    </blockquote>
    <br>
    <small>ENOMEM is not correct code here.. 'token' itself has the
      right one in case of<br>
      failure. To be more precise,<br>
      if (token &lt; 0) {<br>
          if (token != -ERESTARTSYS)<br>
              dev_err(dev, "Failed to get an async token\n");<br>
      <br>
          return token;<br>
      }<br>
    </small><br>
    <blockquote
      cite="mid:1432818408-11558-1-git-send-email-cyrilbur@gmail.com"
      type="cite">
      <pre wrap="">
+	}
+
+	switch (op) {
+	case FLASH_OP_READ:
+		rc = opal_flash_read(info-&gt;id, offset, __pa(buf), len, token);
+		break;
+	case FLASH_OP_WRITE:
+		rc = opal_flash_write(info-&gt;id, offset, __pa(buf), len, token);
+		break;
+	case FLASH_OP_ERASE:
+		rc = opal_flash_erase(info-&gt;id, offset, len, token);
+		break;
+	default:
+		BUG_ON(1);
+	}
+
+	if (rc != OPAL_ASYNC_COMPLETION) {
+		dev_err(dev, "opal_flash_async_op(op=%d) failed (rc %d)\n",
+				op, rc);</pre>
    </blockquote>
    <br>
    <small>release the token, opal_async_release_token();</small><br>
    <br>
    <blockquote
      cite="mid:1432818408-11558-1-git-send-email-cyrilbur@gmail.com"
      type="cite">
      <pre wrap="">
+		return -EIO;
+	}
+
+	rc = opal_async_wait_response(token, &amp;msg);
+	opal_async_release_token(token);
+	if (rc) {
+		dev_err(dev, "opal async wait failed (rc %d)\n", rc);
+		return -EIO;
+	}
+
+	rc = be64_to_cpu(msg.params[1]);
+	if (rc == OPAL_SUCCESS) {
+		rc = 0;
+		if (retlen)
+			*retlen = len;
+	} else {
+		rc = -EIO;
+	}
+</pre>
    </blockquote>
    <br>
    <small>return rc;</small><br>
    <br>
    <blockquote
      cite="mid:1432818408-11558-1-git-send-email-cyrilbur@gmail.com"
      type="cite">
      <pre wrap="">
+	return 0;
+}
+
+/**
+ * @mtd: the device
+ * @from: the offset to read from
+ * @len: the number of bytes to read
+ * @retlen: the number of bytes actually read
+ * @buf: the filled in buffer
+ *
+ * Returns 0 if read successful, or -ERRNO if an error occurred
+ */
+static int powernv_flash_read(struct mtd_info *mtd, loff_t from, size_t len,
+	     size_t *retlen, u_char *buf)
+{
+	return powernv_flash_async_op(mtd, FLASH_OP_READ, from,
+			len, retlen, buf);
+}
+
+/**
+ * @mtd: the device
+ * @to: the offset to write to
+ * @len: the number of bytes to write
+ * @retlen: the number of bytes actually written
+ * @buf: the buffer to get bytes from
+ *
+ * Returns 0 if write successful, -ERRNO if error occurred
+ */
+static int powernv_flash_write(struct mtd_info *mtd, loff_t to, size_t len,
+		     size_t *retlen, const u_char *buf)
+{
+	return powernv_flash_async_op(mtd, FLASH_OP_WRITE, to,
+			len, retlen, (u_char *)buf);</pre>
    </blockquote>
    <br>
    <small>Why typecast ? 'buf' should be 'const' for write operation.</small><br>
    <br>
    <blockquote
      cite="mid:1432818408-11558-1-git-send-email-cyrilbur@gmail.com"
      type="cite">
      <pre wrap="">
+}
+
+/**
+ * @mtd: the device
+ * @erase: the erase info
+ * Returns 0 if erase successful or -ERRNO if an error occurred
+ */
+static int powernv_flash_erase(struct mtd_info *mtd, struct erase_info *erase)
+{
+	int rc;
+
+	erase-&gt;state = MTD_ERASING;
+
+	/* todo: register our own notifier to do a true async implementation */
+	rc =  powernv_flash_async_op(mtd, FLASH_OP_ERASE, erase-&gt;addr,
+			erase-&gt;len, NULL, NULL);
+
+	if (rc) {
+		erase-&gt;fail_addr = erase-&gt;addr;
+		erase-&gt;state = MTD_ERASE_FAILED;
+	} else {
+		erase-&gt;state = MTD_ERASE_DONE;
+	}
+	mtd_erase_callback(erase);</pre>
    </blockquote>
    <br>
    <small>return rc;</small><br>
    <br>
    <blockquote
      cite="mid:1432818408-11558-1-git-send-email-cyrilbur@gmail.com"
      type="cite">
      <pre wrap="">
+	return 0;
+}
+
+/**
+ * powernv_flash_set_driver_info - Fill the mtd_info structure and docg3
+ * structure @pdev: The platform device
+ * @mtd: The structure to fill
+ */
+static int __init powernv_flash_set_driver_info(struct device *dev,
+		struct mtd_info *mtd)</pre>
    </blockquote>
    <br>
    <small>Why __init tag ? Called from the probe so should not be .. ?</small><br>
    <br>
    <blockquote
      cite="mid:1432818408-11558-1-git-send-email-cyrilbur@gmail.com"
      type="cite">
      <pre wrap="">
+{
+	u64 size;
+	u32 erase_size;
+	int rc;
+
+	rc = of_property_read_u32(dev-&gt;of_node, "ibm,flash-block-size",
+			&amp;erase_size);
+	if (rc) {
+		dev_err(dev, "couldn't get resource block size information\n");
+		return rc;
+	}
+
+	rc = of_property_read_u64(dev-&gt;of_node, "reg", &amp;size);
+	if (rc) {
+		dev_err(dev, "couldn't get resource size information\n");
+		return rc;
+	}
+
+	/*
+	 * Going to have to check what details I need to set and how to
+	 * get them
+	 */
+	mtd-&gt;name = of_get_property(dev-&gt;of_node, "name", NULL);
+	/*
+	 * Using MTD_ABSENT as this is really just a passthrough to a firmware</pre>
    </blockquote>
    <br>
    <small>But you are using MTD_NORFLASH :)</small><br>
    <br>
    <blockquote
      cite="mid:1432818408-11558-1-git-send-email-cyrilbur@gmail.com"
      type="cite">
      <pre wrap="">
+	 * interface
+	 */
+	mtd-&gt;type = MTD_NORFLASH;
+	mtd-&gt;flags = MTD_WRITEABLE;
+	mtd-&gt;size = size;
+	mtd-&gt;erasesize = erase_size;
+	mtd-&gt;writebufsize = mtd-&gt;writesize = 1;
+	mtd-&gt;owner = THIS_MODULE;
+	mtd-&gt;_erase = powernv_flash_erase;
+	mtd-&gt;_read = powernv_flash_read;
+	mtd-&gt;_write = powernv_flash_write;
+	mtd-&gt;dev.parent = dev;
+	return 0;
+}
+
+/**
+ * powernv_flash_probe
+ * @pdev: platform device
+ *
+ * Returns 0 on success, -ENOMEM, -ENXIO on error
+ */
+static int powernv_flash_probe(struct platform_device *pdev)
+{
+	struct device *dev = &amp;pdev-&gt;dev;
+	struct powernv_flash *data;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	data-&gt;mtd.priv = data;
+
+	ret = of_property_read_u32(dev-&gt;of_node, "ibm,opal-id", &amp;(data-&gt;id));
+	if (ret) {
+		dev_err(dev, "no device property 'ibm,opal-id'\n");
+		goto out;
+	}
+
+	ret = powernv_flash_set_driver_info(dev, &amp;data-&gt;mtd);
+	if (ret)
+		goto out;
+
+	/*
+	 * Skiboot does expose the partitioning information via OF and the
+	 * ofpart parser could partition it all nicely.
+	 *
+	 * The current flash that skiboot exposes is one contiguous flash chip
+	 * with an ffs partition at the start, it should prove easier for users
+	 * to deal with partitions or not as they see fit
+	 */
+	ret = mtd_device_register(&amp;data-&gt;mtd, NULL, 0);
+
+out:
+	return ret;
+}
+
+/**
+ * op_release - Release the driver
+ * @pdev: the platform device
+ *
+ * Returns 0
+ */
+static int powernv_flash_release(struct platform_device *pdev)
+{
+	/* All resources should be freed automatically */</pre>
    </blockquote>
    <br>
    <small>Other resources are ok, but mtd device should be explicitly
      deleted .. </small><br>
    <br>
    <small>Neelesh.</small><br>
    <br>
    <blockquote
      cite="mid:1432818408-11558-1-git-send-email-cyrilbur@gmail.com"
      type="cite">
      <pre wrap="">
+	return 0;
+}
+
+static const struct of_device_id powernv_flash_match[] = {
+	{ .compatible = "ibm,opal-flash" },
+	{}
+};
+
+static struct platform_driver powernv_flash_driver = {
+	.driver		= {
+		.name		= "powernv_flash",
+		.of_match_table	= powernv_flash_match,
+	},
+	.remove		= powernv_flash_release,
+	.probe		= powernv_flash_probe,
+};
+
+module_platform_driver(powernv_flash_driver);
+
+MODULE_DEVICE_TABLE(of, powernv_flash_match);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Cyril Bur <a class="moz-txt-link-rfc2396E" href="mailto:cyril.bur@au1.ibm.com">&lt;cyril.bur@au1.ibm.com&gt;</a>");
+MODULE_DESCRIPTION("MTD abstraction for OPAL flash");
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------060405070508030502060505--
