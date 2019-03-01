Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E630C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 08:38:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D2F2085A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 08:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oerUJO/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D2F2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449jWD4VPkzDqS0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 19:38:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.15.49; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="oerUJO/Q"; 
 dkim-atps=neutral
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150049.outbound.protection.outlook.com [40.107.15.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449jTV2NwczDqCZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 19:37:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttRDiH7lCn113OfRg+xZYlT7cWOOfAT79L5q/UP7RzM=;
 b=oerUJO/QmwzXL7NugLO+JzwCM9zAB+9cZ+7oMt53HsRr6ksC1SOIUg28AXst986l1TCQcl/bOob9P4OqISaLNtecinF7Wt7RAKOov86VPyo3TP7IY+G1RR922bWXVIqlZONern6gFqj6w+KxhWGUThhBdg5EmY3mesACqZHG1N0=
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) by
 VI1PR0402MB2783.eurprd04.prod.outlook.com (10.172.255.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Fri, 1 Mar 2019 08:37:09 +0000
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22]) by VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22%3]) with mapi id 15.20.1643.022; Fri, 1 Mar 2019
 08:37:09 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V2] ASoC: fsl_asrc: add constraint for the asrc of older
 version
Thread-Topic: [PATCH V2] ASoC: fsl_asrc: add constraint for the asrc of older
 version
