Return-Path: <SRS0=9DpD=XL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE40C49ED7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Sep 2019 10:52:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 997972067D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Sep 2019 10:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 997972067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46X33v59mjzF4cL
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Sep 2019 20:52:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.13; helo=inva020.nxp.com; envelope-from=biwen.li@nxp.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46X2jG4DxnzF3lf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Sep 2019 20:36:27 +1000 (AEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6520C1A0572;
 Mon, 16 Sep 2019 12:36:21 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 22DBD1A0207;
 Mon, 16 Sep 2019 12:36:17 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 92EDF402BF;
 Mon, 16 Sep 2019 18:36:11 +0800 (SGT)
From: Biwen Li <biwen.li@nxp.com>
To: leoyang.li@nxp.com, shawnguo@kernel.org, robh+dt@kernel.org,
 mark.rutland@arm.com
Subject: [1/3] soc: fsl: fix that flextimer cannot wakeup system in deep sleep
 on LS1021A
Date: Mon, 16 Sep 2019 18:25:54 +0800
Message-Id: <20190916102556.16655-1-biwen.li@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Mon, 16 Sep 2019 20:45:10 +1000
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
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Biwen Li <biwen.li@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Why:
    - Cannot write register RCPM_IPPDEXPCR1 on LS1021A,
      Register RCPM_IPPDEXPCR1's default value is zero.
      So the register value that reading from register
      RCPM_IPPDEXPCR1 is always zero.

How:
    - Save register RCPM_IPPDEXPCR1's value to
      register SCFG_SPARECR8.(uboot's psci also
      need reading value from the register SCFG_SPARECR8
      to set register RCPM_IPPDEXPCR1)

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
 drivers/soc/fsl/rcpm.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/soc/fsl/rcpm.c b/drivers/soc/fsl/rcpm.c
index 82c0ad5e663e..2bf37d38efe5 100644
--- a/drivers/soc/fsl/rcpm.c
+++ b/drivers/soc/fsl/rcpm.c
@@ -13,6 +13,8 @@
 #include <linux/slab.h>
 #include <linux/suspend.h>
 #include <linux/kernel.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 
 #define RCPM_WAKEUP_CELL_MAX_SIZE	7
 
@@ -63,6 +65,33 @@ static int rcpm_pm_prepare(struct device *dev)
 					tmp |= value[i + 1];
 					iowrite32be(tmp, rcpm->ippdexpcr_base + i * 4);
 				}
+				#ifdef CONFIG_SOC_LS1021A
+				/* Workaround: There is a bug of register ippdexpcr1,
+				 * cannot write it but can read it.Tt's default value is zero,
+				 * then read it will always returns zero.
+				 * So save ippdexpcr1's value to register SCFG_SPARECR8.
+				 * And the value of ippdexpcr1 will be read from SCFG_SPARECR8.
+				 */
+				{
+					struct regmap * rcpm_scfg_regmap = NULL;
+					u32 reg_offset[RCPM_WAKEUP_CELL_MAX_SIZE + 1];
+					u32 reg_value = 0;
+
+					rcpm_scfg_regmap = syscon_regmap_lookup_by_phandle(np, "fsl,rcpm-scfg");
+					if (rcpm_scfg_regmap) {
+						if (of_property_read_u32_array(dev->of_node,
+						    "fsl,rcpm-scfg", reg_offset, rcpm->wakeup_cells + 1)) {
+							rcpm_scfg_regmap = NULL;
+							continue;
+						}
+						regmap_read(rcpm_scfg_regmap, reg_offset[i + 1], &reg_value);
+						/* Write value to register SCFG_SPARECR8 */
+						regmap_write(rcpm_scfg_regmap, reg_offset[i + 1], tmp | reg_value);
+					}
+				}
+				#endif
+
+
 			}
 		}
 	} while (ws = wakeup_source_get_next(ws));
-- 
2.17.1

