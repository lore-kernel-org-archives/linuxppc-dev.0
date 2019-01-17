Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE38C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 12:52:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48EA820851
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 12:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="APzyCZT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EA820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gP9W1mTdzDqpH
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 23:52:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.73; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="APzyCZT0"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00073.outbound.protection.outlook.com [40.107.0.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gP345d79zDqfN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 23:46:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qk+AlMAVnT7ouR0z4mpntwF5/tiwM20UJqR2L/G7W0=;
 b=APzyCZT0Q2MhamVM4u8ikQOBFtsEn7pAt6mn71BZ4nrCXxyzCZKfVyR3Zpu+xqmmrGFz8i8RALzSlPUaIk9iBnrwrtx9ENuEjAS9RR5IxrMwq0nbUG532IVTfk/id/CTkmjdrZ8F1gATzsm77uW6BvSJtykLuDrL6xA2Xtlgrmo=
Received: from DB7PR04MB4699.eurprd04.prod.outlook.com (20.176.233.28) by
 DB7PR04MB4251.eurprd04.prod.outlook.com (52.135.131.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Thu, 17 Jan 2019 12:46:29 +0000
Received: from DB7PR04MB4699.eurprd04.prod.outlook.com
 ([fe80::f1a0:618e:40fc:a88c]) by DB7PR04MB4699.eurprd04.prod.outlook.com
 ([fe80::f1a0:618e:40fc:a88c%2]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 12:46:29 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi
 <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li
 <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Viorel Suman
 <viorel.suman@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta
 <daniel.baluta@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH v3 2/4] ASoC: add fsl_audmix DT binding documentation
Thread-Topic: [PATCH v3 2/4] ASoC: add fsl_audmix DT binding documentation
Thread-Index: AQHUrmKqT8wDihQUGEKdena01cgo8g==
Date: Thu, 17 Jan 2019 12:46:29 +0000
Message-ID: <1547729177-14317-3-git-send-email-viorel.suman@nxp.com>
References: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR05CA0036.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::49) To DB7PR04MB4699.eurprd04.prod.outlook.com
 (2603:10a6:10:14::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB7PR04MB4251;
 6:OUx0AlIg1aiPSFBSbCSba/r8P21ZXPOZxgM7qjcbwcZbHIhnaQU2xeFZq0weyEIkk814bok0KMDUwLWtRt5uPgYdC4/xWpgdqrr8Qgchj2uFdqxwf9ZbmcAdk09CQp76Vd+gog0RolfEJtnwKc33IxRchJyQk7ElfGut51NnkdF/ovqZNnlFZmF1DLz4CvFJrng+lY3Ib+iNKgegeeQQ2N9GX43awXw1CQbemeH/Dq58jer7maIGPt4r4rQSgEzmBiPW/bNPm5mRQJks5aGL7+MSJUkY+Yf2UaZvtUE4DA//nxe2HFbRtZjD8MmLJ23xTz6gQqvhfxKCZG8S9yrxdSZiG6Lq/x5rt82exIlQhEPs7BVvWFAp+9qTY9KJVmNG9Uwhmn68jnDKJrdj0KwxjBsVWgirE2XBjKjXkkspI6rpDql89it1hsElsiAhqNFHDNrERFUUk6xx1dMIl/xGkw==;
 5:Rp7Lp/CV7ASXyrAylG+OCTG2dURas2ujFrNe+kMgt9qL8Wx04NnB5kUsg3RDonDJ/OAQhhqwRzvPuOBBei7XlbVqa2J4aCQQ8vkosfhNSqJAYXyw2jrhtrQ5vRssx2hf4pVL/s2Xa/dTo1EP4hN9DSbvNNwkH18OD1sIo1JOsK1pioQz64ilLv0WNS0+V/doAXAxQ7oEyCeoBtaB0mXEmg==;
 7:SmiX6EICS/H8mPlZOUFKCzP1FFLAL7OGTnAIG/UsutdvEiZM7d6S+uIeacyn/P1gJUgWfh/Y3OnMlGzkmPiNx2QgZ9GcKnHkIXWgJWCaiqjgNiE674olFFt2qyhEC3SvA8liKCJT/O8YO6e/PE3Jxw==
x-ms-office365-filtering-correlation-id: ebe7abd8-47f3-447e-8c99-08d67c79ccf8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB7PR04MB4251; 
x-ms-traffictypediagnostic: DB7PR04MB4251:
x-microsoft-antispam-prvs: <DB7PR04MB4251A686CC73FA07F3F89DCA92830@DB7PR04MB4251.eurprd04.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(366004)(189003)(199004)(305945005)(76176011)(6116002)(3846002)(14454004)(6512007)(6436002)(6486002)(7736002)(71200400001)(52116002)(6636002)(6506007)(386003)(86362001)(316002)(478600001)(71190400001)(54906003)(110136005)(106356001)(97736004)(105586002)(446003)(53936002)(66066001)(476003)(2906002)(4326008)(486006)(11346002)(14444005)(256004)(99286004)(81166006)(39060400002)(8676002)(2616005)(186003)(102836004)(26005)(44832011)(25786009)(5660300001)(7416002)(81156014)(8936002)(50226002)(68736007)(36756003)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR04MB4251;
 H:DB7PR04MB4699.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eiu/NeVR6zzGaVLuUJ8+EipeyhtfwUt68YalsrE40C6PbTcpvy5W1TUDbmXfbN61IlnesAqJ9r7V2nGBsEy1LknsouWPDzFO9rDySGuOwgL/yFnn1HIq4r1pSEiC7iYfK/jDMq1C9ZsDA0kYbOv0Pa4sPWxMhFoxrk0m20DpeAt0kuPCJVn8vRE5jVnqCIgc8Vdw832WAJUXRKQwDZDKcEO36HEbZUbAy45qBhSWqrYApgtYr7dOBuRISq7BnBmeeupjoUMaO4f5EjHaTYxlKpvaInm17s0w5mGRHj/SWybtux233vRJr+abdvdjc8pPVPejSE07DFrUjjJLwBUmPfa3FB92QiXlDlxV1p6YvsJQw8T/gt5Hz8KkkfsUIx/fv0NAzKKsVHMVvZitYAABQjjBzvrC8+gEM5E+19dY3wg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe7abd8-47f3-447e-8c99-08d67c79ccf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 12:46:27.5763 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4251
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

