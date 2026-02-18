Return-Path: <linuxppc-dev+bounces-16931-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947BBE9A02C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Feb 2026 13:52:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fGHxq15f7z3bqy;
	Thu, 19 Feb 2026 00:52:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771422734;
	cv=none; b=i0ofgS6G5IO7VwNkYFYPfSgYUfgBZybjLn0nn/diOyCJhcdbEvDcYnJRBwjBBb/HHn/9hlRmR9Qf31PDT0JKtnvCOJTxmXORuSS2//HS2WOMOhhSSDxQMQHqZLdl7vvYp3rgwW2mpNZupIgiRRZZSU2a0M7lORyqmHdUvZhluCd/3sfWPbfXp9tuK5YnctOWeDE3IrEAdPZVuu/+a52bUD0nBETYXXsaEIiGZPNvLUnxoVBerlemUBCsb3KTbQNYoJwaheosApxlAF/dwziE1h4S3PnPt9PxLf1WyDLy3YZoIi9rpkZICr73TVGZKmy58iOjLUs++J1BzVKwWUuU7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771422734; c=relaxed/relaxed;
	bh=ZW93bZ55Q9noPPJwsWjiJPwE2eVOkwSBRs3GyIo3O5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=caw9RPgkkghLGsoRkMlSWVkoj5CpkbgcYIVVP/cxDHIiwtL0hN8Zjcj4Xcy/ikPjIT1jLLnOQVR8TQpgFcQqrveAdxka/+nwD85X1R294xbbio7Fz21bZpqxowEEBJMDYxB1OUaPXYeNGjrAL3wz0Liii4pA5bIvcdGw8ayGGa85ga4ZnGXETfx422wKH4RHnLQs7Hm+an50nIrQMzP0HS44gi7Aw8enh9/jgFXWswjxiOJurlIqyZEMelOSF9GguPwVKZf6tXtlh/v0tyUvOLHHBaGHBse3WLIEPZoDf7WxOW584zMWW3bocH5SFPZBVXdCMhGzq0qnMrqGTT1HuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QszJY6id; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QszJY6id;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fGHxm0TPgz3bnD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2026 00:52:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8A15E6185E;
	Wed, 18 Feb 2026 13:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A584C19424;
	Wed, 18 Feb 2026 13:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771422729;
	bh=OzMg1Hi4/8VmDJXStqfMwWgmBNW4HuWjLq4C/QxlQD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QszJY6id0HLRpEvQvHeK74fP0Wape38lmqGan0XqggOUTLKhaVGNpNTk52i1H+92O
	 3J7mpXmG5Di4NLx+UyTXaD6Lpmgo+qUd1RRmykK9mvBTD8GXLROwSoeM3p79UOqQli
	 YT2IO/q0nc2ocVoDzIGr9b008v3D39I+rRWHciP2sH03rBnN3MJIr3l4IcGz4nGrhH
	 1TWLRhxQBbJIKULPX6GYy1nyD9d+f3fwalSOSh2Ub7sjmpnh/RRUu/TPoFyU6gDr4K
	 XNJXrFw92FGpL33R3naGrhfYTURQ7t412s/AmeF8L8ThwbfnL3VIuFz4OoDD6tmTO+
	 Tpug0WeC5V4YQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vshyJ-0000000Bu02-1u1c;
	Wed, 18 Feb 2026 13:52:07 +0000
From: Marc Zyngier <maz@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/6] fsl_mc: Switch over to per-device platform MSI
Date: Wed, 18 Feb 2026 13:52:01 +0000
Message-ID: <20260218135203.2267907-5-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260218135203.2267907-1-maz@kernel.org>
References: <20260218135203.2267907-1-maz@kernel.org>
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
X-SA-Exim-Rcpt-To: ioana.ciornei@nxp.com, tglx@kernel.org, chleroy@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Obtain the msi-parent irqdomain instead of the fsl_mc domain,
which magically engages the per-device infrastructure.

Additionally, simplify the overly complicated error handling.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/bus/fsl-mc/dprc-driver.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index c63a7e688db6a..8ee5fb3c2d416 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -620,9 +620,8 @@ int dprc_setup(struct fsl_mc_device *mc_dev)
 {
 	struct device *parent_dev = mc_dev->dev.parent;
 	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_dev);
-	struct irq_domain *mc_msi_domain;
+	struct irq_domain *mc_msi_domain = NULL;
 	bool mc_io_created = false;
-	bool msi_domain_set = false;
 	bool uapi_created = false;
 	u16 major_ver, minor_ver;
 	size_t region_size;
@@ -663,14 +662,12 @@ int dprc_setup(struct fsl_mc_device *mc_dev)
 		uapi_created = true;
 	}
 
-	mc_msi_domain = fsl_mc_find_msi_domain(&mc_dev->dev);
-	if (!mc_msi_domain) {
+	mc_msi_domain = fsl_mc_get_msi_parent(&mc_dev->dev);
+	if (!mc_msi_domain)
 		dev_warn(&mc_dev->dev,
 			 "WARNING: MC bus without interrupt support\n");
-	} else {
+	else
 		dev_set_msi_domain(&mc_dev->dev, mc_msi_domain);
-		msi_domain_set = true;
-	}
 
 	error = dprc_open(mc_dev->mc_io, 0, mc_dev->obj_desc.id,
 			  &mc_dev->mc_handle);
@@ -710,8 +707,7 @@ int dprc_setup(struct fsl_mc_device *mc_dev)
 	(void)dprc_close(mc_dev->mc_io, 0, mc_dev->mc_handle);
 
 error_cleanup_msi_domain:
-	if (msi_domain_set)
-		dev_set_msi_domain(&mc_dev->dev, NULL);
+	dev_set_msi_domain(&mc_dev->dev, NULL);
 
 	if (mc_io_created) {
 		fsl_destroy_mc_io(mc_dev->mc_io);
-- 
2.47.3


