Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DEAC46475
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 07:16:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04DE120834
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 07:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EU7Jxwdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04DE120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gdhc324JzDqlD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 18:16:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="EU7Jxwdr";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=104.47.0.61; helo=eur01-he1-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="EU7Jxwdr"; 
 dkim-atps=neutral
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0061.outbound.protection.outlook.com [104.47.0.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gdNL6ln6zF0R8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 18:02:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZp+V8c6Bf0IMR+H+rc3cgtn2YkVXeWwArPuwGIkjfw=;
 b=EU7JxwdrXOpUS+FbTnW2tzL6ZWaq/q3mXqBOtJWxtJr+amXwsV4dB6EYuat2jbEms4NMmua6cu8r67+wtIenyQSEUcE0iIPiL15DKJQ7HdFRiR0xhrQbpzsRHURjFpvv7digNBmuVDOUKcgc0lzLClBmHZM+T3LMrU8wC1xp5+Y=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB5167.eurprd04.prod.outlook.com (20.177.50.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Thu, 25 Oct 2018 07:02:02 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca%3]) with mapi id 15.20.1273.021; Thu, 25 Oct 2018
 07:02:02 +0000
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
Subject: [PATCH v6 5/6] arm64: dts: add QorIQ LX2160A SoC support
Thread-Topic: [PATCH v6 5/6] arm64: dts: add QorIQ LX2160A SoC support
Thread-Index: AQHUbDChmEwz+msV3UyIPthBJsA5lA==
Date: Thu, 25 Oct 2018 07:02:01 +0000
Message-ID: <1540407376-24115-6-git-send-email-vabhav.sharma@nxp.com>
References: <1540407376-24115-1-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1540407376-24115-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::21) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5167;
 6:eI56YVBL4EUEPL7yjCw5R9DVKBX3aK4Iw755NVwSZNwsMVp3c+3w6dd8WIlZ0gGTMP8lrPp8nHJIV2TZ9CpJOteet+uoOqS3JFpY8XkxIXc5ErUjxjlZJa3W7RkJYIaezWipp6VZFFdnSA+r0spKHbYHFSTEWd3P04qHBl5Xen8Dyr6bBJL77k0JtZYU33YNWbMh/oGKruBGtI8aM0qImY+c+iIiQVaN3aex4E5DNxery+sYJ9gx3Q4qh55gOGIsf9JVxzPcgvevcFARguarUlH6dqutspeuw2gv2+uOvtfq1kwjMlAAGcxojLZEhBRGOkMGmGhEg2mRK1Kusuvr6wfkGXOoBbIioqKMHaoScZ1mAraurb40jGmBo26uhZLFGuOv653Ybcd079CSiWLYJJ4GhL7DBzBVP+cT7PGCK3kCJr1lxGYnMkVlOy3ESPksQojA2XVs3wcC1Cygkb4wpg==;
 5:yCNbRz/wk5V5y0GuoZFQN9zbb2kC3ZyGVIY8YHoT58K0AfaCJGfMwJljtoGImpr62CD4bfIFmLOhPgisRZw7GnmvGuohtbYRa1pr0admh++B7q5+RZzfXTR/k4pf+UAjSTt6sdq0zzdIb9nfCa5sK7MtYM0J4y6gXfjLTTdmjwI=;
 7:8ffGYdBces1MxSvytb8S7mNORh9aopGgCu4SOd4PfxTXhJaGeN05ssUFFZK5018V/NF05jT5k/a6Gc5eCjztpRx9G7OEOxXHdSR6MH2sE20d35wCpwv3ibxqCHeSPbg5y+iO5WXT7orLC++17TImjf2VHSQpovzZlFQiLaEEP1bMyV5w4Zr4W3yS8Uy7+96kW1jCoJS+wJ4FlO4m9fRy8yn9Ts26fe7sXFhAkySOSn9g8mYZzNuXti/JpGU3LkbG
