Return-Path: <linuxppc-dev+bounces-18647-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96986F532C6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 00:59:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffsBm1qkzz2yhZ;
	Tue, 24 Mar 2026 11:59:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774313984;
	cv=none; b=PGQtMsPCWPM0H/ntFMTWqa0hDuJyNmcaUBPDvpr1mPPoQAy7mCDGDHQQk6J1FfZSOzbE2/+xnul0aeNoTNsC/oLk5tJ8glbKbi5qGnRzaOIKyrguptBX86z2vBqMnxmy4njAqqNNtVvhw2bnPsLlD9rokyDUsYQV7pJy4WpnIArhIf7QAW/15+bZ4ag9RCAm5LwnkgortIt8ycmKlsvY9e0wwG4NdQu4SszKe9U2Im9ApV/AeLqtIGT14CZvDRJgtge5ft7CJNhVkmzi6llKbacpDH+/He0HSCo+SD/wdUX0XQq8veeao2RWnSe2qZDG7616RKQqwJTXEvQn934CTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774313984; c=relaxed/relaxed;
	bh=bJX4tcMv3azIr3OdPdwDjBbGyGyq8wzUXp3/0swsCLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfODY1clC3MYgMlIDoRpG1r9NJqVHvOAAmPcd1SSP/K3xkhd2qlRu1Qi4Tk9+9tqDMnLdKEquLeEm/Fv5HmBlKrXji9YNp1cbXjXAjkJR98hNmYaHqvJNANE/7M7eTh3XQLgxRrpdbJhaVQSLJqF87W3rIp8e7Ntrxb3c6egSm88N4nzChODerf3UiM1tAJUCPp+gM05po4u4QswuY+bwOa9ybK+YwfktC7sJPwldcVxRxlZhR4oxCsndTrR+7AOrPUirMeVM9Zs32mGFKvgfhSxRRMRKqJA0IEr9KGxSuAUbL/f9BHFh2RtUwEJB9Fu4AA2CZVzXTY3Tk4WQMZuqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DeU+QBJf; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DeU+QBJf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffsBl3lcYz2ySb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 11:59:43 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BD3E1401EA;
	Tue, 24 Mar 2026 00:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B53C2BCB0;
	Tue, 24 Mar 2026 00:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774313981;
	bh=o5/mDooZyQOrZSLaTUy9Q9NB3objYZ00gEDKIr30vk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DeU+QBJfQMOEykZ/WseCRw8ncQ/uYJtSAPERUFs4wNJFjvV2eSGwXi54+3St1qSR0
	 yoc1l4FX7gt53/9/XvMnHRcN9nfHKNjkr8h3i441z0kpJEthS6at4bwtLuCRwWfwTQ
	 zUOFjmjLi/lakrrKFe0OAiGbBQZC2pUowaUyN1Nk59BHGkOwYH5feY1hPfdn8wxuy2
	 UQmUcUXQvvOo9AYPJsg0ROOga1OdkZyNhVwqLzazfIXDXCjcb3ZiQGDZJxXC84R4A9
	 oUXH/PpxuyEXrmj7leMJZR37mYepHdDuAXgplUUb9/VB/fUvY3/ve++LVUHPkSsSG8
	 ggFejhQuC6MoA==
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
Subject: [PATCH 01/12] amba: use generic driver_override infrastructure
Date: Tue, 24 Mar 2026 01:59:05 +0100
Message-ID: <20260324005919.2408620-2-dakr@kernel.org>
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
Fixes: 3cf385713460 ("ARM: 8256/1: driver coamba: add device binding path 'driver_override'")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/amba/bus.c       | 37 ++++++-------------------------------
 include/linux/amba/bus.h |  5 -----
 2 files changed, 6 insertions(+), 36 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 6d479caf89cb..d721d64a9858 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -82,33 +82,6 @@ static void amba_put_disable_pclk(struct amba_device *pcdev)
 }
 
 
-static ssize_t driver_override_show(struct device *_dev,
-				    struct device_attribute *attr, char *buf)
-{
-	struct amba_device *dev = to_amba_device(_dev);
-	ssize_t len;
-
-	device_lock(_dev);
-	len = sprintf(buf, "%s\n", dev->driver_override);
-	device_unlock(_dev);
-	return len;
-}
-
-static ssize_t driver_override_store(struct device *_dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
-{
-	struct amba_device *dev = to_amba_device(_dev);
-	int ret;
-
-	ret = driver_set_override(_dev, &dev->driver_override, buf, count);
-	if (ret)
-		return ret;
-
-	return count;
-}
-static DEVICE_ATTR_RW(driver_override);
-
 #define amba_attr_func(name,fmt,arg...)					\
 static ssize_t name##_show(struct device *_dev,				\
 			   struct device_attribute *attr, char *buf)	\
@@ -126,7 +99,6 @@ amba_attr_func(resource, "\t%016llx\t%016llx\t%016lx\n",
 static struct attribute *amba_dev_attrs[] = {
 	&dev_attr_id.attr,
 	&dev_attr_resource.attr,
-	&dev_attr_driver_override.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(amba_dev);
@@ -209,10 +181,11 @@ static int amba_match(struct device *dev, const struct device_driver *drv)
 {
 	struct amba_device *pcdev = to_amba_device(dev);
 	const struct amba_driver *pcdrv = to_amba_driver(drv);
+	int ret;
 
 	mutex_lock(&pcdev->periphid_lock);
 	if (!pcdev->periphid) {
-		int ret = amba_read_periphid(pcdev);
+		ret = amba_read_periphid(pcdev);
 
 		/*
 		 * Returning any error other than -EPROBE_DEFER from bus match
@@ -230,8 +203,9 @@ static int amba_match(struct device *dev, const struct device_driver *drv)
 	mutex_unlock(&pcdev->periphid_lock);
 
 	/* When driver_override is set, only bind to the matching driver */
-	if (pcdev->driver_override)
-		return !strcmp(pcdev->driver_override, drv->name);
+	ret = device_match_driver_override(dev, drv);
+	if (ret >= 0)
+		return ret;
 
 	return amba_lookup(pcdrv->id_table, pcdev) != NULL;
 }
@@ -436,6 +410,7 @@ static const struct dev_pm_ops amba_pm = {
 const struct bus_type amba_bustype = {
 	.name		= "amba",
 	.dev_groups	= amba_dev_groups,
+	.driver_override = true,
 	.match		= amba_match,
 	.uevent		= amba_uevent,
 	.probe		= amba_probe,
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 9946276aff73..6c54d5c0d21f 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -71,11 +71,6 @@ struct amba_device {
 	unsigned int		cid;
 	struct amba_cs_uci_id	uci;
 	unsigned int		irq[AMBA_NR_IRQS];
-	/*
-	 * Driver name to force a match.  Do not set directly, because core
-	 * frees it.  Use driver_set_override() to set or clear it.
-	 */
-	const char		*driver_override;
 };
 
 struct amba_driver {
-- 
2.53.0


