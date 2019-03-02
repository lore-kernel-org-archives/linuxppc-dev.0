Return-Path: <SRS0=6H9d=RF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E551C43381
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 05:54:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77474206BA
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 05:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q+IP3hwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77474206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44BFpb41mqzDqTF
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 16:53:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.15.54; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="Q+IP3hwA"; 
 dkim-atps=neutral
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150054.outbound.protection.outlook.com [40.107.15.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44BFmq3ZB1zDqCF
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2019 16:52:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/YjXl4/l3aKbrP4KsNjvu5Xaul9Fa/j1nASwFieHJM=;
 b=Q+IP3hwAi2j/F09OEkfvGtWI/RKkDT8QdW7WE/SZ3NxI59ZftUrS+HtzCTQutznEgRyOtNu3Wx8PzcJFwc+fxUYPtuDpqmuNY9TfueaMCAnebDK+ZBiDAP+C9bVwWUCqiH1XMgejNC6eBYjGd9r6rP9kaL0zscsyi0BmQSWqSKU=
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) by
 VI1PR0402MB2814.eurprd04.prod.outlook.com (10.172.255.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Sat, 2 Mar 2019 05:52:19 +0000
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22]) by VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22%3]) with mapi id 15.20.1643.022; Sat, 2 Mar 2019
 05:52:19 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V3] ASoC: fsl_asrc: add constraint for the asrc of older
 version
Thread-Topic: [PATCH V3] ASoC: fsl_asrc: add constraint for the asrc of older
 version
