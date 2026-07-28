Return-Path: <linuxppc-dev+bounces-24915-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10DEC54F4D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 00:49:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8H1409Kvz2ygh;
	Tue, 28 Jul 2026 10:49:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785199783;
	cv=none; b=NYXkht56CFHO4wNKkXK4nAF3nOPNQFOuc+G4OUstKrZjdQ/eAB0qRFa6muwXEEqc4bY1DrCLmHzTDlvZO7OEbKYgosCh2yD5dYo98wxdcdKsUuMFA2HLVRJ8iEVbZbV0YT681s8H9R9+xtQ/BszZBFQ5Pc6Fl6X/NBJnyMrJaSW8oclqC+rcFbXd0Asey8Ez7GsM5srSHAv58iaqHU8KyTbUkZZh2bthkTkcH5lwk/umFwsh0y4wIsfYdC6BPOQ7es8Q0z120tP0PtVfD3Qygq0J0FNmEjL61KzeXnL6Gf03hMHPnn1vs2u/iF2ZPStWPqLLsh1Q3gEzU0Y4k7VBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785199783; c=relaxed/relaxed;
	bh=LQr626GGE0piZ3C4A6XO0P6Jwi5RDZH9w5gxGAWoUKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YA4i0R/LmnkLCETGasDk/1Puz0uXBv9ZKGgbTDYLroodi9I1nsCqsJkj1NO22i6n9xIstxcq69V16mAnGnKE5qL7GOwGOd3Idd08ZO5UAUh7bH+cwU61P+ak/opSBaW0kyWNepYFSS/BUPUpxtC9VpCqs8sYFjNu8Zz5wD3l0Q4OesV+dUIjo5g90gc+YQKpyhHsHCiSNmzFKm/GLvsg8q5qbeHmixTwgrGM10nVZY81damUAH7WzCq3Hfd/Z9262nCFL1n2GCc9ElQnABnlSWVC1MUyszizL62DC3caOHb6aA8TZ4ZZSRxzscr8g/SV+5VOaTwYjHZ8vLKqFlErEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mV3fcjBu; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mV3fcjBu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8H114WCgz2ygW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 10:49:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=LQr626GGE0piZ3C4A6XO0P6Jwi5RDZH9w5gxGAWoUKo=; b=mV3fcjBuYaAfWlIF+/dcayNL6k
	NEmFPJGZ4WSFfMU0DOq58JgSJi3LA0zbC+rnSi1pBWBFosZ1P95TsoXQirL+2QNFPX9cDXRdMWn+8
	q4q1dyZUFgOC/gZTxZBnF0r6lfd8PxtQE1EdAxaL2Ou1KiLVNH4Jrrrajo/3BW7GNPQFg0DlVmMYn
	hXlcxODPIEDo5RtbbkNyx0cF0+ZFGI6T5lN5JuT3eWMFeaPU1Sj8YW7wityrf+tcfKexs+s50uXrU
	/l0m1RGpg+Ak4nY/fnHFHdU0eulM7ZxSg+ZCUT0b7YmwJlA38on9L5frKAFB7U3Lrdn5sHmFMpSCM
	G9sHPbNA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woW0o-000000049YW-3Bmg;
	Tue, 28 Jul 2026 00:49:38 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Li Yang <leoyang.li@nxp.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Frank Li <Frank.Li@nxp.com>,
	Guanhua Gao <guanhua.gao@nxp.com>,
	Roy Pledge <Roy.Pledge@nxp.com>
Subject: [PATCH v3] soc: fsl: dpio: fix kernel-doc typos
Date: Mon, 27 Jul 2026 17:49:38 -0700
Message-ID: <20260728004938.905415-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
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

Correct spelling of 2 words.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Guanhua Gao <guanhua.gao@nxp.com>
Cc: Roy Pledge <Roy.Pledge@nxp.com>
---
v2:  update Cc: list, rebase
v3:  rebase & resend

 include/soc/fsl/dpaa2-io.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20260727.orig/include/soc/fsl/dpaa2-io.h
+++ linux-next-20260727/include/soc/fsl/dpaa2-io.h
@@ -22,7 +22,7 @@ struct device;
  * DOC: DPIO Service
  *
  * The DPIO service provides APIs for users to interact with the datapath
- * by enqueueing and dequeing frame descriptors.
+ * by enqueueing and dequeueing frame descriptors.
  *
  * The following set of APIs can be used to enqueue and dequeue frames
  * as well as producing notification callbacks when data is available
@@ -33,7 +33,7 @@ struct device;
 
 /**
  * struct dpaa2_io_desc - The DPIO descriptor
- * @receives_notifications: Use notificaton mode. Non-zero if the DPIO
+ * @receives_notifications: Use notification mode. Non-zero if the DPIO
  *                  has a channel.
  * @has_8prio:      Set to non-zero for channel with 8 priority WQs.  Ignored
  *                  unless receives_notification is TRUE.

