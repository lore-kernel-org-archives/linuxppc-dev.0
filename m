Return-Path: <linuxppc-dev+bounces-4380-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AECE7718B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Dec 2024 14:48:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YFnGH6Gswz2xmk;
	Sun, 22 Dec 2024 01:48:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734792503;
	cv=none; b=GmMl7H0AjXI1ETxhcMPDFNOtqhiTxRXex0Gd8ouyy1jstZBzjBeOcbNQJLuDqx1c3m9CfhvJHJtb6O6OqeDQ1RzX+MuhftIyCSW+8gFv4dVjgPv/4Rtvv3frcSCtB7N9qMIymQVhFSSfVU2Djbz4KzArjFvcPFq/hyuIQ02MghCLx0eqf9/Dj/ZIrpjlSpMicazq0DojxUWQ1tYvgJnfyy173sDcDfbFkfuUD5yjwA9aFLza5ceTPtu9QI+mZvbY0CfpmwixYuRrKgLD4BB1XZDWQN299cLlNqUWymeu1Y07YxMGij5jRdv+rbTD0V3TISjDjTUspn1ENdXOQFcK/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734792503; c=relaxed/relaxed;
	bh=kF+rotHy31iLhqM9Yd1YjAeblQGyFGEfB4ObcwBNME0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lOpjfORV4dCuI83pR35PZxevaOAZN+U7ezl62G3vncL4tF+X+YPzl6olsfLfnc4AtGyL/NEUxDMd68B2JAv8uj+nNXhaJJqBDuVOa/VwBGCuEkh9QbtVRrVxk+gbMBRd39FQZD5SPpv6aVbQUl+vTMpPisXHmaUq+ldGs4ro8nU6gX6dZe2YsMu18SXhzVxFWw4h0ZDktFYHe5ZjihP9zYaTG94aWL4JwEegcDHDlMjXWrX8hVBAUaaAzF+A1Hqowd3m5B3WjjgQXsUuAIsLVLNp8KETj/sYc5MkyIJEy+w12GcPtFLlh1hYbgirqLIJKilRXkNjhZ4EYS8Jr69ABQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=enMld3zO; dkim-atps=neutral; spf=pass (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=enMld3zO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YFnGD1Mzjz2xbP
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Dec 2024 01:48:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734792491;
	bh=H724roLIaoPip44zZqVVk4vtvisEZYzLS47/VZWgyws=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=enMld3zO6o9mSKLhYxKXQHG2Bbc+Rs+lByn+GiB88gzFWqhFsDLgpQ/CPRdpDkwKD
	 RisG0Szjk9NMl3jV0HnhYxnY9RxEJQKbGKoKRg0Mm7dRmt8lVOdE/wwuwtbJH0YmkP
	 Oe9bBtsCvEJPdBMgOEsOrZlpE0RK7Zxs2XA8QGsU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 21 Dec 2024 15:48:10 +0100
Subject: [PATCH v2 4/9] misc: c2port: Calculate bin_attribute size through
 group callback
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241221-sysfs-const-bin_attr-misc-drivers-v2-4-ba5e79fe8771@weissschuh.net>
References: <20241221-sysfs-const-bin_attr-misc-drivers-v2-0-ba5e79fe8771@weissschuh.net>
In-Reply-To: <20241221-sysfs-const-bin_attr-misc-drivers-v2-0-ba5e79fe8771@weissschuh.net>
To: Frederic Barrat <fbarrat@linux.ibm.com>, 
 Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734792490; l=1911;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=H724roLIaoPip44zZqVVk4vtvisEZYzLS47/VZWgyws=;
 b=zsZ1GLJgkyJDB4FWW1KUeoShxFYHVmehKqs0aufi24x33PwPG/GMeCoROYkLYuZad1oVFmeqt
 CLu8iRDVOUhBfq6slRcQdzva8KpYTs09xWkYf0/7+lSRZ7Ffzo2Um7O
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Modifying the size of the global bin_attribute instance can be racy.
Instead use the new .bin_size callback to do so safely.

For this to work move the initialization of c2dev->ops before the call
to device_create() as the size callback will need access to it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/misc/c2port/core.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
index 2bb1dd2511f9dd178b8c06baa460bb609f7f8fd7..f455d702b9cd4999648a57985e305aac5301403f 100644
--- a/drivers/misc/c2port/core.c
+++ b/drivers/misc/c2port/core.c
@@ -874,9 +874,22 @@ static struct bin_attribute *c2port_bin_attrs[] = {
 	NULL,
 };
 
+static size_t c2port_bin_attr_size(struct kobject *kobj,
+				   const struct bin_attribute *attr,
+				   int i)
+{
+	struct c2port_device *c2dev = dev_get_drvdata(kobj_to_dev(kobj));
+
+	if (attr == &bin_attr_flash_data)
+		return c2dev->ops->blocks_num * c2dev->ops->block_size;
+
+	return attr->size;
+}
+
 static const struct attribute_group c2port_group = {
 	.attrs = c2port_attrs,
 	.bin_attrs = c2port_bin_attrs,
+	.bin_size = c2port_bin_attr_size,
 };
 
 static const struct attribute_group *c2port_groups[] = {
@@ -912,8 +925,7 @@ struct c2port_device *c2port_device_register(char *name,
 	if (ret < 0)
 		goto error_idr_alloc;
 	c2dev->id = ret;
-
-	bin_attr_flash_data.size = ops->blocks_num * ops->block_size;
+	c2dev->ops = ops;
 
 	c2dev->dev = device_create(c2port_class, NULL, 0, c2dev,
 				   "c2port%d", c2dev->id);
@@ -924,7 +936,6 @@ struct c2port_device *c2port_device_register(char *name,
 	dev_set_drvdata(c2dev->dev, c2dev);
 
 	strscpy(c2dev->name, name, sizeof(c2dev->name));
-	c2dev->ops = ops;
 	mutex_init(&c2dev->mutex);
 
 	/* By default C2 port access is off */

-- 
2.47.1