Thread-Index: AQHU0LwYZBzCy+o+tE2/+t7z5LKboQ==
Date: Sat, 2 Mar 2019 05:52:19 +0000
Message-ID: <3fc3a2cbe15b67537be9e97beff0d97f619a063f.1551505839.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::21) To VI1PR0402MB3392.eurprd04.prod.outlook.com
 (2603:10a6:803:3::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 710e3c29-b4ff-46f9-13cc-08d69ed33b11
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB2814; 
x-ms-traffictypediagnostic: VI1PR0402MB2814:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR0402MB2814;
 23:wPB4iYeuqqdbcLLmv9BRZXol362kYSeCws6xq?=
 =?iso-8859-1?Q?28HN1PX4hE++3pMpv9EpEDzewPjpEx1lNrazxTyPrB+8n6H8c1Zabm8MNj?=
 =?iso-8859-1?Q?h6t2WFpP35TIXvF9fq177/g9beY66Y3g7KkBmr4NRlRZHswgz/0dN6Xn3D?=
 =?iso-8859-1?Q?o9UctJ90CJ8J3a/w312GRYUMGwlnO1AYg0ucrjiaDASv9VwnkmsTsuQokc?=
 =?iso-8859-1?Q?nrWOg0xfoYXs+9vPWxNhCtSQQVWjnfqWn5Vc6TLjL5Vu6NqYhIEGYvj5cY?=
 =?iso-8859-1?Q?aHEqE3qtDMUimG+zgrbbPTmMs1JTROduK0UK2ZrcXetCzu7tRXlI1prlgY?=
 =?iso-8859-1?Q?WygXe9UIIMfup3Qi+VpIdVTQfz36ToUbsDgXECRePahSzRXAui1JWEDtUE?=
 =?iso-8859-1?Q?DSDh+ICzqi4FSIm2ks96LNtJla2qscbiloLTzfnEQXLEzFwj4mmoklJSd+?=
 =?iso-8859-1?Q?D2aUgGePAKQBFRZl8WWJKF5AqG8zjE4Bvb3fWS9ouAVffjlm4/0QFNCXHd?=
 =?iso-8859-1?Q?erHdVQea3O5o5Q3s7r9BdYhzLWamFYXaqBqoPBiB4UG+9vrOqsp3SPFgBp?=
 =?iso-8859-1?Q?fZ7Yq7Hws+cUy3Lbxao6PBeP8C6N/UTdkayZOs1N5E3Wdv+9wmyN+Pz/cD?=
 =?iso-8859-1?Q?2SGkn5Moq3kLxcTbUXq8mgpmhpA0npch3o9e0se01+lQ17ReOxCHgyUtVe?=
 =?iso-8859-1?Q?7dNIk5ZQAKMrPPaICGNg1V7Ptug2X9Of4B9o+SLLyM8MVKVUVqEdleP/dQ?=
 =?iso-8859-1?Q?cPfMFMIBKumLBh5EllCoGgKnlgyRs68ZrYTCVYjePkCEWeIBVVAiQk5vKA?=
 =?iso-8859-1?Q?37gWF8X1UNEykce0o8KtQ0cBmlAH5faGOpajGYN2JgO+fkq9oe+3S659eh?=
 =?iso-8859-1?Q?9NrArFjl4MlgIxUC6m42/Fqvap3eZP7yrPR3bOhYUKedQeAHaLFxzmyhk4?=
 =?iso-8859-1?Q?W8KKJM5y3hJrrl2s+omfc3NUFHchS/uG1LlK2UReVTg/4SVA5oRUqdk+/9?=
 =?iso-8859-1?Q?xFNuGbN+nvh0ElTx3LaoNXVrUdIMWqR1zOoVBo79Ac3B2bfe9B5aEys9G0?=
 =?iso-8859-1?Q?fJXWBw7Ov+FPhEE9t437UsLSZlM/DFBVgydXXXXLsT/SBTj5HDqeDNutyU?=
 =?iso-8859-1?Q?ulsAp138JTE9kfGk+TDBgsjgxzf3d13mmT3WDJP5I9WVpjNgGZM/H0Y1re?=
 =?iso-8859-1?Q?0RDjtRcobTwDUxjycgVIed+ztdC+RImC1DQ=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB281423943BE3449DC1DAD11EE3770@VI1PR0402MB2814.eurprd04.prod.outlook.com>
x-forefront-prvs: 09645BAC66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(136003)(346002)(39860400002)(396003)(199004)(189003)(2501003)(71200400001)(4326008)(256004)(71190400001)(99286004)(2906002)(66066001)(5660300002)(52116002)(110136005)(2201001)(6116002)(86362001)(3846002)(97736004)(316002)(25786009)(478600001)(14454004)(50226002)(105586002)(81166006)(81156014)(8676002)(2616005)(6436002)(106356001)(476003)(26005)(6512007)(486006)(36756003)(186003)(53936002)(7736002)(102836004)(8936002)(386003)(6506007)(305945005)(68736007)(118296001)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2814;
 H:VI1PR0402MB3392.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XEC28yifdOb/rHQGiBUKM59StxL5/EBs4B+XGULpr7b5RjlAXYLX9HRjP8DKfg2VifalXe4gA0lymqb7eKJJlHV3n7SZyBO91a5EWxWr7977NdnooaAvNJzAZotQz8T1hAokZIw4CY7qwTk/d6xR2QHRWbdZPbyVoILFE803bc5lCg/cKmFF4tSruklf2gV1lCGjfsexeccsvMXstRmv82f+4VAuIVxRQJUFI34zq/DAfvv/Oe4BRYhWwIeYjT1rZJx8d9u3/XAC4Y2n/guruJ8ZyTiplJAL4exITFfr77PwFaK/UrsQyCps91snCYhMnHFcT8nYADJClEDyiMHRoxXiRkKqAw+ttpIXdwdclWodzd8YG05KYO2wn2cvGOsZHWsyh5+BKljRp6B5MhL3HCuOaPjwWx/J1K02wYXP/R4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 710e3c29-b4ff-46f9-13cc-08d69ed33b11
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2019 05:52:16.1449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2814
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

There is a constraint for the channel number setting on the
asrc of older version (e.g. imx35), the channel number should
be even, odd number isn't valid.

So add this constraint when the asrc of older version is used.

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
Changes in v3
- fix comments with Nicolin's review

 sound/soc/fsl/fsl_asrc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 528e8b108422..0b937924d2e4 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -445,6 +445,19 @@ struct dma_chan *fsl_asrc_get_dma_channel(struct fsl_a=
src_pair *pair, bool dir)
 }
 EXPORT_SYMBOL_GPL(fsl_asrc_get_dma_channel);
=20
+static int fsl_asrc_dai_startup(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct fsl_asrc *asrc_priv =3D snd_soc_dai_get_drvdata(dai);
+
+	/* Odd channel number is not valid for older ASRC (channel_bits=3D=3D3) *=
/
+	if (asrc_priv->channel_bits =3D=3D 3)
+		snd_pcm_hw_constraint_step(substream->runtime, 0,
+					   SNDRV_PCM_HW_PARAM_CHANNELS, 2);
+
+	return 0;
+}
+
 static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params *params,
 				  struct snd_soc_dai *dai)
@@ -539,6 +552,7 @@ static int fsl_asrc_dai_trigger(struct snd_pcm_substrea=
m *substream, int cmd,
 }
=20
 static const struct snd_soc_dai_ops fsl_asrc_dai_ops =3D {
+	.startup      =3D fsl_asrc_dai_startup,
 	.hw_params    =3D fsl_asrc_dai_hw_params,
 	.hw_free      =3D fsl_asrc_dai_hw_free,
 	.trigger      =3D fsl_asrc_dai_trigger,
--=20
1.9.1

