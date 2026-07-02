Return-Path: <linuxppc-dev+bounces-23405-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76899C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 14:16:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grf7g4VFkz2yql;
	Fri, 03 Jul 2026 00:16:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783001775;
	cv=none; b=hAlDm1jrXSlHi70kS3BGoSxhAPuUYN+qQESl/Xuj9cmV4yy2+DDCOyIUeWKRjSlEHitbO75lSB0NATFHK50eorxnFAm2jZ6IdM1bNF+YQ7Lj7oxWcuNW0S/L5rTjpiNXCMGNXk+D8Ta+aEQ+fUCpXCDz7P+PULtMdDI0pX4NoujYxrTlqZMKZcmh9NMecyD+FILNeKhO4HTCE1Q62EHCWXM1hvOQvkXahGj4sxyI0hLWVsi7M4CJoZ2/s3PtZOcug+tcgdCbXBNbfGX0DwNYP3X4oDUM3bwCfQlWrz+VpHz3QLm9qEjPJtBQEXH0iJqfZh/zEacou7A8hcEavVM0dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783001775; c=relaxed/relaxed;
	bh=x+2RMOnDAh4jFfXqz7jJxRkO8m0IlFg42sB4S4WrAs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AV+Z8KTYaYvLGv0kx6JcYCcqfPNtU1JGY/xnfTCLz6voKlGhjsxLReidvM4nYlDIQ6Wt2hywZLh/sFkCC99Zb5A7E6XnWYxsziMg8HuUwqr65S7H1mkLgKqgXNbye7wU2NYOwbimFm0L0cwc35fkFpikpbz5OMKlhv/F7AcgNDxSFBYuAPIWsbbJZDE9sZvljV9tBS0oAEYjm4uBChkx78BFdbpLBexN5GT/arSr7Otea/jCmgwEzsDC7hx+xAdP3SGdLLm8FDVni5yHr7feHoDO7s24SWb8e4Dle536wDwJ1NE1pEDjMBPccZr/czhizm9exCdaMVn4j6x4DJmTiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0F8b928; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0F8b928;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grf7c3xvMz2ydQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 00:16:12 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5930A601E3;
	Thu,  2 Jul 2026 14:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDD71F00A3A;
	Thu,  2 Jul 2026 14:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783001769;
	bh=x+2RMOnDAh4jFfXqz7jJxRkO8m0IlFg42sB4S4WrAs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D0F8b9280qiGBZEW8keiQZiyJvXAHQuZpZKM4cioyG+hqF2qtg5AC7Z5DMI8/iFzQ
	 OvR4pBCTpjnyrqmvufFuSMLYCCBpVMRuYDc10GlYYJR6kAMtK/+X+SxU1Y/p+LkAYz
	 AhiOVr9oq2tX1Dhhbis6VD6cqVMXjLMS7U+ljhZZ3NcWgsBW2e5if79jw3yGyteGQZ
	 I0wv1gLj440jhu8Z1cEt5wOTT9rA95wLl3imJFd1MjGeIYPPQyK5DpzuSJQirJT6vI
	 BAC36MHBQfXvgH+DZM5kL8XgP5GFYiVhE+uFoH3545+2N1Q4LgF7hHdNdj0e32+MkR
	 FmFmPJwnlEp5g==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wfID0-00000000Neg-2t6T;
	Thu, 02 Jul 2026 16:16:06 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/4] USB: gadget: fsl-udc: drop misleading unbind sanity check
Date: Thu,  2 Jul 2026 16:15:36 +0200
Message-ID: <20260702141536.90887-5-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702141536.90887-1-johan@kernel.org>
References: <20260702141536.90887-1-johan@kernel.org>
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

The UDC pointer is set on successful probe and will never be NULL when
the driver is later unbound so drop the misleading sanity check (and
confused error message).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/gadget/udc/fsl_udc_core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index c4761933ec86..20392409afb1 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -2539,12 +2539,6 @@ static void fsl_udc_remove(struct platform_device *pdev)
 
 	DECLARE_COMPLETION_ONSTACK(done);
 
-	if (!udc_controller) {
-		dev_err(&pdev->dev,
-			"Driver still in use but removing anyhow\n");
-		return;
-	}
-
 	udc_controller->done = &done;
 	usb_del_gadget_udc(&udc_controller->gadget);
 
-- 
2.53.0


