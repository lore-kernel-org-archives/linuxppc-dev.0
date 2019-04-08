Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA98C282CE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 09:29:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B2020880
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 09:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aWkGOm+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B2020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44d4rS13BrzDqMB
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 19:29:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.5.84; helo=eur03-ve1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="aWkGOm+x"; 
 dkim-atps=neutral
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50084.outbound.protection.outlook.com [40.107.5.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44d4pk49YlzDqBs
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2019 19:28:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6Z+VtR6NhxBeqRZrfE3KBBMqf0pfxQzOUZTO2V6Dm4=;
 b=aWkGOm+xTySxPz7uBIqUi4cZZorgmjBM9t7xnXssDtIO53cYBGa2PMkE9GiQEv33s3Qo8L42bV3GZ9Ua2MDI/dnwWV3z16ONbGPdSFXrT2RnNhUv0BFWimeRVhb4XGvBrb8f47bOKJKA3WqgVU7o0jmKXC+iKGcA3avuBJ4S2Kg=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6384.eurprd04.prod.outlook.com (20.179.232.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Mon, 8 Apr 2019 09:28:06 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%6]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 09:28:06 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>, "gustavo@embeddedor.com"
 <gustavo@embeddedor.com>
Subject: [PATCH V1] ASoC: fsl_esai: replace fall-through with break
Thread-Topic: [PATCH V1] ASoC: fsl_esai: replace fall-through with break
Thread-Index: AQHU7e1fLmmYRIJqIECtUR/V3RQ9hA==
Date: Mon, 8 Apr 2019 09:28:06 +0000
Message-ID: <66c117128f300b0ec5f278f538412789c78b60a6.1554715589.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:202:16::14) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f046d2d4-4094-45bb-e191-08d6bc048168
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6384; 
x-ms-traffictypediagnostic: VE1PR04MB6384:
x-microsoft-antispam-prvs: <VE1PR04MB6384F0EB89EAAFD3E801CF42E32C0@VE1PR04MB6384.eurprd04.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(39860400002)(346002)(366004)(396003)(376002)(199004)(189003)(86362001)(256004)(53936002)(4326008)(71190400001)(26005)(2616005)(106356001)(81166006)(71200400001)(305945005)(102836004)(14444005)(2501003)(105586002)(14454004)(476003)(6512007)(316002)(99286004)(486006)(110136005)(6506007)(5660300002)(81156014)(118296001)(2201001)(6486002)(66066001)(6116002)(52116002)(8936002)(386003)(50226002)(97736004)(7736002)(3846002)(36756003)(2906002)(6436002)(8676002)(478600001)(4744005)(68736007)(25786009)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6384;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gWvLURVCpgseKJhxBnrN6oyV2ZKnRT2WsfvOSKvDMCt5Z2xeAkW7kiTVQk9Mxxr0eGwakF3n1alaZQJKtC2053PXdbfO1PJUuw4hZZ5V/mQ2bTJ0Tfs7Ti+zL+IWQVmCVQ/1SWcsD13NvhkqbHtDILy50ktrbJgfswUnKIR/Eway9xkc60o9/QEkUGxXM9iw2R4LbK2k9HvoJfU4ZWxUswOCM5aiITWPFchX4r2x/pApXkHZZwbSOhGZuhhwywS0Sxmokg0SS1+APYlqeLOFYP3rmktI1mp0uRm+5Hqq3WMrBOwiPLooMEVLrbCYU4Yb8P4WiUvk7oCPC1MmaUj0E2CFnl98VzvvIhNdpEBew8MXRvFJqseyuoSrlJYbtldt2AYJ+c4sEtDu8Mq214YIcTa79Evee2UdYqGcFeWJGxQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f046d2d4-4094-45bb-e191-08d6bc048168
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 09:28:06.1722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6384
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

case ESAI_HCKT_EXTAL and case ESAI_HCKR_EXTAL should be independent of
each other, so replace fall-through with break.

Fixes: 16bbeb2b43c3 ("ASoC: fsl_esai: Mark expected switch fall-through")

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_esai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index c7410bbfd2af..bad0dfed6b68 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -251,7 +251,7 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *=
dai, int clk_id,
 		break;
 	case ESAI_HCKT_EXTAL:
 		ecr |=3D ESAI_ECR_ETI;
-		/* fall through */
+		break;
 	case ESAI_HCKR_EXTAL:
 		ecr |=3D esai_priv->synchronous ? ESAI_ECR_ETI : ESAI_ECR_ERI;
 		break;
--=20
1.9.1

