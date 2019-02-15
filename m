Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11649C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 14:08:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845DB218FF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 14:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r45QHYis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845DB218FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 441FTq44VWzDq8t
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Feb 2019 01:08:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.15.41; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="r45QHYis"; 
 dkim-atps=neutral
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150041.outbound.protection.outlook.com [40.107.15.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 441FLM2kKszDqWM
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2019 01:01:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qk+AlMAVnT7ouR0z4mpntwF5/tiwM20UJqR2L/G7W0=;
 b=r45QHYisjDO+EvUxepJkrHJ0HxtEWYc2jL31s/HT2C9LsnJOKR2O036f9UM36rMYAEjgW6clSAF9OrfXrwnmAjPMgVc/IRjqxasclP6b19O0NmpfBkNqgUKdgcZhYRBHSyhmjqSVghXLkiYuX6nRIGlWk0kW9A2JWIDieYmqIa8=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB1614.eurprd04.prod.outlook.com (10.164.84.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Fri, 15 Feb 2019 14:01:36 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::6cc1:d14c:a535:87ce]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::6cc1:d14c:a535:87ce%5]) with mapi id 15.20.1622.018; Fri, 15 Feb 2019
 14:01:36 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi
 <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li
 <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Viorel Suman
 <viorel.suman@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta
 <daniel.baluta@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH v5 2/3] ASoC: add fsl_audmix DT binding documentation
