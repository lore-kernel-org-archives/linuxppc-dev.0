Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C4FC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:14:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8FF42184C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FF42184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L4K84kJ5zDqQR
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:14:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.17.13; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
X-Greylist: delayed 325 seconds by postgrey-1.36 at bilbo;
 Fri, 15 Mar 2019 09:40:31 AEDT
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3ZR1h29zDqBX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:40:30 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N49Qd-1gvrll0h97-0103fB; Thu, 14 Mar 2019 23:34:36 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/45] drivers: tty: serial: amba-pl010: use
 devm_ioremap_resource()
Date: Thu, 14 Mar 2019 23:33:34 +0100
Message-Id: <1552602855-26086-5-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:XGcErtNSwWbhM+beVJp8GQkXmsSFvICpTIBZTEUMjOcPXLBAOv+
 l716gkPOIJ0e+QeD8Gj1jW5G07RPO1qxMpGqSJbcy3aRueTrUuay98zHFd8GCY+gQzva6m8
 A6AFNq6qnlIV+GRpKljpQsmVfieEgmLhngunKTALWxW8iiVuTwWuq+TIqJlaSkMHzV4Qgts
 K8/3FfQdltczAXhNmC/cg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gzHxcE8JM1I=:M9FwYxrRSRt+BQY5hulUVh
 Ao9Ho4mvM3JWxp3ryldeVYOMoTdaKl+gnwiIw5LG9H+CR5Dp3EcKdhC8VkNn/ek+4OFvSoVLT
 gOi70hzbUpyY9VEK8UGZIOd2VltIAyqsRqnWO3iyKI4sXlo6jQjyjm2f0Ty0A9cYLG+jfIf91
 NgXIkmWTNpn6CWxWYLYz5idY/qbVi/TdZ2pXTlAq4znvoJMhvk+z8khq9AUE3LI/CWPA3B72r
 vgmyRnVsUjloAl4FMRdzAufO2hg3GPUoti+Sz2yOFXjn1mjbhHYdKpXgK/68FLo8exNDRKd2Y
 cSKxm4aPmgqIXlJNvL2AianvSJFxYR1rEHl+YdacVOPyEnBcPz2JDMV3JxuzlYS+ML5flCBLK
 RB2m1ZKMXP5bYwkojGYBCZEvPuF1NM/6jz+5kjluz3OZwYqsbPH7iRbzXTVA6UpHe0GhR/d9T
 3x967QsZGuHVOWRoW5nsT0Nfeal7bYgidpW1WFthAtr/339JBFOV+CvdYRZXq7+l7GI8HS2If
 urFCQp8lYxk57Fwsbg22ZFeuuShARzov6kaLvC0OJCF+4eHoTZ5SjjBkRD1fnIhEp2sxs+jH8
 M3Z1j9aVadV5WI79T7SbAdlIgC3dkQpjbKlm1FhmXVUa58bG65ReyD2eDrYEO0P86bzqOVtR/
 qVbikJ/ZSCV26RJwlzv3mXA8n4tEAOZgvsDzga/htk80n78wQYITKYxOmUmUWgyO7toleiAeP
 UaUpR12oGtot130iU9fk1+SP47RdJvDJyGyMRA==
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
Cc: linux-arm-msm@vger.kernel.org, yamada.masahiro@socionext.com,
 macro@linux-mips.org, jacmet@sunsite.dk, festevam@gmail.com,
 stefan.wahren@i2se.com, f.fainelli@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, linux-imx@nxp.com,
 linux-serial@vger.kernel.org, u.kleine-koenig@pengutronix.de,
 andy.gross@linaro.org, tklauser@distanz.ch, david.brown@linaro.org,
 rjui@broadcom.com, s.hauer@pengutronix.de, slemieux.tyco@gmail.com,
 linuxppc-dev@lists.ozlabs.org, vz@mleia.com, matthias.bgg@gmail.com,
 andriy.shevchenko@linux.intel.com, baohua@kernel.org, sbranden@broadcom.com,
 eric@anholt.net, richard.genoud@gmail.com, gregkh@linuxfoundation.org,
 kernel@pengutronix.de, shawnguo@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Instead of fetching out data from a struct resource for passing
it to devm_ioremap(), directly use devm_ioremap_resource()

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/amba-pl010.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index 2c37d11..109b8df 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -713,8 +713,7 @@ static int pl010_probe(struct amba_device *dev, const struct amba_id *id)
 	if (!uap)
 		return -ENOMEM;
 
-	base = devm_ioremap(&dev->dev, dev->res.start,
-			    resource_size(&dev->res));
+	base = devm_ioremap_resource(&dev->dev, &dev->res);
 	if (!base)
 		return -ENOMEM;
 
-- 
1.9.1

