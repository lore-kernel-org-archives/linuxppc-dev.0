Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7F9C46475
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 07:06:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92EB420838
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 07:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DLjwy7MS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92EB420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gdTQ4F4yzDrbV
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 18:06:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="DLjwy7MS";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.76; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="DLjwy7MS"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00076.outbound.protection.outlook.com [40.107.0.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gdMn6lCczDrGC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 18:01:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuQtNhKpFm23DHDZMGE8e+19SH9rALkPy5bBAW+Zoyg=;
 b=DLjwy7MSFhlIqJT4R9WWeL34loFsB0sL8ugA4WRtN6YS8o/qlvFrSpFA2/UCkRg5MaatgLX4PAIe/Ez4mB58I0qzHN4++WpdqbsVFOkls529ivJgbTJzHTJZQA3NZkrpsFwuxGoYw4h9SQI38jlc+4f1IENnb7yCO8aJM9YRYP0=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB2077.eurprd04.prod.outlook.com (10.166.43.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.20; Thu, 25 Oct 2018 07:01:35 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca%3]) with mapi id 15.20.1273.021; Thu, 25 Oct 2018
 07:01:35 +0000
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
Subject: [PATCH v6 1/6] dt-bindings: arm64: add compatible for LX2160A
Thread-Topic: [PATCH v6 1/6] dt-bindings: arm64: add compatible for LX2160A
Thread-Index: AQHUbDCRG5m/d7gNDEangw6XyBm3MA==
Date: Thu, 25 Oct 2018 07:01:35 +0000
Message-ID: <1540407376-24115-2-git-send-email-vabhav.sharma@nxp.com>
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
x-microsoft-exchange-diagnostics: 1; VI1PR04MB2077;
 6:z6zZYNklj3qj1X6ukCCjYAeE2oDHSx/WBx1oUGmimF81NhYSfP80N5iZxUJUW6xXM4oKHCluRRSwTji7/dQsySz3tTEQK+8xc/3/+9FtgDB+RJauTbusLzzY8fRGMgO4v3A+wlqnRlMS9EdiXsQh+4gwNeEyFr4eGbZ0u3LWv/zWM4ZI/spwjC2+qMEHTuIi3kar+uIjIq0O6S+/zmEllaXsyM5NzkjplOWA3mmzOPlzu1ybvgIDXz0S8yHSj20kfuJmuhWeZKw0/X05jlY5R0nusZbfZi81z7V5xi7I4+5ZgGC+VqwRbsHiRYIcGQS9ohieLXh/b3aRFGqqMHki6TNuE6b82uMVvEcB/2JRvAMO1BUc6dBlyJ/7SslfmXOAT5iONS5mUmT4JuxIpp7hWonjgj2ovnHZ/SgBb0ROR+qluCgwC6H6GTdlRc53nL6GKRyFoxjbHczKeIFi+WUjyQ==;
 5:APSjBEJ5A50ndvJH0muCb8Nj7iXttGAeVAeQsLx0/vZ8fO+jfpmb/g4hugdVqjgfk/JctHtd0vCWodhz5N5dEshiJGY2QhOPCCyohLkjX/zuhADttOMTDii2pRxhza4JfdqfxZ29gNp0oSyc5pjVMsAWnJ84QFMooRIqv7VpZJs=;
 7:IAqbxOSpqJSq/pUvp/B9H3CVGbj1HtbUUCwmxxkknpMk3x2MI9vB5aPdExmYzQ95Ui9A6tyW6Ja4VvpNrKaEumcwal+RzW7rjxy3Kfoplipk4YtMz+3mocTpdY7vtfHyCmKnbmHAK7fOT18zcsseiA==
x-ms-office365-filtering-correlation-id: 809bc56f-6ee4-42c8-23ac-08d63a47b355
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB2077; 
x-ms-traffictypediagnostic: VI1PR04MB2077:
x-microsoft-antispam-prvs: <VI1PR04MB207765F471AF54CE0CD0643FF3F70@VI1PR04MB2077.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB2077; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB2077; 
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(136003)(366004)(346002)(376002)(189003)(199004)(5250100002)(2201001)(446003)(81156014)(476003)(68736007)(97736004)(54906003)(4326008)(86362001)(5660300001)(26005)(102836004)(478600001)(6486002)(81166006)(44832011)(316002)(2616005)(25786009)(11346002)(486006)(36756003)(7736002)(71190400001)(110136005)(99286004)(52116002)(7416002)(105586002)(76176011)(14454004)(71200400001)(386003)(55236004)(8936002)(6506007)(2906002)(256004)(106356001)(6436002)(14444005)(186003)(305945005)(6116002)(3846002)(6512007)(8676002)(66066001)(2900100001)(2501003)(53936002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB2077;
 H:VI1PR04MB4800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: u3qs9bYNrqRinnGZatrjr7MFhe0pgU0yyiTDfVSv6/fodM79irO4RgBqeoUQI82kfHAkvqMOS1BOlJnCifkLufKZgyrZWFfFfI1XfPBMW9sxz71Euu8E3IW1kUYTu+/h46DDNNpoTCyzZ0GNlwyLuHjrdnV7QzU0zdU24qpW1hRjBzAAExnfzAZJv3vHy2x3b7KkksyZTOVnPqbI32aUosc2nPP43FHy3rf1fSDYfxOv2xhXaPYK/M9aHu59Cs3piueTq4/R0+iKGzQ44PFxVL+1gZ1OoTAq+VY5JgI2p5eNYo++YiU779HpOsxf+xVvCO3tfrfPtefPEmIuq8mqZLKcsO6RRy860x+55m0NY7A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809bc56f-6ee4-42c8-23ac-08d63a47b355
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 07:01:35.0762 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2077
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
 Udit Kumar <udit.kumar@nxp.com>, Pankaj Bansal <pankaj.bansal@nxp.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 Varun Sethi <V.Sethi@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add compatible for LX2160A SoC,QDS and RDB board
Add lx2160a compatible for clockgen and dcfg

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.txt           | 14 +++++++++++++=
-
 Documentation/devicetree/bindings/clock/qoriq-clock.txt |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/=
devicetree/bindings/arm/fsl.txt
index 8a1baa2..71adce2 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -130,7 +130,7 @@ core start address and release the secondary core from =
holdoff and startup.
   - compatible: Should contain a chip-specific compatible string,
 	Chip-specific strings are of the form "fsl,<chip>-dcfg",
 	The following <chip>s are known to be supported:
-	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a.
+	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a, lx2160a.
=20
   - reg : should contain base address and length of DCFG memory-mapped reg=
isters
=20
@@ -222,3 +222,15 @@ Required root node properties:
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
index 97f46ad..3fb9995 100644
--- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
+++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
@@ -37,6 +37,7 @@ Required properties:
 	* "fsl,ls1046a-clockgen"
 	* "fsl,ls1088a-clockgen"
 	* "fsl,ls2080a-clockgen"
+	* "fsl,lx2160a-clockgen"
 	Chassis-version clock strings include:
 	* "fsl,qoriq-clockgen-1.0": for chassis 1.0 clocks
 	* "fsl,qoriq-clockgen-2.0": for chassis 2.0 clocks
--=20
2.7.4

