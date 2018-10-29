Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CB1C46475
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 09:09:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C2E20664
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 09:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MjrKB0xi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C2E20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42k81r51yYzDsG1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 20:09:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="MjrKB0xi";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=104.47.0.44; helo=eur01-he1-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="MjrKB0xi"; 
 dkim-atps=neutral
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0044.outbound.protection.outlook.com [104.47.0.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42k7lx3dGNzDrP4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 19:57:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g88fk7r3K7OfiwRynUBeicxdrF3GKieQcJWEL6amKlE=;
 b=MjrKB0xiho9Iw7aVeB74+8XNU9MFYvublBue2CkqscslK4ALivOkF6IPj2U8NW52rsdENjigYTLDNeGr3B0pfl4mkwYPqantXlvnypR+KQLQpsoIrO/d83za7D1EuPwNj8pR90MMuo1o2UScLRO6JdeqtHdRQSv6XVyOuivCNNQ=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB4125.eurprd04.prod.outlook.com (52.133.14.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.18; Mon, 29 Oct 2018 08:57:41 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca%3]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 08:57:41 +0000
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
Subject: [PATCH v7 3/6] clk: qoriq: increase array size of cmux_to_group
Thread-Topic: [PATCH v7 3/6] clk: qoriq: increase array size of cmux_to_group
Thread-Index: AQHUb2Vy824CSnwcEUyruRxkof+7Gg==
Date: Mon, 29 Oct 2018 08:57:41 +0000
Message-ID: <1540759926-3641-4-git-send-email-vabhav.sharma@nxp.com>
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
x-microsoft-exchange-diagnostics: 1; VI1PR04MB4125;
 6:OkhzTLaMhJNGH75wPv0k577/PxX7i9CVYt0Uy6WEpN87PMNsf8ltEvE8q6yREaIlQGw+S8SccC3RO35lHJ07wz4IrrZ1VJi+6dopzvDwpMBGsz/TiWU0kYRZRCDHu9YrPvlVhAY+1QhuKi0i7VBwbE/7HP9dlHuzrUQ5AS7ks78mYCTkj6CpvyXzZvJjuiynjOneTWGALEzCcMKL7XGNbxJv+cwxo5rjXshbFbcg13jQn38bw0nXvLGPWjkZ7oZudAVikhcxX9Pun2rjNuCW48YmeFl3r7eX0afSW7JdwH9pvENE+3F5qw3NU9Y7lpFXJcPFOGvkwdC9bCXofoxapDUCyskbbv8N4ObYZVU60BnomwZ1i4VenW7JjSJvvB2C5Cr0/dWIJB0pzmeZ/004bbPh/rZ11Ugvcty0ravgxUo68l3qEO+zzT8fjHGOtP+tXy0EdXXYM+oaWRCe734D6g==;
 5:52HAfnEYCXtGXFBg8aFIzd1PAdpbwyPuOlbHU498gVOauCLKnjU232j8RAP9r+/LV1xq8r/L80xajOYzVAnaYANtuZVi/uYSYGqHxiU5ZrEBTYP34B6SY3okWmRIMTXPFmKTZbYZjCvzZdDGj29mfBOCb78pqLJOD3e9ST+f67k=;
 7:KSbVqmBXQ4V/B6PfF6NYrzU4gsVYj6s62k9O/xj7Qc4ko1xEQhEP+De1c7qBSp+7w7FAsVw/54Qcvjw3/UMobGNeGJQAZcaXJ7QoTaVgCgijNMoWODs+y2/a1ccPOSPJzvPYwIT+uQ6NvdKMFxvf9g==
x-ms-office365-filtering-correlation-id: fe0caba5-6168-4e39-940c-08d63d7c9538
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4125; 
x-ms-traffictypediagnostic: VI1PR04MB4125:
x-microsoft-antispam-prvs: <VI1PR04MB41251A42013C197E23AB9471F3F30@VI1PR04MB4125.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB4125; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB4125; 
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(346002)(396003)(376002)(39860400002)(366004)(199004)(189003)(316002)(44832011)(86362001)(106356001)(5250100002)(2501003)(305945005)(11346002)(7736002)(71190400001)(446003)(8936002)(2616005)(476003)(71200400001)(2201001)(486006)(105586002)(186003)(76176011)(81156014)(81166006)(2906002)(110136005)(6512007)(54906003)(26005)(99286004)(6116002)(14454004)(25786009)(14444005)(256004)(7416002)(36756003)(4326008)(53936002)(6436002)(3846002)(102836004)(6486002)(5660300001)(97736004)(52116002)(66066001)(2900100001)(68736007)(478600001)(8676002)(55236004)(386003)(6506007)(21314003)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4125;
 H:VI1PR04MB4800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: N4aVWdxiSQO5iZXNJVV3TG6O6AMFeeMHx0+9Kw33cKp1/fMIbYVFBURn0RAimwBf1+gJQ0z2JQOccy+8hLyQpCVQzjfmGExcf1FYX3EqG+kC0AdOYmCXqFoOvuEvQ9K7qAE9WPux1ixkzdXCUlaQYWtZgF/QRLRH2I3j2Ug0q12WQvCAKYYoEtR3p2w0JGRKBi36bWJBjBSqOBNN01cqpPeZxqyyXBGErI8GA1eK6RKKGX8lDok5OvSfSRiYURnNeL0W0LR1SLrp+AyXNViubAJcU1ZGNYtUDRIzWlGTagGsBI3Dq1Pe/oUb+pCWgkfWg1ef0nhKIuEqzSYIE9zhCILUeDht1SXRwKDF/a75CQ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0caba5-6168-4e39-940c-08d63d7c9538
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 08:57:41.3099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4125
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
 Udit Kumar <udit.kumar@nxp.com>, Pankaj Bansal <pankaj.bansal@nxp.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 Varun Sethi <V.Sethi@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

Increase size of cmux_to_group array, to accomdate entry of
-1 termination.

Added -1, terminated, entry for 4080_cmux_grpX.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-qoriq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 3a1812f..e152bfb 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -79,7 +79,7 @@ struct clockgen_chipinfo {
 	const struct clockgen_muxinfo *cmux_groups[2];
 	const struct clockgen_muxinfo *hwaccel[NUM_HWACCEL];
 	void (*init_periph)(struct clockgen *cg);
-	int cmux_to_group[NUM_CMUX]; /* -1 terminates if fewer than NUM_CMUX */
+	int cmux_to_group[NUM_CMUX+1]; /* array should be -1 terminated */
 	u32 pll_mask;	/* 1 << n bit set if PLL n is valid */
 	u32 flags;	/* CG_xxx */
 };
@@ -601,7 +601,7 @@ static const struct clockgen_chipinfo chipinfo[] =3D {
 			&p4080_cmux_grp1, &p4080_cmux_grp2
 		},
 		.cmux_to_group =3D {
-			0, 0, 0, 0, 1, 1, 1, 1
+			0, 0, 0, 0, 1, 1, 1, 1, -1
 		},
 		.pll_mask =3D 0x1f,
 	},
--=20
2.7.4

