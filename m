Return-Path: <SRS0=vPFq=6L=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDF4C4CECD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2020 18:24:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B5C620775
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2020 18:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5C620775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 499tVK0N7wzDqfP
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 04:24:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kaod.org (client-ip=87.98.171.146; helo=9.mo6.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 11991 seconds by postgrey-1.36 at bilbo;
 Tue, 28 Apr 2020 04:21:57 AEST
Received: from 9.mo6.mail-out.ovh.net (9.mo6.mail-out.ovh.net [87.98.171.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 499tQs4vlKzDqbh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2020 04:21:50 +1000 (AEST)
Received: from player157.ha.ovh.net (unknown [10.110.115.215])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 396A7207236
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2020 16:06:49 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id 2AA8B11CE5C22;
 Mon, 27 Apr 2020 14:06:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc: Add interrupt mode information in /proc/cpuinfo
Date: Mon, 27 Apr 2020 16:06:44 +0200
Message-Id: <20200427140644.332815-1-clg@kaod.org>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16643333898638232497
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrheelgdejtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhduheejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrgh
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
Cc: linuxppc-dev@lists.ozlabs.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

PowerNV and pSeries machines can run using the XIVE or XICS interrupt
mode. Report this information in /proc/cpuinfo :

    timebase    : 512000000
    platform    : PowerNV
    model       : 9006-22C
    machine     : PowerNV 9006-22C
    firmware    : OPAL
    MMU         : Radix
    IRQ         : XIVE

and use seq_puts() where we can.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/platforms/powernv/setup.c | 12 ++++++++----
 arch/powerpc/platforms/pseries/setup.c |  8 ++++++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 3bc188da82ba..39ef3394038d 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -196,14 +196,18 @@ static void pnv_show_cpuinfo(struct seq_file *m)
 		model = of_get_property(root, "model", NULL);
 	seq_printf(m, "machine\t\t: PowerNV %s\n", model);
 	if (firmware_has_feature(FW_FEATURE_OPAL))
-		seq_printf(m, "firmware\t: OPAL\n");
+		seq_puts(m, "firmware\t: OPAL\n");
 	else
-		seq_printf(m, "firmware\t: BML\n");
+		seq_puts(m, "firmware\t: BML\n");
 	of_node_put(root);
 	if (radix_enabled())
-		seq_printf(m, "MMU\t\t: Radix\n");
+		seq_puts(m, "MMU\t\t: Radix\n");
 	else
-		seq_printf(m, "MMU\t\t: Hash\n");
+		seq_puts(m, "MMU\t\t: Hash\n");
+	if (xive_enabled())
+		seq_puts(m, "IRQ\t\t: XIVE\n");
+	else
+		seq_puts(m, "IRQ\t\t: XICS\n");
 }
 
 static void pnv_prepare_going_down(void)
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 0c8421dd01ab..d248fca67797 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -95,9 +95,13 @@ static void pSeries_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "machine\t\t: CHRP %s\n", model);
 	of_node_put(root);
 	if (radix_enabled())
-		seq_printf(m, "MMU\t\t: Radix\n");
+		seq_puts(m, "MMU\t\t: Radix\n");
 	else
-		seq_printf(m, "MMU\t\t: Hash\n");
+		seq_puts(m, "MMU\t\t: Hash\n");
+	if (xive_enabled())
+		seq_puts(m, "IRQ\t\t: XIVE\n");
+	else
+		seq_puts(m, "IRQ\t\t: XICS\n");
 }
 
 /* Initialize firmware assisted non-maskable interrupts if
-- 
2.25.3

