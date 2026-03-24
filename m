Return-Path: <linuxppc-dev+bounces-18648-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55ABF532C0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 00:59:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffsBy2dxnz2yhX;
	Tue, 24 Mar 2026 11:59:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774313994;
	cv=none; b=M2vkp8OadPp62WE2NR1gsewFyyV2Cdw0X+QqFwEiACNZQKcACj398h95X0mRDY83nBiTrHvh1kvNl8FvYxrQB559xMAWzo73n8OLtkmzkPR49e9pPdBqgXd80fmCCwh1wp0XdkDvHmMbdFjWNY6uMI0oXo4bBCHoYUt4IukXKbsIYeeRVBQRfs/bNsP5NzlFL+Dz5ZDjvO7Y6YHTrxG37lkUDN/hwYCIMqBQAvYI8E+XnH746NiQCnTEiXCYNKM7/NIS7fPb9Wb2o0Bs57E2Zz6bgZfsUbVBYqBgIMv9fgltfqkzuKxquF7Y8G0A53fB/X9wNVyjonYadaGHqeP9Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774313994; c=relaxed/relaxed;
	bh=OPwtwsExGGrY22RxyBDyJaQVGtfuIJPA6oHaC8NJpqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDOmpe3m/uSK/Zf36lUzcWBaTzdKr8Q/4VlXUzQwgLRHaD2jH783eoKcUA7pgDL4YCcGvtZkf0lNScnPK/C+QiC8ukcxR3Yct5wXVZOLjyWD6K5q9FW2+M2TdG+0DcKVuKDMEIqpjMHeGOJ1ZSjMr3oaGMkuNKZg8N0ZJ3+TnHfpMrZxsjdsCocUOU/XAn5fEAMkOgceaQegQpdNiVx50tEoXoOg5cA39Wv359Fp0cY+JxclqtLtTIl+NDMS9kQxxZ80kQtF6hmO/HFbi47vNIt3riVPlfPIOQgK44VGMI+iIa7Ch9UPBhctFD8WiapCoxo6OofEn/Kloy8avNxMJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fg9y82ia; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fg9y82ia;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffsBx3c2pz2ySb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 11:59:53 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 87C0F60120;
	Tue, 24 Mar 2026 00:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138D4C4CEF7;
	Tue, 24 Mar 2026 00:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774313991;
	bh=8SBWPlY0FpAPUZM3VGM6jk8MBe902KSJN4WiLZGAbHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fg9y82iadfDPF6nOAy0HmPYPAiOP6FG/VDHn1TkIcmsusWoR+G/nVZNnCuZY075br
	 gKlvWvjVdGmnI0JgptoDvayEdCUtkEYfsg2A7PluZUkmjkJczc4SoAIa2b+24cTLMO
	 ehoUBK1kyWeitGv4Js4jW16nmf/+SUVzGnTpP2KwCYTWTgtSAqvsLMsfsTs35ptcMx
	 Qhx+u6Ww/NKX1+DPPnLU1acTql1U6mNB+wnFZugPadRV0p5Gw0gHRTgVhOLxhxmRdq
	 AfBcD9mRlS2Zl/SNmQhvetfwNouTevadSCvwGk1WKIFaHCmyoKhqRcaFynIdgVlqMc
	 HA/jQLBEPF5WA==
From: Danilo Krummrich <dakr@kernel.org>
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-spi@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-arm-kernel@lists.infradead.org,
	Danilo Krummrich <dakr@kernel.org>,
	Gui-Dong Han <hanguidong02@gmail.com>
Subject: [PATCH 02/12] bus: fsl-mc: use generic driver_override infrastructure
Date: Tue, 24 Mar 2026 01:59:06 +0100
Message-ID: <20260324005919.2408620-3-dakr@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324005919.2408620-1-dakr@kernel.org>
References: <20260324005919.2408620-1-dakr@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a driver is probed through __driver_attach(), the bus' match()
callback is called without the device lock held, thus accessing the
driver_override field without a lock, which can cause a UAF.

Fix this by using the driver-core driver_override infrastructure taking
care of proper locking internally.

