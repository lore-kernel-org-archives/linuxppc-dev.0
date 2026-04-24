Return-Path: <linuxppc-dev+bounces-20065-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6054FE5205
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 10:36:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g28Wm3wr1z2yhD;
	Fri, 24 Apr 2026 20:36:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777026980;
	cv=none; b=Be5W853fjZw19yZQrCsbIuUkbBOsCTHDdTyFS8Fb6XRpDir4e5iCByfJFibYuGuh/KcHEp4/5rzcpopo1S3jmvUC9ZobP1DpqA2LoM2m4mpqPqyAl4wVFUmO+RBvKOO2t396IkEk6Hwx/I2JH5nMaAGsHQqkoDp4McCsHgxRIsr11ToXdLZXBOv5qBZmkpYFAFRls46L9dmA7V8torBPQIVsZ3d6pjVm8R6ihieCK299v3E+ZCdtGIS6+XWIGc/kgKsdfyaxpeAhGLNkyEPTKEPN6wBdvdA6Fbxymz8l0+3dmF0C2eRr6liq9jNa6JW1fJs4FPzjap9b/YpDB9HLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777026980; c=relaxed/relaxed;
	bh=tcov7yLgleOf2gGykcygfE/Z/ck0E844+4kEd+8wt+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2v6yEZUzwWYV5KGCoSfSauMjpJo6zTc9lrEWrlZe3tivqULxbQMOYDs8K2HTUY6owqeq6Ss10J/x0Xlpo82aQpfGmpe21KiUxFVXQlLDDVSKBoo20+bWamDqsSAp+3WF/qAr8aaov9O0oWmJ5v7/RWCWr4FmHpfm3vU5H+8+WtYsBUKT7Cp+fykG/dmRvp3ySz1J2PGncvVZ29zbD4T12BpaqQ7nt9t4YwckoXzU0/+M5ngQ2fQjNdVlZyw5rnIwHsVoeCgxu7YzcBuJWvtJXFdHpfrtTjZ2XYT7T1yGjMrwS9YPnxxv8b6OSq29+GCeh5Vtlvp83dOW3/g8LXCcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SPR35I1X; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SPR35I1X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g28Wl4szdz2yTQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 20:36:19 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A7AF960120;
	Fri, 24 Apr 2026 10:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59653C2BCB5;
	Fri, 24 Apr 2026 10:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777026977;
	bh=ZwE069RHo6hyU8LL6FzDYw0Wg1+bXUJujekvNAdWEys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SPR35I1XRiFR74YKSQrmPc+aOFKBUE9q3V7EgK8pKe4GjghnPqPWyQvysQg8hz7/N
	 fpIU6UD7f4UQrANglzvxWiNlXVxuIHC57QnJPPOLhFooUVNm/LV3D1CfG4QvHFAWNG
	 mAs1SWtzElv1BTIurhdgFod9UlXLchTVVARpqP38oJ1WR8HNh4oF5KXL3ITouA5gs4
	 NzHvYl6LcBncryWJ3bRsPbDzzrOW6LDEgr7Qh90vmEqJLAklHPWLYnFzgQ1auQDO00
	 xUiPZNbIFXkLa5yKImyi33bkcGDxXtY3xEY3dP/x5N0EfRw04S2RYd8slsCIEe2EOY
	 5CIu3OGt452kw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wGDtP-0000000Ayib-0rYe;
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
Subject: [PATCH 2/3] powerpc/pseries: switch to dynamic ibmebus root device
Date: Fri, 24 Apr 2026 12:36:03 +0200
Message-ID: <20260424103604.2616657-3-johan@kernel.org>
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

Driver core expects devices to be dynamically allocated and will, for
example, complain loudly if a device that lacks a release function is
ever freed.

Use root_device_register() to allocate and register the root device
instead of open coding using a static device.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/powerpc/platforms/pseries/ibmebus.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index cad2deb7e70d..e3b41e2d844f 100644
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
 
@@ -171,7 +169,7 @@ static int ibmebus_create_device(struct device_node *dn)
 	struct platform_device *dev;
 	int ret;
 
-	dev = of_device_alloc(dn, NULL, &ibmebus_bus_device);
+	dev = of_device_alloc(dn, NULL, ibmebus_bus_device);
 	if (!dev)
 		return -ENOMEM;
 
@@ -458,11 +456,11 @@ static int __init ibmebus_bus_init(void)
 		return err;
 	}
 
-	err = device_register(&ibmebus_bus_device);
-	if (err) {
-		printk(KERN_WARNING "%s: device_register returned %i\n",
+	ibmebus_bus_device = root_device_register("ibmebus");
+	if (IS_ERR(ibmebus_bus_device)) {
+		err = PTR_ERR(ibmebus_bus_device);
+		printk(KERN_WARNING "%s: root_device_register returned %i\n",
 		       __func__, err);
-		put_device(&ibmebus_bus_device);
 		bus_unregister(&ibmebus_bus_type);
 
 		return err;
@@ -470,7 +468,7 @@ static int __init ibmebus_bus_init(void)
 
 	err = ibmebus_create_devices(ibmebus_matches);
 	if (err) {
-		device_unregister(&ibmebus_bus_device);
+		root_device_unregister(ibmebus_bus_device);
 		bus_unregister(&ibmebus_bus_type);
 		return err;
 	}
-- 
2.53.0


