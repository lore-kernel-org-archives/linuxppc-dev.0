Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD2FC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 08:45:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE11B2147C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 08:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IAtsGL7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE11B2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447spK5lnvzDq9s
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 19:45:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.74; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="IAtsGL7s"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00074.outbound.protection.outlook.com [40.107.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447sZ03YqTzDqSC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 19:34:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WG269VoNS5sKeqRvSDeU13wX2mT/JDfn6uqCW8w3biU=;
 b=IAtsGL7sq6GThgAbptBdPofLJdgfrrBXS0uGgE3EerYT5EOhu6SkHbSXtcpOqlIYRW3brcJcglpUDGzu8XAWehvveYV57g3rY/VtzXZs6G27sxHENTUVN4dKemke7M5ieyfoy4ZMn3OBh1AR8Sl3PVdObFC0A42nBRgmcenQG54=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB5645.eurprd04.prod.outlook.com (20.178.125.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 08:34:29 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::7437:2195:ffd3:a33a]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::7437:2195:ffd3:a33a%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 08:34:29 +0000
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
Subject: [PATCH 1/4] dt-bindings: arm64: add compatible for LX2160A
Thread-Topic: [PATCH 1/4] dt-bindings: arm64: add compatible for LX2160A
Thread-Index: AQHUza4Xsegi2YRAlUK+EnXv/Ykw5A==
Date: Tue, 26 Feb 2019 08:34:29 +0000
Message-ID: <1551126463-5341-2-git-send-email-vabhav.sharma@nxp.com>
References: <1551126463-5341-1-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1551126463-5341-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::23) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [92.120.1.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d29bb221-4b57-4cfa-73b1-08d69bc53947
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5645; 
x-ms-traffictypediagnostic: VI1PR04MB5645:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB5645;
 23:21//tDeWovUVEBPeul9ePo6KYsxIHLktnDmB741?=
 =?iso-8859-1?Q?AkdXssCVVaJPpfdBUt5H59j+tkb3s9P7/FcQPj83NefZlLCSLhlna4FuWI?=
 =?iso-8859-1?Q?QoegMQW8BrrnC+a01bfeolZc6Wt8MIMAp2TY0P0jfYiWKTt6kf0NtVzDQR?=
 =?iso-8859-1?Q?vdIEl+Cod/WKmZUaQzxXaJIc/jiq7yuPaITqRfTV/rSnfzNpkxqS849ENu?=
 =?iso-8859-1?Q?wNOPyJnoeDVLkIPfu1UdLHHd283lA2bFVfpE4P9W/IQ1bKFN6y0te+fRjP?=
 =?iso-8859-1?Q?VrlzF3ENsqe+7VPuxIV9goXKskDxrjmttTUrAEtChFckFQ+Hbb89Thk2t6?=
 =?iso-8859-1?Q?LJk8pGiRw+T5Lu5WpLy4A2Ki/0zPx/JsMKkiYQmFfemu9LJRv0a5b5vMVh?=
 =?iso-8859-1?Q?17GX7gMal+i0na/Hj0u9kDbhLksyIr1LV6OSYswavATLk7mMO4v2zgBvc1?=
 =?iso-8859-1?Q?vfcEO22y4CgXPqCSqltmuEKL6A6IXA+rlaqEy5vak2IzkFvjvuCcwm3jyQ?=
 =?iso-8859-1?Q?PxGnlX9kkZfXo7LB+sxBoYr1HGe9n16IOP+zun2pQJanYJnwhsvE9+OKN3?=
 =?iso-8859-1?Q?YxP40trr7XsExl40p7m6F8r1+MKDmK0PSANee/oDgBQSQ9NsDHZs//pq/5?=
 =?iso-8859-1?Q?CPaFZHeNrPn84frgbTu1lNo4Q9zus5R7Z2FqMwSoGUpKvj9Te5+C1SVfcB?=
 =?iso-8859-1?Q?0wxta/nmQwkpa95FOs4wWb8ZHb3wcAe1fOHdhk/RUKT4NUA3WxNBAq0hZ1?=
 =?iso-8859-1?Q?D47JfH8n0/DyNrYqCIW1MQvUisXsPjcg10lkBhJeCpNABH7EIRJOpXilTx?=
 =?iso-8859-1?Q?MpPvJqIgQm7BjEUm7tafrlM7z+wwg9jolRidB9dAbRqkDv77KKif+F4Kep?=
 =?iso-8859-1?Q?bUPN+VsPSK+qzya31O4WA4m2acFECK9dJcSIenAjNbs+xenWYzgmiajj07?=
 =?iso-8859-1?Q?Qd2/4j+6QY/TYNl10P9pv4nuQPBnxfhj6aUm3yZBBf3nRjVVn/3xitfIpF?=
 =?iso-8859-1?Q?zTGiEjIud1TUUo3IJdPA6iInNas1sbG84NIwYFAbBQ6lItN/bObNyg1ePh?=
 =?iso-8859-1?Q?kFoX1kB4nSNjeIipKmRWobLoBxdYw6xheavwZD6y2iYslDCZd6toVYh0Jt?=
 =?iso-8859-1?Q?o1E1rz+m6Qm7lkz0XNt5LZPWwcmdwXAxTLmJbBCDf/ceLp9e77t8ZRhQnm?=
 =?iso-8859-1?Q?Zdxg562/8NFG53N8Q9QOcEWNc8oXqBbu68pXFyuQuQZfUh8EUwywY2E0At?=
 =?iso-8859-1?Q?ZtFLYcLcVx+BGb9qVE1/u62Zpxo763oumG+PpZaehC1uyQrjmrQl6JS21V?=
 =?iso-8859-1?Q?h5XxBT0e9qcTn+dlanMgcg7fiOqzfamaYMKETjE0kdAkYBPdYb3+WZ1d84?=
 =?iso-8859-1?Q?S1hUYQDI=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB5645DCBB70488EE9484EE998F37B0@VI1PR04MB5645.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(396003)(136003)(39860400002)(376002)(199004)(189003)(66066001)(71200400001)(71190400001)(2906002)(478600001)(97736004)(6512007)(50226002)(8936002)(5660300002)(54906003)(6506007)(99286004)(386003)(76176011)(102836004)(2501003)(53936002)(110136005)(2201001)(52116002)(86362001)(68736007)(316002)(6436002)(2616005)(11346002)(476003)(486006)(7416002)(7736002)(44832011)(186003)(81166006)(8676002)(81156014)(3846002)(6116002)(446003)(6486002)(4326008)(25786009)(256004)(14444005)(106356001)(36756003)(305945005)(26005)(105586002)(14454004)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5645;
 H:VI1PR04MB4800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QwOI7rdRE+gB59b3veD4JT9SrSf3a1VNbZB5N8XdrKWFAtSH1eYQyQAm//6DhRHncWSGPiHrXUBgZSKgCnXwMEIldw3+4fU4ooXQ3eRiRhB0tSAH+EkgPv/hm/AzgzNlsUMLcStzRwRvTs8BszEZBJajzLCh5Eb4O+3liQOlZiybvWJrjhbsvCQR/iUX20SFwCGWdwKrDlGhYbrHMkuDNKyhpmJqprtpvenMGcIJPUcuwMLdWoDN6rqKe9UWjAcPt0JmjHcmzwTj5E6kaXCfY5/vUZKg2G14HgP7UcwClUcuKMrBIcy2Rx6Eza7gI8xr86RFpNX7D6treoMboRj5pLYYjl2JfoYhOjyv4Ykh0MVzFTzTzbsq/yqd0Lfz7MCvX5xdUFmHnLtg3cBeIi+qPpRswckOssrI1ZD0mGUVvTw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d29bb221-4b57-4cfa-73b1-08d69bc53947
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 08:34:24.2544 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5645
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
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 Vabhav Sharma <vabhav.sharma@nxp.com>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add compatible for LX2160A SoC,QDS and RDB board
Add lx2160a compatible for clockgen and dcfg

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/arm/freescale/fsl,layerscape-dcfg.txt           |  2 +-
 Documentation/devicetree/bindings/arm/fsl.txt                | 12 ++++++++=
++++
 Documentation/devicetree/bindings/clock/qoriq-clock.txt      |  1 +
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape=
-dcfg.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-=
dcfg.txt
index b5cb374..dc76046 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.t=
xt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.t=
xt
@@ -8,7 +8,7 @@ Required properties:
   - compatible: Should contain a chip-specific compatible string,
 	Chip-specific strings are of the form "fsl,<chip>-dcfg",
 	The following <chip>s are known to be supported:
-	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a.
+	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a, lx2160a.
=20
   - reg : should contain base address and length of DCFG memory-mapped reg=
isters
=20
diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/=
devicetree/bindings/arm/fsl.txt
index 7fbc424..baef162 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -235,3 +235,15 @@ Required root node properties:
 LS2088A ARMv8 based RDB Board
 Required root node properties:
     - compatible =3D "fsl,ls2088a-rdb", "fsl,ls2088a";
+
+LX2160A SoC
+Required root node properties:
+    - compatible =3D "fsl,lx2160a";
+
+LX2160A ARMv8 based QDS Board
+Required root node properties:
+    - compatible =3D "fsl,lx2160a-qds", "fsl,lx2160a";
+
+LX2160A ARMv8 based RDB Board
+Required root node properties:
+    - compatible =3D "fsl,lx2160a-rdb", "fsl,lx2160a";
diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt b/Docu=
mentation/devicetree/bindings/clock/qoriq-clock.txt
index c655f28..f322989 100644
--- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
+++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
@@ -43,6 +43,7 @@ Required properties:
 	* "fsl,ls1046a-clockgen"
 	* "fsl,ls1088a-clockgen"
 	* "fsl,ls2080a-clockgen"
+	* "fsl,lx2160a-clockgen"
 	Chassis-version clock strings include:
 	* "fsl,qoriq-clockgen-1.0": for chassis 1.0 clocks
 	* "fsl,qoriq-clockgen-2.0": for chassis 2.0 clocks
--=20
2.7.4

