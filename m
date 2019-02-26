Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8E5C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 08:43:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B0D820851
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 08:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fAhe/blz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0D820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447smT2rprzDqSt
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 19:43:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.13.40; helo=eur01-he1-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="fAhe/blz"; 
 dkim-atps=neutral
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr130040.outbound.protection.outlook.com [40.107.13.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447sZ03YlhzDqSG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 19:34:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Eh9bZ7fPwTvuq+JvMheQIuTmdboHpxr+blzrFJ/2Jc=;
 b=fAhe/blzlGYZAf5SEtMKwe5yDZcpe3gkCE0ThT9m7yG4T1HVDVcuxSGN5n9ksicHDb5V7h4XSwFXL2IsMnPY2bXM200vhpD46mVMJ711kNLHBJtv897M1kruIW18PgQIU2w44swkBgQpfKiysnsgk60+uFeQajZyk/Nv3b28Q2U=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB1645.eurprd04.prod.outlook.com (10.164.84.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 08:34:46 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::7437:2195:ffd3:a33a]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::7437:2195:ffd3:a33a%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 08:34:46 +0000
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
Subject: [PATCH 4/4] clk: qoriq: Add clockgen support for lx2160a
Thread-Topic: [PATCH 4/4] clk: qoriq: Add clockgen support for lx2160a
Thread-Index: AQHUza4hvZ73Kv/IW0iTEWsunnaw7g==
Date: Tue, 26 Feb 2019 08:34:46 +0000
Message-ID: <1551126463-5341-5-git-send-email-vabhav.sharma@nxp.com>
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
x-ms-office365-filtering-correlation-id: adf79c23-bace-481d-cb29-08d69bc54377
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB1645; 
x-ms-traffictypediagnostic: VI1PR04MB1645:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB1645;
 23:TehsCnGrBLBta51VOu47FsiLHP2EaAu/iylAI1i?=
 =?iso-8859-1?Q?sXN6tB8R/Ssz5WYhwtMx3IcuXIDnkiGKUZqP8LRiIhZEQTf/AsrXtppGbg?=
 =?iso-8859-1?Q?dW4hNYuuW5MDkMGY/+/rjqbkXk/imy69S/W6IJZeTxadr+3iQfkD5uAz3u?=
 =?iso-8859-1?Q?kbttnx6Ur1sqgiC9tTnJG6qKUHbkqgLSGnAZUAwbQY1ymM9wHsj16nbLXm?=
 =?iso-8859-1?Q?aHHhxtdHUmHpy8GdZEzxPAmj9YLQek7cIQQ92vcRw92k2CS/TNbIgw7Cla?=
 =?iso-8859-1?Q?rWYwfiW+m7zgKmkKev8fgna02HgCcKm+NqF/Oyha9WFL2RddAT4K7HOLs8?=
 =?iso-8859-1?Q?b3p5ArfwiaHv71pJN5b8xmIUPYWNEwb7Ogcqpco0JUpSvcrUFwM+t7Gu8p?=
 =?iso-8859-1?Q?fyFRdoIYQwRVoMraR5xTC0hdtBeU/J7ENenftFnkRrXJrX7pMKvJQptUEL?=
 =?iso-8859-1?Q?coMdlu3F56wmmNr2u6eY59R6arezg1VL78tvIuFf7jGLJkmrBTGpQUVJP8?=
 =?iso-8859-1?Q?Zn3SDL3hen95dL5LB5ZeFux6JvbVS/1U8PSUa5n9D7FVm6cqCUbwO/8ROt?=
 =?iso-8859-1?Q?Y95lxlG/5O7uIR+GUqzFavQaLjgfUWGXh5N4Ai6l+WU5+oP3h9AoG4JLsM?=
 =?iso-8859-1?Q?5Zp2fJpxRzki90zAaT1u4i69Ye+cIc2pyyMZPj0q8QxZS//3e1n3cDXUyf?=
 =?iso-8859-1?Q?RNI5j1i33NlTAaqC3K9oTSTrvCxnr3uZrUU4p6++0HdaJaFm0BhC9321Lk?=
 =?iso-8859-1?Q?Piso9yrL2fNSBuBDaCMOZJLgy1lHBChPkAv8YeRPIzce9TywLAZTEvq2Iu?=
 =?iso-8859-1?Q?NXcEKauPwB8hadh1trbmbt1crWu1Xjj8tZMsAvc2hBPJqa+qY1+qJrtPP+?=
 =?iso-8859-1?Q?PSGAGG9UftzM8LXld2mNbkJn8c3meIzUDk36wEKRBoCUXuRFo0E4nrPfB8?=
 =?iso-8859-1?Q?/FGVT7wQuZUfeTyEOEPQlrPZsL2IceOM1AKHhvXJhdww5+unI+zbMi2Ec5?=
 =?iso-8859-1?Q?i7+LHH3Fb3tBMROBldvPGlkGVJjxhheWFiNWaaVI4+sCOpegULpst4V0JH?=
 =?iso-8859-1?Q?rGQZjYfNG6aJl9JVu1h/0Y2OTC+SZZG7Ife6pF77paRZZUoQaB76Wk39rb?=
 =?iso-8859-1?Q?KCsOACcWp/qXQr5WNQ0Z0BdOMHPHbQhmYCQNFc+2d72SYCT+HzCoDFJnfM?=
 =?iso-8859-1?Q?+SYIR3JHPQr2oHnTxToIUUDuQyRI6Do3fprem1m0U/aWlPfgMzNeHAx6+9?=
 =?iso-8859-1?Q?j5lcGvv/nOwUaesg9wIGItV/vkJ2qpX9DuKrbGGCLOvD/M4d57/MDMG0//?=
 =?iso-8859-1?Q?S4/4y5plQcXaarG8rn4NW8kjhnvalwZB0sal6Wq+tMsDg=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB164539DBA6CCA74D30EA038AF37B0@VI1PR04MB1645.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(396003)(366004)(346002)(136003)(39860400002)(199004)(189003)(71190400001)(446003)(11346002)(25786009)(476003)(2616005)(71200400001)(7416002)(2906002)(97736004)(316002)(4326008)(478600001)(6512007)(68736007)(6116002)(6486002)(44832011)(3846002)(6436002)(486006)(2501003)(105586002)(5660300002)(106356001)(81166006)(256004)(386003)(52116002)(6506007)(7736002)(305945005)(50226002)(102836004)(2201001)(86362001)(26005)(53936002)(110136005)(8676002)(54906003)(14454004)(81156014)(8936002)(186003)(99286004)(76176011)(66066001)(36756003)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB1645;
 H:VI1PR04MB4800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KtGynWCfSWdToGQ4YMI1MRA/c6e+pWFAbms7/X45TXNpPFMQ8p0HQYpIzYFdL7mkBcXRIBgWA44a/jHw249T0zb/lV1Wp+Hqi/svlzbOilCT4yXxVPHsneSCMouMPB9XX6/PPXW26TzgCmR94Fn95W8R+vqp4AIBSGCzw+/IYXrbO3QflpMpCKGA7S0DBvvUMkHM5l/o50eGRFelekpOaKIH+YHCdB+mMRiZikJH9wcbovIvKryK3j7js3ZRYgN0Lbn1A4x5yISSUWCbnkgfvrMa1IcchLDgIZPIsa4qvDukSpD5qzQvJUVZ7GlLdXNt8D6rzKHaBEVKoOwmLaf1NHTJRZP8pyuvP0Jjse24F2tttImJLWgM/CtxQYsPFyZImqlIxDbA8v3leItwDRXCpTlmA4mt34hG72CN78Jw/Nw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf79c23-bace-481d-cb29-08d69bc54377
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 08:34:41.0118 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1645
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
 Andy Tang <andy.tang@nxp.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 Vabhav Sharma <vabhav.sharma@nxp.com>
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
index e75194a..cfd14ef 100644
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
@@ -1435,6 +1446,7 @@ CLK_OF_DECLARE(qoriq_clockgen_t1023, "fsl,t1023-clock=
gen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_t1040, "fsl,t1040-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_t2080, "fsl,t2080-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_t4240, "fsl,t4240-clockgen", clockgen_init);
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

