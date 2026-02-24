Return-Path: <linuxppc-dev+bounces-17101-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FDDE9B251
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Feb 2026 10:09:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKtkT0glzz3cMF;
	Tue, 24 Feb 2026 21:09:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771927793;
	cv=none; b=IHVFfIUCdTwELupGsiTYUq18HUPotJR9HC417SW009awy82cGEFXkHgTb74AAmRu8CJgNSBK0m8bThLQz1SXj3P8IvBEY/VGoVzHhSf/PCBN5EuRx9YJvh1mOLsHD9lKy1+Jmrmkx2IfljjFWyS/K7gg4V4tbbUYREw+BcyxEUVItXzAEUHKbOqDEgT/GSyX4QZ6Hb80zKjwC+qCtZvUbay//3eMJEW4grz4tZXD2hACOyDWST82RM1eTGuFeuhLzwcHqm7fY12MHt4FfOiWD0XqgamjtzJsUTHjgmgpW2kXcqWwsWV+c6FuMQaHyJUIzzqe/G94OTJ12RFCn/XiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771927793; c=relaxed/relaxed;
	bh=o3aFZkTFo6qE95gUNZWoWD2UnJD4ca4+RPcR5rfIP54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTshwH/OXPswKhI1iw13AsIdARGDYvpQp4ktaraVM9zHZxWxSjbfyZxyRdLgqHaP4s+BmsCymx7Lt1LUwsLf1qsM+VdJorkoshuK36Qb/9lU13xhwzjHqY9Ag0SN42WcjHF1IzxFCmHWOVkBaT8oXVLj6UIEf0LvBDFtXJv83S+pg4wXnIm3gNXuup/yR4Ty7fQ+Ytjb9y13prmsN+OXOf5/vG3i7q2SnGGJ0+j+NHAK7MbDX9LzkxGVZkJY5QEK8gQL4GKp0rdkgm5LKaaqkpj57G5RcPAFyKx+yEdAM3it7UdjJG8kMYXbm2d4jMqWuERm2Qt2EaZckdln3dMzlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ivbQeShO; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ivbQeShO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKtkQ5tSRz3cLL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2026 21:09:50 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8183461336;
	Tue, 24 Feb 2026 10:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327E2C116D0;
	Tue, 24 Feb 2026 10:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771927788;
	bh=AckF3xFv3RkFn2rCAMv8OnSIMcQRU5FCIBwvh/LY0BA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ivbQeShOSKXsmubiwKPszuyUkChI7ON4V0pULOaiPtD0++8HaIsE/hvKQ9WF0hBn9
	 g+90fQ/i6Pxbk3n6qZwTMmUeMY8VGu0SapN3A7bCR3id26lmbv1XcDVsxawvs0Bgap
	 Ps0s98jrNuTLoDcy4CHQ22+VWRAphBFaLo69GKGuwYAEC2kY/cphsY0FIAuKalIVlI
	 YRGQcOd5g+mPmVi0u04JQJQ3Fx7nPFiLeCeSRH6IO9/rANPtG8Fh9w2Z5xo34UBszb
	 pZ3PR7rHklvi/pkv7vdyJLdQ1dVvQglMxUmwNuzlpZF4wnMFwObOBdRSrwTX0jDaw5
	 BeffElhFbTAxA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vupMP-0000000DIa5-3TiK;
	Tue, 24 Feb 2026 10:09:45 +0000
From: Marc Zyngier <maz@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Sascha Bischoff <sascha.bischoff@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/6] fsl-mc: Remove MSI domain propagation to sub-devices
Date: Tue, 24 Feb 2026 10:09:31 +0000
Message-ID: <20260224100936.3752303-2-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224100936.3752303-1-maz@kernel.org>
References: <20260224100936.3752303-1-maz@kernel.org>
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
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: ioana.ciornei@nxp.com, tglx@kernel.org, chleroy@kernel.org, sascha.bischoff@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Only the root device generates MSIs (it is the only one talking to
the ITS), so propagating the domain is pretty pointless. Remove it.

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com> # LX2160ARDB, LS2088ARDB
Tested-by: Sascha Bischoff <sascha.bischoff@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index c117745cf2065..1a6c8e3c0b27f 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -854,14 +854,12 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 	} else {
 		/*
 		 * A non-DPRC object has to be a child of a DPRC, use the
-		 * parent's ICID and interrupt domain.
+		 * parent's ICID.
 		 */
 		mc_dev->icid = parent_mc_dev->icid;
 		mc_dev->dma_mask = FSL_MC_DEFAULT_DMA_MASK;
 		mc_dev->dev.dma_mask = &mc_dev->dma_mask;
 		mc_dev->dev.coherent_dma_mask = mc_dev->dma_mask;
-		dev_set_msi_domain(&mc_dev->dev,
-				   dev_get_msi_domain(&parent_mc_dev->dev));
 	}
 
 	/*
-- 
2.47.3


