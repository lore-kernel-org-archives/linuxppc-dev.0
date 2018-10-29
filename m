Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894AEECDE44
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 09:07:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07AE420664
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 09:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HaGLd1vd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07AE420664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42k7yl6XW8zDrMD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 20:07:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="HaGLd1vd";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.6.81; helo=eur04-db3-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="HaGLd1vd"; 
 dkim-atps=neutral
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60081.outbound.protection.outlook.com [40.107.6.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42k7lj3XfCzDrP2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 19:57:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Tw12xB1ajkqPXg0EQ6CyGxy6i6KHRsX+WOfIzWGsZE=;
 b=HaGLd1vdpl/tnS0aKIYmIn1q8x97sjwplw2xYQtVvQhbzpcg32zQSDsnKYmHFil9bj448zuewzFh5GBtIFVjs8tawxtuINKPNvFoshB7KAf2V9WT0AsycXwI0hcxI5oOQKbE/+w1QfGcyDhZw3glZABGzZ4H9K4zxc4l26QIE10=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB4255.eurprd04.prod.outlook.com (52.134.31.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.27; Mon, 29 Oct 2018 08:57:34 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca%3]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 08:57:34 +0000
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
Subject: [PATCH v7 2/6] soc/fsl/guts: Add definition for LX2160A
Thread-Topic: [PATCH v7 2/6] soc/fsl/guts: Add definition for LX2160A
Thread-Index: AQHUb2Vu6PkGjw9WQUyVBNIL+dO1VA==
Date: Mon, 29 Oct 2018 08:57:34 +0000
Message-ID: <1540759926-3641-3-git-send-email-vabhav.sharma@nxp.com>
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
 6:NbcVo5BupsnHEMN7P15c4eyCY65EsRzBi5wGzJoHFEsZ7AMXJ+ZPagskJ4oHQQBv+7nq9FUbhQsWcfi7ZCzwgottmPE5trKQr56dbI4dq7WiMBI4dEhpOgcS6LOA6Hn8qVdzENOCnJBkWWTcndVvimlgEb4dVGBZMRw1r3/WpYwoHJmM2exvjnwGqsMWW3iZlutEPeRk/dnrcaHf0QtAX+3f5RAw+2g6pqSE9AfJKsnTzMtpnq1scFcOfhl8Jgi60/qC7WRZ+UtvuYeUg3o8s+7CW7mb9eWejVy3fL7ifqS+ScddW5WW2+LfYpl3DKufsP1o4K+F0+rCnjphJezWSU5q0yHqF4sDP+zvEeaol7Op2mXw5YHC18NAEElmdmuAMwsYc+71g0N8Z01efBIwU6I/J+krI0plfgNFA6Yz1RI0QFjGvkHZTrD8AAV+ZLmczpwhhnXOYym36WJHvcA7dQ==;
 5:9yAzB0wZl1VzJ2MoRQDi+zvyGsze+U0lRZwL8lgUysdDatzbGCeX6UkGlsS7RgUQiawu7PUYIoFz91mBXg+sMTiKF4hR2ohuxSvYKB/myLX9oNiZ3VSDauqDpYnmn4U9b6x3ILAbCg20QwP4AefMia899xpxLYGvjyzvEV3SkvY=;
 7:Kz6NkGTkh+KC39MVYJslBJMGgknJZvaDO6Mz9o8J6+AVBPdA0JZlQtic4hQp3DS+2yQ3lhLN7HyA33Td1NsIdHkC1zO0Kt99RqHcyEys0exBBtAcjvkR70m0ppM8Wudic7BSvcr3nIOq5rgv2Iq8ug==
x-ms-office365-filtering-correlation-id: 6e77df88-0144-4be9-c447-08d63d7c9139
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4255; 
x-ms-traffictypediagnostic: VI1PR04MB4255:
x-microsoft-antispam-prvs: <VI1PR04MB4255C69BF14977AA21C40A03F3F30@VI1PR04MB4255.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB4255; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB4255; 
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(346002)(376002)(396003)(366004)(136003)(189003)(199004)(575784001)(6486002)(2201001)(53936002)(478600001)(256004)(86362001)(3846002)(68736007)(6116002)(7416002)(305945005)(71200400001)(71190400001)(7736002)(6512007)(6436002)(106356001)(476003)(55236004)(386003)(316002)(105586002)(76176011)(6506007)(186003)(25786009)(54906003)(2616005)(4326008)(11346002)(5660300001)(44832011)(486006)(446003)(110136005)(5250100002)(14454004)(66066001)(8676002)(81156014)(2906002)(81166006)(2900100001)(99286004)(8936002)(26005)(97736004)(2501003)(52116002)(36756003)(102836004)(921003)(1121003)(473944003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4255;
 H:VI1PR04MB4800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9bHPPgomkvqZb57OWXfxA6Eg6QOoCnYbDc2c+675DWQttUvfiwXAE3roKqDJmseMvm3IMzpm6mzNbzjZgOMetELCRGTGcN5f6bQ/zH0PdXtFO4GQVY3ZtOkwYbCbh1h4SBP4DBGo3JnHtu4osuND95tU3UxOg/7AmM5dT4Vn8RHdL0jsRjkxQNTOrXRzBijh778cVEGKCfJ+ZW4McwZeM2r2pNpB+jr7plKZTA9Jrk9yoDCyHxZbaEEUapdEiG4PRDOrWzDrqb3dcRzaVs+t8UhqOPS+Wugo+LKpdf5xjH30Ubi8F9INGVTtX1oVi42NY9hgXaCgMWX9FISoJ9lYM3SVfbb9RHBCOcnSzs6LQW8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e77df88-0144-4be9-c447-08d63d7c9139
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 08:57:34.5600 (UTC)
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
 Varun Sethi <V.Sethi@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>,
 Yinbo Zhu <yinbo.zhu@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Adding compatible string "lx2160a-dcfg" to
initialize guts driver for lx2160 and SoC die
attribute definition for LX2160A

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
Acked-by: Li Yang <leoyang.li@nxp.com>
---
 drivers/soc/fsl/guts.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 302e0c8..bcab1ee 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -100,6 +100,11 @@ static const struct fsl_soc_die_attr fsl_soc_die[] =3D=
 {
 	  .svr		=3D 0x87000000,
 	  .mask		=3D 0xfff70000,
 	},
+	/* Die: LX2160A, SoC: LX2160A/LX2120A/LX2080A */
+	{ .die          =3D "LX2160A",
+	  .svr          =3D 0x87360000,
+	  .mask         =3D 0xff3f0000,
+	},
 	{ },
 };
=20
@@ -222,6 +227,7 @@ static const struct of_device_id fsl_guts_of_match[] =
=3D {
 	{ .compatible =3D "fsl,ls1088a-dcfg", },
 	{ .compatible =3D "fsl,ls1012a-dcfg", },
 	{ .compatible =3D "fsl,ls1046a-dcfg", },
+	{ .compatible =3D "fsl,lx2160a-dcfg", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
--=20
2.7.4

