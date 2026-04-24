Return-Path: <linuxppc-dev+bounces-20087-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDACFFED3EA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 16:04:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2Hnn0RmFz2yps;
	Sat, 25 Apr 2026 02:03:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777046636;
	cv=none; b=GZoQRuZ1FwdEaURvu44xj1y2pw0qypZg6/AkY/mYJ7f7Ba2sTDZHlfEDnm4O9MaaiHlcJqWnijyN8AT/akjNrQLnGnTwEweXWjDTz1sPP3igeOixCqddioybAq6+uvb9YN60XEGyHuI9wqldWjp1bOgkJ3YpOcxMCpGjPMoKf1tVIHf7W9E7lcrouXkZJfdj+LZvqi3Y6qvRiSxk5UBaZCm1ChbxOfqG0eAbDvY/952Qm4QHgJOzfs3jCnQO4Lz/VW2jra34eP/NGqlUyZP+jMfYz5eJTd6AE9KGiMDIIF7T5OjOCq794nAwlzs80N2YGOtfrV/8R3GW9xCNNJidfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777046636; c=relaxed/relaxed;
	bh=vWSKtBFAQzmEEefMgNM3SuXrWODGB109gf614QLUmiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Njybm/ep1kQo42V1iDij3Pw93VG8l4bLnxbK4fWaqLK4o0fmjABUEQKRMiWqMhlR+igYM7MZnOB2Xhyea+q3Eo0oO8BrNFWYEyU7h29Viuyo/yu5oCw4DLNc1ktdlvYJ+2+MqDfClIEIBhCPN+B5NaPWhlmBBvasY6elKhsRAqSussz+28j3yhAoQIFVzMXMxa2PuII9WdPNv0OF2Sk8vwyetCigOrztmcDqTyci3EmWZ0oKaYYhSXPD4Weo8dHYArCG03VaxpxfJDLrki0EEg4KkaNbaTCFpCI9s37ZEKfS2Panii80qy9jztuXkv8L9X5fKs/7ANZ8eUtwBBPqxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hEBhmvJT; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hEBhmvJT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g2Hnl3gZDz2yYs
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2026 02:03:55 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4D8E260125;
	Fri, 24 Apr 2026 16:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0621C2BCB6;
	Fri, 24 Apr 2026 16:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777046632;
	bh=HgtVi8OJ+/vIrStnMhO7W57bp79LE5Df42vhHHfdxpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hEBhmvJTHXvQyJNp44YCnJZdKEP4UG5PFKRk75M19GsVhhMcH5E4nrHgVOPb+qeYD
	 fzYCaz14564Tkrulxn2oOzAEYVzviqEDq7VkaTKGdh8tY5OFhps/ybTui0rPuqMFV2
	 fBCyWBDQU7SlJfJSADfgYHrtlQemdwnjq6FRePMVT7hakj4KqgPGI7Nz2qXFJYHk6Z
	 FC4VKzDpsPiLPFhwUxLy3Ji4OFXIqJOaAbsboz+Vq/P7RZu+uqxRWr0/OVq7J4xDRi
	 WBn2F7wFm9Se5/81BzPHPN+JBjpmxuyuiooRyAn61DFsAffY+8LqPiafGXxaQdKSrV
	 Fbca3UoWcgPIw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wGJ0P-0000000BDJf-3JTr;
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
Subject: [PATCH v2 2/3] powerpc/pseries: switch to dynamic ibmebus root device
Date: Fri, 24 Apr 2026 18:02:58 +0200
Message-ID: <20260424160259.2672722-3-johan@kernel.org>
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
index cad2deb7e70d..f2064e0b975d 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -51,9 +51,7 @@
 #include <asm/ibmebus.h>
 #include <asm/machdep.h>
 
-static struct device ibmebus_bus_device = { /* fake "parent" device */
-	.init_name = "ibmebus",
-};
+static struct device *ibmebus_bus_device;	/* fake "parent" device */
 
 const struct bus_type ibmebus_bus_type;
 
@@ -171,7 +169,10 @@ static int ibmebus_create_device(struct device_node *dn)
 	struct platform_device *dev;
 	int ret;
 
-	dev = of_device_alloc(dn, NULL, &ibmebus_bus_device);
+	if (!ibmebus_bus_device)
+		return -ENOENT;
+
+	dev = of_device_alloc(dn, NULL, ibmebus_bus_device);
 	if (!dev)
 		return -ENOMEM;
 
@@ -447,6 +448,7 @@ EXPORT_SYMBOL(ibmebus_bus_type);
 
 static int __init ibmebus_bus_init(void)
 {
+	struct device *root;
 	int err;
 
 	printk(KERN_INFO "IBM eBus Device Driver\n");
@@ -458,23 +460,28 @@ static int __init ibmebus_bus_init(void)
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
2.53.0


