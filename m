Return-Path: <SRS0=/GF9=P6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98744C282C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 11:18:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13EEF2084A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 11:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q2SUQq3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13EEF2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kQrx1MzNzDq7n
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 22:18:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.84; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="Q2SUQq3P"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00084.outbound.protection.outlook.com [40.107.0.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kQmX4fTYzDqLs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 22:14:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZM7TxwbN9tPA2MfIEsf6GQiSUPbu2CtiZ2uIJ4YQ74E=;
 b=Q2SUQq3P6JK1E1EhEUnGXioZC8gD1XvfCaXCDmUlXTKw6wBBMlrL44Wv1ELKoq5HvAwy6qtdT9yu+3Z0D8VEiqAr0Bkh9Jhjq9IlvEgqFqcqMrfDVG93nz9wr+lDSU+JqXpOmejov7DbSQ+R9hlZEA4L2XFs+4e1bSwVIJ81F3A=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB5422.eurprd04.prod.outlook.com (20.178.121.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.31; Tue, 22 Jan 2019 11:14:28 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::e58a:8812:d380:2080]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::e58a:8812:d380:2080%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 11:14:28 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi
 <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li
 <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Viorel Suman
 <viorel.suman@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta
 <daniel.baluta@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH v4 2/3] ASoC: add fsl_audmix DT binding documentation
Thread-Topic: [PATCH v4 2/3] ASoC: add fsl_audmix DT binding documentation
Thread-Index: AQHUskOjyw34cq16q0ecl8TZoyZj1A==
Date: Tue, 22 Jan 2019 11:14:27 +0000
Message-ID: <1548155654-12985-3-git-send-email-viorel.suman@nxp.com>
References: <1548155654-12985-1-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1548155654-12985-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR05CA0019.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::32) To VI1PR04MB4704.eurprd04.prod.outlook.com
 (2603:10a6:803:52::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5422;
 6:6vXyixJzRr536t6FlJyyGj660fqoyAUEHNB8xgdiP552zB5RziJ3T09tYZT29OnakuDJ6fXK/aNL374kzcjmS9L3q8Vv2Bui3nbqGYuQKItcxb2rqqCRhUfR3RA9eA5wNz5OMAvnrMHoGcI/uIlL/TJTG9VR+5YzaPKbDpQPkbvp0xNDktXHYQj4P9fHnCfbMeN2/Fcw7xVXxp5MqwjH5slPRx/tJlNFIhkrigoOwzkr5YkzEsMWZDFbgYmbdaHemycRUHDja47o2EUrkFScLDYWTtoYhKNqIeGxc0Co9sP52DcHSvl8kIcWmsJGy0KWL2hTyOUcpxqTWU7FKClsBYX8m6XlJo/GYo+wmFnJjNz+aAhEgW7btU7InNTQhKY934AO53jUrOELgDfpTdvz8ve08tZXJNE5MWBB+tiJlt+wKuSm3VpZxk9tet+hMlykqDN+gXPJC1q8eN8KPcKZiQ==;
 5:cUimCHdxBj5XMD4DLgcZCLt27TKjUsBIkiQCpbwMVVVhEfbBQBct4L/WM9MbWyz71vETC5nTikT4qq4+NM4qQ8y4SOjqER2qSWJRe69zEk/KwGRgC1Db7YAea8nfmcgT9ugsFndSamMtl5QuFhBCCxrUUCdzYacjsyMjJrbh0dyRWe6ZEck95vFqm++aPCpYfX9gnZrIaj31482K1xOxVA==;
 7:L95kri6dsAGcJlwAaWxCpCCNxnfKRnAvJNL1+Lq5pMRh0d0MnW9kLjC6qy0ZktkklIB796EUKdAA8dJPnn7L9ZwghE8BIbMZa2tFb+TTw8GFq+nuAAZN9i7hkWIdJyIZywX1imw9VOkWbyTpqS76yA==
x-ms-office365-filtering-correlation-id: ca960435-dc1e-4e8f-8411-08d6805ac5f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5422; 
x-ms-traffictypediagnostic: VI1PR04MB5422:
x-microsoft-antispam-prvs: <VI1PR04MB54225F81E3D9BD89BD865C6592980@VI1PR04MB5422.eurprd04.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(39860400002)(376002)(346002)(396003)(199004)(189003)(316002)(8936002)(86362001)(6636002)(36756003)(50226002)(110136005)(6486002)(14454004)(54906003)(6436002)(99286004)(6116002)(97736004)(7416002)(81166006)(81156014)(3846002)(478600001)(2906002)(44832011)(8676002)(68736007)(66066001)(105586002)(106356001)(7736002)(305945005)(25786009)(26005)(6346003)(186003)(71190400001)(256004)(486006)(39060400002)(2616005)(4326008)(476003)(6512007)(6506007)(446003)(386003)(53936002)(71200400001)(14444005)(11346002)(102836004)(52116002)(76176011)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5422;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZwIRHBS5FhKnP8LsAsMEgdG2wsr7ILX/TEoAx6SShzQLTXIiMumOGL1ma7jYLfUCYH6WeV1ym3ncJmHTBWmZAVpDLryw7UfS+A8dPYeOTfw6QM+P+Us1ZWSIPD29cFH4uuPpeAzpFs3XC7DDlVp/rlUV0ifj7CMv6bVa3Tu1eD1S82w56eIddjajPi/cN0grCHcnbo4j3hnaByxkQtngZNaIzu0HR96sRa1swhlD8/jBmqlBVA6CMysQ6FEU0cngWZ0CYIIMYltvqg2WwbSWbmH9Yoho++YtvxsBHclefamGAK36JnFFbPHkgTeLdyE4lMYKqtiia4uZVngPmeZ7E8UeJMIkQ4nsk19rhN8QjI/O0sU0l9ZPxHH6tu0AJgGaYm5fVreIZfTP99WFc/0qvD670j6MSaBuk+ITnxf0Sww=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca960435-dc1e-4e8f-8411-08d6805ac5f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 11:14:26.3078 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5422
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
 .../devicetree/bindings/sound/fsl,audmix.txt       | 54 ++++++++++++++++++=
++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt

diff --git a/Documentation/devicetree/bindings/sound/fsl,audmix.txt b/Docum=
entation/devicetree/bindings/sound/fsl,audmix.txt
new file mode 100644
index 0000000..45f807e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,audmix.txt
@@ -0,0 +1,54 @@
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
+  - model		: Must contain machine driver name which will configure
+			  and instantiate the appropriate audio card.
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
+    model =3D "imx-audmix";
+  };
--=20
2.7.4

