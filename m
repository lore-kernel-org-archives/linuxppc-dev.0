Return-Path: <SRS0=INWp=NY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7D9C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 16:39:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7FB216FD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 16:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7FB216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vYHH155JzF3PM
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 03:39:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.21; helo=inva021.nxp.com;
 envelope-from=madalin.bucur@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vYF45DypzF3KD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 03:37:12 +1100 (AEDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8290420023F;
 Tue, 13 Nov 2018 17:30:04 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 80FCD20023B;
 Tue, 13 Nov 2018 17:30:04 +0100 (CET)
Received: from fsr-fed2164-101.ea.freescale.net
 (fsr-fed2164-101.ea.freescale.net [10.171.82.91])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 19AA2205E2;
 Tue, 13 Nov 2018 17:30:04 +0100 (CET)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: davem@davemloft.net,
	netdev@vger.kernel.org
Subject: [PATCH v2 0/2] dpaa_eth: add ethtool coalesce control
Date: Tue, 13 Nov 2018 18:29:49 +0200
Message-Id: <1542126591-5114-1-git-send-email-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.1.0
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Reply-To: madalin.bucur@nxp.com
Cc: Madalin Bucur <madalin.bucur@nxp.com>, roy.pledge@nxp.com,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add control of the DPAA portal interrupt coalescing settings from
ethtool.

changes from v1: added range checking for the QMan APIs

Madalin Bucur (2):
  soc/qman: add return value to interrupt coalesce changing APIs
  dpaa_eth: add ethtool coalesce control

 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c | 49 ++++++++++++++++++++++
 drivers/soc/fsl/qbman/qman.c                       | 33 +++++++++++----
 include/soc/fsl/qman.h                             |  8 +++-
 3 files changed, 81 insertions(+), 9 deletions(-)

-- 
2.1.0