x-ms-office365-filtering-correlation-id: a1d55697-3004-4e51-2734-08d63a47c355
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5167; 
x-ms-traffictypediagnostic: VI1PR04MB5167:
x-microsoft-antispam-prvs: <VI1PR04MB516749ECF9D8130311F6789FF3F70@VI1PR04MB5167.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB5167; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB5167; 
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(366004)(39860400002)(346002)(136003)(376002)(396003)(189003)(199004)(478600001)(305945005)(76176011)(316002)(2900100001)(5660300001)(4744004)(4326008)(2906002)(7736002)(8676002)(99286004)(81156014)(3846002)(6116002)(81166006)(256004)(386003)(6506007)(52116002)(14444005)(2201001)(86362001)(71190400001)(68736007)(575784001)(71200400001)(53936002)(55236004)(36756003)(2616005)(106356001)(11346002)(110136005)(14454004)(54906003)(105586002)(6436002)(446003)(476003)(6512007)(53946003)(97736004)(8936002)(486006)(7416002)(66066001)(102836004)(5250100002)(186003)(6486002)(2501003)(26005)(25786009)(44832011)(921003)(1121003)(579004)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5167;
 H:VI1PR04MB4800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DVP7q7pwZASSA20HzCZtPj65rjiL/wQirFGOMt1rGVBJRh3y2yDrTS8y+S8O/9h1g5lyC4YReuS0Ure4ThjVcKOReOh7W3PuPnyx5WKo2++4JPJYFZpwY4dY9I6bkQvbjOY8ilfWYwZ5975FcQMGWg+Cf0DAOWgJJrAGdGSQuHF6uQxV3iwuqxmeCO7auk2+NAhTaJZ4/nMeM2r2P0nhifN+hrOOhAHOKyu0PuxD4RUkqlrRRobKGSpgLC4k/KzX3KsblAsJ2Pt69Kvfx9W9VwQfiqncb7buevn/eodPSmDryO6r3sa1ZG87A3dTEh6/vCXbWlB9HQOqoPRO6YBB3HVVnLlQDUKskqed6jpgLiU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d55697-3004-4e51-2734-08d63a47c355
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 07:02:02.1074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5167
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
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 Horia Geanta <horia.geanta@nxp.com>, Udit Kumar <udit.kumar@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Pankaj Bansal <pankaj.bansal@nxp.com>,
 Ying Zhang <ying.zhang22455@nxp.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 Ramneek Mehresh <ramneek.mehresh@nxp.com>, Varun Sethi <V.Sethi@nxp.com>,
 Vabhav Sharma <vabhav.sharma@nxp.com>, Nipun Gupta <nipun.gupta@nxp.com>,
 Sriram Dash <sriram.dash@nxp.com>, Ran Wang <ran.wang_1@nxp.com>,
 Yinbo Zhu <yinbo.zhu@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

LX2160A SoC is based on Layerscape Chassis Generation 3.2 Architecture.

LX2160A features an advanced 16 64-bit ARM v8 CortexA72 processor cores
in 8 cluster, CCN508, GICv3,two 64-bit DDR4 memory controller, 8 I2C
controllers, 3 dspi, 2 esdhc,2 USB 3.0, mmu 500, 3 SATA, 4 PL011 SBSA
UARTs etc.

Signed-off-by: Ramneek Mehresh <ramneek.mehresh@nxp.com>
Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Signed-off-by: Horia Geanta <horia.geanta@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 766 +++++++++++++++++++++=
++++
 1 file changed, 766 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-lx2160a.dtsi
