Return-Path: <linuxppc-dev+bounces-20088-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C649FFED3F0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 16:04:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2Hnn3glgz2yqq;
	Sat, 25 Apr 2026 02:03:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777046637;
	cv=none; b=L2IY4zu19RlfBUW5/+Jh1Ho/8DR5Rr9TOI/91od1wTS/jeiGcXNkhVBYIkMP3KMePhGICR78V7faSWMEpkMU86naOu7S8LL+g8ObWuncesjQE8iKIf3EULovXLl3jMShTkU6X81KAycR0O/XADXFvHZQ3ZDYJ8qNCggs4iYEIx/DRvn7Vn82LY0D8uDVjiZyDQ1CNSKGmT3MTJ53NkLzMsHn8lW3R/Y8GH5DsFtScrl8dqax2uqQ2iAh8TkcU3i+oPjCskMQc19TZI9Gdf+9j7CqGE4PWoAbV3wSh+EqJ4gDITVgwbaEj/TVLAHcbIvL62xrKdgQpMt0/3Jbk2iPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777046637; c=relaxed/relaxed;
	bh=eyfEwbtnPePJWYX5rFNwBPVNmKIouRo5Dd6BaIqeMdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBlS2ROjECwaffaVgDOjA5W1XJHh3JC8ThFbHqQgMKAXCrBkqOXgwXnO6DQc64cZSyTz40HuODdWujZSvyFC76+4OuDJqfaP4n9eVSBREXoPDxhZ+PdWDFd6/upx+moTceiPdNCoMZcU6hOmCRlBHqfCjMVrcETez/3OApOTix0OROBMaAOJIoia3BEjzhcbZQqQ7lJXuUpI6CYbzqwLndKAezPBTJVNus87bJ8nvGkgM8+xl4AsiNo6unvuXl1aRp07xQ56KVTs5agoeQuALKmybmVyTIah92Bfvd5H2+GwTSHjOxKQB+VVI/n6MP7Mqa3SCygQ2b5fEF3ai1WFog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=r+d0lrtA; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=r+d0lrtA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g2Hnm0MSyz2yfK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2026 02:03:55 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4D91860128;
	Fri, 24 Apr 2026 16:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AF9C4AF09;
	Fri, 24 Apr 2026 16:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777046632;
	bh=mqneH79EzeFeOxrWkixTrTTzC47bHkuPKa7R4p811E0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r+d0lrtAK3edmQEWczLVMByJvn0kIOzzMnds3YFkbiPrX1r3WRvzC8exTrN+1nJIF
	 /PgMNBXy1lU5/HS6P53nIZyZv+dQoXvB/FAVAwBIZK401OuPCWowGf7i5NWRQVFTi3
	 dGegIUJsNmZOSofyzTkO286YEL2QUVjKQhRRld02seX2Z+MVupWjstk4IzZPUnD+UA
	 c8OMJ8+3n9oXDmwTOm3EZ96Vr0MAYK2PfyJcfEtDv4ZHpu46msW/TOWCgCKKpaDxJv
	 jcFJVELPANYwkLtKNwxUDdCVyC0+gxergtuoMzjBP7pUKe5RPAUTyjm2lvoEbphzJL
	 fXEFjfnvLYQBA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wGJ0P-0000000BDJh-3Lxr;
	Fri, 24 Apr 2026 18:03:49 +0200
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
Subject: [PATCH v2 3/3] powerpc/pseries: clean up ibmebus printks
Date: Fri, 24 Apr 2026 18:02:59 +0200
Message-ID: <20260424160259.2672722-4-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424160259.2672722-1-johan@kernel.org>
References: <20260424160259.2672722-1-johan@kernel.org>
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
index f2064e0b975d..24c3ec76b0c1 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -206,8 +206,7 @@ static int ibmebus_create_devices(const struct of_device_id *matches)
 
 		ret = ibmebus_create_device(child);
 		if (ret) {
-			printk(KERN_ERR "%s: failed to create device (%i)",
-			       __func__, ret);
+			pr_err("%s: failed to create device: %d\n", __func__, ret);
 			of_node_put(child);
 			break;
 		}
@@ -285,8 +284,7 @@ static ssize_t probe_store(const struct bus_type *bus, const char *buf, size_t c
 			      ibmebus_match_path);
 	if (dev) {
 		put_device(dev);
-		printk(KERN_WARNING "%s: %s has already been probed\n",
-		       __func__, path);
+		pr_warn("%s: %s has already been probed\n", __func__, path);
 		rc = -EEXIST;
 		goto out;
 	}
@@ -295,8 +293,7 @@ static ssize_t probe_store(const struct bus_type *bus, const char *buf, size_t c
 		rc = ibmebus_create_device(dn);
 		of_node_put(dn);
 	} else {
-		printk(KERN_WARNING "%s: no such device node: %s\n",
-		       __func__, path);
+		pr_warn("%s: no such device node: %s\n", __func__, path);
 		rc = -ENODEV;
 	}
 
@@ -325,8 +322,7 @@ static ssize_t remove_store(const struct bus_type *bus, const char *buf, size_t
 		kfree(path);
 		return count;
 	} else {
-		printk(KERN_WARNING "%s: %s not on the bus\n",
-		       __func__, path);
+		pr_warn("%s: %s not on the bus\n", __func__, path);
 
 		kfree(path);
 		return -ENODEV;
@@ -451,20 +447,18 @@ static int __init ibmebus_bus_init(void)
 	struct device *root;
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
 
 	root = root_device_register("ibmebus");
 	if (IS_ERR(root)) {
 		err = PTR_ERR(root);
-		printk(KERN_WARNING "%s: root_device_register returned %i\n",
-		       __func__, err);
+		pr_err("%s: failed to register root device: %d\n", __func__, err);
 		goto err_deregister_bus;
 	}
 
-- 
2.53.0


