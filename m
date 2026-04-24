Return-Path: <linuxppc-dev+bounces-20068-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1AFFE5205
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 10:36:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g28Wp00Y0z2yql;
	Fri, 24 Apr 2026 20:36:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777026981;
	cv=none; b=HQk+aJQ1iiGwJVqXKkPuAdORz0CG/oNi7EYUGzsqalSePH/vNawfpS+Xj2fEDA4Oc9SBqpis2v6W8P/wGdmGEHLL0n8bmwhK/AhBUI2XqYAbOogRLArRvwzPKiWllKpGh+3LqCp7ElnKOEQnz2sIcr4IfapIBLPIoT3ek7q1PQt3v1y6shUlS0ptK19a/UBlxJYT3FYF1pXSB2Z1kj6AvUVrXe9ca4O5JwXf8GyO68fF5/XzLp+uDvGjPmJO6UyQbmXC2MjLscUUs8HdavPEaSgeO4bgia6lfeC/10QIxLhYs+uHzroeL/TZDeXKgD+wYPI9KW3uO8geuj7FvGr4mg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777026981; c=relaxed/relaxed;
	bh=m5pjwrWvtX8hEGA84jOB2WzPkwcVIwZUE/Ac5wsJqXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjFj0znGHqNSa/hL7pDC48I6VYbTcSTMZJBOSQZbulB9DU4ux9oz03+oUKvMyYTJlUF+9jGKKYLp+QKp2l4OmS5q+RvI4ejDgK8qeFBr/cl05b9IbyqaMrBGlyFj5ObMhuRfB3SlhpAFOXhphc4bxFYXIzgBNsLCs57GEYM2oEGSv52dhg2tqOGXocgaiQd1gG61c/ZCHzxcCEj3VqGv++lkQBKgH0R+VXumJKjFOAwt6SmThcAt+jwWSus2CC4QNUDPpFejVj9RIF5TmjLjrBkhk6qeWBQ5fnFsBXnQs4f27vA6TvybpTVDnsztvVngqEaHKLLfXJGlX4o7GMs0IQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uhuDpIl9; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uhuDpIl9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g28Wm1zkmz2ybQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 20:36:19 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CA06E44453;
	Fri, 24 Apr 2026 10:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64713C19425;
	Fri, 24 Apr 2026 10:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777026977;
	bh=r7t9IjXKXmo4brGWblnNZdlBkkZXdXtKpLhAebYCUJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uhuDpIl9/P8W25DmD4zGUUPjIEs4PGArX3GqU0qqG/dKcu1QBbVK620WbzuOcV0Fh
	 mCArJVLlL4ksuM5CeqEkwLLc7LzEzeiUr6wJ0hh4guRWrl/ZcXYjoG17Lr2PVF5Gkq
	 QyO4uEkytfkD3h1cIWYoRU/A0oA7krXkrDvNZDl4d9bh3YFHjuGFtWSmKCWRQySn3y
	 UKQrbZs+yEKodPgcs+/hP0NRQe04fiq0qs9PeLsgPBTN0WDht3cN1HLygdra6eo4Lu
	 NaZoehxIPU2hdr59PKcHb4x1ZIGnDetoOQBWfqO42Cu0Wo+LjZiRHqd85kApa1zRGv
	 ZwC10VgN//vjg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wGDtP-0000000Ayid-0ttq;
	Fri, 24 Apr 2026 12:36:15 +0200
From: Johan Hovold <johan@kernel.org>
To: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/3] powerpc/pseries: clean up ibmebus printks
Date: Fri, 24 Apr 2026 12:36:04 +0200
Message-ID: <20260424103604.2616657-4-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424103604.2616657-1-johan@kernel.org>
References: <20260424103604.2616657-1-johan@kernel.org>
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

Clean up the imbebus printks by switching to pr_warn() and pr_err(),
adding a missing newline and making the error messages a bit more
uniform.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/powerpc/platforms/pseries/ibmebus.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index e3b41e2d844f..8797b2137d9c 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -203,8 +203,7 @@ static int ibmebus_create_devices(const struct of_device_id *matches)
 
 		ret = ibmebus_create_device(child);
 		if (ret) {
-			printk(KERN_ERR "%s: failed to create device (%i)",
-			       __func__, ret);
+			pr_err("%s: failed to create device: %d\n", __func__, ret);
 			of_node_put(child);
 			break;
 		}
@@ -282,8 +281,7 @@ static ssize_t probe_store(const struct bus_type *bus, const char *buf, size_t c
 			      ibmebus_match_path);
 	if (dev) {
 		put_device(dev);
-		printk(KERN_WARNING "%s: %s has already been probed\n",
-		       __func__, path);
+		pr_warn("%s: %s has already been probed\n", __func__, path);
 		rc = -EEXIST;
 		goto out;
 	}
@@ -292,8 +290,7 @@ static ssize_t probe_store(const struct bus_type *bus, const char *buf, size_t c
 		rc = ibmebus_create_device(dn);
 		of_node_put(dn);
 	} else {
-		printk(KERN_WARNING "%s: no such device node: %s\n",
-		       __func__, path);
+		pr_warn("%s: no such device node: %s\n", __func__, path);
 		rc = -ENODEV;
 	}
 
@@ -322,8 +319,7 @@ static ssize_t remove_store(const struct bus_type *bus, const char *buf, size_t
 		kfree(path);
 		return count;
 	} else {
-		printk(KERN_WARNING "%s: %s not on the bus\n",
-		       __func__, path);
+		pr_warn("%s: %s not on the bus\n", __func__, path);
 
 		kfree(path);
 		return -ENODEV;
@@ -447,20 +443,18 @@ static int __init ibmebus_bus_init(void)
 {
 	int err;
 
-	printk(KERN_INFO "IBM eBus Device Driver\n");
+	pr_info("IBM eBus Device Driver\n");
 
 	err = bus_register(&ibmebus_bus_type);
 	if (err) {
-		printk(KERN_ERR "%s: failed to register IBM eBus.\n",
-		       __func__);
+		pr_err("%s: failed to register IBM eBus\n", __func__);
 		return err;
 	}
 
 	ibmebus_bus_device = root_device_register("ibmebus");
 	if (IS_ERR(ibmebus_bus_device)) {
 		err = PTR_ERR(ibmebus_bus_device);
-		printk(KERN_WARNING "%s: root_device_register returned %i\n",
-		       __func__, err);
+		pr_err("%s: failed to register root device: %d\n", __func__, err);
 		bus_unregister(&ibmebus_bus_type);
 
 		return err;
-- 
2.53.0