Thread-Topic: [PATCH v5 2/3] ASoC: add fsl_audmix DT binding documentation
Thread-Index: AQHUxTb29jU2YVCmtUqPKCgK+dTP8w==
Date: Fri, 15 Feb 2019 14:01:36 +0000
Message-ID: <1550239285-12587-3-git-send-email-viorel.suman@nxp.com>
References: <1550239285-12587-1-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1550239285-12587-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P191CA0059.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:7f::36) To VI1PR04MB4704.eurprd04.prod.outlook.com
 (2603:10a6:803:52::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c8806c3-83e8-46e3-26d5-08d6934e1939
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB1614; 
x-ms-traffictypediagnostic: VI1PR04MB1614:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB1614;
 23:o6UKgjPAXGFPeoYvbgD4rwaaIirZzznm0N/ZbrX?=
 =?iso-8859-1?Q?10rrgjEz5F4iinaALn4jYPefRGVbk/c/4FVvE6PetsRlaUAvu9Mod9cN2x?=
 =?iso-8859-1?Q?hKyPNgfqb39SthYPrPSclAg1FPhizLlrNYSo+ZDQmLZ3myNK2lYyW/3HD0?=
 =?iso-8859-1?Q?WNHXyEUA21/S2jZWSagiNttx4f12vTN9sYmOaDGrM392utzRHA/a0UaKJZ?=
 =?iso-8859-1?Q?IhEyWPOI9IvydolnfsyvX/NeoX/Ptp2prxOvmzZnUmpVBuHPm/lUdTs/kw?=
 =?iso-8859-1?Q?OvoDZ7wjlbuLRV+jn4kfug7pOlq1Jmz7NP9k7djVufzmNVZURd8sXF81Ei?=
 =?iso-8859-1?Q?FvSljeaFlcuOoRnkaqXwNaCuaVggNRnPFCF6LeUyRpHqvNSYYro46lKBaK?=
 =?iso-8859-1?Q?hqYT3LF55M+CqvXraAz7H+L7jDy/vAUCk5+irm5lUzHIXYZfwDAPocErIM?=
 =?iso-8859-1?Q?vsNzjAaxQTGWVXUQuEhyN3boBpqkrmjoOibtvoVaQHV74NeHG06bhyZwcQ?=
 =?iso-8859-1?Q?5a0c63ovDiVdmSy7hfQE0KMh7ik0Az7X0guyuL3mVG45VKz185VOKUQ0nV?=
 =?iso-8859-1?Q?uW14d/9hWVLEIpouh0L5uuL8l0w2E8l2pafIT/dOLCkkQPGO4s0HyODv9X?=
 =?iso-8859-1?Q?3vIKjrshiid9sewyqx9mEFmWebj9kWO17+lyV4De2U+vHvUG9r9nqD1KvC?=
 =?iso-8859-1?Q?AT7hlDXMg5/NZnkrxaFGavKRIuQFIcrOB9uC5dMPU/ADVIyhUWx46J7Pq2?=
 =?iso-8859-1?Q?CjGXS2MZzRQUEbXdTDqneL3Z7mKp6rBN7Rp169CYGMk9h9TsN6CDguFSP8?=
 =?iso-8859-1?Q?iUl9Ofcl6aIP9vp495d7PqoKEfN+SpbfOxhPCntK8Rg0Z5KV9YRsvxDm1V?=
 =?iso-8859-1?Q?pFbq9Oz0sOG+ads2lxLJaOQEHYTpTrj8njmiHDqFeou+VLWrUrEsoDfPmY?=
 =?iso-8859-1?Q?PnqdiuYDYqJ0at/P5ctGvvfTSb21u3YiCjiYh39G0aX9N2GVy2yj6GT+zG?=
 =?iso-8859-1?Q?yJUmwmQzJedRpYrbkTQEg2a+Xad00fG872/RoUUNh4wD1nlay0XfG+Owcw?=
 =?iso-8859-1?Q?n5Mk5AhSDCnVprFepUPXNLSCXqSwlYVUs3kCZEI2tLT5kw2Dgq6FfG1ypm?=
 =?iso-8859-1?Q?I9/0wuNTLo6FksIQNOjiAi+vo7nlAAI8TddZU94ugNeIrxO02T5FzxAsRI?=
 =?iso-8859-1?Q?dm+i5cl77y7/fjlhv9CHoCIjXUSwUanXwdOKTcifmmKW9cS5b5K260nIN4?=
 =?iso-8859-1?Q?Nh51ThAn443MFZzclgNTQ5XQS88xKlimMZYPtfYipKTw6zxfa6miEyMffD?=
 =?iso-8859-1?Q?+qo6DwJiQ9SBycWHXzgvz34?=
x-microsoft-antispam-prvs: <VI1PR04MB1614F541CB89D96F9E720C7492600@VI1PR04MB1614.eurprd04.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(366004)(136003)(39860400002)(346002)(396003)(199004)(189003)(50226002)(486006)(14444005)(54906003)(76176011)(52116002)(99286004)(256004)(86362001)(11346002)(97736004)(446003)(478600001)(71200400001)(6486002)(71190400001)(2906002)(6636002)(25786009)(66066001)(110136005)(36756003)(6436002)(6116002)(26005)(4326008)(305945005)(8676002)(7736002)(8936002)(81166006)(81156014)(44832011)(476003)(386003)(6512007)(2616005)(106356001)(6506007)(105586002)(14454004)(186003)(3846002)(53936002)(7416002)(316002)(102836004)(68736007)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB1614;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CogIXBkXhTevRcQZLeYGoO77UrMl3oynSO1gDlZWwJpFmDpR2LARwT32PQEu8vrd+wm6bw+tE3R7OWRS/YjC60YpjF/F/qW7J1/v7OSnEvY+TlpJad0qm3McPHSotvA2niWQXRvLmwgnL+uYMX8FJLreT/UNdkyy3IkkhXgjn/p2oX4/5rNZUOuLNsVF7MC18B6FvuvutCO14WGhX6duipYpeptzTkB0Cqe6TEHCFJT1/lzFIwCZ8fWvDga+pVxuuJ58unPZNqIIkYOyni3pk1Gwl6HTbrJFLsSpipyHlLABMszA7zfz9C2eUG5nJm4NPcPXyoPBVFwN5p3SRB56kbmS1Vq6vDEetDg6tAwi+8m099fmtZqgrOm6y3BgjXi3E02V1AcawNaxiwor7VgsqXhwthXFvKzTjfjmT1ezV10=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8806c3-83e8-46e3-26d5-08d6934e1939
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 14:01:34.6102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1614
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
 .../devicetree/bindings/sound/fsl,audmix.txt       | 50 ++++++++++++++++++=
++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt

diff --git a/Documentation/devicetree/bindings/sound/fsl,audmix.txt b/Docum=
entation/devicetree/bindings/sound/fsl,audmix.txt
new file mode 100644
index 0000000..840b7e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,audmix.txt
@@ -0,0 +1,50 @@
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
+  - dais		: Must contain a list of phandles to AUDMIX connected
+			  DAIs. The current implementation requires two phandles
+			  to SAI interfaces to be provided, the first SAI in the
+			  list being used to route the AUDMIX output.
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
+    dais =3D <&sai4>, <&sai5>;
+  };
--=20
2.7.4

