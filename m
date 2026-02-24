Return-Path: <linuxppc-dev+bounces-17105-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E081BE9B24C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Feb 2026 10:10:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKtkV6GvBz3cPl;
	Tue, 24 Feb 2026 21:09:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771927794;
	cv=none; b=UzJZuIZS58JQy33rH1dRmr34r2LGmPzYmPt6lYPrNCOB7f3fW3Hzo5zc2OJvGMV/+V4W9SQriG8yejo1csjQGp6SGlKcMIV6r5U94GdWFbzPs0kglU5HWCWQfh9Ne5AtrWacxOzceoMU8q45mPl3IMSF03BRmS8Ane50s34Tq3UCo1OPmlWwv81ysB0lsne48FU5db5gYr4VGowoClIeofACBj/zIR7CLxOr0orUY8IK+mnhAPRtiwMyXPv6l0sI5wI652GBFT1B2OQkPzOj9VWKXRoGnfAOuA1YJdJyp1OLDu3rJ6D1D/9vNp5ZOXxTfRDii2AAAg2CcRJyuz9fmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771927794; c=relaxed/relaxed;
	bh=3anWyn7fJD7tloH6wyDktrvnU/7yWNaxU6qE+6fX/TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/iWP1YaN248h2bP5K4IVDeb2n3didvVwsXWD77dezPE9pdoGdieN0zbbsOM+e9ucCw5Tok6dKDQlonBBjRYynrn5fbR4H1gVZDnuVglwN4y1eqjC2PZflNLODRV3rpWck7nAQXy2Qw08mpQ4gsamoTjoP/XbdLt9DjKJPOgQAijFPS6ha3bePIWPCwolora9kOr6x2/L45ESUsJhiphET5JuozUOAsU+lgw7VeEpT2bEcKBHGvi9WF3UTPEH6mSTIGLWC6VPNZskwVAtgT+4Rd3HTm5ZhmCjMcpc/O/InuIWb5HcKIsDiJghtMDH6nW3o5Rf+/SqttEDOr43Jt1xQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dUcXbY0/; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dUcXbY0/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKtkS5tgsz3cM9
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2026 21:09:52 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 03277445AA;
	Tue, 24 Feb 2026 10:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39ADC19424;
	Tue, 24 Feb 2026 10:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771927788;
	bh=+mIYXoJQ0DKik4PPz+rU9CG4TWONToou5quJ/VFR000=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dUcXbY0/iNiZQI00KrTaVdv8bnC9DzKGpoSAPzVdTegTjPbB/dA+WYFsUuMLYRCpD
	 9FrlsTxdUjPcd7wRlvyOjy3jR4gag559naNnj0S6tmC+6H7ymwW62GBjOgTnHThXoO
	 AqCaf5scJ68hxfkPqNfXc7zhtkhbFsmgB253f92czb2EvjW276eyinWEZ8uVbh9fYg
	 92ZyM4daFuvCvHpsHNkhscbdlqUEAwDJ6h3l3npRdBVCqODNCsQvVQO0AZT8yoJH9S
	 ApyljUaXQmIwwdsQU8FdSEKpjc0pcdD0gz4nJiv20X+KM9t4USuskTpjmN9S2+ClDz
	 525brg1S6D/nA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vupMR-0000000DIa5-0175;
	Tue, 24 Feb 2026 10:09:47 +0000
From: Marc Zyngier <maz@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Sascha Bischoff <sascha.bischoff@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 6/6] platform-msi: Remove stale comment
Date: Tue, 24 Feb 2026 10:09:36 +0000
Message-ID: <20260224100936.3752303-7-maz@kernel.org>
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

The backward compatibility code for the previous incarnation of
platform MSI was removed in e9894248994ca ("genirq/msi: Remove
platform MSI leftovers"), but the comment about that removal is
still present.  Remove it.

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com> # LX2160ARDB, LS2088ARDB
Tested-by: Sascha Bischoff <sascha.bischoff@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/base/platform-msi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 70db08f3ac6fa..69eed058eb208 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -61,10 +61,6 @@ static const struct msi_domain_template platform_msi_template = {
  * parent. The parent domain sets up the new domain. The domain has
  * a fixed size of @nvec. The domain is managed by devres and will
  * be removed when the device is removed.
- *
- * Note: For migration purposes this falls back to the original platform_msi code
- *	 up to the point where all platforms have been converted to the MSI
- *	 parent model.
  */
 int platform_device_msi_init_and_alloc_irqs(struct device *dev, unsigned int nvec,
 					    irq_write_msi_msg_t write_msi_msg)
-- 
2.47.3


