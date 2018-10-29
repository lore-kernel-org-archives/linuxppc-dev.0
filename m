Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48186C2BC61
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 09:05:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D80D2084A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 09:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p6DKPm1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D80D2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42k7w94mC4zDrPy
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 20:04:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="p6DKPm1q";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.6.81; helo=eur04-db3-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="p6DKPm1q"; 
 dkim-atps=neutral
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60081.outbound.protection.outlook.com [40.107.6.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42k7lg5nw9zDrMm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 19:57:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuQtNhKpFm23DHDZMGE8e+19SH9rALkPy5bBAW+Zoyg=;
 b=p6DKPm1qnrk3S7kCE8MvaSuQAhmQW3BWYIAEUaCnxp6bPl0PnssyO16aIzkgnxZwM89T5Vwy5pp1Zp/0qbtdJ6b0WWFrsglLkFqpiSM8hfw85exd/QUTXxAudA0bQMIRFSGCldHHZDMzGoO16qtwNl/mu/nam0lvQ5Ys/O0eV2E=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB4255.eurprd04.prod.outlook.com (52.134.31.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.27; Mon, 29 Oct 2018 08:57:28 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca%3]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 08:57:28 +0000
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
Subject: [PATCH v7 1/6] dt-bindings: arm64: add compatible for LX2160A
Thread-Topic: [PATCH v7 1/6] dt-bindings: arm64: add compatible for LX2160A
Thread-Index: AQHUb2VrKUhZBLtdAEODhC83fS4ZAQ==
Date: Mon, 29 Oct 2018 08:57:28 +0000
Message-ID: <1540759926-3641-2-git-send-email-vabhav.sharma@nxp.com>
References: <1540759926-3641-1-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1540759926-3641-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::14) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB4255;
 6:22J+MYvPq2VjtAMSQcF7zEIB7l332CTmVMlGVH9qlGm0BFzcmPkli0aKWvg4lDTo/U/Lj/4PM2VmwUTsnYf8/CZC1hoq+RabNrr6bG097i/5HF5cHqxrr8E3OWoGrG716K9dcn4LZgUrTS0+/3GmEH+tCqgC5bIUXWbNrYLSMagN+1NOpvZ12PkDrkzwjHrNz9fTcJearwdm6mDAq7GPxpDRxxI76TLi2Zvv4qRH8AHVCb/Jbg52oAyPGB0IeKeefYOH5/hva/2hkV4AzpxYuQhugbOJdnE4KqRUIjcDKLCGAehiX0ie+uierAoaaA22fBhSKsiGq9XIXf5m8/Vc6pSJbNtbY/cS52VZdjfGLLWzu6xiXTgojIQGy+rB+8397P4fBFU9GTg7j0mbl1lwEwg1D8UuRqoDPVbY4uRRA8XEOreXWKdulRuUuXELcv75/jAR2QDPnFb2Dj/Z5G24kg==;
 5:DauVEuynnY0DcKxAeYWcVmoXDNQgHn1e0Q/BZhu3z3dDQUCmlIoVZuRvdWnB3bA2sXkM7aaCQJqepasfCCT8K/XgFZ1K7wz+gS++zmNa57tVL8kU1QV7SIuu/NxYDgtGHrJZzNyrNxt0spuKoa0ecRmQKVJtvZ1g92iMIvMj0hk=;
 7:LMlhGN4tLOiSFwzhUH8Ozvd21ktFnpmIJ8ykZ2aGkJuF3UVYZm2SjoMhswY4wHCLofE5LqzGp6fvb9Hd65PXKlijC3DqEtOXZFxVxJDa8V/Ej4IqDpN+vE4ifiMd0iXVx1ApyKYD2npOyRHnyCvHeA==
x-ms-office365-filtering-correlation-id: 0e08e758-11f8-4041-a206-08d63d7c8d89
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4255; 
x-ms-traffictypediagnostic: VI1PR04MB4255:
x-microsoft-antispam-prvs: <VI1PR04MB425577B0934D42B37A3D61BDF3F30@VI1PR04MB4255.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB4255; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB4255; 
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(346002)(376002)(396003)(366004)(136003)(189003)(199004)(6486002)(2201001)(53936002)(478600001)(256004)(14444005)(86362001)(3846002)(68736007)(6116002)(7416002)(305945005)(71200400001)(71190400001)(7736002)(6512007)(6436002)(106356001)(476003)(55236004)(386003)(316002)(105586002)(76176011)(6506007)(186003)(25786009)(54906003)(2616005)(4326008)(11346002)(5660300001)(44832011)(486006)(446003)(110136005)(5250100002)(14454004)(66066001)(8676002)(81156014)(2906002)(81166006)(2900100001)(99286004)(8936002)(26005)(97736004)(2501003)(52116002)(36756003)(102836004)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4255;
 H:VI1PR04MB4800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +syF1J9DTfyUFKN+3u9O8Ap+q75/OgYf0OrQu9aFSdXmO3uHLAibi8HlBwp0UCeuIMYbLH7/H9FmsEbujdcFUDbXJhpphp6ec+01H2H2c8LavWiZjhVyFvl+9cl/oEs4rl3dJvKE3ja73df/PA2V2tQ0SiUNcarctQYtqy+L+cpDOWBxhrzYEmteQf67qjy/mrtnjc3mtnekz5yxclZuRHrNTqTw2jbUFn68CqlrMcs6EXf9pnK6HWZW/mADshEK2jaMC+Y50X1ogUu/XfQlvsZ+QRs1c/Vt7IkIWl6oitSgsVZeo3LO8UWR8t1ngFbLz8L+jBBaHxo3RgtWRXo3cdVUAUQc2/3qoNcxiUCCn0g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e08e758-11f8-4041-a206-08d63d7c8d89
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 08:57:28.5287 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4255
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

