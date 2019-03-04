Return-Path: <SRS0=bgOd=RH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C23CC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 10:41:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0AC20663
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 10:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oI9kY5v0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0AC20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Cc5j3FvTzDqHZ
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 21:41:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.2.64; helo=eur02-ve1-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="oI9kY5v0"; 
 dkim-atps=neutral
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20064.outbound.protection.outlook.com [40.107.2.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Cbzq2w7GzDqG8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2019 21:36:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fIcGmB7iUpAgAjixrTAxrSEyrlm7/CvszU1+WsO6UY=;
 b=oI9kY5v000itPQuQ4/5PAk4qqK3wEzNnMDQUvlrtHiFtoxFm9z5+i49ZmbjTEp8gylQDp+uSK3xR8GxbqMjFanxNPqjOhTCWqumxuI151Uu4XH1Xk+2cCqmjT8SLyTgBp9itnFZ/TQ2A7LE6mvywBhoIHeQpsakP9tLHmwdCFqw=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB6270.eurprd04.prod.outlook.com (20.179.26.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Mon, 4 Mar 2019 10:36:26 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::78ad:1f42:aeff:b22e]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::78ad:1f42:aeff:b22e%4]) with mapi id 15.20.1665.020; Mon, 4 Mar 2019
 10:36:26 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi
 <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li
 <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Viorel Suman
 <viorel.suman@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta
 <daniel.baluta@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH RESEND v5 2/3] ASoC: add fsl_audmix DT binding documentation
Thread-Topic: [PATCH RESEND v5 2/3] ASoC: add fsl_audmix DT binding
 documentation
