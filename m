Return-Path: <linuxppc-dev+bounces-26419-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AB8C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:05:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZH0172Twz2xmh;
	Wed, 02 Sep 2026 06:05:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788293105;
	cv=none; b=DeMkoJIVjDXhCsKa+pZ/0p4VGU2yjDjKQXLHGSdyiJcbHGx3Lg00RmfmyCE2t+8MOjRZEQoGcJPxuWvx6qoOgN1wKXpRnZ8oROl3H5aIhqyepk0PuewXnGKaKCHP4H4Uqf6jZgqcrEBh1TSEe7RT+h7B7+ovlAs8rtaSKAhyLumbubl5FRcLfchKZ3u7cqzVOLKxrl4mIDXrDHv9foKFnk45q+e0c+RyzANkG3OKiAjh1xxnDxhalNlqsQtXxcYMc4KqjkZY3kwaH+IF+lHSHGEt/ZDaTyXAYzQkpsDXyEzIEoobiC1PwNGtyT46qa04rwxpvrYk86pwZD+YX+/zVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788293105; c=relaxed/relaxed;
	bh=01IkyQRQG/lSUmqdbouqV6kPDaesEhGkw7qS1Uqjgdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=awhhnx3vsOLwSxYAWjUso7VF/Gy7vxlPoJGwl7gJE8TRCWnIpxGCWYZOozkoq2xaSWObt5+/yol6mrSbuDmQk6N1sAiWg4rHD1dqkVJuISK5evXWD6Rryp9hCkHuAYw+Y840fvyICme1tL0ykigpyVFfczZscoHGX4R+Ua2u/vWmfZC8RLxWsWZWpdRnBDRVhJqJr9nxLL7s8nZ8I6ReXMovo/0sWVnA5In57wdxd24ma9nRJO53zYXgPD+5r1+qROJwPc6yeROMD7KDYVXoffGKj3asJmBpqFmSau1VuhOuIvwWUnK5lBMyDwy4LPD1eyBBV1DYpNAfmxbKFJUM4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TnzEUrOn; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TnzEUrOn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZH010Jl6z2x9g
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 06:05:04 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 63248600D9;
	Tue,  1 Sep 2026 20:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F362CC2BCF4;
	Tue,  1 Sep 2026 20:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788293101;
	bh=Qvg96r1uqRi7ZsIahTd0vxEuEUAxLGPkPnDx+jmOuQs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=TnzEUrOnWeKc2IJhDqDEHr24D1ZpYZJTysb91o2LXRfFMdLZJD8mon8H9TFI1JY+g
	 wHBs3NQfp/kNUO8unmeJXu9FFgc1ywOzd8wd8R6KsCjGi5+oOk+xXooNI6waXpRBPT
	 2W2dJA8Pcon9slfvjKvGaa/Kg9MZLGSOBq4btFOzzOIHiaEwDoKsG5XRRvq1mVWmk3
	 f4SK+nIxxW8UkkzcWPyH0g8mRQTtt3sZK2lTX7YK1dAKyRCEVq27puthHw8f5vTe+i
	 0RoJG/1mMSvdGe7mmO1fK/sMGU+FF7ByXgL2fBH+62ePRjQ/LR50qBeKVlNC2qevZa
	 85k4kYnncJzZg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC85DC61DD6;
	Tue,  1 Sep 2026 20:05:00 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Tue, 01 Sep 2026 22:04:37 +0200
Subject: [PATCH] bus: fsl-mc: register the object drivers after misc_class
 exists
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-for-upstream-fsl-mc-initcall-order-v1-1-36ffe48f767d@free.fr>
X-B4-Tracking: v=1; b=H4sIANQvl2oC/x3NwQrCMAyA4VcZORtoU5jMVxEPtUs10LUj2UQYe
 3eLx+/y/wcYq7DBbThA+SMmrXb4ywDpHeuLUeZuIEejm4gwN8V9tU05Lpit4JJQqmwploJNZ1b
 kEPwYJnf19IQeWpWzfP+T++M8f6bGI1F0AAAA
To: Ioana Ciornei <ioana.ciornei@nxp.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable+noautosel@kernel.org, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788293080; l=2613;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=SXlMvnAA+Yv9aOr3bof+GHsV/62VSrRffjRMXK6jUP8=;
 b=Q0DNQlW6k/74/YvmvMnm7KR6URJ1LrX/mfYfTlKrZ73dg+vhupeXaUuRo+NA7LhYlLA4RULEh
 Bl42jSLrySdALA0c54lYp2NUpW7m/nPrOleoqbafewj1sO6QtpbR7ZC
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr

From: Vincent Jardin <vjardin@free.fr>

Unbinding and re-binding the root DPRC fails with:

  sysfs: cannot create duplicate filename '/dev/char/10:256'
    misc_register / fsl_mc_uapi_create_device_file /
    dprc_setup / dprc_probe

Cc: stable+noautosel@kernel.org # niche: root DPRC unbind/rebind only
Fixes: 2cf1e703f066 ("bus: fsl-mc: add fsl-mc userspace support")
Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
Issue found when unbinding/rebinding the root DPRC on an LX2160A.

The failure is silent at bind time and only shows up as a
duplicate /dev/char entry on the second bind.
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 66a4fa73c5b86..7f283844e4500 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -1264,35 +1264,43 @@ static int __init fsl_mc_bus_driver_init(void)
 	error = bus_register(&fsl_mc_bus_type);
 	if (error < 0) {
 		pr_err("bus type registration failed: %d\n", error);
-		goto error_cleanup_cache;
+		return error;
 	}
 
-	error = platform_driver_register(&fsl_mc_bus_driver);
-	if (error < 0) {
-		pr_err("platform_driver_register() failed: %d\n", error);
+	error = bus_register_notifier(&platform_bus_type, &fsl_mc_nb);
+	if (error < 0)
 		goto error_cleanup_bus;
-	}
+
+	return 0;
+
+error_cleanup_bus:
+	bus_unregister(&fsl_mc_bus_type);
+	return error;
+}
+postcore_initcall(fsl_mc_bus_driver_init);
+
+static int __init fsl_mc_bus_drivers_init(void)
+{
+	int error;
 
 	error = dprc_driver_init();
 	if (error < 0)
-		goto error_cleanup_driver;
+		return error;
 
 	error = fsl_mc_allocator_driver_init();
 	if (error < 0)
 		goto error_cleanup_dprc_driver;
 
-	return bus_register_notifier(&platform_bus_type, &fsl_mc_nb);
+	error = platform_driver_register(&fsl_mc_bus_driver);
+	if (error < 0) {
+		pr_err("platform_driver_register() failed: %d\n", error);
+		goto error_cleanup_dprc_driver;
+	}
+
+	return 0;
 
 error_cleanup_dprc_driver:
 	dprc_driver_exit();
-
-error_cleanup_driver:
-	platform_driver_unregister(&fsl_mc_bus_driver);
-
-error_cleanup_bus:
-	bus_unregister(&fsl_mc_bus_type);
-
-error_cleanup_cache:
 	return error;
 }
-postcore_initcall(fsl_mc_bus_driver_init);
+subsys_initcall_sync(fsl_mc_bus_drivers_init);

---
base-commit: 786262be6048deab760f68c8acc2c85607165894
change-id: 20260922-for-upstream-fsl-mc-initcall-order-e3316390712b

Best regards,
-- 
Vincent Jardin <vjardin@free.fr>



