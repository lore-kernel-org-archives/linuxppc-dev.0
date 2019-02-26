Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558C4C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 08:40:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA662173C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 08:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pZOxzGQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA662173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447shS18R0zDqV9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 19:40:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.74; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="pZOxzGQI"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00074.outbound.protection.outlook.com [40.107.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447sYw4NBCzDqRC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 19:34:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7aI4QmtKuT1UFvH1OsoPAFh58Tw4TT19iR3rLotEHk=;
 b=pZOxzGQIdcfiodBX5XmSMP143wYgYpTWUh/BO3yUDNj1ZTLloU2aQrzMCXsA9RJcOsHBkdUotzKBvRUC+Y2yb+OlxptyfTSOpEA8EC7e/7C7CUCXWHw66FU1vsRInOv8zn3MWFZSfhGntNk82YZL3Pd/BkQsuydyOT/AcrM6Qyk=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB5645.eurprd04.prod.outlook.com (20.178.125.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 08:34:24 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::7437:2195:ffd3:a33a]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::7437:2195:ffd3:a33a%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 08:34:24 +0000
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
Subject: [PATCH 0/4] arm64: dts: NXP: add basic dts file for LX2160A SoC
Thread-Topic: [PATCH 0/4] arm64: dts: NXP: add basic dts file for LX2160A SoC
Thread-Index: AQHUza4TOTc711rzQESpWziL6V1yEw==
Date: Tue, 26 Feb 2019 08:34:24 +0000
Message-ID: <1551126463-5341-1-git-send-email-vabhav.sharma@nxp.com>
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
x-ms-office365-filtering-correlation-id: 1d8e6be2-106d-4395-4cf4-08d69bc5360a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5645; 
x-ms-traffictypediagnostic: VI1PR04MB5645:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB5645;
 23:JQwkxwDpdiJ7YKUnterg8q9tRDyFw+6Y4lvJLQg?=
 =?iso-8859-1?Q?sPpuqdMEZW6/ZIP8AuB9W1t7kt1A5dFNS2QuAS4dcgDWrWlQ7Qi0USbpUD?=
 =?iso-8859-1?Q?W8wbvB3yTF1lFSx816vtS/2MAs2pgc+2g8WpnDMjlKywgL/6zqgt0QgeTX?=
 =?iso-8859-1?Q?fsHErxZT0gCBQxQFWi1f9hwc7eLvs2xVGgfSYRnVS6EtepzQxzmPdFwunj?=
 =?iso-8859-1?Q?fN8UlO2BXRnqFWlSw9Br7dvBVmaaasMTGQCeN75VeBFi6O03fuf93l0t/I?=
 =?iso-8859-1?Q?e79O03u8/ETnYkurDS0CKHea65TVgmmZAIew6ZZ+hFYIwfyIauGwhGKCxu?=
 =?iso-8859-1?Q?sZUGursdP1y7LwxZwoAnURwJuxjT6rMQmUTSUsiRMdtl2uxV5ljGxhAkw5?=
 =?iso-8859-1?Q?W+EO8SmBG6zs3n+DAt4ElXe+JH37nsXlJVTvje32yGu3YFYFwi0yZ3TOt8?=
 =?iso-8859-1?Q?8fdJVE5TqQdqlUtj7HivkgTmdHpBz88/ye3vlzu7W3nxn45oNwZqO76Nr7?=
 =?iso-8859-1?Q?SEdTTZlKC8yz4njRYfk4ElQTmC+0dCTcohef4YqFkSSgHitOVeOecJXml/?=
 =?iso-8859-1?Q?gc/jbbEQsS04l+icQDV9Q9J9fG1o/MmrCQrJFhmMbuHPXEr3u3V4qnJbJ6?=
 =?iso-8859-1?Q?RTOecyF/7VayTGoRyDlpWsjjfjgpRh+2LHEOx6Bcp5UJtVptk50A4PmZxj?=
 =?iso-8859-1?Q?OkMLxE7T4zLw21dvrM4SLzU77xqOdIPGqfTRhPafqmw9w46wywCLNGk/eX?=
 =?iso-8859-1?Q?Rt4qEaZmcSY58nZoIDUKGFVeBkwzRBCfHe8IMFAiVXGSNBxD5EVo5Yjim8?=
 =?iso-8859-1?Q?jDlAi7pOk88uJEZ7xvbJv5sOBghkYRwSqMvI1+WWHUTJZN3/RiqjvoG0Lt?=
 =?iso-8859-1?Q?K+RMRcJjK/PZ9iFuFv3cM62Lz/pYEpQih0khZMLmCY8uoH2cO1Hip4qNxa?=
 =?iso-8859-1?Q?OgrRUaNQUutOF9NOYJDTsxNmyjAWoYbaRyGKw/wDkgVOOJcGvX0lmonz/q?=
 =?iso-8859-1?Q?9c8QjXSOPa4c1j+BMDzNsL0Eq19fsbYj/m2b3P60UjNbTuab45OJNf7gnE?=
 =?iso-8859-1?Q?YUdBgiYzVCJhA5ySRbkYPZf3cCC/mWHQhKeV2ntY11hz1z6YbduaAII0/R?=
 =?iso-8859-1?Q?A8ADJcJhiG1J33oGNGXMbcd4QIQSPoPDAOh1ddwdN/Do1zkD6PMnJyXIwf?=
 =?iso-8859-1?Q?dM2Kop4Lj86InkKznw4DdKUr7Td4WPder7j0PK4+8Mru3sdKRXcbvPgwJu?=
 =?iso-8859-1?Q?C6NG46UrOhLc0e9FozimlJiw30hn2XZGsNQTGCkP6yCKtd6N6pzsUscgpR?=
 =?iso-8859-1?Q?K2cbJWAN3EMEBCbetY8Vbsc618eafk97VegSZgIBjH0Jw=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB5645A0662BD35B0917C58518F37B0@VI1PR04MB5645.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(396003)(136003)(39860400002)(376002)(199004)(189003)(66066001)(966005)(71200400001)(71190400001)(6306002)(2906002)(478600001)(97736004)(6512007)(50226002)(8936002)(5660300002)(54906003)(6506007)(99286004)(386003)(102836004)(2501003)(53936002)(110136005)(2201001)(52116002)(86362001)(68736007)(4744005)(316002)(6436002)(2616005)(476003)(486006)(7416002)(7736002)(44832011)(186003)(81166006)(8676002)(81156014)(3846002)(6116002)(6486002)(4326008)(25786009)(256004)(106356001)(36756003)(305945005)(26005)(105586002)(14454004)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5645;
 H:VI1PR04MB4800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KgnfgoM/dfNzKGpTEfLeRX+T+b6CQfXd4tcf31BAhac0GBrw1cnnxs5XfcEuJVbCBRlEDIJbbIF283oCceo4aCLUWcoA6upPH7e904CNhdNqFQq9I6ebtkGwgYfdJvvx/YKkIibkek4w41xCIzGh7Y9BEVv1wxl1vG7ZkY/vwJiyX1jiI3e6AMnmnjnM8kRmtoLQgfsHY1WsKpvnNpCanTlK2wDqazZ/3yao9Z5GxQ6NBPrjgWC1cYHF9or1sNHby07p6Dy4lDiFpNUmrrd+SXzu5/RfwOGi/FdYqqJhRxa1Mj+kXHXnWHiQPPlYr4m/n0/7voSF7HiYdrIP9/u/ByPrpBL0i61IkA3ZBRAousNH3rSApa2Qf6CsA/IYMOodKZGPfdZO/wi8pR8AueasklJx8wpbNizlKDJK+7WHdws=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8e6be2-106d-4395-4cf4-08d69bc5360a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 08:34:18.8336 (UTC)
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

These patches were reviewed and acked but dropped during merge window.
Patchwork link was https://lore.kernel.org/patchwork/cover/1004155/


Vabhav Sharma (2):
  dt-bindings: arm64: add compatible for LX2160A
  soc/fsl/guts: Add definition for LX2160A

Yogesh Gaur (2):
  clk: qoriq: increase array size of cmux_to_group
  clk: qoriq: Add clockgen support for lx2160a

 .../bindings/arm/freescale/fsl,layerscape-dcfg.txt       |  2 +-
 Documentation/devicetree/bindings/arm/fsl.txt            | 12 ++++++++++++
 Documentation/devicetree/bindings/clock/qoriq-clock.txt  |  1 +
 drivers/clk/clk-qoriq.c                                  | 16 ++++++++++++=
++--
 drivers/cpufreq/qoriq-cpufreq.c                          |  1 +
 drivers/soc/fsl/guts.c                                   |  6 ++++++
 6 files changed, 35 insertions(+), 3 deletions(-)

--=20
2.7.4

