Return-Path: <linuxppc-dev+bounces-17103-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314C7E9B24D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Feb 2026 10:10:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKtkV13hGz3cNt;
	Tue, 24 Feb 2026 21:09:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771927794;
	cv=none; b=c6ZRXEQ4nHnd8EON+Ujl62ljtjtWgZNJM2gyek7CcsLYbqAVxhcyjeWxwu6ykVeEdM3eRoEUuebt97xD8Mednrx+2mliMMrjHF9IcrcHQrXYj5EYDZLEWV6c7Hk0gibEIMmQV2Vt3AGfQeiWhkD44qqoP+RNycp293/Hg2HGm5a/xqpd3JA38zc78TZciP84HU7bCzjUFzUd6Jk4djSowZ5Y9KqcXzZfNbDOVLmM12d5z/tnTfkzcmPyCXmTQ9V+qNhF1tsTHilXtoV81ESrjrKI9Up00bNCsbGGG7kYvzrbOi/AVYwjpExIkTCmHvnA6w/tLf1ORaNzZ6pvUeU42w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771927794; c=relaxed/relaxed;
	bh=g+XuFLR2vHR8fRdFxdM4nBK5CYAUy53Xf5sj3MMEcQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=By5H9anAZ6qmxA7nhPSihxv/9YQpwEF6YzXF4eIoDIV40cVFI2yfvGpZbYmmXWPDzaQl3IheX14fQsq73lJJxm6rAyAGmIKcWuSAiNGsLfZpzYMcJ6nYtSIrChCk4mVCQEW0lBMZsoMgx3snjqXzjE/N7IL+qvobto+JIg3xbCM3K9iZ1CALCxVwdJoMNKmES5p9NKtKuTKwpPZB8Ogy4XKJB5hhUX7W01GU56AtGciANxfCGWSZMyAzPwkRqdhGlLlweDjiiT6MIneyoVjdGnVzjv0Lc6qnWPBkWbx0h1jEM1/av5waS7p6NuOFSMAb22OcUJR4W9TXsAC9EbjdkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NoLxYcXT; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NoLxYcXT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKtkR1R6Vz3cLV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2026 21:09:51 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A1EB9445AD;
	Tue, 24 Feb 2026 10:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8132CC2BC9E;
	Tue, 24 Feb 2026 10:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771927788;
	bh=fmwZsFG2mQswj1CldtERGx0gFVuT8PrD6fuT1n1QemU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NoLxYcXTduxMnD3ZooqViNnlsEONuJq50yjwPk0tTRncHahzVysOljAseB1CKQRIk
	 oqwJ1hkig04D+WIwo8Muu17MfuSDJV6mXCX5421jci1Qw2LYqd1lUqFtShxvVJc4LI
	 zixlu6I2cs5OC/kPHuFl2U+B2hivY5OXREULVDbAImtY85VY3qhMbA0Iy3LrGsK2TK
	 BI9Frt6ABWCWr0LsLaxPJHw3knTlQLBarOvil7jA8GOa4m5mQaBhz/O0PuSaCJFWV7
	 7Nt2PZJp00f37BGBHKXn5wT91YbA/MHsPVq2AjiMh28PM/1pWleS00Q5B491ZZvnWQ
	 U4Od+RgQSviPA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vupMQ-0000000DIa5-27eJ;
	Tue, 24 Feb 2026 10:09:46 +0000
From: Marc Zyngier <maz@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Sascha Bischoff <sascha.bischoff@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 4/6] fsl-mc: Switch over to per-device platform MSI
Date: Tue, 24 Feb 2026 10:09:34 +0000
Message-ID: <20260224100936.3752303-5-maz@kernel.org>
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

Obtain the msi-parent irqdomain instead of the fsl_mc domain,
which magically engages the per-device infrastructure.

Additionally, simplify the overly complicated error handling.

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com> # LX2160ARDB, LS2088ARDB
Tested-by: Sascha Bischoff <sascha.bischoff@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/bus/fsl-mc/dprc-driver.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index db67442addad2..a85706826fa06 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -609,9 +609,8 @@ int dprc_setup(struct fsl_mc_device *mc_dev)
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
@@ -652,14 +651,12 @@ int dprc_setup(struct fsl_mc_device *mc_dev)
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
@@ -699,8 +696,7 @@ int dprc_setup(struct fsl_mc_device *mc_dev)
 	(void)dprc_close(mc_dev->mc_io, 0, mc_dev->mc_handle);
 
 error_cleanup_msi_domain:
-	if (msi_domain_set)
-		dev_set_msi_domain(&mc_dev->dev, NULL);
+	dev_set_msi_domain(&mc_dev->dev, NULL);
 
 	if (mc_io_created) {
 		fsl_destroy_mc_io(mc_dev->mc_io);
-- 
2.47.3


