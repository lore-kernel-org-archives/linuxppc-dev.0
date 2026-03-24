Return-Path: <linuxppc-dev+bounces-18654-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738DCF532C0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 01:00:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffsD412fCz2ynn;
	Tue, 24 Mar 2026 12:00:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774314052;
	cv=none; b=axsW6wD7X0Y2NwC7J/1n7m/Pi1TDHz0caWAHnRVo63ZJbBMOv//dzadEUpVhN6L+17pUogfw+6tGdTFHebx+Eo66y3jPHQa9q9P/fSN1vD5RKwiYgI8t/7VMhNEWraBtGwK92/xO/UwYJBf0FYh5uxsQXclgK1H30jrgbtikTCoHGKNayOE7/svfhfbd41ILLI99nzk9gt3e6FInWlc8UXpuw6JZ4nBDlzCg3GD/Jz/S++hb9UwvbIbHDb4NVMcH5LL+0LQn1SriZkvSn9DxcPAdjv5cQTLIL6oqhdYJ0jqtH7LUV2rXRvA3x5DyYJz+AxYVwJW/BoqVKFijc3z1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774314052; c=relaxed/relaxed;
	bh=+MLshFReIqhZSL4PQBZb5w4TLJZFVfWFxsrP2NTpU6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxoUSaq6Nf/Fy5bld4I8rWpthYfPf2fnyewHpcbmWHlmYSbKKCAyDZMaZxuZH8l9v9iEs4IMuQb1kgoB8MIOnTfsIJa5uVxcaset9kXuuAXQiVnG8YfEu+3j0WJaZhMpxia884a6pS1HwZECzBiUM4djgC3XljUEImfQidqpL6Z9PsPiDBwDEUAGsh+su9cv2FzelVgvcT5DV4RwMfyXrh4+nT3bisoS0qNsy+MHkzKjOcrZL1g1x+inQd7JOMhtlyw2sjXLfrRljr1zjre0TO3VnlHLhvYEWNKgzS0g+UGxaZq6aUw/xoooy+PeOdYSV8p8H+yrSugU1IQ5g5yYBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=urbkSyPC; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=urbkSyPC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffsD3323Wz2yVB
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 12:00:51 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A8BF1402D2;
	Tue, 24 Mar 2026 01:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600FAC2BCB3;
	Tue, 24 Mar 2026 01:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774314049;
	bh=2lHhdrgE9qzH1ZdWMWGXkZLiIUExSh17kxoWzoBpEYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=urbkSyPC//Mc+7xDMT60BWD1PM5iJno/Pv3C12Ww9BFBlm+Txslon6hgVop799Zux
	 g+Sv+q81mxYoKpArwgNlL1ZLxKeJEZHi/lM3U9lsj91wt+dVuwPQVluFb1QQ+HQlCj
	 sv5wTpgn5xlflwnnmanQE9E5F/Pn2wr+wAILRhGodQgtrhj4oxFDHJG9NtY75ERcHC
	 m7A8DB8J2Ne77LkVgV0/eIo9dU9uCfUYKNhjjLT4Tt3E8Clc0+8oqnyAcHS/Bg4R5L
	 D1zJWmU8m174lSqL3A0Ubvc3fqLrq3bwEdahRa42TfG/CVeZDK4Hwt1j/T6kr4aNVX
	 9oiBCcvJ5IK1g==
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
Subject: [PATCH 08/12] vdpa: use generic driver_override infrastructure
Date: Tue, 24 Mar 2026 01:59:12 +0100
Message-ID: <20260324005919.2408620-9-dakr@kernel.org>
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
Fixes: 539fec78edb4 ("vdpa: add driver_override support")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/vdpa/vdpa.c  | 48 +++++---------------------------------------
 include/linux/vdpa.h |  4 ----
 2 files changed, 5 insertions(+), 47 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 34874beb0152..caf0ee5d6856 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -67,57 +67,20 @@ static void vdpa_dev_remove(struct device *d)
 
 static int vdpa_dev_match(struct device *dev, const struct device_driver *drv)
 {
-	struct vdpa_device *vdev = dev_to_vdpa(dev);
+	int ret;
 
 	/* Check override first, and if set, only use the named driver */
-	if (vdev->driver_override)
-		return strcmp(vdev->driver_override, drv->name) == 0;
+	ret = device_match_driver_override(dev, drv);
+	if (ret >= 0)
+		return ret;
 
 	/* Currently devices must be supported by all vDPA bus drivers */
 	return 1;
 }
 
-static ssize_t driver_override_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
-{
-	struct vdpa_device *vdev = dev_to_vdpa(dev);
-	int ret;
-
-	ret = driver_set_override(dev, &vdev->driver_override, buf, count);
-	if (ret)
-		return ret;
-
-	return count;
-}
-
-static ssize_t driver_override_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
-{
-	struct vdpa_device *vdev = dev_to_vdpa(dev);
-	ssize_t len;
-
-	device_lock(dev);
-	len = sysfs_emit(buf, "%s\n", vdev->driver_override);
-	device_unlock(dev);
-
-	return len;
-}
-static DEVICE_ATTR_RW(driver_override);
-
-static struct attribute *vdpa_dev_attrs[] = {
-	&dev_attr_driver_override.attr,
-	NULL,
-};
-
-static const struct attribute_group vdpa_dev_group = {
-	.attrs  = vdpa_dev_attrs,
-};
-__ATTRIBUTE_GROUPS(vdpa_dev);
-
 static const struct bus_type vdpa_bus = {
 	.name  = "vdpa",
-	.dev_groups = vdpa_dev_groups,
+	.driver_override = true,
 	.match = vdpa_dev_match,
 	.probe = vdpa_dev_probe,
 	.remove = vdpa_dev_remove,
@@ -132,7 +95,6 @@ static void vdpa_release_dev(struct device *d)
 		ops->free(vdev);
 
 	ida_free(&vdpa_index_ida, vdev->index);
-	kfree(vdev->driver_override);
 	kfree(vdev);
 }
 
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 2bfe3baa63f4..782c42d25db1 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -72,9 +72,6 @@ struct vdpa_mgmt_dev;
  * struct vdpa_device - representation of a vDPA device
  * @dev: underlying device
  * @vmap: the metadata passed to upper layer to be used for mapping
- * @driver_override: driver name to force a match; do not set directly,
- *                   because core frees it; use driver_set_override() to
- *                   set or clear it.
  * @config: the configuration ops for this device.
  * @map: the map ops for this device
  * @cf_lock: Protects get and set access to configuration layout.
@@ -90,7 +87,6 @@ struct vdpa_mgmt_dev;
 struct vdpa_device {
 	struct device dev;
 	union virtio_map vmap;
-	const char *driver_override;
 	const struct vdpa_config_ops *config;
 	const struct virtio_map_ops *map;
 	struct rw_semaphore cf_lock; /* Protects get/set config */
-- 
2.53.0


