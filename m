Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A94C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 12:58:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E314920657
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 12:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CrFdmBqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E314920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gPJV0F6FzDqrW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 23:58:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.73; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="CrFdmBqL"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00073.outbound.protection.outlook.com [40.107.0.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gP374MlszDqjy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 23:46:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6JkFROnDAt8KpocB6EP5kOqZ8N+qo27ORI/FUinNl4=;
 b=CrFdmBqLrPRBmIPoQPatMzjsMFNp4YxzvND/JWp35nlRBdkdW3bQsMHBuLCwvImOpUoIFKAvoUstgTjrWdxRYd533dIVQlMqpEQLJH3ZoAthWLnnyCFk13kPsT2RCX1dwXufnHGTxJrhymEQQRwz2ixh8L+FQ2/nJRqWGTbc43w=
Received: from DB7PR04MB4699.eurprd04.prod.outlook.com (20.176.233.28) by
 DB7PR04MB4251.eurprd04.prod.outlook.com (52.135.131.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Thu, 17 Jan 2019 12:46:32 +0000
Received: from DB7PR04MB4699.eurprd04.prod.outlook.com
 ([fe80::f1a0:618e:40fc:a88c]) by DB7PR04MB4699.eurprd04.prod.outlook.com
 ([fe80::f1a0:618e:40fc:a88c%2]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 12:46:32 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi
 <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li
 <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Viorel Suman
 <viorel.suman@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta
 <daniel.baluta@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH v3 4/4] ASoC: add imx-audmix DT binding documentation
Thread-Topic: [PATCH v3 4/4] ASoC: add imx-audmix DT binding documentation
Thread-Index: AQHUrmKsWgF/5daV40+8FM0YbnyFjQ==
Date: Thu, 17 Jan 2019 12:46:32 +0000
Message-ID: <1547729177-14317-5-git-send-email-viorel.suman@nxp.com>
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
 6:HflPDH8jquQE+JKE0gQLyGgtl1CzSbs5M1xyYYhcwtAUOHY32Zc9vfggaC6PZUI1libWmsVEcvPc+jy7HvSyvbAppgYst2jGWdZHgeIt8f6ESdM5TQCYiaWbEgTkm8VhH5DIwbNm8TWwDcPv/5WEUd46KI7arczbNk/m+xH8+SVslPcR7mk2Ydo29VR77g8M32hQ58LaALjJOjdX0gxWXMuh5pwgDPF8ky7oOsb+BDIGw4qTr5mOMBrZbuCVkN0ElPTKCuScai7FZWXV3KmYXGQ1JzakEidHqmpYVVohu5lf95beEkr4aioeJCQd3mUZ6BbBrkKLvxf1RxALXsm12l+YLK+nqNQ62fiexqvlHimZ927BLMrkUQPiGNUKMCH0PLPsHFPc1aFm5e/zQ4+mD4bQdPPk9HlNdhnffDeANv3frPR8eHUOebaJ+2rUykGa2h2ggWi+s3pELqXUFVSlXQ==;
 5:6TeT2XPgPE0kWzGXGKFYNJBKjoOI8XhA9KbWJZROiDxX+GGuBaMF8d6ryuZKPpstnqqViEgWM3IRTKQpADlnzquCCb8qGNn5bBcP9X+ZxDYI+VA7BAev4EjVjPDMofame8enO0Tud1YkBb3bREJlp6FqGKTON7cogErt/9cRmtB4D4r0bBiRi53kGFI3T7hCtJyV4eBNhNdOJyy+9UECJQ==;
 7:cTj55x0HYgAS4/M7Z1sXo8YK1oPpXD8cNEqfsZu/B9eKCbeV5KxGnNTCPpWz1mu3u02k8ZYUjduSzujahH4dMMCKJacxCKoTgzc6dcPKmAn2YQ+Vs7kJf3tbXWNBLEX7AIl99cZwvtILyORJ3EooQQ==
x-ms-office365-filtering-correlation-id: fb3f18d5-73be-45a7-1235-08d67c79cf05
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB7PR04MB4251; 
x-ms-traffictypediagnostic: DB7PR04MB4251:
x-microsoft-antispam-prvs: <DB7PR04MB42511A4CEBD304E0B17EDC3492830@DB7PR04MB4251.eurprd04.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(366004)(189003)(199004)(305945005)(76176011)(6116002)(3846002)(14454004)(6512007)(6436002)(6486002)(7736002)(71200400001)(52116002)(6636002)(6506007)(386003)(86362001)(316002)(478600001)(71190400001)(54906003)(110136005)(106356001)(97736004)(105586002)(446003)(53936002)(66066001)(476003)(2906002)(4326008)(486006)(11346002)(256004)(99286004)(81166006)(39060400002)(8676002)(2616005)(186003)(102836004)(26005)(44832011)(25786009)(5660300001)(7416002)(81156014)(8936002)(50226002)(68736007)(36756003)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR04MB4251;
 H:DB7PR04MB4699.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qpNHmKi/90qxaLf+z+POJct5hRcYfsR7TW1avHZ0p7fGQe6p+16FySRQBEymFTod81dctoNj7QiiXrf3yqhR1u/Ku3RzyKFSIrJJy/spmBPPyDaAYiieiL+k2GdOAiS9a4zIp3b6Sqfk0E1Vke9kJ4E0ys/Y2auJt1AlssAAher94rk9dzO/syQBdycCFFKoRG3yvYUykM96tXhmWCTVX9oJxty6gCbTLPoG14fRBg02zMUMJJ6AOUwwM5Tc0DWW1tBiQ4zRzVOVBEJOP3NwAzz1U1ZAoCfTYlkQJmPGNin8oK0wbcT0BmZQh9L0Rl1GLMEtf4Pk1j2787n/bZYXBJdUwiDP+zH5sHUHcb5nb45WQsFQ+NMFxhjiViawLLm1tW6k89vX6gK2pC7ow85/SiOZoYVT2kwkkor8tUIumTI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3f18d5-73be-45a7-1235-08d67c79cf05
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 12:46:30.9669 (UTC)
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

Add the DT binding documentation for Audio Mixer
machine driver.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 Documentation/devicetree/bindings/sound/imx-audmix.txt | 18 ++++++++++++++=
++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audmix.txt

diff --git a/Documentation/devicetree/bindings/sound/imx-audmix.txt b/Docum=
entation/devicetree/bindings/sound/imx-audmix.txt
new file mode 100644
index 0000000..c840ed5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/imx-audmix.txt
@@ -0,0 +1,18 @@
+NXP Audio Mixer (AUDMIX) machine driver.
+
+Required properties:
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+  - compatible		: Compatible list, contains "fsl,imx-audmix"
+
+  - model		: Short audio card description.
+
+  - audmix-controller	: Must contain the phandle to the AUDMIX device node=
.
+
+Machine driver configuration example:
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+  sound-audmix-sai {
+    compatible =3D "fsl,imx-audmix";
+    model =3D "audmix-sai";
+    audmix-controller =3D <&audmix>;
+  };
+
--=20
2.7.4

