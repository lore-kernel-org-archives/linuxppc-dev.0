Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D4D301A2F6B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 19:22:49 +1000 (AEST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C7843140E60
 for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2015 19:22:48 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Fri, 29 May 2015 14:52:45 +0530
Message-ID: <55682FDC.8030505@linux.vnet.ibm.com>
Date: Fri, 29 May 2015 14:52:36 +0530
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@ozlabs.org
CC: Joel Stanley <joel@jms.id.au>, Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH V3] drivers/mtd: add powernv flash MTD abstraction driver
References: <1432884797-3056-1-git-send-email-cyrilbur@gmail.com>
In-Reply-To: <1432884797-3056-1-git-send-email-cyrilbur@gmail.com>
Content-Type: multipart/alternative;
 boundary="------------050005070007050102010705"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050005070007050102010705
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


[...]
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

return rc ? You also document the same  '.... or -ERRNO if an error 
occurred'

> +	return 0;
> +}
> +
> +/**
> + * powernv_flash_set_driver_info - Fill the mtd_info structure and docg3
> + * structure @pdev: The platform device
> + * @mtd: The structure to fill
> + */
> +static int powernv_flash_set_driver_info(struct device *dev,
> +		struct mtd_info *mtd)
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

'mtd' is contained within the 'data' so you can cast 'mtd' to get the 'data'
anywhere you want using container_of() macro.. 'priv' can be used to pass
an unrelated structure ....  just a thought, you may ignore it.. :)

Rest looks ok.

Neelesh.



--------------050005070007050102010705
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    <div class="moz-cite-prefix"><small>[...]</small><br>
    </div>
    <blockquote
      cite="mid:1432884797-3056-1-git-send-email-cyrilbur@gmail.com"
      type="cite">
      <pre wrap="">
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
    <small>return rc ? You also document the same  '.... or -ERRNO if an
      error occurred'<br>
    </small><br>
    <blockquote
      cite="mid:1432884797-3056-1-git-send-email-cyrilbur@gmail.com"
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
+static int powernv_flash_set_driver_info(struct device *dev,
+		struct mtd_info *mtd)
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
+	data-&gt;mtd.priv = data;</pre>
    </blockquote>
    <br>
    <small>'mtd' is contained within the 'data' so you can cast 'mtd' to
      get the 'data'<br>
      anywhere you want using container_of() macro.. 'priv' can be used
      to pass<br>
      an unrelated structure ....  just a thought, you may ignore it..
      :)<br>
      <br>
      Rest looks ok.<br>
      <br>
      Neelesh.<br>
    </small><br>
    <br>
  </body>
</html>

--------------050005070007050102010705--
