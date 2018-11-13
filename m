Return-Path: <SRS0=INWp=NY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249D5C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 16:43:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1A0F216FD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 16:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A0F216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vYMy4FSXzF38T
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 03:43:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.13; helo=inva020.nxp.com;
 envelope-from=madalin.bucur@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vYFc2BHJzF3NR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 03:37:39 +1100 (AEDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B2A2A1A021D;
 Tue, 13 Nov 2018 17:30:09 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A6AA11A0032;
 Tue, 13 Nov 2018 17:30:09 +0100 (CET)
Received: from fsr-fed2164-101.ea.freescale.net
 (fsr-fed2164-101.ea.freescale.net [10.171.82.91])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 4B9B8205E2;
 Tue, 13 Nov 2018 17:30:09 +0100 (CET)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: davem@davemloft.net,
	netdev@vger.kernel.org
Subject: [PATCH v2 2/2] dpaa_eth: add ethtool coalesce control
Date: Tue, 13 Nov 2018 18:29:51 +0200
Message-Id: <1542126591-5114-3-git-send-email-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1542126591-5114-1-git-send-email-madalin.bucur@nxp.com>
References: <1542126591-5114-1-git-send-email-madalin.bucur@nxp.com>
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

Allow ethtool control of the DPAA QMan portal interrupt coalescing
settings.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
index 13d6e2272ece..4df366b05976 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
@@ -529,6 +529,53 @@ static int dpaa_get_ts_info(struct net_device *net_dev,
 	return 0;
 }
 
+static int dpaa_get_coalesce(struct net_device *dev,
+			     struct ethtool_coalesce *c)
+{
+	struct qman_portal *portal;
+	u32 period;
+	u8 thresh;
+
+	portal = qman_get_affine_portal(smp_processor_id());
+	qman_portal_get_iperiod(portal, &period);
+	qman_dqrr_get_ithresh(portal, &thresh);
+
+	c->rx_coalesce_usecs = period;
+	c->rx_max_coalesced_frames = thresh;
+	c->use_adaptive_rx_coalesce = false;
+
+	return 0;
+}
+
+static int dpaa_set_coalesce(struct net_device *dev,
+			     struct ethtool_coalesce *c)
+{
+	const cpumask_t *cpus = qman_affine_cpus();
+	struct qman_portal *portal;
+	u32 period;
+	u8 thresh;
+	int cpu;
+	int res;
+
+	if (c->use_adaptive_rx_coalesce)
+		return -EINVAL;
+
+	period = c->rx_coalesce_usecs;
+	thresh = c->rx_max_coalesced_frames;
+
+	for_each_cpu(cpu, cpus) {
+		portal = qman_get_affine_portal(cpu);
+		res = qman_portal_set_iperiod(portal, period);
+		if (res)
+			return res;
+		res = qman_dqrr_set_ithresh(portal, thresh);
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
+
 const struct ethtool_ops dpaa_ethtool_ops = {
 	.get_drvinfo = dpaa_get_drvinfo,
 	.get_msglevel = dpaa_get_msglevel,
@@ -545,4 +592,6 @@ const struct ethtool_ops dpaa_ethtool_ops = {
 	.get_rxnfc = dpaa_get_rxnfc,
 	.set_rxnfc = dpaa_set_rxnfc,
 	.get_ts_info = dpaa_get_ts_info,
+	.get_coalesce = dpaa_get_coalesce,
+	.set_coalesce = dpaa_set_coalesce,
 };
-- 
2.1.0

