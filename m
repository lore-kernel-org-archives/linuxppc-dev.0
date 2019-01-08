Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0B4C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 13:14:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AA59206B6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 13:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZdDMmgHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA59206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Yt562f3FzDqVp
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 00:14:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.15.81; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="ZdDMmgHP"; 
 dkim-atps=neutral
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150081.outbound.protection.outlook.com [40.107.15.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YsvS2xMjzDqSc
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 00:05:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LY/7GEdtnAVCIIT486UVguCUWycd6qUefZEAhkZfC8=;
 b=ZdDMmgHPJj1xZjLkfUX2WI641YSYH8PODmMNdNuRChu5PfwgCwsLWp4w2oGab39cPu6p9KObYTk/ZUOVGCcZyBZ3WHrxtpFlj2CTVE0BERBdA3rSAKIYJ6PGXX7mqWopYYDRCH4IXNBjLx42n918+VBtk1KcYkpQeWEkJmya0wM=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB6240.eurprd04.prod.outlook.com (20.179.24.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Tue, 8 Jan 2019 13:05:47 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::ad47:75b9:3ed8:51f0]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::ad47:75b9:3ed8:51f0%6]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 13:05:47 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi
 <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li
 <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Viorel Suman
 <viorel.suman@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta
 <daniel.baluta@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH v2 2/4] ASoC: add fsl_audmix DT binding documentation
