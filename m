Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B11AC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 10:14:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C412147C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 10:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U9UDMNkr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C412147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447vn60y3kzDqXw
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 21:14:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe1e::61d;
 helo=eur01-he1-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="U9UDMNkr"; 
 dkim-atps=neutral
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447vj318tqzDqQr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 21:11:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WG269VoNS5sKeqRvSDeU13wX2mT/JDfn6uqCW8w3biU=;
 b=U9UDMNkrlFJmljUgBrfL8rerkJwxWBLePNFWkloL27sR7LbItc4sHFHwIKasnXHlf9CdA5E4eTBGrxc9s5jFP7YgD95Wd8YqYev0w78EEE0sTzXcHAH2LZ52L8PybjgXjHoXKzGbmabDCEPj0x0UKhQLoDhi+AH77Nz9+M4panY=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 26 Feb 2019 10:10:51 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::7437:2195:ffd3:a33a]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::7437:2195:ffd3:a33a%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 10:10:51 +0000
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
Subject: [PATCH v1 1/4] dt-bindings: arm64: add compatible for LX2160A
Thread-Topic: [PATCH v1 1/4] dt-bindings: arm64: add compatible for LX2160A
Thread-Index: AQHUzbuN4akhuqbX10Ke5fel48DmPg==
Date: Tue, 26 Feb 2019 10:10:51 +0000
Message-ID: <1551132245-6089-2-git-send-email-vabhav.sharma@nxp.com>
References: <1551132245-6089-1-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1551132245-6089-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::21) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [92.120.1.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8741c6a-141d-47c9-c522-08d69bd2af87
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5726; 
x-ms-traffictypediagnostic: VI1PR04MB5726:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB5726;
 23:LLueLWAyrlECdw1axX8h+doQxCkcHteHFlmWSnb?=
 =?iso-8859-1?Q?v4S5I9gU+G74TKX0Fefd8HDzmvx+Pr6FfSWP4j9AO+FW1gAMVgWYGxpull?=
 =?iso-8859-1?Q?qmYsNZCAETiXvfVDtQf3XBerEFMQNdu4zX2zkuz4KW8am+hlBNp0AQA/8K?=
 =?iso-8859-1?Q?RZ7qJifK9Jhtw5X0VDuDxw41kOzRUyZWbWRkn5bcakiS8USBMRzPA5gq9a?=
 =?iso-8859-1?Q?zaupXWCeBAu0pmmuMoilBQk6QvOiDVYHva+OMmgVz49cIYu2UlYWSpFpf6?=
 =?iso-8859-1?Q?dC6Q1H1J3T2evATJGHu2QYvo+wL1X4rRQBBeCKx+BuZo+/T0G+ZsKpqENS?=
 =?iso-8859-1?Q?EEMluj1ePb9NgkPa8UgmT/Mdg2X3AZ6jZvAPlUsoMw7fEQEZHqVPY/oq6F?=
 =?iso-8859-1?Q?Q5lPVsRCC2ZDTmTZ1N/thJ2cKsIfnrRiVEdKW9l/XsBxC3XDXvdYTSy7TO?=
 =?iso-8859-1?Q?sKBsJqDatkDRrzlwxwAaMxpktXqmds74ayXqM1BesctMTRxqogMiYx2t0b?=
 =?iso-8859-1?Q?nGjALqHUCHlN8E+kebTbtxtI10bS+CtkpbmsmO5m2tsjRlb+AhSUCxS1Fx?=
 =?iso-8859-1?Q?45IqeKAf3N2PqRR/PqLSSGOWhU5fN86nsLTCpzNRUI7wlpdbOwcUvDcnfY?=
 =?iso-8859-1?Q?pX2v0HXHm0UZO8xMkW6W8iAz3RsOfXT+jPwKdLg6VcLMw5WiLq1T3rFhhP?=
 =?iso-8859-1?Q?OXallBzqSyLDSDs8n3n4cxWnpXYwrGyMSLq/KpS1DczBfxIboB8daaeZzi?=
 =?iso-8859-1?Q?reiI7PGDB4Af+FuLgZAgkCrsUG4jX5qh/4LhxB7tGWMpX344oNzdAdOp3D?=
 =?iso-8859-1?Q?yPq82PiA/HEtiGPBsBNw94NIGgmJ2AMKQwqsZuidybQZ721a+N8hlQKSaP?=
 =?iso-8859-1?Q?Lus2/zbVJ2cQ7odAoKPtAuQfaFJutpSQ0iLba1UxW7WRgQsoH4OYmWD4/M?=
 =?iso-8859-1?Q?WT8ZVNV3h/RDEoWYtro4ZANNH5a0pqqMNWJDsK9dHGo/7GN9ABHd8qvcRG?=
 =?iso-8859-1?Q?bijSeYyfuL7KwILEoAD97y12tWGZ3aDZq+fwAQyrBSLTOHHrWxupDZ9g0P?=
 =?iso-8859-1?Q?z4CV74ohlWEtMcwUsye3KsqdJl6myXKw8MhpQOE7++Dt0dsFvjooKkihbT?=
 =?iso-8859-1?Q?zckCb8wuE9VRUD9iNnIq7NOSD6BbXlk/KjuFC8qtovNp2Tgni/XGI7anmp?=
 =?iso-8859-1?Q?gSGbXVdcA+K46yipoeh9f950Y0nMMvVW0NefUh6XTHTRhXhwrqDtsCR3zB?=
 =?iso-8859-1?Q?ECjgEguSpRdCY9S2Z+CUqTUqQZXJ86d5o5tfs5Mb5kz1d5fP/74sqPKsOY?=
 =?iso-8859-1?Q?wqNLEuZxSAfw1eG5lPSLtQR5FZAkDf7hpB+ooSDnMMKI7K2C82xeoEdq0O?=
 =?iso-8859-1?Q?opZz79mU=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB5726CE06A0C000CF7EBE1A3FF37B0@VI1PR04MB5726.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(6116002)(3846002)(50226002)(4326008)(26005)(99286004)(6506007)(386003)(316002)(54906003)(110136005)(8936002)(8676002)(102836004)(305945005)(36756003)(25786009)(53936002)(6486002)(81156014)(81166006)(478600001)(6436002)(44832011)(2906002)(6512007)(71200400001)(2501003)(71190400001)(66066001)(106356001)(105586002)(5660300002)(14454004)(7416002)(97736004)(256004)(14444005)(446003)(68736007)(7736002)(76176011)(486006)(86362001)(2616005)(476003)(11346002)(2201001)(52116002)(186003)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5726;
 H:VI1PR04MB4800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y6R3uF9isdD8O2bgyYl2GXNoDhN5BXIa8lM/pq6HEuhEpH4N/t13wWbn6hVk94c+XdqW/45uAwZFhYAU/wEgFcIr/G6JOROpZlleK3XxUUkSKxJrXZw0lLOIViwPhmOISdXDwOihYhMUHNNsDpWYc1CaAuPXMb73h0QnuFXT9UTm3RwalsI3VUbkwGcqGRAMMgXE+KrSUGKNLi0lu68Ueg+Ibi1iGRhv5sRg47u0RwDB/8Cu3tgWl+8WRLlmPHkJRAu9qEzI/TWmgeitV0wyBX5N5RJFxqXTsLEECug9FPCGo4il7ZXZ9HEFpcQqPOSMBMHo5udvzqPzhpvYLavTP1aAsCWVymdSoNLpW7bdEEkre0oFz2Lfa/WHj5cb0p7u5Wj8qsooegMovUo+tOTQ9i+BkxYVajH/DzAtKcT9sjY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8741c6a-141d-47c9-c522-08d69bd2af87
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 10:10:46.2949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5726
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

