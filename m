Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8712FC46475
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 09:17:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE01920664
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 09:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AlltrJzM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE01920664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42k8BX5P5TzDr5Y
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 20:17:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="AlltrJzM";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.8.54; helo=eur04-vi1-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="AlltrJzM"; 
 dkim-atps=neutral
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80054.outbound.protection.outlook.com [40.107.8.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42k7mF5n92zDrMD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 19:58:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yT1nD6+p3bPv4rTswzFGg/kLz3Cisik4qPqGu929Lzw=;
 b=AlltrJzMnmDZGIvtEIU3ckDHvXXIXhOE+FsM1TsuoXm+eWVVMpVJ1+RftsFFSg6Sl/Np8VrL+VZu7mkMw7HJxnIPh5IW8LSd25hBU0ruz/QVGEUwpMmWOXJGsebOPaYFibSUu5qm8mEgb2f2X761hpsUtjVf7rF5wyvBzVUVj14=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB5149.eurprd04.prod.outlook.com (20.177.50.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.21; Mon, 29 Oct 2018 08:58:02 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca%3]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 08:58:01 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "oss@buserror.net"
 <oss@buserror.net>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "mturquette@baylibre.com"
 <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org"
 <viresh.kumar@linaro.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "linux-kernel-owner@vger.kernel.org"
 <linux-kernel-owner@vger.kernel.org>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de"
 <arnd@arndb.de>, "kstewart@linuxfoundation.org"
 <kstewart@linuxfoundation.org>, "yamada.masahiro@socionext.com"
 <yamada.masahiro@socionext.com>, Leo Li <leoyang.li@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: [PATCH v7 6/6] arm64: dts: add LX2160ARDB board support
Thread-Topic: [PATCH v7 6/6] arm64: dts: add LX2160ARDB board support
Thread-Index: AQHUb2V/H+qQLgKfCkiPqStcYu8Q1w==
Date: Mon, 29 Oct 2018 08:58:01 +0000
Message-ID: <1540759926-3641-7-git-send-email-vabhav.sharma@nxp.com>
References: <1540759926-3641-1-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1540759926-3641-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::14) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5149;
 6:r/wQ6A9fcRK+JclZw5VDj75sjN1uLgvUKzomLfyzF1NooqLLT5MAmJ05iVkzNgg7cY9FFg4UKyjHd29gVG5ucrhKemAVPdU3pFqhvfb538jcSDllbLgPI6tsdMK+pxX5Pe4B7YOtgfeF9J39gTrgCZ72XbS+Y3E5xBz051FLRNw7xxqP7t0aG+ScX7GlRiNTt8VL72/K2vWWxNbfCtoQCBUoyrmm6GGjZ8Krk/skhDRLyCNgfqNt6m0EgRWq4WNq40+yzB6P2HAyaKFmYueKm7Eqmr0OlSNNUABVp1s+gvmDb6XFoaJSDLIuOxfqWwv/Rz5cX3r/A5TL1TcA1AKRLebrzwffAfgUDScrEfZ9Jy/a3ETabjIOkLd6UNl9jLvowVa6xDvDoNAWYgN0lQZipSXZLy/npAy/Oe4zNPPpvCWGx2HAnSwd4JoOcu8v93ZLNAs9L2PCxKLLPyaK2Gb28w==;
 5:87wnyIfVV+6REAMZaVcpgKBaVcj7g1jT+ENg3+mBDvjCkQO1fTYA6HOpvg2ro4CQ5K51IPpT9oewSJP0/xE+OL3Fip5LVtqu6qGvM+5FUXAYZ6EcBA7X8xXu4EylY6BSUiGD8Ow/EdnuVEjAHQ2Fwc22mZzHg6pUEy1OlB0HIb4=;
 7:kafpN+eSaEjHMJzjk+ESrKkp8BqpM4+NVXWdXUPqd35/cTcavrOgNEO/NRNr2zJvgVjiIxSw7H7/KKxrWVSynLoF+kjvbMPavPGsUWZMzLStbGEVEi8ymfJ+xaW5vSIUMlWqxzYq5ftBolNbE2MKEQ==
