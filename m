Return-Path: <linuxppc-dev+bounces-25775-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B30EC5B572
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2026 14:20:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKrHj35nkz2ytv;
	Thu, 13 Aug 2026 00:20:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786544433;
	cv=none; b=B9WARVJyTjTr/shV4RiMq1V9EJIyRXvwx+QmqjpIAtD5zK+tfaNg8II0tmvh6Sj/mcQ+d3BensRv/TkUv5jlYmtOO/gv+qfOuw1enmNJgRjF7Uyp3oXDOLLay4XNjUE1Z07ogrx00v7DS2ChJHs1+b3WFrm2E66qCPwl7SjG4Sutbwhj+KiW3oVhtaKZHNEDqAeFyPZimqBX8Bo6+sW/Bvrv0vcCn3WqF90TQuLsTF8lYSzUTINU9Sgj3uw3eNiETLpuHzrnnB03XZsENG6ntsyssJRDaM7kg40x19L8VZgwsa9RVFu0w2B1HvcAHmCKji7fJfQE2lxSe9CxBJ/0JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786544433; c=relaxed/relaxed;
	bh=P7iOr3nQ+DZjRKBXriTn+qJo7TLaZ9kPfjGghjh5ty8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6MySVj6fEh2JN2QBYgR89/7ACQPx/+x3megGa0QeQI0DcBVM0ox1PJ7s/7MmP0lNbJYaAAkMiJiBCPRyMOz1zzcaLHo/dEfjvD75MSHbAx6vonf23KxIaP1ql2Z2NDW3aQtsqrYnVEIC7yySqByF5cB9XaRjy106j3lXwmd5U5++yKIRtVBPOavLXDltH6tXrjbUw3ERubg5/tWDeZUsmWfQzi2VnPhW4e5MkIYawkgIJNEDkx8quQ7J9b2cmaxABMGaJUMyFx97y4sbJFQNj4P7Zbw+euFtFYIU+DcmTVZg9ep3yYDCX+x7hPWxna0xjDtztanDpFNcEYHDhoWLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gszUJ8Gh; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gszUJ8Gh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKrHh2kMvz3brR
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 00:20:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1251160DB5;
	Wed, 12 Aug 2026 14:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6761F00A3A;
	Wed, 12 Aug 2026 14:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786544428;
	bh=P7iOr3nQ+DZjRKBXriTn+qJo7TLaZ9kPfjGghjh5ty8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gszUJ8Gh/6zGJ5FUSb8cczQIrcov9KAGSOHDGMsH0gg9ohT5yJcd8kF42asYXXx31
	 O29GbsLjDDNGQB1v/4T5aZna4Q4q9Rs636GYThmUOOPBw/dke7D3+aiq/PYT9Q5ZSf
	 vPYcOV4yoYI1VsUl7EglSNm+G34+vVz14jUJGsR4klQeG/RwO+pVWuopquulvtVm5I
	 hL9ca0oCFqdwdiziVu3eU+UXcJs2Bv4Eb8fiDIn/zT6AeLGOfzwW6jQn8FrjQGcggo
	 ROpo7TPGeFP3vJT9OdxbMkP1YmftGvdIP2K0uo/9F6eg8+4YxSOPaFsdjZE7p+T8/V
	 59iTNocwij4ag==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wu9og-00000000ELj-29UR;
	Wed, 12 Aug 2026 16:20:26 +0200
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
Subject: [PATCH v2 RESEND 2/3] powerpc/pseries: switch to dynamic ibmebus root device
Date: Wed, 12 Aug 2026 16:20:15 +0200
Message-ID: <20260812142016.55136-3-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812142016.55136-1-johan@kernel.org>
References: <20260812142016.55136-1-johan@kernel.org>
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

Driver core expects devices to be dynamically allocated and will, for
example, complain loudly if a device that lacks a release function is
ever freed.

Use root_device_register() to allocate and register the root device
instead of open coding using a static device.

Also add the missing sanity check when registering ibmebus devices to
avoid use-after-free if the bus failed to register (which would
previously have triggered a bunch of use-after-free warnings).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/powerpc/platforms/pseries/ibmebus.c | 39 ++++++++++++++----------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index 2d0f991da2c8..48076fe6ab30 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -52,9 +52,7 @@
 #include <asm/ibmebus.h>
 #include <asm/machdep.h>
 
-static struct device ibmebus_bus_device = { /* fake "parent" device */
-	.init_name = "ibmebus",
-};
+static struct device *ibmebus_bus_device;	/* fake "parent" device */
 
 const struct bus_type ibmebus_bus_type;
 
@@ -172,7 +170,10 @@ static int ibmebus_create_device(struct device_node *dn)
 	struct platform_device *dev;
 	int ret;
 
-	dev = of_device_alloc(dn, NULL, &ibmebus_bus_device);
+	if (!ibmebus_bus_device)
+		return -ENOENT;
+
+	dev = of_device_alloc(dn, NULL, ibmebus_bus_device);
 	if (!dev)
 		return -ENOMEM;
 
@@ -448,6 +449,7 @@ EXPORT_SYMBOL(ibmebus_bus_type);
 
 static int __init ibmebus_bus_init(void)
 {
+	struct device *root;
 	int err;
 
 	printk(KERN_INFO "IBM eBus Device Driver\n");
@@ -459,23 +461,28 @@ static int __init ibmebus_bus_init(void)
 		return err;
 	}
 
-	err = device_register(&ibmebus_bus_device);
-	if (err) {
-		printk(KERN_WARNING "%s: device_register returned %i\n",
+	root = root_device_register("ibmebus");
+	if (IS_ERR(root)) {
+		err = PTR_ERR(root);
+		printk(KERN_WARNING "%s: root_device_register returned %i\n",
 		       __func__, err);
-		put_device(&ibmebus_bus_device);
-		bus_unregister(&ibmebus_bus_type);
-
-		return err;
+		goto err_deregister_bus;
 	}
 
+	ibmebus_bus_device = root;
+
 	err = ibmebus_create_devices(ibmebus_matches);
-	if (err) {
-		device_unregister(&ibmebus_bus_device);
-		bus_unregister(&ibmebus_bus_type);
-		return err;
-	}
+	if (err)
+		goto err_deregister_root;
 
 	return 0;
+
+err_deregister_root:
+	ibmebus_bus_device = NULL;
+	root_device_unregister(root);
+err_deregister_bus:
+	bus_unregister(&ibmebus_bus_type);
+
+	return err;
 }
 machine_postcore_initcall(pseries, ibmebus_bus_init);
-- 
2.54.0


