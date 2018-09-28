Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3112C43382
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 08:46:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DE5A2173D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 08:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE5A2173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42M4z0057fzF3C6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 18:46:20 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42M4vw6BKtzF3BW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 18:43:39 +1000 (AEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3A18A200032;
 Fri, 28 Sep 2018 10:43:36 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2E48620000A;
 Fri, 28 Sep 2018 10:43:36 +0200 (CEST)
Received: from fsr-fed2164-101.ea.freescale.net
 (fsr-fed2164-101.ea.freescale.net [10.171.82.91])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B2DF120621;
 Fri, 28 Sep 2018 10:43:35 +0200 (CEST)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: leoyang.li@nxp.com
Subject: [PATCH v2 0/5] soc/fsl/qbman: DPAA QBMan fixes and additions 
Date: Fri, 28 Sep 2018 11:43:19 +0300
Message-Id: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
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
Cc: Madalin Bucur <madalin.bucur@nxp.com>, catalin.marinas@arm.com,
 roy.pledge@nxp.com, linux-kernel@vger.kernel.org, oss@buserror.net,
 claudiu.manoil@nxp.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch set brings a number of fixes and the option to control
the QMan portal interrupt coalescing.

Changes from v1:
 - change CPU 0 with any online CPU to allow CPU 0 to be taken offline
 - move common code in a function
 - address all places in the code where the portal interrupt was affined
   to CPU 0
 - remove unrelated change from patch adding 64 bit DMA addressing
   requirement

Madalin Bucur (2):
  soc/fsl/qbman: replace CPU 0 with any online CPU in hotplug handlers
  soc/fsl_qbman: export coalesce change API

Roy Pledge (3):
  soc/fsl/qbman: Check if CPU is offline when initializing portals
  soc/fsl/qbman: Add 64 bit DMA addressing requirement to QBMan
  soc/fsl/qbman: Use last response to determine valid bit

 drivers/soc/fsl/qbman/Kconfig       |  2 +-
 drivers/soc/fsl/qbman/bman.c        |  6 ++---
 drivers/soc/fsl/qbman/bman_portal.c |  4 ++-
 drivers/soc/fsl/qbman/dpaa_sys.h    | 20 ++++++++++++++
 drivers/soc/fsl/qbman/qman.c        | 53 ++++++++++++++++++++++++++++++++-----
 drivers/soc/fsl/qbman/qman_portal.c |  6 +++--
 include/soc/fsl/qman.h              | 27 +++++++++++++++++++
 7 files changed, 104 insertions(+), 14 deletions(-)

-- 
2.1.0