x-ms-office365-filtering-correlation-id: 2ab801ae-48f8-4d5d-b252-08d63d7ca164
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5149; 
x-ms-traffictypediagnostic: VI1PR04MB5149:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-microsoft-antispam-prvs: <VI1PR04MB514973FA069DEB8EB7370B11F3F30@VI1PR04MB5149.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB5149; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB5149; 
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(86362001)(186003)(54906003)(44832011)(486006)(102836004)(2900100001)(256004)(2201001)(55236004)(386003)(6506007)(7736002)(478600001)(4326008)(97736004)(26005)(105586002)(110136005)(99286004)(446003)(2616005)(52116002)(14454004)(476003)(11346002)(76176011)(106356001)(2501003)(6512007)(5660300001)(316002)(8936002)(5250100002)(68736007)(71190400001)(71200400001)(7416002)(53936002)(6486002)(25786009)(3846002)(6116002)(8676002)(81156014)(81166006)(305945005)(36756003)(2906002)(6436002)(66066001)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5149;
 H:VI1PR04MB4800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6V/ZB1zx2c4b2bWsBuAv/REY8VT6X/tO8LvfJBD+CS2i/MLvNUhTL+gsuziFipfgyRb/E93ASa75pCbgJlheEZcvlPJce74/AeOvSqO2ZToU2d3G0adTJpUCdbxmgANHMRt84HK0TPbuESgAnjooaAf4zb7rMTpn8T1GUe+MiQnoZQp0wXn17EVAmjrCgk2JlYPiI1bBriLGi7zPS+JeX2tV4XS6OQCCzZdKuWfdmPdjwVFu9lABLbSotJfuSwWpqvZw/fNwTjrVF6K2R4o/h6dMVBZzVI+pkq1YExP+wqSYdJBlDYEuvvVVVeHTg14AzncKroXrydCgVVuR+qgAucAUgrp1vfysaoxHY4Cg5xQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab801ae-48f8-4d5d-b252-08d63d7ca164
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 08:58:01.7473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5149
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
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 Horia Geanta <horia.geanta@nxp.com>, Udit Kumar <udit.kumar@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Pankaj Bansal <pankaj.bansal@nxp.com>,
 Ying Zhang <ying.zhang22455@nxp.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 Varun Sethi <V.Sethi@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>,
 Sriram Dash <sriram.dash@nxp.com>, Ran Wang <ran.wang_1@nxp.com>,
 Yinbo Zhu <yinbo.zhu@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

LX2160A reference design board (RDB) is a high-performance
computing, evaluation, and development platform with LX2160A
SoC.

Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Signed-off-by: Horia Geanta <horia.geanta@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
Acked-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 119 ++++++++++++++++++=
++++
 2 files changed, 120 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/f=
reescale/Makefile
index 86e18ad..445b72b 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -13,3 +13,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2080a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2080a-simu.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2088a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2088a-rdb.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2160a-rdb.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64=
/boot/dts/freescale/fsl-lx2160a-rdb.dts
new file mode 100644
index 0000000..6481e5f
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Device Tree file for LX2160ARDB
+//
+// Copyright 2018 NXP
+
+/dts-v1/;
+
+#include "fsl-lx2160a.dtsi"
+
+/ {
+	model =3D "NXP Layerscape LX2160ARDB";
+	compatible =3D "fsl,lx2160a-rdb", "fsl,lx2160a";
+
+	aliases {
+		crypto =3D &crypto;
+		serial0 =3D &uart0;
+	};
+
+	chosen {
+		stdout-path =3D "serial0:115200n8";
+	};
+
+	sb_3v3: regulator-sb3v3 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "MC34717-3.3VSB";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&crypto {
+	status =3D "okay";
+};
+
+&esdhc0 {
+	sd-uhs-sdr104;
+	sd-uhs-sdr50;
+	sd-uhs-sdr25;
+	sd-uhs-sdr12;
+	status =3D "okay";
+};
+
+&esdhc1 {
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	bus-width =3D <8>;
+	status =3D "okay";
+};
+
+&i2c0 {
+	status =3D "okay";
+
+	i2c-mux@77 {
+		compatible =3D "nxp,pca9547";
+		reg =3D <0x77>;
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		i2c@2 {
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x2>;
+
+			power-monitor@40 {
+				compatible =3D "ti,ina220";
+				reg =3D <0x40>;
+				shunt-resistor =3D <1000>;
+			};
+		};
+
+		i2c@3 {
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x3>;
+
+			temperature-sensor@4c {
+				compatible =3D "nxp,sa56004";
+				reg =3D <0x4c>;
+				vcc-supply =3D <&sb_3v3>;
+			};
+
+			temperature-sensor@4d {
+				compatible =3D "nxp,sa56004";
+				reg =3D <0x4d>;
+				vcc-supply =3D <&sb_3v3>;
+			};
+		};
+	};
+};
+
+&i2c4 {
+	status =3D "okay";
+
+	rtc@51 {
+		compatible =3D "nxp,pcf2129";
+		reg =3D <0x51>;
+		// IRQ10_B
+		interrupts =3D <0 150 0x4>;
+	};
+};
+
+&uart0 {
+	status =3D "okay";
+};
+
+&uart1 {
+	status =3D "okay";
+};
+
+&usb0 {
+	status =3D "okay";
+};
+
+&usb1 {
+	status =3D "okay";
+};
--=20
2.7.4