Thread-Index: AQHU0An1hGn59KuT1UaLuZVdqt/UKw==
Date: Fri, 1 Mar 2019 08:37:08 +0000
Message-ID: <24ebf5b610cc69f18c05e4aefa1874ae23861943.1551429264.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:202:2e::28) To VI1PR0402MB3392.eurprd04.prod.outlook.com
 (2603:10a6:803:3::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b3bcda1-1ed8-4354-b44c-08d69e211784
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB2783; 
x-ms-traffictypediagnostic: VI1PR0402MB2783:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR0402MB2783;
 23:UnDq+hllvK2YYgRRjAt1cdUoMBWN7hDXSdYa/?=
 =?iso-8859-1?Q?lTc5rUY7N1JOHXVILF93c08H7MTxcl+NlocEH8zffXRsi0LMjs3qgk33Mx?=
 =?iso-8859-1?Q?h1MVqWIDRB2gjxloqf2j+LdeHpuTV8tgEIvjMTiMbTkbE0PXZVUaPUWejr?=
 =?iso-8859-1?Q?NymfagqGUgqtVeM9+4i+8ynxQ/LwqMBSBXyze7Z+PwiLBzfrF8p806JN0u?=
 =?iso-8859-1?Q?n2N2zlp4IAdhnZ2NXbKumxikghjwSVrw30EdTyraRd/p84hHKqImfQYCIY?=
 =?iso-8859-1?Q?9ngcsiyQpqmCX0TziXKy1yQeAqlcZVfb01iDnE08Qh+XDTG/3Rf+bNo3DB?=
 =?iso-8859-1?Q?OvHPWlhkAOk85oKVZrjjPlyi/Er3lgp6PPqFN+ouHWMLNPcktJsBH9vsi1?=
 =?iso-8859-1?Q?E2PVJNb7SKhG4bhsTkwDiG5JCp6TYqxzIieT9lKuWHfhAy+yJpHQqxUqJk?=
 =?iso-8859-1?Q?V70ZidgdcMvw5MmaB5mKjD7zPKxIWAJAoyR1TY1UQUEjQx2axmXOGB2bQN?=
 =?iso-8859-1?Q?seRr7ORcH3lA1Zk+0tE0zh53j16RdXzzEc0R/mSskw4pJfb3PaYRKZIEjS?=
 =?iso-8859-1?Q?8FqlQ+I3B+J3YJwW4eoPdH/ErEvIwHSOkFybAHUp3mLU2MgrONMEswNdSy?=
 =?iso-8859-1?Q?HjzAiIPjEr5TWkEkY6A+1UjEoPdLemJLSc6viZyFNtmr7JzqKrHUXHSdIG?=
 =?iso-8859-1?Q?0XCkALr5SgQh9FaIkIppM1X9/QAM2NP1mj+/tIey5vRDLfUbiP/ccJrZvB?=
 =?iso-8859-1?Q?JozEGvXbqHd4j4ozA29RFmH5ndEWukd+bqY/TFHZeP3cp6g2EVgOCItvGO?=
 =?iso-8859-1?Q?Jp6U3AmO+KZ3fwINDDVjiknfIAmakCPfJ9XVe15NrxCIlSUWgLoO0RKj6Q?=
 =?iso-8859-1?Q?u1Q5OTZb/4WFxIxhciLoNCfxNXOHxz2UxN8tugC80dGZTHGeUt5xKlsyFF?=
 =?iso-8859-1?Q?A0/ndA/ufYyuSFRMPVbOMn5bCzAJ+FhCqVnM7IvYtFE2iBmmCEPngrSahh?=
 =?iso-8859-1?Q?FeTdT4a6BJYKso4GhRUt/DFWhQXkoohCS4LrS+igrNnSTMJG4g1ecCapkV?=
 =?iso-8859-1?Q?T6TLXh8rw0fnWCASuyjL5gQCkgGaLad4FqFfdls0/UO/aFf7SxC4kX/OYh?=
 =?iso-8859-1?Q?icnjAGKQDb/22+UcJaHaFOCFNSY548XPSUDTqhazgci5Ex76hVS4ru07xC?=
 =?iso-8859-1?Q?9hY3ZKycAvyV2Td/3mYba/EBcF4Zp+sEAyQ=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB2783CD3225028B082D6EE53BE3760@VI1PR0402MB2783.eurprd04.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(136003)(346002)(396003)(39860400002)(199004)(189003)(486006)(2201001)(71190400001)(2616005)(110136005)(186003)(14454004)(316002)(99286004)(71200400001)(26005)(118296001)(2501003)(66066001)(476003)(256004)(2906002)(6116002)(3846002)(36756003)(8676002)(6512007)(8936002)(53936002)(97736004)(4326008)(81166006)(6436002)(6486002)(6506007)(478600001)(52116002)(25786009)(106356001)(305945005)(68736007)(105586002)(386003)(5660300002)(7736002)(102836004)(86362001)(81156014)(50226002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2783;
 H:VI1PR0402MB3392.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rxyeZryGs15imrvRAcZQo5JvYRsgOa9Sb2/bs6Ri3glbouTuWzVWtEwlZUzYItToi0AyxSzYrMYBBnYJgDsZB0cNJsFoWegO3agh+K7B+K1IJw4OPZ3zyUuGx/7S6me6yXtK1aZAsdn690B3NFaqm4fw9RxXJqwiXORZX4DLVw+Jjg1szIS8EUuNdzTIAKuNs6lt0t5oPt3q9SdrLI8oTkms1/VDnH+P90vJkiTVOEHzvRF+28spT0beNrbYX8uEuVfUexNPCsh9KyZD0AIh5qZJe/i56zHU1bSJ5wlvGbA3eLBR5K+WIP8pP8IXc0915PR2SMSkmN7W71ead4z2OyxGTqxVLC6GZceXgH6ri++UpIQx5m+O+ZNbBslHtrv2L66apkNaqz7pImJngsFCctRP5d4n59lhEMwVCEQymUQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3bcda1-1ed8-4354-b44c-08d69e211784
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 08:37:06.0998 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2783
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

There is constraint for the channel number setting on the
asrc of older version (e.g. imx35), the channel number should
be even, odd number isn't valid.

So add this constraint when the asrc of older version is used.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2
- switch to add constraint in startup function

 sound/soc/fsl/fsl_asrc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 528e8b108422..31494f225037 100644
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
+	/* channel_bits =3D 3 means older version on imx35*/
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