Thread-Index: AQHU0nYe/M1b8nS0JkW6XgiHhY/M8g==
Date: Mon, 4 Mar 2019 10:36:26 +0000
Message-ID: <1551695748-21541-3-git-send-email-viorel.suman@nxp.com>
References: <1551695748-21541-1-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1551695748-21541-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR01CA0067.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::44) To VI1PR04MB4704.eurprd04.prod.outlook.com
 (2603:10a6:803:52::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb5aa383-31c5-4f0c-f4ed-08d6a08d414d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB6270; 
x-ms-traffictypediagnostic: VI1PR04MB6270:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB6270;
 23:f/vB+pXztquYs0HEOA1QIK36pQ5yGmR/+kBtJXr?=
 =?iso-8859-1?Q?gsYhbCXhNIA8ZAVXeCUZppA477piBSqId8GImwvf8XPGfw+tBjvjybRWJO?=
 =?iso-8859-1?Q?cItS7+XufpPqeCaCl22cmNpZXJrbP+gPi6oDhTBqiZZ5BlKoxuJzP5OAuz?=
 =?iso-8859-1?Q?mHB+1eZCrPbzdGt53MpLve9wkPjgrzBMMP/pdK1Dz+rPbdcWC7HH7rl4TF?=
 =?iso-8859-1?Q?4XQZ/mkgpxiX2kNIk0/L8uHgtKzcZhQ/O7Vz72zP61i+AMQwuqrn/D/GC2?=
 =?iso-8859-1?Q?n9YkuJ4IRa5i8RmlZJjcZzYEHiAoVxxmSR5+d4hJvGDzkOFNO8woD5ccRP?=
 =?iso-8859-1?Q?nam2RaPJlXzAuKe+QHhBtcHeZNb+y8cHKv3iQqYEJ95uHNEflWXbX5R9GX?=
 =?iso-8859-1?Q?8NOOnjlmJE6y3Fa7nIwszWDRG8yR+y0n9i72MgmF11+cbLE0KhNfyXoPhD?=
 =?iso-8859-1?Q?pXrVm5fUghSZPh+YHCAE967cXSl/+7fHgkVH+xBLUlGhGAd9mgVMUg+N+I?=
 =?iso-8859-1?Q?4QLWblx2gtKCuFoZRjKnBTglXwZTUtv1Ay2p8gQEcVa8PkJ/DfM3Rz/5VM?=
 =?iso-8859-1?Q?SsKf4/MragyqkU0hldxa8gzmSpJCmjA4U0YyVIzw2MhLbNlpciC3EjsBJh?=
 =?iso-8859-1?Q?35gVDWuVzXopkY8qnSREq6kTMcCgtSgAROJ4hfjJOWy38k8/FWe5Zj+ZwE?=
 =?iso-8859-1?Q?DhrOc5G1NMAMKIuhoPvOMDo2WINAOffhkDNwzUTUrOk31qSnPUlwHKI3bZ?=
 =?iso-8859-1?Q?onvU4srU5HZM9hwHlytfEHCwxc9cCvUlY7xEx9/3ijZjW2RrDIcQxQCzW3?=
 =?iso-8859-1?Q?QQTEwNJ36eMaxiOyc9jA9lRfKAdST/xYd7+LINjHP6Lti96PdVXfz903vM?=
 =?iso-8859-1?Q?eJMOcZvLLjQrySYdCdNS/MrZb7g7MAW0+r+r19RTcpXzsp/dHsSSTqhom4?=
 =?iso-8859-1?Q?XRX38y+aRoaFubEYmolZPpFH4RyXBEtIycNdMccTDxEk+tjOU3YZRNRnvs?=
 =?iso-8859-1?Q?uSYQra/ywgdlj/Kj016ZvU0ng5PMbySpaePbMIULO/lxuy4UpH2XCir1A3?=
 =?iso-8859-1?Q?spgUzknf+WJsx/O3Jwm/cjrtkfNkncM4L0dajnYQiC+Gay/Oh8VOgR3D05?=
 =?iso-8859-1?Q?nmoeqSCYpbAHBzq4Rsg8hsR/oEoLqTgTP/o1r5QVgCca4ncPShXK7i3RgQ?=
 =?iso-8859-1?Q?Gs2/XdWoaMVAdy2wPFEpaviY0pT8H9Kpl1Lv8YFB7mDkmZE2uSUgP7aooW?=
 =?iso-8859-1?Q?nJWBNtuxyx2jCYOApMevUg9wORPRT3T62LToADFUS2LL0xh3M3gPShxdEL?=
 =?iso-8859-1?Q?FzXxDYotTapxWufC9TRUANOMGlEWh/8pwMNhhKkGFHHdA=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB6270561F57F57B66566CB89592710@VI1PR04MB6270.eurprd04.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(189003)(199004)(186003)(26005)(81156014)(81166006)(76176011)(8676002)(52116002)(102836004)(66066001)(2906002)(105586002)(386003)(6506007)(106356001)(478600001)(86362001)(305945005)(7736002)(99286004)(256004)(446003)(11346002)(2616005)(486006)(44832011)(476003)(316002)(97736004)(14444005)(6116002)(3846002)(36756003)(4326008)(8936002)(50226002)(68736007)(54906003)(110136005)(14454004)(71200400001)(6436002)(6486002)(53936002)(25786009)(6512007)(71190400001)(5660300002)(7416002)(6636002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB6270;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: f9JqOntT+gop0f8A/vSSz3vbV8tI47IZEIcs76DgJgT3CgKMc6Xdzza+9pGtvXProK2IP0uWdlF2I43gFuWAAHLRw2PIGRTbQ5vt04WSxCWCEDc2LUpRPR4fe4H861b+Cu4t0QyYWvMPk13drofzWl7dGZGSUp9xK8kTr3+JxQLt/R6dG71YqrFpLErojJuDAu3Sw7n7E0umrB0E9dH+vp7GjavNxIcYnH1p8jDPN31c+OsoHgWik+jLi9EseLNcv4HmHbDUrqyHceBuL2M4SMnJAYATeHxPPNdy42aCM+e6NKdErj5FWvtyUPTsYQ+aa8AGNUHFXDUx9yh6ed24x0Z7jsy4xyHqWZWcL2fLgfCHGUbltMUA+AsHLjVW6OM/T2wITse62+3YDZaEVLlRxr3haO3pJkUl6fXfDB3ueEU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5aa383-31c5-4f0c-f4ed-08d6a08d414d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 10:36:26.8726 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6270
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
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
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

