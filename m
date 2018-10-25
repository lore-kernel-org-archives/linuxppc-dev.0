Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53C0C46475
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 07:13:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A26C20834
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 07:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AdCP6PtU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A26C20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gdds0mqjzF14d
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 18:13:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="AdCP6PtU";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.6.77; helo=eur04-db3-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="AdCP6PtU"; 
 dkim-atps=neutral
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60077.outbound.protection.outlook.com [40.107.6.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gdNC1s82zDrWV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 18:02:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MALEO5ltLd+Bp7OEryabJF+FlyngHm0DrJeZKbB87sM=;
 b=AdCP6PtUWg+QOgh3CqorQJtyRNAZ0ZDjrZKqx7hW41oiXxICLwWBiYAwgpGegiVVByn61AbVFk//N4EqXByBm9uTSpAvtWtHlV9HWg5KSaC6BbUgNiVja12JqbGaqnnqxpITYR7opoDeGuIsEkvYex31NrOehT79UcSSzObznVU=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB0909.eurprd04.prod.outlook.com (10.161.106.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Thu, 25 Oct 2018 07:01:54 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca%3]) with mapi id 15.20.1273.021; Thu, 25 Oct 2018
 07:01:54 +0000
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
Subject: [PATCH v6 4/6] clk: qoriq: Add clockgen support for lx2160a
Thread-Topic: [PATCH v6 4/6] clk: qoriq: Add clockgen support for lx2160a
Thread-Index: AQHUbDCc0zkWJqs0YU6lPEAT1AT4FQ==
Date: Thu, 25 Oct 2018 07:01:54 +0000
Message-ID: <1540407376-24115-5-git-send-email-vabhav.sharma@nxp.com>
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
x-microsoft-exchange-diagnostics: 1; VI1PR04MB0909;
 6:VH3knDkhbyxSX76dDWDUYWakPribYt1h+EB2xNmKkZZLcZt88C+9iHdAT3NAelyNe8OSnCFmJlKYme/LHZtztIndFekTEJNHbsBQzZXDt4ujpE1Vgw+/jimeFlWWw2JOwq49YEaMrAS0Tqmklenm0DkBhKVRpfU9rhOeL0R3MSMTFUssPJ06rXA80uoZ7Jre3rzHLwk6OUSnDS+7K0cdfiKtRwHRl0yZJ67s5quGNwQJ7FAumSHdb+iaW82qZR9n0wRkPEeJjVJDALYmG1FmvIjtn/yRWrKNeSS2HYYyUNSzmJHH//VAGT+HlCxnImmSiqCuL7/wnOTwT0G99BB5tc6QLnZVzoejBaea9ZQiI4hoqxWjFkbPQodUUxGO8dWVm5WHUe0rROM78RRCFRwjvwJHMv6ksLZeXwC2ql2tMmIVTq475K5hEtSHJwZ6IkSlVv62oKhwB3Eu3oGxXTJSDQ==;
 5:tG4lBU9gFmD+dIvK0hGrgQa/8FbDHqAfWO1EM6+K68AnB3JqgN7Uf7lPhb9QFyrdRqei/IpygXd451izaM3kipAazpQKTpAKutikP8Pg9ZGPjPjbi+SX4ALernnjb0hzGwhfHwmsR7Y0vRyuptLjVR06wVmRmedc5eON59hrnxE=;
 7:/zA1ShNwAHBR2uFK6ZqaMDPZt4U4bHfJKj21ZHzwBjUgybm/79laXpvmOcZqUdlnx3lc0L80waOPlejR8bc8/2Z1fWzB9TszVMZ7c6Dcz/7eIfkw6uE3fc6WWNXtcTORm0a39Ljt9fli6I2dLSIh4Q==
x-ms-office365-filtering-correlation-id: 0c12bb51-f051-455d-fc5e-08d63a47beb8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB0909; 
x-ms-traffictypediagnostic: VI1PR04MB0909:
x-microsoft-antispam-prvs: <VI1PR04MB09093F748D84E3A38A618AE8F3F70@VI1PR04MB0909.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB0909; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB0909; 
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(136003)(39860400002)(376002)(396003)(189003)(199004)(186003)(478600001)(5660300001)(14454004)(4326008)(25786009)(7416002)(105586002)(106356001)(36756003)(26005)(110136005)(3846002)(6116002)(6436002)(2906002)(102836004)(55236004)(316002)(2900100001)(305945005)(66066001)(8676002)(99286004)(7736002)(6506007)(6512007)(386003)(81156014)(8936002)(52116002)(81166006)(53936002)(476003)(54906003)(68736007)(6486002)(256004)(2616005)(97736004)(2201001)(44832011)(486006)(86362001)(76176011)(5250100002)(11346002)(71190400001)(446003)(2501003)(71200400001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB0909;
 H:VI1PR04MB4800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jIGFEVha+Z8bH70iOCSxzHr7lztBI1LcPQWhXKLGEy3xbKMSDYE9G1LK0HMKH7WTu8m5Gge+fwnl7JR0MiWnhKrXnV38CmHPeFYIUGtR4Rc5xd4o/mgXFWAISe1MFIUfx4e45wKMf4Z8s2Arc/QgrtzSaawHtF2mXAZRoLisvAVT1ATpeEi73VqUcCcnHNjKPnnOHlp8Lhnx3pZCuKUCbddMiOpkwasnqUwS9CcSV1z1cMcDWfd44R2THlkpuykkARh5xDL8VgkYeGvKx5J2W2RjLCzACoaUqUIqrBxUbU3mWCu1GNuY+ncpH6ZCb2Fp9wU9hkUYwvd4w6r9J1nVjBmHLlnO+i7lYNq5kbicGCY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c12bb51-f051-455d-fc5e-08d63a47beb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 07:01:54.2480 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB0909
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
 Andy Tang <andy.tang@nxp.com>, Udit Kumar <udit.kumar@nxp.com>,
 Pankaj Bansal <pankaj.bansal@nxp.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 Varun Sethi <V.Sethi@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

Add clockgen support for lx2160a.
Added entry for compat 'fsl,lx2160a-clockgen'.

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clk/clk-qoriq.c         | 12 ++++++++++++
 drivers/cpufreq/qoriq-cpufreq.c |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index e152bfb..99675de 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -570,6 +570,17 @@ static const struct clockgen_chipinfo chipinfo[] =3D {
 		.flags =3D CG_VER3 | CG_LITTLE_ENDIAN,
 	},
 	{
+		.compat =3D "fsl,lx2160a-clockgen",
+		.cmux_groups =3D {
+			&clockgen2_cmux_cga12, &clockgen2_cmux_cgb
+		},
+		.cmux_to_group =3D {
+			0, 0, 0, 0, 1, 1, 1, 1, -1
+		},
+		.pll_mask =3D 0x37,
+		.flags =3D CG_VER3 | CG_LITTLE_ENDIAN,
+	},
+	{
 		.compat =3D "fsl,p2041-clockgen",
 		.guts_compat =3D "fsl,qoriq-device-config-1.0",
 		.init_periph =3D p2041_init_periph,
@@ -1424,6 +1435,7 @@ CLK_OF_DECLARE(qoriq_clockgen_ls1043a, "fsl,ls1043a-c=
lockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1046a, "fsl,ls1046a-clockgen", clockgen_in=
it);
 CLK_OF_DECLARE(qoriq_clockgen_ls1088a, "fsl,ls1088a-clockgen", clockgen_in=
it);
 CLK_OF_DECLARE(qoriq_clockgen_ls2080a, "fsl,ls2080a-clockgen", clockgen_in=
it);
+CLK_OF_DECLARE(qoriq_clockgen_lx2160a, "fsl,lx2160a-clockgen", clockgen_in=
it);
=20
 /* Legacy nodes */
 CLK_OF_DECLARE(qoriq_sysclk_1, "fsl,qoriq-sysclk-1.0", sysclk_init);
diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufre=
q.c
index 3d773f6..83921b7 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -295,6 +295,7 @@ static const struct of_device_id node_matches[] __initc=
onst =3D {
 	{ .compatible =3D "fsl,ls1046a-clockgen", },
 	{ .compatible =3D "fsl,ls1088a-clockgen", },
 	{ .compatible =3D "fsl,ls2080a-clockgen", },
+	{ .compatible =3D "fsl,lx2160a-clockgen", },
 	{ .compatible =3D "fsl,p4080-clockgen", },
 	{ .compatible =3D "fsl,qoriq-clockgen-1.0", },
 	{ .compatible =3D "fsl,qoriq-clockgen-2.0", },
--=20
2.7.4

