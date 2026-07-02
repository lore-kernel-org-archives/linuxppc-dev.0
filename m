Return-Path: <linuxppc-dev+bounces-23404-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61137C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 14:16:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grf7g1P0Xz2ynH;
	Fri, 03 Jul 2026 00:16:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783001775;
	cv=none; b=Gm0o8z/EkVuPlMwUTP+id4PZm0Lc+utgRG3dTFQQJJqBOTOYGoHl10sNLGFOFTS078reu5CgJMN5bo1vj4BAx/y+3zh3oyJuakERMEuBXFpzl6O2J8FDy+jHz7m9+AFLPKsaVrnCXIR4/uePAt+nuugNPp7Mzu9CTvU0pxROg0ToKYkRIOp3lCCeZaAoa/6BWAv1xsOHJAhYP0dkeuhCg4VMgmwH8fcpbhoT5Wov8QOaKNFRjKnSEht1oYaPaI7jA3ECGp+Jju45gJ2m6e9Ic1RS9hZYclVbnQPG1Jhvv1pgYvFRWvmSJ4KqC6/7vAnQOGxygEDeFvPdtbiqfwODhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783001775; c=relaxed/relaxed;
	bh=MhBTAqbX+6ddORWh3uOqJPTx4/35gVXV/hnc5cvGL/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Adtq6bSJyui6hSaxf+ebjHweVfpvERFBK6NE2sRAKHCGzNmDIMWBcPwfd4Ovk1qHK9f6z3aJi9JUcX+4acxnSCNrGN/uurukCGdMqcgV6TqWHmS9zGo/jVjReiKQdaQKcmyrJ5mcMK8pTrML2obDClWaueVAhynQwmewQO0N3GcQ7zBckHofUzz+5WiFMvS/X2Q7HgMG6XojFrU0r6Fhnzt5TZdK/c3yRw3oMU43i0DxoLSUh8R67dcC5vDJ8X/foGfh8UCkRbjRsONj3afDe1wHVppe6nNLiAspL1B1bSwK6OGYlRNjQZR3lrMizBvuGfzmQEz9WgKjc2widxSYqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IWq9ghV9; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IWq9ghV9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grf7c3r60z2yd7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 00:16:12 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 66402601ED;
	Thu,  2 Jul 2026 14:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0751F00A3E;
	Thu,  2 Jul 2026 14:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783001769;
	bh=MhBTAqbX+6ddORWh3uOqJPTx4/35gVXV/hnc5cvGL/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IWq9ghV9ePdP6Jv1QTUqpDdm/5QFTr7+Be5rrPQUiptDgFHFD9Gl9PR9JhKsdnoyT
	 tzfxxQHEVO3WAqvmaeswEZjQgnjX7+4/+I5ulGvR2dw0CekZ83mIrdtxtoncdXkz3/
	 CFmpmBuDRvmbpfPZNTQ/tBS0p9QGkYKBqmW03QwEBzWTswsjH7iL0IvZUbHRxLQZdI
	 svZHG1tIRsiEPOyc4zMM1OGqzUoc4quVUzIQx3KOUaPDk37MvEvrnhn2oZKCvDtpNp
	 bnT1HxvVeVJuVAzMyInZOfqMta4HF3CbkxZO/ngoUDhXx+roSdST9tEsgIuANrHbqN
	 pywL2OgZVBRNQ==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wfID0-00000000Nea-2lTM;
	Thu, 02 Jul 2026 16:16:06 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] USB: gadget: fsl-udc: fix device name leak on probe failure
Date: Thu,  2 Jul 2026 16:15:33 +0200
Message-ID: <20260702141536.90887-2-johan@kernel.org>
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

The gadget device name is set by UDC core when registering the gadget
and must not be set before to avoid leaking the name in intermediate
error paths (e.g. on dma pool creation failure).

Fixes: eab35c4e6d95 ("usb: gadget: fsl_udc_core: let udc-core manage gadget->dev")
Cc: stable@vger.kernel.org	# 3.10
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/gadget/udc/fsl_udc_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index 600ce8cc0fef..8c5b2f42ff44 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -2474,7 +2474,6 @@ static int fsl_udc_probe(struct platform_device *pdev)
 	udc_controller->gadget.name = driver_name;
 
 	/* Setup gadget.dev and register with kernel */
-	dev_set_name(&udc_controller->gadget.dev, "gadget");
 	udc_controller->gadget.dev.of_node = pdev->dev.of_node;
 
 	if (!IS_ERR_OR_NULL(udc_controller->transceiver))
-- 
2.53.0


