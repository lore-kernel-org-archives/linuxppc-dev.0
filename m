Return-Path: <linuxppc-dev+bounces-26988-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9BDC79FBD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 17:04:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg6cS1nctz2ywv;
	Thu, 10 Sep 2026 03:04:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788973496;
	cv=none; b=OIMGRz1OWpCHoeM5dpFQl08N/hupfoSKQ/3U0+uhL3WtD/efSH3+BfzCkfwEXcXER+DF70sprfR7w/KocB+KCPifvYSrBJOgwLfgE/AmxbW5MRh6JkRkbf78Pg5PKfAuLxQ2/q29gaNxo7gVKKThzgw4+fzXjiPYdnqPOPJpGsRGwjMEeWkPhV8jhgh7c5HFt12AZhIUMrtrPnszsnq1HdLswDTdCGcGY1njE/X5VfLJa3DD1ZbGr4u5PyxgfYrJ51OqTevNchNoAAmxn8PqG67qQwiJT1+U++L+tufb3gqtmK7yPyfkzsph/rP+TzvuQZFPn7Y4APHiP/hWGUyssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788973496; c=relaxed/relaxed;
	bh=V55Vy6qlE51TuDXRPnlBmr4WZ0tBNiL6HCMdQkuXoL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SmYv0HtoWnl6wPpGx2k9YrksiVLeEW5ubBYjfN+sftHqZElsiTq4Pmrrh/kMX4K2B9MBH+uqKyR5K/GsjpqPlBNYQCDbeXLEf6wUHkkxJ01AD5DECBAT8H30UmNHOzeSYDPO2sA7UvqnPNhVgYJJ6VhgciO/KXWcaHuJfbC9ZeT5VoQX6OsmU3Bn0pMIbWTLuI2WbwhQ9H9EWRrPw4YsgpNoszXQSjCmg+IysCGUQRDS4hoR0Ovpih0DdPXqiiNzcSawFsMeRaaRm9Fvy9FD7YYsHwgAqFYIXTQm8lG0Uy9lRgCkPg1k/BEAMsyLxtPOlO1AePjc5qM6qQwV4ACQ9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VFB6zFOX; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VFB6zFOX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg6cQ3sNPz2yvK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 03:04:54 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5B37E4195E;
	Wed,  9 Sep 2026 17:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 345F8C2BCF4;
	Wed,  9 Sep 2026 17:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788973487;
	bh=LpKlJiaVIsQKsTlyaIZbqHjsJ9yGKW71aQcyPqxS5to=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=VFB6zFOXxeYqx/x5OYlOcN6MKkmkPrjbOAZVw/dHIyn5e7N106G9+6xYU1GMK7/Fs
	 8EHMZXOHg6gDFjgvsAIUCjHlwqeJuBXNFb0poUpElNRi1soabtllxgU+uMLuQ2vm51
	 ufI/6iAUPXkc26k+qRs9rQenCTvtU7a48+S51sFt9MY+QObiqOrh9sVh5DDjKzAcQJ
	 uBZlNZ9vy07ez/ZP/fef6gOAqcNbEPTwPMHCGGoq+B7gqqTn+ODbWF+Ybt30up0Tb1
	 8IF5wvwbYiUkLtBRTMw9+j4SH1Dn3K/UHqAqmLifJ8Z3CCUac8qpOsoY6clPc0If8D
	 2LlNgGvxq7yVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCB0C79FBD;
	Wed,  9 Sep 2026 17:04:47 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Wed, 09 Sep 2026 19:04:40 +0200
Subject: [PATCH v2] bus: fsl-mc: register the object drivers after
 misc_class exists
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
Message-Id: <20260909-for-upstream-fsl-mc-initcall-order-v2-1-b7a04634fcf1@free.fr>
X-B4-Tracking: v=1; b=H4sIAKeRoWoC/42NSw6CMBBAr0K6dkw/pogr72FYIMzIJEDJFBsN4
 e5W4gFcvrd4b1URhTGqS7EqwcSRw5TBHgrV9s30QOAus7Lael1ZCxQEnnNcBJsRKA4wtsATL20
 zDBCkQwF0znhX6dLYu8qhWZD4tU9udeae4xLkvT+T+dpfXpt/8smAAeeJ8HSm0pfdlQTxSKLqb
 ds+MEjWltIAAAA=
To: Ioana Ciornei <ioana.ciornei@nxp.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable+noautosel@kernel.org, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788973486; l=3680;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=4w8EyLodWYbpAxy4IdhaZ8kc0Y8HbWHFCMkpK6NuPbI=;
 b=Rid5LvQoK9miq+gA7+YL1kd3AUGRJD8FeSxJ1xg5zimcVvmU64GZjtoDj5sORC46X9N1xjtkj
 HACM4entDAGAiqmRKDC0kGr5rSInrkDPfoIfd+y7zLR9ubxcwGErk7M
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

It happens when the fsl-mc bus probe is not deferred, without SMMU:
- the dprc driver is registered at postcore_initcall,
- the DT node is populated at arch_initcall_sync,
- the root DPRC probes right there, before misc_init() has
  registered misc_class at subsys_initcall.

misc_register() still succeeds but the device gets
no class, so misc_deregister() at unbind cannot find it:
the minor is freed while the device and its /sys/dev/char/ link leak,
and then the next bind collides on the same minor.

Let's move the dprc and allocator drivers registration, and
platform_driver_register(), to subsys_initcall_sync, after misc_init()
at subsys_initcall.
bus_register() and the platform-bus notifier stay at postcore_initcall
so that fsl_mc_bus_notifier() still pauses the MC before the SMMU is probed.

Cc: stable+noautosel@kernel.org # niche: root DPRC unbind/rebind only
Fixes: 2cf1e703f066 ("bus: fsl-mc: add fsl-mc userspace support")
Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
Issue found when unbinding/rebinding the root DPRC on an LX2160A.

The failure is silent at bind time and only shows up as a
duplicate /dev/char entry on the second bind.
---
Changes in v2:
- Commit message: the bug needs a non-deferred fsl-mc bus
  probe (no SMMU) - Ioana Ciornei
- No code change
- Link to v1: https://lore.kernel.org/r/20260901-for-upstream-fsl-mc-initcall-order-v1-1-36ffe48f767d@free.fr
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