Note that calling match() from __driver_attach() without the device lock
held is intentional. [1]

Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kernel.org/ [1]
Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220789
Fixes: 1f86a00c1159 ("bus/fsl-mc: add support for 'driver_override' in the mc-bus")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c   | 43 +++++--------------------------
 drivers/vfio/fsl-mc/vfio_fsl_mc.c |  4 +--
 include/linux/fsl/mc.h            |  4 ---
 3 files changed, 8 insertions(+), 43 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index c117745cf206..221146e4860b 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -86,12 +86,16 @@ static int fsl_mc_bus_match(struct device *dev, const struct device_driver *drv)
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
 	const struct fsl_mc_driver *mc_drv = to_fsl_mc_driver(drv);
 	bool found = false;
+	int ret;
 
 	/* When driver_override is set, only bind to the matching driver */
-	if (mc_dev->driver_override) {
-		found = !strcmp(mc_dev->driver_override, mc_drv->driver.name);
+	ret = device_match_driver_override(dev, drv);
+	if (ret > 0) {
+		found = true;
 		goto out;
 	}
+	if (ret == 0)
+		goto out;
 
 	if (!mc_drv->match_id_table)
 		goto out;
@@ -210,39 +214,8 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(modalias);
 
-static ssize_t driver_override_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
-{
-	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
-	int ret;
-
-	if (WARN_ON(dev->bus != &fsl_mc_bus_type))
-		return -EINVAL;
-
-	ret = driver_set_override(dev, &mc_dev->driver_override, buf, count);
-	if (ret)
-		return ret;
-
-	return count;
-}
-
-static ssize_t driver_override_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
-{
-	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
-	ssize_t len;
-
-	device_lock(dev);
-	len = sysfs_emit(buf, "%s\n", mc_dev->driver_override);
-	device_unlock(dev);
-	return len;
-}
-static DEVICE_ATTR_RW(driver_override);
-
 static struct attribute *fsl_mc_dev_attrs[] = {
 	&dev_attr_modalias.attr,
-	&dev_attr_driver_override.attr,
 	NULL,
 };
 
@@ -345,6 +318,7 @@ ATTRIBUTE_GROUPS(fsl_mc_bus);
 
 const struct bus_type fsl_mc_bus_type = {
 	.name = "fsl-mc",
+	.driver_override = true,
 	.match = fsl_mc_bus_match,
 	.uevent = fsl_mc_bus_uevent,
 	.probe = fsl_mc_probe,
@@ -910,9 +884,6 @@ static struct notifier_block fsl_mc_nb;
  */
 void fsl_mc_device_remove(struct fsl_mc_device *mc_dev)
 {
-	kfree(mc_dev->driver_override);
-	mc_dev->driver_override = NULL;
-
 	/*
 	 * The device-specific remove callback will get invoked by device_del()
 	 */
diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc.c b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
index 462fae1aa538..b4c3958201b2 100644
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
@@ -424,9 +424,7 @@ static int vfio_fsl_mc_bus_notifier(struct notifier_block *nb,
 
 	if (action == BUS_NOTIFY_ADD_DEVICE &&
 	    vdev->mc_dev == mc_cont) {
-		mc_dev->driver_override = kasprintf(GFP_KERNEL, "%s",
-						    vfio_fsl_mc_ops.name);
-		if (!mc_dev->driver_override)
+		if (device_set_driver_override(dev, vfio_fsl_mc_ops.name))
 			dev_warn(dev, "VFIO_FSL_MC: Setting driver override for device in dprc %s failed\n",
 				 dev_name(&mc_cont->dev));
 		else
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 897d6211c163..1da63f2d7040 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -178,9 +178,6 @@ struct fsl_mc_obj_desc {
  * @regions: pointer to array of MMIO region entries
  * @irqs: pointer to array of pointers to interrupts allocated to this device
  * @resource: generic resource associated with this MC object device, if any.
- * @driver_override: driver name to force a match; do not set directly,
- *                   because core frees it; use driver_set_override() to
- *                   set or clear it.
  *
  * Generic device object for MC object devices that are "attached" to a
  * MC bus.
@@ -214,7 +211,6 @@ struct fsl_mc_device {
 	struct fsl_mc_device_irq **irqs;
 	struct fsl_mc_resource *resource;
 	struct device_link *consumer_link;
-	const char *driver_override;
 };
 
 #define to_fsl_mc_device(_dev) \
-- 
2.53.0


