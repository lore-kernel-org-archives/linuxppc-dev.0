Return-Path: <SRS0=Hg4A=QZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E479CC10F01
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 15:15:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 608FE21905
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 15:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ZQgODXR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608FE21905
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4436r03StXzDqKP
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 02:15:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=hotmail.com
 (client-ip=40.92.254.94; helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=yellowriver2010@hotmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="ZQgODXR4"; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-oln040092254094.outbound.protection.outlook.com [40.92.254.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4436pC3N29zDqHX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 02:13:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVljQ5y9PHavg8WZjyPWUQ8MDHMgL3eec4PreTyOB40=;
 b=ZQgODXR4C7pHCQy5pfAo5jnOXyhXxyyxgFq/66yzGZ5DgWQORe0tJBAPfiwbGF1BIP1AUYgunNDA6vuu9LrmoNW76d3aX2Hex4OG+RaTWLSRzXb7up5FzpaCkURqbfgRCGudoOuv+bplnPK5WWF5LOiwiOQh9UjBYQjuAnaNnE03a/QnN2Q4hNZl5aIs5ZoAn7p/7Vfn/nqza95gIpBARKR+wq1o2usKTE1GTLjfZXkHsgvqTn1Lgzmch6ySJlrSzERQeHB5Gsaogo2RNUyoUGDmPyO4/5jFDui+oCebaLHbO7xg7y1/vLINw3Vv6hwEjFPtOy2tPMbw9Oz2x1oXmg==
Received: from PU1APC01FT027.eop-APC01.prod.protection.outlook.com
 (10.152.252.56) by PU1APC01HT191.eop-APC01.prod.protection.outlook.com
 (10.152.252.176) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Mon, 18 Feb
 2019 15:13:47 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.252.57) by
 PU1APC01FT027.mail.protection.outlook.com (10.152.252.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 18 Feb 2019 15:13:47 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 15:13:47 +0000
From: Wen Yang <yellowriver2010@hotmail.com>
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Mark Brown <broonie@kernel.org>, "Jaroslav
 Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 1/3] SoC: imx-sgtl5000: add missing put_device()
Thread-Topic: [PATCH 1/3] SoC: imx-sgtl5000: add missing put_device()
Thread-Index: AQHUx5yLVoYrWF49lEOrQBFwsayyWw==
Date: Mon, 18 Feb 2019 15:13:47 +0000
Message-ID: <HK0PR02MB3634C18C42652DC3A2893043B2630@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0038.prod.exchangelabs.com (2603:10b6:a03:94::15)
 To HK0PR02MB3634.apcprd02.prod.outlook.com
 (2603:1096:203:97::14)
x-incomingtopheadermarker: OriginalChecksum:98D7A082F0DA93C22750C1B167AE38627F1910D426D1574A241B1D748F9B79B0;
 UpperCasedChecksum:120AC8C052E0D2BE12530C1CA51ED07AAD156E0421CB4E380547E4FD62CC01B4;
 SizeAsReceived:8951; Count:62
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-tmn: [vRYiuKw2gg5Hd4k3ET9SnFdXNzQ/DRFD]
x-microsoft-original-message-id: <20190218151035.9459-1-yellowriver2010@hotmail.com>
x-ms-publictraffictype: Email
x-incomingheadercount: 62
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: mBRmoEB1kyK7hrgxOKbLTYwirQRQRxH3pkPf/rs4j9PFGwlrxooVMtca33saXR4/6Qlg+/V8ySkjWwv6SGOx08v7woBRphQUk7caTCc45/G7iMoPOqbyYVBPKK0TRJg/g5cfueD37qcjGOFvtZHMFypi703kHRWL8qWjVDR4Bxyx0ox0r8zx3qPuaLkiJ7CP+v+J9X0310nC94fFgpwiWqB6vfRaQ+hEQ5dDzTDkYFX4T0ujUngRsgC30KeGYYK4TLbcDpaJ2ml9/meYllxUVYKfvq9SieWmex2gmUXF1TLnCsBZWU7hMgCKb7q/I4IJmtZqgQqmdVK7yNy1nmGpGH+yZy8ZktLhW5Tu+0rXquD1vZDtzue/1fXsZ6iGSz77F2kri+SMVDkkJeoqSc90Yo8a2KVbh4P8VwR9/5de/gbdYsWnHGpeoRTi79AoSg3rFjHn8v+dqISkI/5F/0vyTWlra76ytBgI3DIv8c2WjyCC8mSpqPPDIo9n0g0dCgVBCs0vAe0Q5vx4GNb+/zn9XyZJZh4vyDxvSefoiOzBMETbdLXYQF/Vh+JJWuy92tZnh2hJErS29NnqFpXV+TzOVF+TI3ALzPTmELmbudsOVhaT0arNkh5GoEqfs8eUHDno06j7GBbCFPTutBJ030ew9Uxd8KvRgk9ByKls0uphTdIGOEB0AcQTsu7DBphqkqLohMbxjo4PJ+AOUiiKfebm5mO1lLNHKou3lx4Vq3lcaUsABb8WUL/ZisIshp5FUZcFpF1DqhMGa7Q=
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);
 SRVR:PU1APC01HT191; 
x-ms-traffictypediagnostic: PU1APC01HT191:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:PU1APC01HT191; BCL:0; PCL:0; RULEID:; SRVR:PU1APC01HT191; 
x-microsoft-antispam-message-info: tnVp0z1dPnxsVhrV9hVSNeSz2g4mwKAHCzxiCrGJ6Qo0JPI6FDpzvFNVPTCsQzM+
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: 68009049-f75d-4f02-771b-08d695b3aded
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 15:13:38.9291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT191
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Wen Yang <yellowriver2010@hotmail.com>, Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The of_find_device_by_node() takes a reference to the underlying device
structure, we should release that reference.

Detected by coccinelle with the following warnings:
./sound/soc/fsl/imx-sgtl5000.c:169:1-7: ERROR: missing put_device;
call of_find_device_by_node on line 105, but without a corresponding
object release within this function.
./sound/soc/fsl/imx-sgtl5000.c:177:1-7: ERROR: missing put_device;
call of_find_device_by_node on line 105, but without a corresponding
object release within this function.

Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: alsa-devel@alsa-project.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/fsl/imx-sgtl5000.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index b6cb80480b60..bf8597f57dce 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -108,6 +108,7 @@ static int imx_sgtl5000_probe(struct platform_device *p=
dev)
 		ret =3D -EPROBE_DEFER;
 		goto fail;
 	}
+	put_device(&ssi_pdev->dev);
 	codec_dev =3D of_find_i2c_device_by_node(codec_np);
 	if (!codec_dev) {
 		dev_dbg(&pdev->dev, "failed to find codec platform device\n");
--=20
2.20.1

