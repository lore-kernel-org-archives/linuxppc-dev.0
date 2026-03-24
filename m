Return-Path: <linuxppc-dev+bounces-18655-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7DCF532C0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 01:01:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffsDG1vZRz2yhv;
	Tue, 24 Mar 2026 12:01:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774314062;
	cv=none; b=iobQKB7Nmzxj7Tji2S0ioseoVpVEIV2wtmlK9aZdCM+yB6ZoeK5nw5HHnM3EXCjQpN15IWwwnsu6sD8rbjUkTMzCXMhTt0SMIMu0zvjdm1Ieug18Qs79cyfUF97FipeySjGbcVbHjjSsCMW7SpooxCxBB6WRbs2akGGmMhTjSgJibY/O00V6JbFF20C7vXdGuiqUnWeQWKqV5J7Mq0XhMyM81gMcPI590tXfGlvUE01BAbKCacaJWKHurYLUsIcZETDdvquQh7vruhzsSZmvBRSU1vjUlh2Ctyfj1/OjOkkMCHal199b71D1t4zfSSd7894UWFdOJ1JTu+wJ3BiRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774314062; c=relaxed/relaxed;
	bh=VkTaNbllFdXAfFnk9N/PYFIXzWHjOHJz7Mb/kxW/ylw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qx42GYaE4z2LlNYB1VnnR4kyw+9ulmMvyfs86luWZDpZh8tbcLiFMo5k3FjHqoOU3/aeW809yWBea9UdWjOWHTqVLKFxANF6Zrx5yq6JB4HAv0/lNOSAfeiGo1IBJc4K/bfEWYPTiV2qNPWWgdRPL9pYdAaQc8BJA7hLG16PPdxS+YbuFG8hu8oAcimfmykQyXffmKKBQMoiJSySZuyGXVvnFW3xxXgK6Z4ssPtlfLh2zW14bMq8KHVh3Pt2L/c9RLg4kKZMpZWSngR/wS5p5AWZ2rnAZ0goCahp4rEq/uEeQNoI0aw+25JJNeTKbeTAEbSm2e9G2zlE/3sVOU2LIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=M5cmM+6D; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=M5cmM+6D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffsDF3GsFz2yVB
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 12:01:01 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6F07260121;
	Tue, 24 Mar 2026 01:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37F1C4CEF7;
	Tue, 24 Mar 2026 01:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774314059;
	bh=ByobimVvZngWYiBS4MISNoCZaILbn7MyP0EmUHxONX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M5cmM+6DyqmK+EAGRvLHS/yaDqvmCvw5jU4r7SCyXiBwcQBFFqbb4X/i4pXN2bi2S
	 gHkRbl+Xo3RELYoiG4jfGiG71cPBeRkIjOhdvO7LyCtTJjVMWWsggEZfDrMHEQh/LT
	 sJPml12ZLm2ZXWcUV7+rSBuPDv4wlXIGpfa5Mp3UMgF0NSXsREGrGnuvEljzT3nxKU
	 rRCqRHzFA+L/AZEsNVivSFaFs9zyzzt9OOmEyPjs+2mnPiQ4PBAEg9i9nAYF6+ohUT
	 5vkv2XGga3nnGd1hHPKmfzckD1wY8wwkbKkdLTe4mZgsX9KBZZceAs6EiZe7MaJYyF
	 N2W+3BMlOYL3w==
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
Subject: [PATCH 09/12] s390/cio: use generic driver_override infrastructure
Date: Tue, 24 Mar 2026 01:59:13 +0100
Message-ID: <20260324005919.2408620-10-dakr@kernel.org>
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
Fixes: ebc3d1791503 ("s390/cio: introduce driver_override on the css bus")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/s390/cio/cio.h |  5 -----
 drivers/s390/cio/css.c | 34 ++++------------------------------
 2 files changed, 4 insertions(+), 35 deletions(-)

diff --git a/drivers/s390/cio/cio.h b/drivers/s390/cio/cio.h
index 08a5e9380e75..bad142c536e1 100644
--- a/drivers/s390/cio/cio.h
+++ b/drivers/s390/cio/cio.h
@@ -103,11 +103,6 @@ struct subchannel {
 	struct work_struct todo_work;
 	struct schib_config config;
 	u64 dma_mask;
-	/*
-	 * Driver name to force a match.  Do not set directly, because core
-	 * frees it.  Use driver_set_override() to set or clear it.
-	 */
-	const char *driver_override;
 } __attribute__ ((aligned(8)));
 
 DECLARE_PER_CPU_ALIGNED(struct irb, cio_irb);
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 5ab239f38588..e5a0ec6b4e3e 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -159,7 +159,6 @@ static void css_subchannel_release(struct device *dev)
 
 	sch->config.intparm = 0;
 	cio_commit_config(sch);
-	kfree(sch->driver_override);
 	kfree(sch);
 }
 
@@ -323,37 +322,9 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_RO(modalias);
 
-static ssize_t driver_override_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
-{
-	struct subchannel *sch = to_subchannel(dev);
-	int ret;
-
-	ret = driver_set_override(dev, &sch->driver_override, buf, count);
-	if (ret)
-		return ret;
-
-	return count;
-}
-
-static ssize_t driver_override_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
-{
-	struct subchannel *sch = to_subchannel(dev);
-	ssize_t len;
-
-	device_lock(dev);
-	len = sysfs_emit(buf, "%s\n", sch->driver_override);
-	device_unlock(dev);
-	return len;
-}
-static DEVICE_ATTR_RW(driver_override);
-
 static struct attribute *subch_attrs[] = {
 	&dev_attr_type.attr,
 	&dev_attr_modalias.attr,
-	&dev_attr_driver_override.attr,
 	NULL,
 };
 
@@ -1356,9 +1327,11 @@ static int css_bus_match(struct device *dev, const struct device_driver *drv)
 	struct subchannel *sch = to_subchannel(dev);
 	const struct css_driver *driver = to_cssdriver(drv);
 	struct css_device_id *id;
+	int ret;
 
 	/* When driver_override is set, only bind to the matching driver */
-	if (sch->driver_override && strcmp(sch->driver_override, drv->name))
+	ret = device_match_driver_override(dev, drv);
+	if (ret == 0)
 		return 0;
 
 	for (id = driver->subchannel_type; id->match_flags; id++) {
@@ -1415,6 +1388,7 @@ static int css_uevent(const struct device *dev, struct kobj_uevent_env *env)
 
 static const struct bus_type css_bus_type = {
 	.name     = "css",
+	.driver_override = true,
 	.match    = css_bus_match,
 	.probe    = css_probe,
 	.remove   = css_remove,
-- 
2.53.0