Thread-Topic: [PATCH v2 2/4] ASoC: add fsl_audmix DT binding documentation
Thread-Index: AQHUp1Lfou9hDnrJVEmiFPuEBZavog==
Date: Tue, 8 Jan 2019 13:05:47 +0000
Message-ID: <1546952716-2743-3-git-send-email-viorel.suman@nxp.com>
References: <1546952716-2743-1-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1546952716-2743-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P192CA0107.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::48) To VI1PR04MB4704.eurprd04.prod.outlook.com
 (2603:10a6:803:52::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB6240;
 6:nF86mRWY0MHNlBt5B4h9cxBKOhJZaKL6o17/mZAEq8blUvUQcpq8iUgeFN/ItdbLox55nBcAX0D96aYwmBU5K/Htqqw6Cbw4GDJ1DJFeaN2xqnGmeKzdwo7bmmopCbpO4tVWTRzJDejxrw8rHQWBYt9hWdRiTBysifD05k0BwV3Ta1XatiTrTSt5zlOKHsLAknT60DJyF2a+rNmAAQXsIkqHTwahriHtEOj00Bnh2csCI+kbexLIUuUV9KFjmMVPtuJu9f8V3n23AVdjqJS5SdVNjjBQZs0dXz2zvWLJoyOCyEcotjkXexkMVEGGftcyswa7pAxxJFt8ehlUIMXV2to/NwKURtGem+im3nUecZld3HF6thXgUY2PhCg1iOMMAdtg/L4kN2zNAgrkTtm/rEMwZhuRfRx+BQkUH9nCirtd+iChUIe5AK0sR1BuKUT2X0d26DtBGz7rY3GkZkr7vQ==;
 5:86aj8o84QS1cTiXjZB0KxB3FKkN7gVI0xZUDIfEI02riBuSpq4NXxJZGZUqQ+kaCMQhKNWulximGNweC0z4lUNCdiBxLj+JdCRmAv9x5sTi/s5HyMbOznGRyo48wAsI//fjUQ2Cu8jjmSlFuXemUhi8HQTQC0gKdnxkXHVw7YwOCD9Gwl+ixuW00s6cIckNnC8jY14CgX/csWY2DdO/KvQ==;
 7:8fTIBYXQEuufId/BeSP7Vi+4Yk4BTjL/o+fEO0sbgLn9ECtC/oz7wmm+cllNl7lyWFBVKzaR8BLLiisu+GlfkBS0aSkgGdQdN3gack7H+eNHKnhE7QbuICDXqEj9DKtptVn9X7Zsc2+EFuU1iLpEjA==
x-ms-office365-filtering-correlation-id: 64ce6f9a-e3b5-41fc-d041-08d6756a0175
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB6240; 
x-ms-traffictypediagnostic: VI1PR04MB6240:
x-microsoft-antispam-prvs: <VI1PR04MB6240F73ED6D4562365C168D2928A0@VI1PR04MB6240.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB6240; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB6240; 
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(189003)(2906002)(7736002)(106356001)(39060400002)(256004)(14444005)(305945005)(81166006)(4326008)(6486002)(6636002)(25786009)(6436002)(105586002)(8676002)(36756003)(71200400001)(71190400001)(99286004)(486006)(54906003)(110136005)(316002)(81156014)(44832011)(66066001)(5660300001)(478600001)(68736007)(6512007)(2616005)(476003)(50226002)(11346002)(446003)(53936002)(386003)(6506007)(97736004)(52116002)(102836004)(14454004)(86362001)(76176011)(6116002)(8936002)(26005)(7416002)(3846002)(186003)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB6240;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BueOtRfiqY7dtb7AIW7sMHUOvcp1rzCuIRVziKSAUex3QfIi3/vcU32E8adc6SG5qtGVhZGidoa9MLmVKZzWXc49t73MkpP7X78QP8x0qiRR+LE9zVymc1yz9Wako9JhQs+oPrar0jKc+bK18LO2YG1l1UkYTCvn7nhA7r1NwxwD4tZj+ec8QMOb0p576hM+ZvxhfQT6TlbSheFCgb7AERpBT/iK+uxWtcQBYGqxI7LiXV1GStZbZrU2sFmqvdg80lu2nRDtmUCc/ejcDUzzE9UoOGAhollYyBhiL7lmzcyiOEI0hl3B43NTAEEtbhdz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ce6f9a-e3b5-41fc-d041-08d6756a0175
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 13:05:45.7345 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6240
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Viorel Suman <viorel.suman@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add the DT binding documentation for NXP Audio Mixer
CPU DAI driver.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../devicetree/bindings/sound/fsl,audmix.txt       | 44 ++++++++++++++++++=
++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt

diff --git a/Documentation/devicetree/bindings/sound/fsl,audmix.txt b/Docum=
entation/devicetree/bindings/sound/fsl,audmix.txt
new file mode 100644
index 0000000..512d39b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,audmix.txt
@@ -0,0 +1,44 @@
+NXP Audio Mixer (AUDMIX).
+
+The Audio Mixer is a on-chip functional module that allows mixing of two
+audio streams into a single audio stream. Audio Mixer has two input serial
+audio interfaces. These are driven by two Synchronous Audio interface
+modules (SAI). Each input serial interface carries 8 audio channels in its
+frame in TDM manner. Mixer mixes audio samples of corresponding channels
+from two interfaces into a single sample. Before mixing, audio samples of
+two inputs can be attenuated based on configuration. The output of the
+Audio Mixer is also a serial audio interface. Like input interfaces it has
+the same TDM frame format. This output is used to drive the serial DAC TDM
+interface of audio codec and also sent to the external pins along with the
+receive path of normal audio SAI module for readback by the CPU.
+
+The output of Audio Mixer can be selected from any of the three streams
+ - serial audio input 1
+ - serial audio input 2
+ - mixed audio
+
+Mixing operation is independent of audio sample rate but the two audio
+input streams must have same audio sample rate with same number of channel=
s
+in TDM frame to be eligible for mixing.
+
+Device driver required properties:
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+  - compatible		: Compatible list, contains "fsl,imx8qm-audmix"
+
+  - reg			: Offset and length of the register set for the device.
+
+  - clocks		: Must contain an entry for each entry in clock-names.
+
+  - clock-names		: Must include the "ipg" for register access.
+
+  - power-domains	: Must contain the phandle to AUDMIX power domain node
+
+Device driver configuration example:
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+  audmix: audmix@59840000 {
+    compatible =3D "fsl,imx8qm-audmix";
+    reg =3D <0x0 0x59840000 0x0 0x10000>;
+    clocks =3D <&clk IMX8QXP_AUD_AUDMIX_IPG>;
+    clock-names =3D "ipg";
+    power-domains =3D <&pd_audmix>;
+  };
--=20
2.7.4