new file mode 100644
index 0000000..9fcfd48
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -0,0 +1,766 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Device Tree Include file for Layerscape-LX2160A family SoC.
+//
+// Copyright 2018 NXP
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/memreserve/ 0x80000000 0x00010000;
+
+/ {
+	compatible =3D "fsl,lx2160a";
+	interrupt-parent =3D <&gic>;
+	#address-cells =3D <2>;
+	#size-cells =3D <2>;
+
+	cpus {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		// 8 clusters having 2 Cortex-A72 cores each
+		cpu@0 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x0>;
+			clocks =3D <&clockgen 1 0>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster0_l2>;
+		};
+
+		cpu@1 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x1>;
+			clocks =3D <&clockgen 1 0>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster0_l2>;
+		};
+
+		cpu@100 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x100>;
+			clocks =3D <&clockgen 1 1>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster1_l2>;
+		};
+
+		cpu@101 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x101>;
+			clocks =3D <&clockgen 1 1>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster1_l2>;
+		};
+
+		cpu@200 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x200>;
+			clocks =3D <&clockgen 1 2>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster2_l2>;
+		};
+
+		cpu@201 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x201>;
+			clocks =3D <&clockgen 1 2>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster2_l2>;
+		};
+
+		cpu@300 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x300>;
+			clocks =3D <&clockgen 1 3>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster3_l2>;
+		};
+
+		cpu@301 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x301>;
+			clocks =3D <&clockgen 1 3>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster3_l2>;
+		};
+
+		cpu@400 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x400>;
+			clocks =3D <&clockgen 1 4>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster4_l2>;
+		};
+
+		cpu@401 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x401>;
+			clocks =3D <&clockgen 1 4>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster4_l2>;
+		};
+
+		cpu@500 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x500>;
+			clocks =3D <&clockgen 1 5>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster5_l2>;
+		};
+
+		cpu@501 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x501>;
+			clocks =3D <&clockgen 1 5>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster5_l2>;
+		};
+
+		cpu@600 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x600>;
+			clocks =3D <&clockgen 1 6>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster6_l2>;
+		};
+
+		cpu@601 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x601>;
+			clocks =3D <&clockgen 1 6>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster6_l2>;
+		};
+
+		cpu@700 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x700>;
+			clocks =3D <&clockgen 1 7>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster7_l2>;
+		};
+
+		cpu@701 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x701>;
+			clocks =3D <&clockgen 1 7>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster7_l2>;
+		};
+
+		cluster0_l2: l2-cache0 {
+			compatible =3D "cache";
+			cache-size =3D <0x100000>;
+			cache-line-size =3D <64>;
+			cache-sets =3D <1024>;
+			cache-level =3D <2>;
+		};
+
+		cluster1_l2: l2-cache1 {
+			compatible =3D "cache";
+			cache-size =3D <0x100000>;
+			cache-line-size =3D <64>;
+			cache-sets =3D <1024>;
+			cache-level =3D <2>;
+		};
+
+		cluster2_l2: l2-cache2 {
+			compatible =3D "cache";
+			cache-size =3D <0x100000>;
+			cache-line-size =3D <64>;
+			cache-sets =3D <1024>;
+			cache-level =3D <2>;
+		};
+
+		cluster3_l2: l2-cache3 {
+			compatible =3D "cache";
+			cache-size =3D <0x100000>;
+			cache-line-size =3D <64>;
+			cache-sets =3D <1024>;
+			cache-level =3D <2>;
+		};
+
+		cluster4_l2: l2-cache4 {
+			compatible =3D "cache";
+			cache-size =3D <0x100000>;
+			cache-line-size =3D <64>;
+			cache-sets =3D <1024>;
+			cache-level =3D <2>;
+		};
+
+		cluster5_l2: l2-cache5 {
+			compatible =3D "cache";
+			cache-size =3D <0x100000>;
+			cache-line-size =3D <64>;
+			cache-sets =3D <1024>;
+			cache-level =3D <2>;
+		};
+
+		cluster6_l2: l2-cache6 {
+			compatible =3D "cache";
+			cache-size =3D <0x100000>;
+			cache-line-size =3D <64>;
+			cache-sets =3D <1024>;
+			cache-level =3D <2>;
+		};
+
+		cluster7_l2: l2-cache7 {
+			compatible =3D "cache";
+			cache-size =3D <0x100000>;
+			cache-line-size =3D <64>;
+			cache-sets =3D <1024>;
+			cache-level =3D <2>;
+		};
+	};
+
+	gic: interrupt-controller@6000000 {
+		compatible =3D "arm,gic-v3";
+		reg =3D <0x0 0x06000000 0 0x10000>, // GIC Dist
+			<0x0 0x06200000 0 0x200000>, // GICR (RD_base +
+						     // SGI_base)
+			<0x0 0x0c0c0000 0 0x2000>, // GICC
+			<0x0 0x0c0d0000 0 0x1000>, // GICH
+			<0x0 0x0c0e0000 0 0x20000>; // GICV
+		#interrupt-cells =3D <3>;
+		#address-cells =3D <2>;
+		#size-cells =3D <2>;
+		ranges;
+		interrupt-controller;
+		interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+		its: gic-its@6020000 {
+			compatible =3D "arm,gic-v3-its";
+			msi-controller;
+			reg =3D <0x0 0x6020000 0 0x20000>;
+		};
+	};
+
+	timer {
+		compatible =3D "arm,armv8-timer";
+		interrupts =3D <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu {
+		compatible =3D "arm,cortex-a72-pmu";
+		interrupts =3D <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	psci {
+		compatible =3D "arm,psci-0.2";
+		method =3D "smc";
+	};
+
+	memory@80000000 {
+		// DRAM space - 1, size : 2 GB DRAM
+		device_type =3D "memory";
+		reg =3D <0x00000000 0x80000000 0 0x80000000>;
+	};
+
+	ddr1: memory-controller@1080000 {
+		compatible =3D "fsl,qoriq-memory-controller";
+		reg =3D <0x0 0x1080000 0x0 0x1000>;
+		interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+		little-endian;
+	};
+
+	ddr2: memory-controller@1090000 {
+		compatible =3D "fsl,qoriq-memory-controller";
+		reg =3D <0x0 0x1090000 0x0 0x1000>;
+		interrupts =3D <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+		little-endian;
+	};
+
+	// One clock unit-sysclk node which bootloader require during DT fix-up
+	sysclk: sysclk {
+		compatible =3D "fixed-clock";
+		#clock-cells =3D <0>;
+		clock-frequency =3D <100000000>;
+		clock-output-names =3D "sysclk";
+	};
+
+	soc {
+		compatible =3D "simple-bus";
+		#address-cells =3D <2>;
+		#size-cells =3D <2>;
+		ranges;
+
+		crypto: crypto@8000000 {
+			compatible =3D "fsl,sec-v5.0", "fsl,sec-v4.0";
+			fsl,sec-era =3D <10>;
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			ranges =3D <0x0 0x00 0x8000000 0x100000>;
+			reg =3D <0x00 0x8000000 0x0 0x100000>;
+			interrupts =3D <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
+			status =3D "disabled";
+
+			sec_jr0: jr@10000 {
+				compatible =3D "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg        =3D <0x10000 0x10000>;
+				interrupts =3D <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr1: jr@20000 {
+				compatible =3D "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg        =3D <0x20000 0x10000>;
+				interrupts =3D <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr2: jr@30000 {
+				compatible =3D "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg        =3D <0x30000 0x10000>;
+				interrupts =3D <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr3: jr@40000 {
+				compatible =3D "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg        =3D <0x40000 0x10000>;
+				interrupts =3D <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		clockgen: clock-controller@1300000 {
+			compatible =3D "fsl,lx2160a-clockgen";
+			reg =3D <0 0x1300000 0 0xa0000>;
+			#clock-cells =3D <2>;
+			clocks =3D <&sysclk>;
+		};
+
+		dcfg: syscon@1e00000 {
+			compatible =3D "fsl,lx2160a-dcfg", "syscon";
+			reg =3D <0x0 0x1e00000 0x0 0x10000>;
+			little-endian;
+		};
+
+		i2c0: i2c@2000000 {
+			compatible =3D "fsl,vf610-i2c";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x0 0x2000000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names =3D "i2c";
+			clocks =3D <&clockgen 4 7>;
+			scl-gpio =3D <&gpio2 15 GPIO_ACTIVE_HIGH>;
+			status =3D "disabled";
+		};
+
+		i2c1: i2c@2010000 {
+			compatible =3D "fsl,vf610-i2c";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x0 0x2010000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names =3D "i2c";
+			clocks =3D <&clockgen 4 7>;
+			status =3D "disabled";
+		};
+
+		i2c2: i2c@2020000 {
+			compatible =3D "fsl,vf610-i2c";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x0 0x2020000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names =3D "i2c";
+			clocks =3D <&clockgen 4 7>;
+			status =3D "disabled";
+		};
+
+		i2c3: i2c@2030000 {
+			compatible =3D "fsl,vf610-i2c";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x0 0x2030000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names =3D "i2c";
+			clocks =3D <&clockgen 4 7>;
+			status =3D "disabled";
+		};
+
+		i2c4: i2c@2040000 {
+			compatible =3D "fsl,vf610-i2c";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x0 0x2040000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names =3D "i2c";
+			clocks =3D <&clockgen 4 7>;
+			scl-gpio =3D <&gpio2 16 GPIO_ACTIVE_HIGH>;
+			status =3D "disabled";
+		};
+
+		i2c5: i2c@2050000 {
+			compatible =3D "fsl,vf610-i2c";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x0 0x2050000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names =3D "i2c";
+			clocks =3D <&clockgen 4 7>;
+			status =3D "disabled";
+		};
+
+		i2c6: i2c@2060000 {
+			compatible =3D "fsl,vf610-i2c";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x0 0x2060000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names =3D "i2c";
+			clocks =3D <&clockgen 4 7>;
+			status =3D "disabled";
+		};
+
+		i2c7: i2c@2070000 {
+			compatible =3D "fsl,vf610-i2c";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x0 0x2070000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names =3D "i2c";
+			clocks =3D <&clockgen 4 7>;
+			status =3D "disabled";
+		};
+
+		esdhc0: esdhc@2140000 {
+			compatible =3D "fsl,esdhc";
+			reg =3D <0x0 0x2140000 0x0 0x10000>;
+			interrupts =3D <0 28 0x4>; /* Level high type */
+			clocks =3D <&clockgen 4 1>;
+			voltage-ranges =3D <1800 1800 3300 3300>;
+			sdhci,auto-cmd12;
+			little-endian;
+			bus-width =3D <4>;
+			status =3D "disabled";
+		};
+
+		esdhc1: esdhc@2150000 {
+			compatible =3D "fsl,esdhc";
+			reg =3D <0x0 0x2150000 0x0 0x10000>;
+			interrupts =3D <0 63 0x4>; /* Level high type */
+			clocks =3D <&clockgen 4 1>;
+			voltage-ranges =3D <1800 1800 3300 3300>;
+			sdhci,auto-cmd12;
+			broken-cd;
+			little-endian;
+			bus-width =3D <4>;
+			status =3D "disabled";
+		};
+
+		uart0: serial@21c0000 {
+			compatible =3D "arm,sbsa-uart","arm,pl011";
+			reg =3D <0x0 0x21c0000 0x0 0x1000>;
+			interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			current-speed =3D <115200>;
+			status =3D "disabled";
+		};
+
+		uart1: serial@21d0000 {
+			compatible =3D "arm,sbsa-uart","arm,pl011";
+			reg =3D <0x0 0x21d0000 0x0 0x1000>;
+			interrupts =3D <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			current-speed =3D <115200>;
+			status =3D "disabled";
+		};
+
+		uart2: serial@21e0000 {
+			compatible =3D "arm,sbsa-uart","arm,pl011";
+			reg =3D <0x0 0x21e0000 0x0 0x1000>;
+			interrupts =3D <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+			current-speed =3D <115200>;
+			status =3D "disabled";
+		};
+
+		uart3: serial@21f0000 {
+			compatible =3D "arm,sbsa-uart","arm,pl011";
+			reg =3D <0x0 0x21f0000 0x0 0x1000>;
+			interrupts =3D <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			current-speed =3D <115200>;
+			status =3D "disabled";
+		};
+
+		gpio0: gpio@2300000 {
+			compatible =3D "fsl,qoriq-gpio";
+			reg =3D <0x0 0x2300000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			little-endian;
+			#gpio-cells =3D <2>;
+			interrupt-controller;
+			#interrupt-cells =3D <2>;
+		};
+
+		gpio1: gpio@2310000 {
+			compatible =3D "fsl,qoriq-gpio";
+			reg =3D <0x0 0x2310000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			little-endian;
+			#gpio-cells =3D <2>;
+			interrupt-controller;
+			#interrupt-cells =3D <2>;
+		};
+
+		gpio2: gpio@2320000 {
+			compatible =3D "fsl,qoriq-gpio";
+			reg =3D <0x0 0x2320000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			little-endian;
+			#gpio-cells =3D <2>;
+			interrupt-controller;
+			#interrupt-cells =3D <2>;
+		};
+
+		gpio3: gpio@2330000 {
+			compatible =3D "fsl,qoriq-gpio";
+			reg =3D <0x0 0x2330000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			little-endian;
+			#gpio-cells =3D <2>;
+			interrupt-controller;
+			#interrupt-cells =3D <2>;
+		};
+
+		watchdog@23a0000 {
+			compatible =3D "arm,sbsa-gwdt";
+			reg =3D <0x0 0x23a0000 0 0x1000>,
+			      <0x0 0x2390000 0 0x1000>;
+			interrupts =3D <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+			timeout-sec =3D <30>;
+		};
+
+		usb0: usb@3100000 {
+			compatible =3D "snps,dwc3";
+			reg =3D <0x0 0x3100000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			dr_mode =3D "host";
+			snps,quirk-frame-length-adjustment =3D <0x20>;
+			snps,dis_rxdet_inp3_quirk;
+			status =3D "disabled";
+		};
+
+		usb1: usb@3110000 {
+			compatible =3D "snps,dwc3";
+			reg =3D <0x0 0x3110000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+			dr_mode =3D "host";
+			snps,quirk-frame-length-adjustment =3D <0x20>;
+			snps,dis_rxdet_inp3_quirk;
+			status =3D "disabled";
+		};
+
+		smmu: iommu@5000000 {
+			compatible =3D "arm,mmu-500";
+			reg =3D <0 0x5000000 0 0x800000>;
+			#iommu-cells =3D <1>;
+			#global-interrupts =3D <14>;
+				     // global secure fault
+			interrupts =3D <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				     // combined secure
+				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				     // global non-secure fault
+				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+				     // combined non-secure
+				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				     // performance counter interrupts 0-9
+				     <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
+				     // per context interrupt, 64 interrupts
+				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
+		};
+	};
+};
--=20
2.7.4

